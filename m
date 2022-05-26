Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B76A534828
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 03:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345808AbiEZBaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 21:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345717AbiEZB35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 21:29:57 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46106A0D35
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 18:29:53 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B7D2C2C0657;
        Thu, 26 May 2022 01:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1653528590;
        bh=LJpXCxq+I57n1rGrvrEseEpic3rE2tpsbcOLDqS+u6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d46+nZvMGIizXwKJPNSFF24IzgHYKbcNoBV9wcC8fhp4j2mjGMRvsFPf0ne5URCwF
         BaL1mA3ewHZjw9hqrlDX+gwqbAuW1A16GVQKTyq4d0YLiQWcsANSjeBf4JEBW1wzKX
         toqANzsmNGYzy/H+CzngnIL4A61ZOE7Dcc7W2HT5VDjSs/8UTR9xB8btD7e7p23vIM
         AbLolJ6XweycvByEkFaVPPqHaIz8bHUZSUqKA63+aP1eOuuy41YGNnNo5A2BmNpJrS
         Tm+x+WD4XULE4aC4wQpRXSY7YcjREdh8lGXRi+0j7ZFMOAK7XDWqMtuz+cdvRTa0IY
         IJZk+COvmiaBw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B628ed80e0002>; Thu, 26 May 2022 13:29:50 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 60E7813ED7D;
        Thu, 26 May 2022 13:29:50 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 606CC2A0088; Thu, 26 May 2022 13:29:50 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        andrew@lunn.ch, thomas.petazzoni@free-electrons.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v4 3/3] dt-bindings: gpio: gpio-mvebu: document offset and marvell,pwm-offset
Date:   Thu, 26 May 2022 13:29:46 +1200
Message-Id: <20220526012946.3862776-4-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220526012946.3862776-1-chris.packham@alliedtelesis.co.nz>
References: <20220526012946.3862776-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=U+Hs8tju c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=oZkIemNP1mAA:10 a=KKAkSRfTAAAA:8 a=XThe9qdf-NWsa71EaF4A:9 a=cvBusfyB2V15izCimMoJ:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The offset and marvell,pwm-offset properties weren't in the old binding.
Add them based on the existing usage in the driver and board DTS when
the marvell,armada-8k-gpio compatible is used.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Notes:
    Changes in v4:
    - Reword commit message slightly
    - Add review from Krzysztof
    Changes in v3:
    - Split off from 1:1 conversion patch

 Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml b/Doc=
umentation/devicetree/bindings/gpio/gpio-mvebu.yaml
index 459ec35864fe..f1bd1e6b2e1f 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
@@ -45,6 +45,10 @@ properties:
       - const: pwm
     minItems: 1
=20
+  offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Offset in the register map for the gpio registers (in b=
ytes)
+
   interrupts:
     description: |
       The list of interrupts that are used for all the pins managed by t=
his
@@ -68,6 +72,10 @@ properties:
   "#gpio-cells":
     const: 2
=20
+  marvell,pwm-offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Offset in the register map for the pwm registers (in by=
tes)
+
   "#pwm-cells":
     description:
       The first cell is the GPIO line number. The second cell is the per=
iod
--=20
2.36.1

