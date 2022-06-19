Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E98550954
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 10:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbiFSI01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 04:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiFSI0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 04:26:21 -0400
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B222AEE0D;
        Sun, 19 Jun 2022 01:26:19 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout4.routing.net (Postfix) with ESMTP id 16505101294;
        Sun, 19 Jun 2022 08:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1655627178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MgcSu/bZTjky7t6qN/ZaauuAgwOYV51FTF/OPnptHgI=;
        b=V6/kqZMK1osbUAGBkeFFjrg5dRAARQNas58FVCI4qRndkb38a6EHvdAEV/aLOMhouEWz/q
        LejXWwk/2sPy+jDMUP1N+8QGvamW9vYJK+S3X/d82GDMzG5ofe/EUICg9bi2gqBCt03ZNt
        Lu70UDU7W6ytiAZu07Poq4q0kD5SAu4=
Received: from frank-G5.. (fttx-pool-157.180.227.195.bambit.de [157.180.227.195])
        by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 1633710054D;
        Sun, 19 Jun 2022 08:26:17 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Liang Chen <cl@rock-chips.com>, Simon Xue <xxm@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 2/5] dt-bindings: soc: grf: add pcie30-{phy,pipe}-grf
Date:   Sun, 19 Jun 2022 10:26:02 +0200
Message-Id: <20220619082605.7935-3-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220619082605.7935-1-linux@fw-web.de>
References: <20220619082605.7935-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 1f4313a6-4642-4c5d-9b5c-1584b150b7b3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Add compatibles for PCIe v3 General Register Files.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v4:
- rebase on 5.19-rc1
- add acked-by

v3:
- fix order of grf-bindings

v2:
- add soc-part to pcie3-phy-grf
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 75a2b8bb25fb..97301c470173 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -16,9 +16,12 @@ properties:
           - enum:
               - rockchip,rk3288-sgrf
               - rockchip,rk3566-pipe-grf
+              - rockchip,rk3568-pcie3-phy-grf
               - rockchip,rk3568-pipe-grf
               - rockchip,rk3568-pipe-phy-grf
               - rockchip,rk3568-usb2phy-grf
+              - rockchip,rk3588-pcie3-phy-grf
+              - rockchip,rk3588-pcie3-pipe-grf
               - rockchip,rv1108-usbgrf
           - const: syscon
       - items:
-- 
2.34.1

