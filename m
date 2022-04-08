Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CFA4F9D05
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238901AbiDHSlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238827AbiDHSkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:40:32 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A992DA8B;
        Fri,  8 Apr 2022 11:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649443084;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=bNIR+Wzhbvm+wU9DNMXN2Rv35lJlQbfLLKdlltaiO+A=;
    b=IGs7cxHNaOVq+PeiCjWStRPzT3Z8Gqvd3JhpC0x2RYMJyhw3GKAWVHaH8GnEKu15Iv
    CLCYUOubpET6585oQ+gRbDhoth9lvyUVbeDvhlXnHKWgakIoXPrVvqJ4/qtEddo5+Ls2
    zcq1djy1joGz/hPTiFTIRU9w4u627aZi48/USzJlhjo6IyeKeKs62CAqhaeDX77AElNM
    6gEW732ISqvAIGOw4XsTgp38c6dLZsAQznCJ4WONIbbuI79oFUcAbbs95W3N+oYob+a9
    fQWD1KR3zzg2FOP6dwCJq1zngvrqu68HaouSX4lfviSoD6k7Sy7vRUcsDtX48TmEz8Gv
    HQJw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UMf2MwPVbgdr/a"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy38Ic4sny
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 8 Apr 2022 20:38:04 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 07/18] MIPS: DTS: jz4780: fix otg node as reported by dtbscheck
Date:   Fri,  8 Apr 2022 20:37:50 +0200
Message-Id: <298162bfa2e7225ccc753865e1ffa39ce2722b2a.1649443080.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1649443080.git.hns@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/mips/boot/dts/ingenic/ci20.dtb: usb@13500000: compatible: 'oneOf' conditional failed, one must be fixed:
	['ingenic,jz4780-otg', 'snps,dwc2'] is too long
	['ingenic,jz4780-otg', 'snps,dwc2'] is too short
	'brcm,bcm2835-usb' was expected
	'hisilicon,hi6220-usb' was expected
	'rockchip,rk3066-usb' was expected
	'ingenic,jz4780-otg' is not one of ['rockchip,px30-usb', 'rockchip,rk3036-usb', 'rockchip,rk3188-usb', 'rockchip,rk3228-usb', 'rockchip,rk3288-usb', 'rockchip,rk3308-usb', 'rockchip,rk3328-usb', 'rockchip,rk3368-usb', 'rockchip,rv1108-usb']
	'lantiq,arx100-usb' was expected
	'lantiq,xrx200-usb' was expected
	'ingenic,jz4780-otg' is not one of ['amlogic,meson8-usb', 'amlogic,meson8b-usb', 'amlogic,meson-gxbb-usb', 'amlogic,meson-g12a-usb', 'intel,socfpga-agilex-hsotg']
	'amcc,dwc-otg' was expected
	'apm,apm82181-dwc-otg' was expected
	'snps,dwc2' was expected
	'st,stm32f4x9-fsotg' was expected
	'st,stm32f4x9-hsotg' was expected
	'st,stm32f7-hsotg' was expected
	'st,stm32mp15-fsotg' was expected
	'st,stm32mp15-hsotg' was expected
	'samsung,s3c6400-hsotg' was expected
	'intel,socfpga-agilex-hsotg' was expected
	From schema: Documentation/devicetree/bindings/usb/dwc2.yaml

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index 2021836983c96..c5124459678b7 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -576,7 +576,7 @@ bch: bch@134d0000 {
 	};
 
 	otg: usb@13500000 {
-		compatible = "ingenic,jz4780-otg", "snps,dwc2";
+		compatible = "snps,dwc2";
 		reg = <0x13500000 0x40000>;
 
 		interrupt-parent = <&intc>;
-- 
2.33.0

