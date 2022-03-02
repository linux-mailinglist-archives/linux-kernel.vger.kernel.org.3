Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89654CA842
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243062AbiCBOfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242306AbiCBOfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:35:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF7B1FCEA;
        Wed,  2 Mar 2022 06:34:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC5FB6133D;
        Wed,  2 Mar 2022 14:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EAF9C004E1;
        Wed,  2 Mar 2022 14:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646231678;
        bh=DsddKgliXpWgfbTSJqq6vbfVEJXlCc5yzM7GOjfvd2k=;
        h=From:To:Cc:Subject:Date:From;
        b=pgvWETVkoFF4pAglxqhxWAalhLE20E45W4S3hMYrAS0UkvtR/ilZ/bwXabiyQHKdh
         DkBwFr3SelME5V7IvbwCnNJKk93hKZvCvK+LK1CJm/xGN9gPqnDVHBKgAuPoDCxEQ9
         szrC6UgcMzmHmVxu2cgzuq59ZehMe5+R8laoL1ZyBq10HZGCIt+ca4R5vKUb7y3ELg
         v1OhxNNIl8dD6sHgTtBRCF3G25UVhlE5k7B4su+CngT3wVha5eVE1cu+7bB7DaB0U/
         CuDLGxh5ZtwyVOXpKgwFotwQtv/8crf8uIvBs5xGLsayYjNMGaUYNT5VLj0pwS+U8g
         nAlxiD78cWkqA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: Revert "dt-bindings: soc: grf: add naneng combo phy register compatible"
Date:   Wed,  2 Mar 2022 20:04:27 +0530
Message-Id: <20220302143427.447748-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit b3df807e1fb0 ("dt-bindings: soc: grf: add naneng
combo phy register compatible") as that was wrongly merged, so better to
drop the wrong patch

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
I am applying this to phy-next to fix the issue

 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index fe68e22efce0..dfebf425ca49 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -38,8 +38,6 @@ properties:
               - rockchip,rk3399-grf
               - rockchip,rk3399-pmugrf
               - rockchip,rk3568-grf
-              - rockchip,rk3568-pipe-grf
-              - rockchip,rk3568-pipe-phy-grf
               - rockchip,rk3568-pmugrf
               - rockchip,rv1108-grf
               - rockchip,rv1108-pmugrf
-- 
2.34.1

