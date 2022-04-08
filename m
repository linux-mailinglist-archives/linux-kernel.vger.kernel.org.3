Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148F34F9D02
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238876AbiDHSlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238826AbiDHSkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:40:32 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC06525E9D;
        Fri,  8 Apr 2022 11:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649443083;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=hJ1J5LMNjhwZoX0fR0DkYrCb1jeXSRImxFlYVSKJrjo=;
    b=QdFtZeUva8D21fofBJHCr2WtmWFVFlWLXz2oEzPZVA6mDxXLO9UHRg0U5fsHDcWIhu
    zjmEb7yN+E1RXyQ90uBKEW5mSOdHQj1C68Ydpsjex4pxCM0U8zkeFWcbFiToDBpAYSZc
    oWGK9YQ7g8f+xJNLKC87qARRYdgimqns/+WEmVmHBpCoCWkIrAJHPLzYtkbhNLDYjKjU
    3P7qI8tW2WWNdIFSLK8byFVCT468x3BJ561F4nkEEjVSV5t6SqZ4G5xncWqhFfStNy+W
    NE+WwdDz21h169p7ViBvud3SeFPME+rr4ROrYIiGE8VEMvrKbqF2ztdo3oyRnZEL5vmw
    Xeyw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UMf2MwPVbgdr/a"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy38Ic2sns
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 8 Apr 2022 20:38:02 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 01/18] MIPS: DTS: jz4780: remove cpu clock-names as reported by dtbscheck
Date:   Fri,  8 Apr 2022 20:37:44 +0200
Message-Id: <064a1f029a82ea3895109efe8fb1f472581d4581.1649443080.git.hns@goldelico.com>
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

arch/mips/boot/dts/ingenic/ci20.dtb: cpu@0: clock-names does not match any of the regexes: pinctrl-[0-9]+
	From schema: Documentation/devicetree/bindings/mips/ingenic/ingenic,cpu.yaml
arch/mips/boot/dts/ingenic/ci20.dtb: cpu@1: clock-names does not match any of the regexes: pinctrl-[0-9]+
	From schema: Documentation/devicetree/bindings/mips/ingenic/ingenic,cpu.yaml

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index b998301f179ce..710605df40ed3 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -18,7 +18,6 @@ cpu0: cpu@0 {
 			reg = <0>;
 
 			clocks = <&cgu JZ4780_CLK_CPU>;
-			clock-names = "cpu";
 		};
 
 		cpu1: cpu@1 {
@@ -27,7 +26,6 @@ cpu1: cpu@1 {
 			reg = <1>;
 
 			clocks = <&cgu JZ4780_CLK_CORE1>;
-			clock-names = "cpu";
 		};
 	};
 
-- 
2.33.0

