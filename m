Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC0B4F9D07
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238909AbiDHSlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238806AbiDHSkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:40:25 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554291A3A1;
        Fri,  8 Apr 2022 11:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649443085;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=0+IDZOg6sjk2fG8LmEu8eygBhYSSr8rO5vvRGf2Xg40=;
    b=ZzZLJTtbPKrPxtBv8kd322X1jiX5TN0hC7zh6VoIZWKaQ/+5LIJC3YGtpnI1tCfJSL
    At5EV/qp4t7tJ1igVeA4S7ffOwj4BUpIP6i5F2o7AkkDBMgvBtiLPB6UELCuF4WT9XXX
    SdCy7cOqyDETrPKzHmxlI8RDlw7u9CUp6bPtw4bY9Gqw/dsFPsp1QvAqbkIIfTV/1/qv
    Rq2IkOexUoRN4HnUUqdgzTkhWT5hN+Tv5comV8PT7jkEXcDed/b62LWh2Ffwun5gpfYi
    dkBRZEkKgKSAQLA62995JBYCZfD/oaBwExBzx/cY8SZyYy9gDmJtH2RCJbVfUzBuwacV
    OqsQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UMf2MwPVbgdr/a"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy38Ic5so3
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 8 Apr 2022 20:38:05 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 12/18] MIPS: DTS: jz4780: fix nemc memory controller as reported by dtbscheck
Date:   Fri,  8 Apr 2022 20:37:55 +0200
Message-Id: <995a8977d6ecc5798bf6139811698f3493b71249.1649443080.git.hns@goldelico.com>
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

arch/mips/boot/dts/ingenic/ci20.dtb: nemc@13410000: $nodename:0: 'nemc@13410000' does not match '^memory-controller@[0-9a-f]+$'
	From schema: Documentation/devicetree/bindings/memory-controllers/ingenic,nemc.yaml

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index dcb93d0158856..cf259dac519ad 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -523,7 +523,7 @@ lcdc1: lcd-controller@130a0000 {
 		status = "disabled";
 	};
 
-	nemc: nemc@13410000 {
+	nemc: memory-controller@13410000 {
 		compatible = "ingenic,jz4780-nemc", "simple-mfd";
 		reg = <0x13410000 0x10000>;
 		#address-cells = <2>;
-- 
2.33.0

