Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B380583C47
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbiG1KoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236067AbiG1KoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:44:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FB2558CD;
        Thu, 28 Jul 2022 03:44:03 -0700 (PDT)
Date:   Thu, 28 Jul 2022 10:44:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659005041;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6dym8jQwKNJfRrMbWAQAa+tsSzahSV/26AMvapoU0zw=;
        b=K0dlb2Aka0j56S2aCT5cJvp3Ne/qaimMsOriJ1z+tDvNJSIzmGJh06wlpL8zZDVSOtuwkN
        dEqrRF9K/WdJMBhplo3OjiNVrZcu8ID3K5GDXbNExIKY/SKui3xsNF5tpx8Qy4vz9OVMRa
        IroyweTSChK052q4CKpNUG6dlrVGk88nBKiJDSMQ/mHiNUowK98VoFh7gG4Wq9rX6kOJUV
        Z//OG6tIXkioqeLF7X5NrGZ8uMN46uKI5JR+dve2weoxYK9kRnbMBU1bL1BN/nMqevbrzF
        KlwEDfadLsE7RfWm1IrRZ1X/v3SWabv3JJGmhu0WODbohR+f0oqnHgFwT65iaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659005041;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6dym8jQwKNJfRrMbWAQAa+tsSzahSV/26AMvapoU0zw=;
        b=JjnNaBFC5h6LWtqv/snBstvwxNTR7aemt3mzcqGdSoF7zJpjZcpXxAvlLVZjIs6AZU9P9N
        U3e6fS/wYjYdg8DA==
From:   "tip-bot2 for Krzysztof Kozlowski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: ingenic,tcu: use absolute path
 to other schema
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220726115937.101432-1-krzysztof.kozlowski@linaro.org>
References: <20220726115937.101432-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Message-ID: <165900504071.15455.4947109577211210102.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     561a0846182ef6fe87c20426d43fd956a644687a
Gitweb:        https://git.kernel.org/tip/561a0846182ef6fe87c20426d43fd956a644687a
Author:        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
AuthorDate:    Tue, 26 Jul 2022 13:59:37 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 27 Jul 2022 17:01:52 +02:00

dt-bindings: timer: ingenic,tcu: use absolute path to other schema

Absolute path to other DT schema is preferred over relative one.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Paul Cercueil <paul@crapouillou.net>
Link: https://lore.kernel.org/r/20220726115937.101432-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/ingenic,tcu.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
index d541cf2..0a01e4f 100644
--- a/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
+++ b/Documentation/devicetree/bindings/timer/ingenic,tcu.yaml
@@ -113,7 +113,7 @@ properties:
 patternProperties:
   "^watchdog@[a-f0-9]+$":
     type: object
-    $ref: ../watchdog/watchdog.yaml#
+    $ref: /schemas/watchdog/watchdog.yaml#
     properties:
       compatible:
         oneOf:
@@ -145,7 +145,7 @@ patternProperties:
 
   "^pwm@[a-f0-9]+$":
     type: object
-    $ref: ../pwm/pwm.yaml#
+    $ref: /schemas/pwm/pwm.yaml#
     properties:
       compatible:
         oneOf:
