Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D947850834C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376701AbiDTIYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbiDTIYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:24:54 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E36325593
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:22:08 -0700 (PDT)
X-UUID: d36a1601c1d3401899026fca389b882a-20220420
X-CPASD-INFO: 97dda830c4bb42beb7efe951a2b9cc36@goeehI5qYWCPVKSug3Wtn4JolZaWZVW
        Ao2yCaZGTX1aVhH5xTWJsXVKBfG5QZWNdYVN_eGpQY19gZFB5i3-XblBgXoZgUZB3iHmehJFmYw==
X-CLOUD-ID: 97dda830c4bb42beb7efe951a2b9cc36
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:186.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:1.0,CUTS:82.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5.
        0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-5
        ,AUF:2,DUF:37722,ACD:259,DCD:361,SL:0,EISP:0,AG:0,CFC:0.282,CFSR:0.054,UAT:0,
        RAF:0,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:0
        ,EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: d36a1601c1d3401899026fca389b882a-20220420
X-CPASD-BLOCK: 1001
X-CPASD-STAGE: 1
X-UUID: d36a1601c1d3401899026fca389b882a-20220420
X-User: sunliming@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by nksmu.kylinos.cn
        (envelope-from <sunliming@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1897742763; Wed, 20 Apr 2022 16:20:45 +0800
From:   sunliming <sunliming@kylinos.cn>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Cc:     linux-kernel@vger.kernel.org, sunliming <sunliming@kylinos.cn>
Subject: [PATCH] x86,trace: Remove the incorrect notes in file arch/x86/kernel/tracepoint.c
Date:   Wed, 20 Apr 2022 16:21:50 +0800
Message-Id: <20220420082150.1018653-1-sunliming@kylinos.cn>
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


No virus found
		Checked by Hillstone Network AntiVirus
