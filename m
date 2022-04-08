Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93004F9CE4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238803AbiDHSkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiDHSkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:40:19 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F47E0CD;
        Fri,  8 Apr 2022 11:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649443083;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=Q0KWHwnx8MLz9n+kraaOH887Scjy32+dyQU5A7jH5CM=;
    b=ZoIINeXRJV5AYQXHaVkisnBoksQ3+37bSpA6SQ/jd1sonfPfI+JObcTLKAxhkOg8zN
    yMVotiNE0xSu6E9Q/kSdT0e5aaxS/8aspGz9hi3we9cJeYag+OTfU1yRIydIdC4GFijE
    L/YCdYMPmCZxWFwSjnwJ7dV6sgB/tOKc93aUc0k7sFnKTL/i8tNxTXywSdxbyNFgeu18
    DMfD/3sJ9b8D8/b7JrsWfejZDjRBugHq/Qin+D4i76mGKXsCBgaUGGSzDKcVKlp/cT1t
    K7B6n9+FRiBHXHcTUgjaAAnmFkzDhjDQ3H17CzfZVH8j0Fgtk7/EIQ65iDMpt11tcP58
    wYuA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UMf2MwPVbgdr/a"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy38Ic3snu
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
Subject: [PATCH 03/18] MIPS: DTS: jz4780: fix tcu timer as reported by dtbscheck
Date:   Fri,  8 Apr 2022 20:37:46 +0200
Message-Id: <c48277625f0ab5afc86d89deb1b87537e9c592f6.1649443080.git.hns@goldelico.com>
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

arch/mips/boot/dts/ingenic/ci20.dtb: timer@10002000: compatible: 'oneOf' conditional failed, one must be fixed:
	['ingenic,jz4780-tcu', 'ingenic,jz4770-tcu', 'simple-mfd'] is too long
	'ingenic,jz4780-tcu' is not one of ['ingenic,jz4740-tcu', 'ingenic,jz4725b-tcu', 'ingenic,jz4760-tcu', 'ingenic,x1000-tcu']
	'simple-mfd' was expected
	'ingenic,jz4760-tcu' was expected
	From schema: Documentation/devicetree/bindings/timer/ingenic,tcu.yaml

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index 6fb6229c3186b..6027f14c393e3 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -91,7 +91,7 @@ rng: rng@d8 {
 
 	tcu: timer@10002000 {
 		compatible = "ingenic,jz4780-tcu",
-			     "ingenic,jz4770-tcu",
+			     "ingenic,jz4760-tcu",
 			     "simple-mfd";
 		reg = <0x10002000 0x1000>;
 		#address-cells = <1>;
-- 
2.33.0

