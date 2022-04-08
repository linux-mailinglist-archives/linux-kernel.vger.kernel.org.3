Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0174F9D13
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238938AbiDHSll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238811AbiDHSkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:40:25 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD55140A3;
        Fri,  8 Apr 2022 11:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649443083;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=zOv4vpytn9gP/3c5V0tH+m+bUz7dSLAbrW0h70y0Rf0=;
    b=a1HEuaOu8t2Cis2xGvlS1ROAR1N6A3vQmiDo3rLsHpkUU++RtKI/31ZCiPpk/U2cwN
    EZQ46FSMLPDczNiAlYLi9tPcnBcK71qjfSk3YLXaiEcsYYk4hVkWNmpLq8lYuf2HHZeG
    Gr93XD0wVlxVcWhvSoDZ/a2S6vkOvh8kIBmOkRtkWqjTD5CW1l45A53Z8cei5wgps3CG
    sGL95NDjS2Xa2Huax/d8ZOxY4QZTdXezZvCJjrxVG7yKViWcH1X5lO5Y2UniA9y5nrLb
    vbdl2JHDM8RQRfEYPD3Vt9pFmxRLwqfRYRarvoQtqaHvzpwnWN1GXpN0hesQlbxQrjfK
    /xnw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UMf2MwPVbgdr/a"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy38Ic3snt
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 8 Apr 2022 20:38:03 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 02/18] MIPS: DTS: jz4780: fix cgu as reported by dtbscheck
Date:   Fri,  8 Apr 2022 20:37:45 +0200
Message-Id: <6665d5059c840a240721f9ea6ae4abc8536d0400.1649443080.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1649443080.git.hns@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/mips/boot/dts/ingenic/ci20.dtb: jz4780-cgu@10000000: $nodename:0: 'jz4780-cgu@10000000' does not match '^clock-controller@[0-9a-f]+$'
	From schema: Documentation/devicetree/bindings/clock/ingenic,cgu.yaml

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index 710605df40ed3..6fb6229c3186b 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -58,7 +58,7 @@ rtc: rtc {
 		clock-frequency = <32768>;
 	};
 
-	cgu: jz4780-cgu@10000000 {
+	cgu: clock-controller@10000000 {
 		compatible = "ingenic,jz4780-cgu", "simple-mfd";
 		reg = <0x10000000 0x100>;
 		#address-cells = <1>;
-- 
2.33.0

