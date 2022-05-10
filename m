Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA937522288
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348072AbiEJR3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348070AbiEJR31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:29:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17F72BF314;
        Tue, 10 May 2022 10:24:43 -0700 (PDT)
Message-ID: <20220510171254.592781786@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652203482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Jdru0Z4dwxxx1ZDnJ61CKzrL+VDbbe/34GiMgPlOESc=;
        b=dej1QhTEQHZGvyz2ZRPoKQ0/+dfoCXAc2Hrcko138SclpN3Gt6N6hV1KwINv92QDPUH1bo
        Jwt/vYeRjlF98j2VufvGqREITK86u9kEy8HXoizRZzXyv1KXIUsoNtfNClZbvR8R1kXgi8
        UsH/yWJEMqcRO7XBVmkLf4xjnbzHx5Ltmtb6Xx9EV559Dl7VrOlXvaGHpNeuSuvMa0gA5E
        ReLBjVqGnJpzJZg4LLINhsZ3TlHp/Mfe6N1xkrssl//4mGHo+dKMnOVYf4mdXTr/AdleVA
        YWo6yrig9llGPaIb3WfaaeE6UKBAj2BW8l8VBdkwA/P4pWnbWfex4AZT7JXcPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652203482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Jdru0Z4dwxxx1ZDnJ61CKzrL+VDbbe/34GiMgPlOESc=;
        b=lPGIiaW2aCNcY6sd4PoCCE1VbDjMAhUyirgIuNKBszoRUqyHygGyvY8E6Y/QnSIoimrjmf
        WvMX2dHCbcxktoDQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-spdx@vger.kernel.org,
        Gregory Clement <gregory.clement@free-electrons.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [patch 04/10] clocksource/drivers/armada-370-xp: Convert to SPDX identifier
References: <20220510171003.952873904@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 10 May 2022 19:24:41 +0200 (CEST)
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
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-armada-370-xp.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/clocksource/timer-armada-370-xp.c
+++ b/drivers/clocksource/timer-armada-370-xp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Marvell Armada 370/XP SoC timer handling.
  *
@@ -7,10 +8,6 @@
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
  * Timer 0 is used as free-running clocksource, while timer 1 is
  * used as clock_event_device.
  *

