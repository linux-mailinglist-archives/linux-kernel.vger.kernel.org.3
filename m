Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D3650C157
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbiDVWHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiDVWHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:07:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE1F31DDC;
        Fri, 22 Apr 2022 13:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650660721;
        bh=nH5nbmzHe/xRwz0pWDdjzn30b813GPDvATKACfo4I6g=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=eyIq38Ti8Xyoy7E0KkA29w0DkaRlW8dP8h5wyY9BNqYn3J9bSSzUP+PiTaibG9SWW
         ub/Uupa1SinGBG1AycTDetvFx9E3NVW1btY5UCZ0+WtMgR2lprvv76u7jqnf9PXAlo
         APJT4bkv9v2gXLwuJ7IC7ZKkhZzyEIufDZb39CVI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([87.78.190.74]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGQnF-1nh6473Djx-00GnuC; Fri, 22
 Apr 2022 20:31:46 +0200
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
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 1/7] dt-bindings: timer: nuvoton,npcm7xx-timer: Allow specifying all clocks
Date:   Fri, 22 Apr 2022 20:30:06 +0200
Message-Id: <20220422183012.444674-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422183012.444674-1-j.neuschaefer@gmx.net>
References: <20220422183012.444674-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lnBh/Tpvgmu7+wHhf+H5KmdyA2JGqflwIdExxJyori80ywRZSGg
 flOvQpXx/6FTotPushCAlRjkrTtc6+4Al0ktSv+PUZ0hpSYy2O5QKr8ZpiSt5c26UcjQFfW
 MAWFL4Hz8F9vQWjXrGC1jMgB2bGBiqgY4p203hrVJHH/jNtRhzgk4N0vl6J4PqBB2kLE79S
 VYINyKnXBIFnjHKOVSF+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GH6IMDgDjVk=:zwNWdBjXT58bbmqMOK1ZyH
 eKVkZYuRPsrGXFJR11x2HGexmFcrG5npjb3hw1G81xS9+G68DLMvyuSJV4bJk3zuLcYVJqa1M
 JWCQfcfDk5UKkQ1rlenE34gpA7hztwRAbHJ3iV6js3KyzuDVsz7Xo8zK/L+L4Yi0F085xgL+o
 PCIGn+niJIKUgnUVAwQKaQOF7iMw9eTwkXwpmnLbOjTqD5eJ5aG1UDFcRwINNWUvcvI5O4cda
 FQUNnGTdL7ujQZfXVbbM0ZBbIDcDFeIdagpMtfYnq0h+zFg8PJZCOlhXMwVdT6ULcVnprY1UJ
 n9mFbqmetOirWzDWemHEOkTuSHZQn2h6rEShW8mtcEW/nVfKJPcy4FF5BtIidgV33NM6mm8A+
 HWaHmQUaszJdqIepItfxN51b9DovnEQJd8AU8r4F2m9W8TQYAMToGJq0RoC/wG+Qi+iq0q/8E
 7L+7jniWOs5WQJj1+KSh+kuXBI8o60eik0JBj2P/bYnPGx6z7TzbU3u5mD1m0eknZ7YbQKvRX
 s6Qq7qwu3VdY3zwYawvsipVz9/hbIhNvnDjTHZIKK9021lvFY89Y3dXQ25/yJzSUyP/h6vqAC
 mLWNBcsefhfoCOf9EMY7Y1iHQRXaNOLMcDomv1Gyb2d+IzEBcAXNewrk7kZA4RPMlnF+ydcF0
 uH9kNHGGrDq+QvsnKHjBZWQxvezef3FAaaap6IRxvIKEeoDaNWDkMUCY/5bQPd5gF45Q9Nxtq
 bTPPVTzxFfMC5IkLZt3dGT+Vk5g6/FZ6r2Md5bslCrwrI9K6x5mQVeWdZVfnfEaGf/iLPNVuq
 FHTow+h+Ja7faVEPIx8RBs0/dP7YTJttdutvqRV1pNbPZp2FRYYC8g4Yv11aWbFNKS8X82J/F
 AbdPHOZSjmZ2I6JKMpkNbmZ8BIU3SisXUpxy2UqgVlrc3oVBR+87o8v+DQAX2Fv2QenHhXDu3
 QdDCeqGp3hOCaon8nS6Fx4843UHajRwjuzgvPIqr5Atg1Hgt07zD4FqllQMD+y/9T0Rmf/6Y0
 k5EC7jZo/XUQXoyyEyQ+Mpit8AG9G6ArfHdlYaDKkfSa5ZtaKLXdUEMTQY/i3vNI1kTulkD9T
 DSKFokWsM0Uosw=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The timer module contains multiple timers. In the WPCM450 SoC, each timer
runs off a clock can be gated individually. To model this correctly, the
timer node in the devicetree needs to take multiple clock inputs.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
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

