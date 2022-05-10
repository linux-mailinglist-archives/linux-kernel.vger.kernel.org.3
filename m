Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35710522290
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348156AbiEJRa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348077AbiEJR31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:29:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D552BF321;
        Tue, 10 May 2022 10:24:45 -0700 (PDT)
Message-ID: <20220510171254.655035023@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652203484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=OX3ZZIHB57cv1ap5MwgGLW9zpPS1Hd+CwymGFolU6dQ=;
        b=WcQ74u2sd4hEN9YEoL3Ht4xcPqtjK64tQbBX9wbpsF67mUFi85KPf5ZS1wwRq3ivleNx6+
        XWGTOaM7HgrZqzlk4KlmHZWqYoZ7ctOw7pMso2sYgz/2TPhIS/AOzmLLUB+55lyWxH3HL0
        hkdljM9J2UcJJQfxlX4tb0nQNEKXITs5gv2yH7U0m1nVadztUS/hqzO1/9AG2Gyko9fH7F
        llLfoKeM+jpqXneJRuH/XdYJMYXqi5SbeGuZkv6q3LOeRedAxWVWjq0U5C3uX/q6b1gaXw
        8QK9/nOX6qtrKBKsT5BrmEIMvv6pHwUP+7fS+RbnS3RqcuBd+26ZC2Y7XpfvMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652203484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=OX3ZZIHB57cv1ap5MwgGLW9zpPS1Hd+CwymGFolU6dQ=;
        b=KkweOoYl2z3X1JIKSBy74gRNXqDNGADL0x7imrAOR5u9ZsD8mgwHKrEfLAv0DA7hrwtXz/
        n/+O8STJAn5vauBg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-spdx@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Baruch Siach <baruch@tkos.co.il>,
        linux-arm-kernel@lists.infradead.org
Subject: [patch 05/10] clocksource/drivers/digicolor: Convert to SPDX identifier
References: <20220510171003.952873904@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 10 May 2022 19:24:43 +0200 (CEST)
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
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Baruch Siach <baruch@tkos.co.il>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/clocksource/timer-digicolor.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/drivers/clocksource/timer-digicolor.c
+++ b/drivers/clocksource/timer-digicolor.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Conexant Digicolor timer driver
  *
@@ -11,10 +12,6 @@
  * Copyright (C) 2013 Maxime Ripard
  *
  * Maxime Ripard <maxime.ripard@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 /*

