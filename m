Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2283F545D21
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346766AbiFJHW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346721AbiFJHWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:22:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1393F333;
        Fri, 10 Jun 2022 00:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654845718;
        bh=IQX8e4DimYSxfYiB0892MoZKJaCfS7TtVYY2navJcRE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CuMibIAZmB/ve2MuTr1f1+wZVderTUs7KGiC13adrseH2oLgJT4zT8wqkV4hqMauL
         8W7TK1+u22oOoDY+LIJa8HI9JXrLrseZbbirKlJmpgTR57jaaVfz2mLGe9ob7FDjlf
         D3eeelWzAIdUfOHB8PbJG+WpyqqpqS1JuXdF7UJ4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.3]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuDXp-1nlLT91uOb-00ucv9; Fri, 10
 Jun 2022 09:21:58 +0200
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
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v4 1/6] dt-bindings: timer: nuvoton,npcm7xx-timer: Allow specifying all clocks
Date:   Fri, 10 Jun 2022 09:21:36 +0200
Message-Id: <20220610072141.347795-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220610072141.347795-1-j.neuschaefer@gmx.net>
References: <20220610072141.347795-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yBVwif+DGktWM+o9r7sNiZrEwl/zKMtKSiq2+UCGtlsbNtgIk7x
 /bbX2sXzYaXAHSx44puYxomiEoqtXeh96nX3Juh/ZB+ZLZn7Na1fVtezN2XCv8yIcCHMfOp
 6fh5zvIqvP5lpYYiQJ7clKDGsnJE+kiOYvK6wveqk+3IERfbN/R0A10m7PgewWhnTtZnhXG
 pxyEgviIcFGYC0xKZ2leg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OysjaKN0sh4=:FlL2Ak8DjTMz8OOajXTmsw
 tDNGd70HsIgiPxXBYKsnztMa+Fk+Pml/h35M59WmgIjr6X7U/mOLkuQ2CqYDhU+5QtbWB9UTx
 nq2ioahzPVyDN57LmqmaFIppfYPuPZQz3APeIcRze5Qd7FnCtu4OhWynBIF+3J8ymqX1RjTxN
 fgoTN9Q/YbgvYTBFlVib8DB7ZSJkH/8Wnp4bcL0GfereOLuFkqzXWT82pCKgG6/CcRdO6APNO
 1R/KMbXovtwtwuvHr9U4HVg4jjG86Lcb6FBhONxvyYH3nQTAtAmE/jpSoA7jNFfK8YsEuW0nC
 pxpCMS/iGnCkNaQD7uwxPRf5J5lOnpPzeKat0wsEq27rJbwhnDzgfm/3682Pe/1OrPRsXJRvi
 u56mUm4jdBx9VgD3xlauvcTHaFVap/4K+OFihvebbxT+oiR+OE1wJDINFPhwAuEGg8ap6oAbC
 jCaKogVszBpVuu1YBoz8dd1YoVOOPWH/CnRzgt3OUUsSGrkRr79o9cQlPp7mgPln6y8mnfYF8
 b+9RWX1AYtt9Sf8pPCVs4Mra1Lp4tqVyEqqG8Z/b2bjbCJMtSbruwpExkvVWClZvhfGflRkBm
 1+K6IVodoq+l8UNxpIKMA6UXhfjd5PNC75ZD5laQh0aobHF5SdjXMS0HM7XPaJ6BCnEbt8Ycu
 jfYp1Sj5wc1VD/NZg32B4hlS3/YGSBK3BA+B7p85BiFB7rQwOlGglNi7Wfy7A/KlwQ+6yCj2k
 seHkoCEKI9cJd11pQj5Z3+MVwEzs7SbugxIKmKM529HEXfKvR6+oqzRRHfnLr2m7a6dnnPDUW
 fHgmCami6/UnQ5crYy/O8IH2CzMEvWH5aFsZfCtpd9S0idSlkYOMxnkOTZHbG2NVUPOOOomo7
 9IzKqpehLW3E009ZA8NoQKXcbIZA23AcI75h7CVRD2RMqjkNCgAUqwB0DINaC3CyrCkyIbqeN
 8b7qgM8JDN0TAAGrqtBD+kZOphVKi/KJeT08BpqepDP6olk2r9fcmu/HCQhodinlbp/AoT1ex
 znrsGHZEmt8fmE3gExnaK0Xp0JVSqUZlQYMKsoOB8lhzR6lo7kVeJ0UnAGZrs35dljK6FJVVj
 BBjbXARDBPTVPT7acTieD/ZFkAbFNfWWZp1yyqGUjLXPrQqO1sU2WQ0Rw==
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

v4:
- no changes

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

