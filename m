Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C58452228C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348150AbiEJRaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348085AbiEJR31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:29:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C73B2BF330;
        Tue, 10 May 2022 10:24:50 -0700 (PDT)
Message-ID: <20220510171254.843410802@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652203488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rTfQBfOFn/Hf22H4lKTwQ/RGsWnwxvcYlcKZgAO7w7M=;
        b=QJ1b+XEjyiioenbbPunMQMba6BXqqjawsNy+rHL+e7bnIEhV06uawmeJE6oXCS64B/qWcw
        tfwIS17P4q82W1AVvhtxrqKXWnc0ykcLVo960sp1m9H2LiVsx4t589XxwWWVciRVMooLL7
        2eWKrLGVYxj0hRRm//e40GyXXUaTJEbJrHl6JgaCeJ8SNM6C3vRNC7okTSN8+YyPU9Ghqo
        YurEe7Dsb5xjMh6CnUf7htkPjKHgJw/zuVL7RVYVktOcY+brvSHTx9b8W+H/vLb7lB4AuN
        ZR4KIMvW2ZoxPmPS6CFMktpcK2PaI7qiMBef3MdGGxRY/Sqb/Nu0ltl6pQZeRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652203488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rTfQBfOFn/Hf22H4lKTwQ/RGsWnwxvcYlcKZgAO7w7M=;
        b=Llio6rL/1qA3FGuhCciOcYjWyLBI4M3lIjrhAch4fihVwV5Rv6282NZuV8smCiIwdcaEE9
        HRJFoHYHBGjwksBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-spdx@vger.kernel.org,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [patch 08/10] clocksource/drivers/pistachio: Convert to SPDX identifier
References: <20220510171003.952873904@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 10 May 2022 19:24:48 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The licensing text references explicitely the COPYING file in the kernel
base directory, which is clearly GPL version 2 only.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-pistachio.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/clocksource/timer-pistachio.c
+++ b/drivers/clocksource/timer-pistachio.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Pistachio clocksource based on general-purpose timers
  *
  * Copyright (C) 2015 Imagination Technologies
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #define pr_fmt(fmt) "%s: " fmt, __func__

