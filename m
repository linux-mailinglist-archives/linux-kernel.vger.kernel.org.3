Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C6252494C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352186AbiELJlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352171AbiELJle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:41:34 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942556A016
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 02:41:32 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 7DB4C2C0719;
        Thu, 12 May 2022 09:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1652348489;
        bh=CCea1k7mwJq3WEXEcbjXo1IM6THw8sWAL42OOl5qT/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vEcEskj7ddPr0p5sbPQTfSQCvbw9vD2jNmdcb17n8EQQQJRNZv9UykGNV74723pr0
         o9d5sxzUR+cSoHuCIFnKhs5v1XBN4OQHDfq/MZXNoeNIvwO5pexfOnM0DJQrUNvn8L
         96PtSj0Sb1m4JWfyfjzURl4ZeSJhj8OUTemZA/BgdCMkujflQ044uS40QeTimfv48c
         0g8/de4AUf6nsD9g1ocXpxxsWAI4AfVRGXarm0pqmp84Q5+Qv3i8DiZNwPw/uMAMp0
         YrZLJnLY6niGuBKQS/GVbL1Rmb8Kn4DUmbtV5dLSh7mpzm/38VNUygDwo3qT68uJQ6
         gA/2qlP5luz8w==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B627cd6490001>; Thu, 12 May 2022 21:41:29 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 4225F13EE41;
        Thu, 12 May 2022 21:41:29 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 3F3562A00D3; Thu, 12 May 2022 21:41:29 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        andrew@lunn.ch
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 2/2] dt-bindings: gpio: gpio-mvebu: document offset and marvell,pwm-offset
Date:   Thu, 12 May 2022 21:41:25 +1200
Message-Id: <20220512094125.3748197-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220512094125.3748197-1-chris.packham@alliedtelesis.co.nz>
References: <20220512094125.3748197-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=U+Hs8tju c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=oZkIemNP1mAA:10 a=9OvEkFhTLsvuW6oDEM0A:9
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
Add them based on the existing usage when the marvell,armada-8k-gpio
compatible is used.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v3:
    - Split off from 1:1 conversion patch

 Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml b/Doc=
umentation/devicetree/bindings/gpio/gpio-mvebu.yaml
index 2d95ef707f53..790a17af7c59 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
@@ -41,6 +41,10 @@ properties:
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
@@ -64,6 +68,10 @@ properties:
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
2.36.0

