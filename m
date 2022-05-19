Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F9052DABE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 18:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242285AbiESQ6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 12:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbiESQ6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 12:58:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86762939E1;
        Thu, 19 May 2022 09:58:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B207B824F2;
        Thu, 19 May 2022 16:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB66C385AA;
        Thu, 19 May 2022 16:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652979521;
        bh=8msCZGZp9vw10oH1HRJNB+EC/PkjHEg1vwfz5vYcw/Q=;
        h=From:To:Cc:Subject:Date:From;
        b=Pjk092wVmetA22+lvBjRPJ57dzZ/2n4MhvMOLGxNHxYLqO0stnezgbcib1o5BGeeU
         793eGieTLIOalZtyt1/RGF+9tRqHBHiwIGzkkfhzKxiGrR02eyauCsAk9DhSSWJ9Cf
         BRRaG0lzu0gU0/j4j7fy7+seBCCkR0QJbGLfbmHQUOH6iudYGLSpbm/9m/SOHnNlGd
         TsnMt8EnioNYIBWSoUXpBJHTlDpiuyIXluhhb36t9VWW8qNMJXg2ecSVTj1ZO5w0kL
         /Fm02OqtrrPXkUg1FzwaGLGuwHbW3C8jOwy0/ZLFEJIv/d96MHju+K8iSKub3OIvD5
         sxYBCu92QgWjQ==
From:   Georgi Djakov <djakov@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        djakov@kernel.org
Subject: [GIT PULL] interconnect changes for 5.19
Date:   Thu, 19 May 2022 19:58:39 +0300
Message-Id: <20220519165839.28592-1-djakov@kernel.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This is the pull request with interconnect changes for the 5.19-rc1 merge
window. It contains driver updates. The details are in the signed tag.

All patches have been in linux-next during the last few days. No issues have
been reported so far. Please pull into char-misc-next.

Thanks,
Georgi

The following changes since commit 672c0c5173427e6b3e2a9bbb7be51ceeec78093a:

  Linux 5.18-rc5 (2022-05-01 13:57:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.19-rc1

for you to fetch changes up to 3be0ec65fd17b9677d0a4c8913ee359bd941da5d:

  dt-bindings: interconnect: Remove sc7180/sdx55 ipa compatibles (2022-05-18 03:03:55 +0300)

----------------------------------------------------------------
interconnect changes for 5.19

These are the interconnect changes for the 5.19-rc1 merge window
consisting of driver updates.

 Driver changes:
 - New driver for SC8280XP
 - New driver for SDX65
 - SC8180X driver fixes
 - Constify various data structures in that are never modified
 - Fix clock rate caching in RPM drivers.
 - Misc fixes and clean-ups

Signed-off-by: Georgi Djakov <djakov@kernel.org>

----------------------------------------------------------------
Bjorn Andersson (7):
      dt-bindings: interconnect: qcom: Add sc8280xp binding
      interconnect: qcom: Add SC8280XP interconnect provider
      dt-bindings: interconnect: Add SC8180X QUP0 virt provider
      interconnect: qcom: sc8180x: Modernize sc8180x probe
      interconnect: qcom: sc8180x: Fix QUP0 nodes
      interconnect: qcom: sc8180x: Mark some BCMs keepalive
      interconnect: qcom: sc8180x: Reformat node and bcm definitions

Georgi Djakov (5):
      Merge branch 'icc-sc8280xp' into icc-next
      Merge branch 'icc-sdx65' into icc-next
      Merge branch 'icc-const' into icc-next
      Merge branch 'icc-sc8180x' into icc-next
      Merge branch 'icc-rpm' into icc-next

Krzysztof Kozlowski (6):
      interconnect: qcom: constify qcom_icc_desc
      interconnect: qcom: constify icc_node pointers
      interconnect: qcom: constify qcom_icc_bcm pointers
      interconnect: qcom: sc8280xp: constify qcom_icc_desc
      interconnect: qcom: sc8280xp: constify icc_node pointers
      interconnect: qcom: sc8280xp: constify qcom_icc_bcm pointers

Leo Yan (2):
      interconnect: qcom: icc-rpm: Fix for cached clock rate
      interconnect: qcom: icc-rpm: Cache every clock rate

Rohit Agarwal (2):
      dt-bindings: interconnect: Add Qualcomm SDX65 DT bindings
      interconnect: qcom: Add SDX65 interconnect provider driver

Stephen Boyd (1):
      dt-bindings: interconnect: Remove sc7180/sdx55 ipa compatibles

 Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml |   18 +-
 drivers/interconnect/qcom/Kconfig                             |   18 +
 drivers/interconnect/qcom/Makefile                            |    4 +
 drivers/interconnect/qcom/icc-rpm.c                           |   16 +-
 drivers/interconnect/qcom/icc-rpm.h                           |    6 +-
 drivers/interconnect/qcom/icc-rpmh.c                          |    2 +-
 drivers/interconnect/qcom/icc-rpmh.h                          |    6 +-
 drivers/interconnect/qcom/msm8916.c                           |   12 +-
 drivers/interconnect/qcom/msm8939.c                           |   16 +-
 drivers/interconnect/qcom/msm8974.c                           |   28 +-
 drivers/interconnect/qcom/msm8996.c                           |   16 +-
 drivers/interconnect/qcom/osm-l3.c                            |   16 +-
 drivers/interconnect/qcom/qcm2290.c                           |   24 +-
 drivers/interconnect/qcom/qcs404.c                            |   12 +-
 drivers/interconnect/qcom/sc7180.c                            |   66 +-
 drivers/interconnect/qcom/sc7280.c                            |   72 +-
 drivers/interconnect/qcom/sc8180x.c                           | 1895 +++++-
 drivers/interconnect/qcom/sc8180x.h                           |    7 +
 drivers/interconnect/qcom/sc8280xp.c                          | 2438 ++++++++
 drivers/interconnect/qcom/sc8280xp.h                          |  209 +
 drivers/interconnect/qcom/sdm660.c                            |   24 +-
 drivers/interconnect/qcom/sdm845.c                            |   32 +-
 drivers/interconnect/qcom/sdx55.c                             |   12 +-
 drivers/interconnect/qcom/sdx65.c                             |  231 +
 drivers/interconnect/qcom/sdx65.h                             |   65 +
 drivers/interconnect/qcom/sm8150.c                            |   66 +-
 drivers/interconnect/qcom/sm8250.c                            |   66 +-
 drivers/interconnect/qcom/sm8350.c                            |   60 +-
 drivers/interconnect/qcom/sm8450.c                            |   68 +-
 include/dt-bindings/interconnect/qcom,sc8180x.h               |    7 +
 include/dt-bindings/interconnect/qcom,sc8280xp.h              |  232 +
 include/dt-bindings/interconnect/qcom,sdx65.h                 |   67 +
 32 files changed, 5209 insertions(+), 602 deletions(-)
 create mode 100644 drivers/interconnect/qcom/sc8280xp.c
 create mode 100644 drivers/interconnect/qcom/sc8280xp.h
 create mode 100644 drivers/interconnect/qcom/sdx65.c
 create mode 100644 drivers/interconnect/qcom/sdx65.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sc8280xp.h
 create mode 100644 include/dt-bindings/interconnect/qcom,sdx65.h
