Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A43534829
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 03:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240777AbiEZBaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 21:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345720AbiEZB35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 21:29:57 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB7F9E9CF
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 18:29:53 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 8132C2C049A;
        Thu, 26 May 2022 01:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1653528590;
        bh=QHyZnC4rqumt3wHA68GEYa3OZenHl1h51o2C2yqx0hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TfyHid8mBhNdVeE9z1SNzToZk5f+vjqJN568qUXTJCEQIJmQQdOIexv4puzSYQkay
         7goSMOW+zXuqUK/tC+nq2iAEai/MHtzgTr2pxLCWSYMmzsR5z2QNdo4zAsOH55xKz+
         10Em0E8Ow6wMaM/SseC4kSLz7O1WeRI/ExLsZan5cXHZSxrZfKlPHhcte0NwR4Zf60
         SAtveA91mxVeW8aN+LAgMVkwCs0OcmaNpVd7/RzSJbNejD0+6BX3KfhV/JFro7GAZ9
         l9LjdbRuCABSXA7Yy950ifyX8FmGojXpmiMyXAju7zsqpBmFyYfWbMXn4kJ0HqXw+W
         iHJkUBziN/N4Q==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B628ed80e0001>; Thu, 26 May 2022 13:29:50 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by pat.atlnz.lc (Postfix) with ESMTP id 421E813ED7D;
        Thu, 26 May 2022 13:29:50 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 41A572A0088; Thu, 26 May 2022 13:29:50 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        andrew@lunn.ch, thomas.petazzoni@free-electrons.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v4 2/3] dt-bindings: gpio: gpio-mvebu: deprecate armadaxp-gpio
Date:   Thu, 26 May 2022 13:29:45 +1200
Message-Id: <20220526012946.3862776-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220526012946.3862776-1-chris.packham@alliedtelesis.co.nz>
References: <20220526012946.3862776-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=U+Hs8tju c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=oZkIemNP1mAA:10 a=hUIUswXySYZqKnqjVYYA:9
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

Commit 5f79c651e81e ("arm: mvebu: use global interrupts for GPIOs on
Armada XP") the marvell,armadaxp-gpio compatible obsolete.

The driver code still exists to handle the armadaxp behaviour but all
the in-tree boards use the marvell,armada-370-gpio.  Document the
marvell,armadaxp-gpio compatible as deprecated.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    This could potentially be squashed into the first commit but it seeme=
d
    more proper to do a straight 1:1 conversion of the old binding then
    clean things up to match reality.
   =20
    Changes in v4:
    - New

 .../devicetree/bindings/gpio/gpio-mvebu.yaml  | 24 +++++++------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml b/Doc=
umentation/devicetree/bindings/gpio/gpio-mvebu.yaml
index d1695e7bd825..459ec35864fe 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
@@ -21,17 +21,21 @@ properties:
           - enum:
               - marvell,mv78200-gpio
               - marvell,armada-370-gpio
-              - marvell,armadaxp-gpio
           - const: marvell,orion-gpio
=20
+      - description: Deprecated binding
+        items:
+          - const: marvell,armadaxp-gpio
+          - const: marvell,orion-gpio
+        deprecated: true
+
   reg:
     description: |
       Address and length of the register set for the device. Not used fo=
r
       marvell,armada-8k-gpio.
=20
-      For the "marvell,armadaxp-gpio" variant a second entry is expected=
 for
-      the per-cpu registers. For other variants second entry can be prov=
ided,
-      for the PWM function using the GPIO Blink Counter on/off registers=
.
+      A second entry can be provided, for the PWM function using the GPI=
O Blink
+      Counter on/off registers.
     minItems: 1
     maxItems: 2
=20
@@ -103,18 +107,6 @@ allOf:
       required:
         - reg
=20
-  - if:
-      properties:
-        compatible:
-          contains:
-            const: marvell,armadaxp-gpio
-    then:
-      properties:
-        reg:
-          minItems: 2
-        reg-names:
-          minItems: 2
-
 unevaluatedProperties: true
=20
 examples:
--=20
2.36.1

