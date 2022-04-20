Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F019350834A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376692AbiDTIYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbiDTIYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:24:37 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A5325299
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:21:51 -0700 (PDT)
X-UUID: 30180f10c6a146ccadaf249a1afef23c-20220420
X-UUID: 30180f10c6a146ccadaf249a1afef23c-20220420
Received: from cs2c.com.cn [(172.17.111.24)] by nksmu.kylinos.cn
        (envelope-from <sunliming@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 902704730; Wed, 20 Apr 2022 16:20:25 +0800
X-ns-mid: postfix-625FC299-1526536288
Received: from localhost.localdomain (unknown [172.20.110.210])
        by cs2c.com.cn (NSMail) with ESMTPA id E9D6F383C03E;
        Wed, 20 Apr 2022 08:21:44 +0000 (UTC)
From:   sunliming <sunliming@kylinos.cn>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Cc:     sunliming <sunliming@kylinos.cn>
Subject: [PATCH] x86,trace: Remove the incorrect notes in file arch/x86/kernel/tracepoint.c
Date:   Wed, 20 Apr 2022 16:21:37 +0800
Message-Id: <20220420082137.1018577-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,T_SPF_PERMERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The notes "Code for supporting irq vector tracepoints." is used for irq
vector tracepoints. But commit 809547472eda ("x86/tracing: Disentangle
pagefault and resched IPI tracing key") has remove all of the special
code for irq vector tracepoints. And the file is common for irq vector
tracepoints and page fault traceponits. Just remove the incorrect notes.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 arch/x86/kernel/tracepoint.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/tracepoint.c b/arch/x86/kernel/tracepoint.c
index fcfc077afe2d..18daa9291002 100644
--- a/arch/x86/kernel/tracepoint.c
+++ b/arch/x86/kernel/tracepoint.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Code for supporting irq vector tracepoints.
  *
  * Copyright (C) 2013 Seiji Aguchi <seiji.aguchi@hds.com>
  *
-- 
2.25.1

