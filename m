Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55834583C4E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbiG1KoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236060AbiG1KoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:44:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466D113E8D;
        Thu, 28 Jul 2022 03:44:02 -0700 (PDT)
Date:   Thu, 28 Jul 2022 10:43:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659005040;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KDyIabuMnmmbrb7lgp5WE4OgAEOWIqJEJwGBMojDZC8=;
        b=E8FBcsd08FCTAs/X/03OKMUTWReT2ESRp/EMJgSAK53gbFiU1naaRQJIBDrqcTiLz/SBvH
        HS4J0u7w1BXcHk0NCaY9xEMKlYgDXEi6w4ZoIGmo+Y5wARaoLf2qiR+G0mFf4q6BzJ892v
        ofCili9f49qY93VHf6fydIxOecFD8Yio9knzllIoe0fgPizNzYwZucs1fr3SQxJ0DLXskV
        Q5fmVAjJBpmkRcwi24pNKG2ZdsC67DBail4A2qjmqFrykJtmWPiCigUtR//ZHDeM0EtWtB
        x6MCSB5G5ijgzRUBgeghs/2KmMCLjJdysfLQYuVHeEB53fJP0y9zDIWnAXJw3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659005040;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KDyIabuMnmmbrb7lgp5WE4OgAEOWIqJEJwGBMojDZC8=;
        b=eWtUtOox2HehjnxZCjrlUohGtkx4JcMt6q+kIBwN9SzYS4DhbKOW/ffCyXJiJL+Y3O106G
        nK3z61hcIOE/7VAA==
From:   "tip-bot2 for Samuel Holland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: allwinner,sun4i-a10-timer: Add
 D1 compatible
Cc:     Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220725051715.56427-1-samuel@sholland.org>
References: <20220725051715.56427-1-samuel@sholland.org>
MIME-Version: 1.0
Message-ID: <165900503974.15455.18087719119523606326.tip-bot2@tip-bot2>
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

Commit-ID:     c329fb5318ef82e8793432f845ad916c3199a5b6
Gitweb:        https://git.kernel.org/tip/c329fb5318ef82e8793432f845ad916c3199a5b6
Author:        Samuel Holland <samuel@sholland.org>
AuthorDate:    Mon, 25 Jul 2022 00:17:14 -05:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 27 Jul 2022 17:01:52 +02:00

dt-bindings: timer: allwinner,sun4i-a10-timer: Add D1 compatible

Allwinner D1 contains the usual sun4i MMIO timer device. It contains two
timers like other recent SoCs, so it is compatible with the A23 variant.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20220725051715.56427-1-samuel@sholland.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml b/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml
index 53fd24b..3711872 100644
--- a/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml
+++ b/Documentation/devicetree/bindings/timer/allwinner,sun4i-a10-timer.yaml
@@ -20,6 +20,7 @@ properties:
           - allwinner,suniv-f1c100s-timer
       - items:
           - enum:
+              - allwinner,sun20i-d1-timer
               - allwinner,sun50i-a64-timer
               - allwinner,sun50i-h6-timer
               - allwinner,sun50i-h616-timer
