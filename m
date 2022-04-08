Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D894F9D0A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbiDHSlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238809AbiDHSkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:40:25 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1916177;
        Fri,  8 Apr 2022 11:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649443087;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=HfyKIvQvUXQtvsFLPqc151vqol/YcRoKi2SxWsPrSm4=;
    b=fs/I/Jg7IC7qCkLFx2M3Bn4fAs6nvfmOGab5D03qoPv9p68Z2OQJYxu+qmONLKymXR
    hXJlbPryp4zOmn2+OpcNukI2TEey7Z3FI9yrq8ocx3mODzpWNnX/QEPdSpSK2geLrcMi
    LRZgyRzWqcOnqMosm0R/LbwlCq6VNt2kzntaQBCksEDDPzq5PKIOvValY3DJ44qAo/7R
    N+9S+lW29S/1bbXJ6pbt0pj6IE0ryEO0ed09rpmgNj1SCMoYFurAOWkzSTQ3VZle4Y9r
    HoT4luX1PYvs7LLzn5FnYnqTej6+P+AoQrMppPVftHwe+n5sIUw6UP0J4iyMUhcLKVt5
    PT/g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UMf2MwPVbgdr/a"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy38Ic7so8
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 8 Apr 2022 20:38:07 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 17/18] MIPS: DTS: CI20: fix wifi as reported by dtbscheck
Date:   Fri,  8 Apr 2022 20:38:00 +0200
Message-Id: <e96fc7f98ef3ef0d16ff9272a6835df4e376a497.1649443080.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1649443080.git.hns@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/mips/boot/dts/ingenic/ci20.dtb: wifi@1: compatible: oneOf conditional failed, one must be fixed:
	[brcm,bcm4330-fmac] is too short
	brcm,bcm4329-fmac was expected
	From schema: Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index 98f0a5ccbb4da..dc587b4b36009 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -176,7 +176,7 @@ &mmc1 {
 
 	brcmf: wifi@1 {
 /*		reg = <4>;*/
-		compatible = "brcm,bcm4330-fmac";
+		compatible = "brcm,bcm4330-fmac", "brcm,bcm4329-fmac";
 		vcc-supply = <&wlan0_power>;
 		device-wakeup-gpios = <&gpd 9 GPIO_ACTIVE_HIGH>;
 		shutdown-gpios = <&gpf 7 GPIO_ACTIVE_LOW>;
-- 
2.33.0

