Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FBD522282
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348076AbiEJR3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348016AbiEJR30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:29:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E634D2BAE5B;
        Tue, 10 May 2022 10:24:41 -0700 (PDT)
Message-ID: <20220510171254.529249404@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652203480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ymoBlOGN2ybNUuPo4wojs5hcQRHP3a2WlqWJBn+DUm4=;
        b=vufO8Hja8bINZyZPG6SGh615X52P+Ij4wwRXcvisaFTxzUtrNxjQUCG/ubBeu016GhN2gf
        PtcClYnDRGtgQWcTwd0clkYmklqYIFNF7RFRNTVv5xaeKmgj7I0yHK0nV0UfuOHqA0+GC3
        9porDwFu58cWKIJsOUPv9DI4Gic2uptUMj0MUj/dJvS+uXVGDF9WBPKm4uhzxLOoWDeyJV
        K0AzEjVb7JNj7z8V69Ht1yNPUpmtM8hQNJ3we5PF+qnc1JfQB0GitfLg21cSX/SlKFqvo+
        q9Q4FVVAqGai39AvHCPnSzv5awVp50OoPLw+FUxyKSv6uzqoAcrK8DhnsZOBKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652203480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ymoBlOGN2ybNUuPo4wojs5hcQRHP3a2WlqWJBn+DUm4=;
        b=u6XvzzxQUQQ3fTQ/dMKNp7FAB032iNrqjtZ7Nyy7mPlgJCCvTwHzzhfairobEjD2tbtw4H
        li4LgJeSVL47vdDQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-spdx@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-mips@vger.kernel.org
Subject: [patch 03/10] clocksource/drivers/mips-gic-timer: Convert to SPDX identifier
References: <20220510171003.952873904@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 10 May 2022 19:24:40 +0200 (CEST)
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
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Serge Semin <fancer.lancer@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-mips@vger.kernel.org
---
 drivers/clocksource/mips-gic-timer.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -1,10 +1,5 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
- */
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2012 MIPS Technologies, Inc.  All rights reserved.
 
 #define pr_fmt(fmt) "mips-gic-timer: " fmt
 

