Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C22522289
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348101AbiEJR3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348035AbiEJR31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:29:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958FC2BF32A;
        Tue, 10 May 2022 10:24:48 -0700 (PDT)
Message-ID: <20220510171254.780389240@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652203487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+CqeOXLh4GC9Cft2JnFn6EHiV1vdzMPeemNzMClYCpI=;
        b=ntqebqeFIiurgFgyEQ6s2AblsKl9BB/9CtkNPKDvhCxRbUxVRzhKAcE3gUZf0YbLRFlde5
        1oQ+SXOtyMCB/HSDyUYO6sv1MLmezTFx0N1UP1lDCI7LBse385AlWKReJQU77CllItZi6N
        bx4LNMnnGfKzqLJqlbEyS9sceUzftPANAJSn5ue9GO/mNPCJxtvC7N2IWMV6pklx/3kHtw
        ZiiALLOqU/bJ/23/IuB0VKPHJ8jqPyQOWwzETPgTvBCPrWDNFoCamBlJZC8kGIyiIjcZtx
        gupG/XLVmKFQsit0teO7CiYghsE8WwQsylWZEkvRe48GpEdC9jwJktVsV/Xe2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652203487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+CqeOXLh4GC9Cft2JnFn6EHiV1vdzMPeemNzMClYCpI=;
        b=WAXpvTvfCt8APg7oom7qDZxxi39ZVCy9IFuediFU+eSqHIfqK0BDPVIzJbCegXCnD0lJ2J
        21g/H8B+03vovmDA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-spdx@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [patch 07/10] clocksource/drivers/orion: Convert to SPDX identifier
References: <20220510171003.952873904@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 10 May 2022 19:24:46 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The license information clearly states GPL version 2 only. The extra text
which excludes warranties is an excerpt of the corresponding GPLv2 clause
11.

So the SPDX identifier covers it completely.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-orion.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/clocksource/timer-orion.c
+++ b/drivers/clocksource/timer-orion.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Marvell Orion SoC timer handling.
  *
  * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
  * Timer 0 is used as free-running clocksource, while timer 1 is
  * used as clock_event_device.
  */

