Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DA451F0C6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiEHTsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiEHTsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 15:48:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED98B849;
        Sun,  8 May 2022 12:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652039024;
        bh=mGjWYLEwtu+ry5GXvt2ravbif89/+OFp+v9Ndwokqdo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KPG+FxkKQDZ5nsfn9b/rDbyRj/EIqKAafJrmd0UKHk3sF7F0EpIr9E0HuW+sj9MmE
         F6jSp87+YhIrpWvSy/70KQZZgiUasjqmT3gk+bqpdehgm0Tu1LSAxs+xcWauIFHWJO
         LN0zyxBJ2Q90EaNevt4+QnKnN3sWHZxrhChH4Y5M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.103]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M59C8-1noskF3cxw-001D9L; Sun, 08
 May 2022 21:43:43 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/7] dt-bindings: timer: nuvoton,npcm7xx-timer: Allow specifying all clocks
Date:   Sun,  8 May 2022 21:43:26 +0200
Message-Id: <20220508194333.2170161-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220508194333.2170161-1-j.neuschaefer@gmx.net>
References: <20220508194333.2170161-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+B8D9NNv1GquKXyh+yewe8u/YXwDSp0omRF9EcPdcedfR2AXylE
 J1AAfDCtk1qY+HAxFunLVRrV18OJHIvc7EDyOOtcTwouPCChp/DNsHnUQHZDqgWERyuPagV
 X3P1BvR4gdkav6U/K/2NPsrhWLngw/NR5mURmKEnd+ZzDRYHM7q7F0VB6IL7wxqCkulSdi9
 N3W8ciYjZX4nRwIkhXYvg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3V62gOaobJc=:u7MPmttD/cbQagij6o+M6e
 A1ZgpIfOP04t2VpF2yls4Fr1yKyPFRpoJAVOsfVK3lip+W4IH6N1atgx+OYVetTttNeE6sJe8
 UFvKAKZ7rIDLPMnxXkzCQ1HTarfQ8W+Zdsks+9dSjg25zN1RbNF+wUUfeS1qBa4yj21neK38i
 +FsmfZSiHWlv9dIa14fF+lceiHFEElLdVfZK1uj+YZbqPveniamE8ccpQIK0/U1xuFaFgCKsU
 6CsIy0FsbEE9DdBDpwL0FDsfkAUHJ8CLvvIVEtmHIAf8Xo3YId+07sCAZLFKCPH12bvRQPqSx
 AtdPOYd+4htYu86XBjRSkKiHSkG9w2hG/XtTEGea32xKLScSm7Mue2rPzc1PhK8FyelEb3Fhk
 kfB65E7zXM3FTwmUcSkZKQsMSHpsobQpHu7t3+mYvYFt0E3iVe3ld0dsWUGL7l8/0veOTPTdk
 Hfl89lyE9m/kuTbw2DycNFTu08GAlP3+8hfpCdI8Qbp0GvmYlYqyGDOlAJ3sZCqZor6+x1OkE
 fks595DFnq3ROcqdSVcSqvtx5Gp5WLVrAwAp+pC0MyzboFr/0erS1Wosk6O6QCSrc+xrGw4Du
 s9ZnU7q9PXs6aiR06M8ckI4AZuIUlxggw8Aa1lGiOh69MokAfR3mnxSZ83zwopw0Np1eYRneb
 5mkm5b3cok+GZ8QLShpqXTBICOXyzxW9/d1gXsL7PY7QfCvjA6y8IvFt/8n60BT+Jxj6YMfsl
 EvTPmKJSW3pcYtthQu5mPTaR9BL3KvcHzROGLEFbAszRf6BhamQJx8zWC7oGL9NAzEowy/ZIE
 39fepLWo06hJoD64GqoCZmf6uQ6gK/wV8Y8EcIGhBe5yRniHbRo43EzVlwppfdWCjwYASYEca
 QQRS3fC1+C71MdUIpJdvuRq9k85w7VejOD/Oj5bLgM1/5EihGiA0CsjHWs/m5Sjw3633cTci2
 tdmO2yicl189R7qgV92XYLkvyVi2TL/C+WASWvEkZ8F4VwBKk289fpCssVSTDQRCud5PwkTpU
 AGVvu1qOjbkaFI/DRQsk+P2ODF8N6DLo9cKituwDI3IwO8qU7ifhLkfAnKzWfMAIcD64b30/8
 6v6fStfcg2PBro=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timer module contains multiple timers. In the WPCM450 SoC, each timer
runs off a clock can be gated individually. To model this correctly, the
timer node in the devicetree needs to take multiple clock inputs.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Reviewed-by: Rob Herring <robh@kernel.org>
=2D--

v3:
- Add R-b tag

v2:
- no changes
=2D--
 .../devicetree/bindings/timer/nuvoton,npcm7xx-timer.yaml  | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer=
.yaml b/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.yaml
index 0cbc26a721514..023c999113c38 100644
=2D-- a/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.yaml
@@ -23,7 +23,13 @@ properties:
       - description: The timer interrupt of timer 0

   clocks:
-    maxItems: 1
+    items:
+      - description: The reference clock for timer 0
+      - description: The reference clock for timer 1
+      - description: The reference clock for timer 2
+      - description: The reference clock for timer 3
+      - description: The reference clock for timer 4
+    minItems: 1

 required:
   - compatible
=2D-
2.35.1

