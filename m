Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B864F9D14
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238934AbiDHSlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238808AbiDHSkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:40:25 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A50AE0CD;
        Fri,  8 Apr 2022 11:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649443087;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=U6xUZX3rABONFQNmgTS5OWTtzD/QUaflv4arT+HMnbE=;
    b=q0SwJSfo8lEk5kY3urcin5nc4lrE9vXbZ/w4sW+2Yd/bD6UvKmSw4PPQTxBEUCKdVY
    Fre+U6n0kVVYE6W1nEjeGQDNqK/CbNpwelxbAj4DTA/r75OK4fHKMG7N2FJwTOb2yry0
    PNJn1KodvtDVK49O0b4SM6CRfMJodT4mazUMwkmfKmqz8Xq6SY0eebx19TCKAVrhEW4W
    zUWxzL2to/nnwfJqQiOWfheqhuKYHaffXThmRuqnDwqreAW9Pzcq+Ufl08kH0rSnL2lP
    Qtp2Yjgs1nUglwcf7hjkqspsjybBz10y2o6rABASmwu2GMa8VqlmYjhUBy9dzANYgLMd
    GV0Q==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UMf2MwPVbgdr/a"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy38Ic7so9
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
Subject: [PATCH 18/18] MIPS: DTS: CI20: fix bluetooth as reported by dtbscheck
Date:   Fri,  8 Apr 2022 20:38:01 +0200
Message-Id: <32a2afa1a8f1f675a199d1aa9b4469bed2391069.1649443080.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1649443080.git.hns@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arch/mips/boot/dts/ingenic/ci20.dtb: bluetooth: vcc-supply does not match any of the regexes: pinctrl-[0-9]+
	From schema: Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index dc587b4b36009..8a120f9374331 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -207,7 +207,7 @@ &uart2 {
 	bluetooth {
 		compatible = "brcm,bcm4330-bt";
 		reset-gpios = <&gpf 8 GPIO_ACTIVE_HIGH>;
-		vcc-supply = <&wlan0_power>;
+		vbat-supply = <&wlan0_power>;
 		device-wakeup-gpios = <&gpf 5 GPIO_ACTIVE_HIGH>;
 		host-wakeup-gpios = <&gpf 6 GPIO_ACTIVE_HIGH>;
 		shutdown-gpios = <&gpf 4 GPIO_ACTIVE_LOW>;
-- 
2.33.0

