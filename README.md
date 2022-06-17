![깃허브 박인우](https://user-images.githubusercontent.com/61109660/160549255-3a5d54da-3502-4526-809b-7abfe3f2302e.png)

## 1차에서 4차까지 개발을 하고 공부를 했던 부분에서 이슈 해결했던 부분 1가지 이상 정리하기

- 예전에 제대로 이해하지 못한채로 넘어간 TableView, CollectionView를 집중적으로 다뤄보면서 배우는 게 많았습니다.
  - TableView Cell 중 하나로 CollectionView를 구성하는 것은 생각하지 못했는데 꽤나 좋은 방법이라는 생각이 들었습니다.
  - cell에서 contentView에 view들을 올리지 않으면 사용자 view들이 다른 레이어에 가려져 제대로 동작하지 않을 수 있습니다.
  - tableView.allowsSelection = false 를 통해 tableView의 selection을 막을 수 있습니다.
  - tableView.rowHeight = UITableView.automaticDimension 를 통해 tableView Row의 크기를 동적으로 변경할 수 있습니다. (이 때 높이를 제대로 판단할 수 있도록 제약사항은 contentView의 bottomAnchor까지 잘 맞춰주어야 합니다.)

## 5차에서 6차까지 협업을 하면서 또는 개발을 하면서 이슈 해결했던 부분 1가지 이상 정리하기

-   위 아래에 각각 View가 존재하고 둘 사이에 존재하는 메뉴 View를 움직이면 각각의 크기가 유동적으로 변경되는 화면을 구성해야 했습니다
-   이를 위해 우선 UIPanGestureRecognizer를 사용했습니다. 메뉴 View에 UIPanGestureRecognizer를 추가하고 해당 이벤트가 발생하면 작업을 수행하도록 했습니다.
-   처음엔 UIPanGestureRecognizer로부터 translation 값을 받아오고 이를 기반으로 frame 값을 변경하려고 했는데 쉽사리되지 않았습니다. 현재 각 View에는 Auto Layout이 걸려있는 상황이기 때문에 당연히 제대로 동작할리 없었습니다.
-   다음으로 시도한 것은 NSLayoutConstraint.activate 를 사용해 관련 제약사항을 한번에 업데이트해주는 것이었습니다. 하지만 이 역시 복잡한 제약사항을 한번에 업데이트하다보니 충돌이 발생했고 이 역시 제대로 작동하지 않았습니다.
-   마지막으로 선택해서 해결한 방법은 제약사항 자체를 저장해놓고 제약사항의 constant 값을 업데이트하는 것이었습니다. 다행히 잘 동작하는 모습을 확인했습니다. 작성된 코드를 설명하며 정리헤보겠습니다.
-   일단 전제는 아래 View(연두색 View)에는 height 제약이 되어있지 않고, 위 View(하늘색 View)에만 superview.frame.height\*0.7의 제약이 있다는 것입니다. 따라서 하늘색 View 걸린 Constraint를 변경하면 모든 View들이 따라서 변경됩니다.

```swift
        let translation = sender.translation(in: view)
        sender.setTranslation(.zero, in: view)
        switch sender.state {
        case .changed:
            if editorHeightConstraint.constant >= -view.frame.height*0.5 && editorHeightConstraint.constant <= view.frame.height*0.20 {
                editorHeightConstraint.constant += translation.y
            }
        case .ended:
            let percentage = (editorCollectionView.frame.height + translation.y) / view.frame.height
            if percentage > 0.8 {
                editorHeightConstraint.constant = view.frame.height*0.20
            } else if 0.4 < percentage && percentage < 0.8 {
                editorHeightConstraint.constant = 0
            } else {
                editorHeightConstraint.constant = -view.frame.height*0.5
            }
        default:
            break
        }

        var alpha = (self.view.frame.height*0.20 - editorHeightConstraint.constant) / 100
        alpha = alpha < 0 ? 0 : alpha
        alpha = alpha > 1 ? 1 : alpha

        photoCollectionView.alpha = alpha
```

-   먼저 sender로부터 translation 값을 받습니다. 여기엔 최초 좌표 기준 x와 y의 변경값이 들어있습니다. 이 중 translation.y를 활용해 위치를 변경해줄 것입니다.
-   setTranslation을 통해 translation을 0으로 초기화합니다. translation은 최초의 시작점을 기준 변경된 값이 계속해서 누적됩니다. 하지만 우리는 매 동작마다 y값을 제약사항에 더해줄 것입니다. 따라서 매 동작마다 0으로 초기화하여 이번에 인식된 변경값만을 더해줄 수 있도록 하는 것입니다.
-   상태가 changed이면 현재의 constant값을 기준으로 제한을 주어서 constant에 translation.y 값을 더해줍니다.
-   상태가 end면 현재의 위치를 기준으로 3가지 지점으로 이동되도록 합니다.
-   아래에 존재하는 View는 그 위치에 따른 투명도 조절이 필요하기 때문에 마지막에서는 이를 계산해서 처리합니다.

## 지금 현재 내가 부족한 부분이 무엇인지 또는 공부할 내용 체크리스트 만들기

-   **네트워크 통신** : 네트워크 부분을 좀 더 보충하고 싶습니다. 기본적인 통신 기능 구현은 익숙하지만 백그라운드 처리, Reachability, 네트워크 연결, WebSocket 통신, 연결 대기 등 아직 미숙한 부분이 많습니다.
-   **이미지 캐싱** : 많은 프로젝트에서 구현되는 부분인데 제가 직접 담당해서 구현해볼 기회가 없었습니다. Kingfisher를 통한 처리부터 직접적인 처리까지 구현해봐야겠습니다.
-   **LLDB** : 기본적인 LLDB 사용법은 알고있었지만, 무지성 print 디버깅에 너무 익숙해지다보니 LLDB 사용과 조금 멀어졌던 것 같습니다. 다시 LLDB 사용법을 정리하고 이를 적극적으로 활용하고 싶습니다.
-   **접근성 구현** : iOS에서는 보이스오버 등을 통해 기본적인 접근성 기능을 지원합니다. 앱은 모두에게 평등한 사용성을 제공할 수 있어야 합니다. 완벽하진 않아도 사용해보는 것이 의미있을 것 같아 꼭 시도해보고 싶습니다.
-   **Unit Test** : 기본적인 Unit Test 작성방법은 익히고 있습니다. 하지만 프로젝트에 제대로 적용해본 경험은 적습니다. 다음번 프로젝트에서는 Unit Test까지 적용된 깔끔한 구조를 완성해보고 싶습니다.
-   **날짜 다루기** : 제 첫번째 iOS 프로젝트는 캘린더 기능이 핵심이었습니다. 그래서 어느정도 Calender 구조체 사용법은 익혔습니다. 하지만 여전히 익숙하진 않더라구요. 정리를 아직 안해서 그런가봐요. 그래서 Date를 완전히 자유자제로 다룰 수 있을 정도로 정리해보고 싶습니다.
-   **애니메이션 처리** : 저는 앱에 애니메이션을 많이 적용해보지 못했습니다. 하지만 사용성에 있어서는 애니메이션도 분명 중요한 부분입니다. 애니메이션쪽은 거의 문외한에 가까운데 CGAffineTransform까지 포함해서 다양한 애니메이션 처리를 공부해보고 싶습니다.
-   **CollectionView 총정리** : TableView를 정리했을 때처럼 CollectionView도 정리해보고 싶습니다. CollectionView는 기능이 더 복잡한 만큼 또 새롭게 보이는 것이 있지 않을까요?
