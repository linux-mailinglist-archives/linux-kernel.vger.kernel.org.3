Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6382504DB0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 10:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237221AbiDRIXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 04:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237218AbiDRIXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 04:23:09 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C47192B0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 01:20:30 -0700 (PDT)
X-UUID: 3b5ebf33dde74f2da049659e03ce7e1d-20220418
X-CPASD-INFO: b3950e822f834d0e918767911d2cc1d4@q4NzVV2XZmJehnp_g6d7n1liaGdmY1m
        Ac55Sk5FhkFSVhH5xTWJsXVKBfG5QZWNdYVN_eGpQYl9gZFB5i3-XblBgXoZgUZB3sXVzVWCTaA==
X-CLOUD-ID: b3950e822f834d0e918767911d2cc1d4
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:186.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:65.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5.
        0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-5
        ,AUF:0,DUF:37468,ACD:257,DCD:359,SL:0,EISP:0,AG:0,CFC:0.335,CFSR:0.076,UAT:0,
        RAF:0,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:0
        ,EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 3b5ebf33dde74f2da049659e03ce7e1d-20220418
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: 3b5ebf33dde74f2da049659e03ce7e1d-20220418
X-User: sunliming@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by nksmu.kylinos.cn
        (envelope-from <sunliming@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 989743572; Mon, 18 Apr 2022 16:19:06 +0800
From:   sunliming <sunliming@kylinos.cn>
To:     tglx@linutronix.de, dave.hansen@linux.intel.com, mingo@redhat.com,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, sunliming <sunliming@kylinos.cn>
Subject: [PATCH] x86,trace: Remove unused headers
Date:   Mon, 18 Apr 2022 16:20:21 +0800
Message-Id: <20220418082021.436433-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused headers.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 arch/x86/kernel/tracepoint.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/tracepoint.c b/arch/x86/kernel/tracepoint.c
index fcfc077afe2d..f39aad69fb64 100644
--- a/arch/x86/kernel/tracepoint.c
+++ b/arch/x86/kernel/tracepoint.c
@@ -8,10 +8,7 @@
 #include <linux/jump_label.h>
 #include <linux/atomic.h>
 
-#include <asm/hw_irq.h>
-#include <asm/desc.h>
 #include <asm/trace/exceptions.h>
-#include <asm/trace/irq_vectors.h>
 
 DEFINE_STATIC_KEY_FALSE(trace_pagefault_key);
 
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
