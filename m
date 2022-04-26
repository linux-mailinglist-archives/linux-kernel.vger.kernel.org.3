Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E14E510CF8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 02:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356267AbiD0ADv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 20:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiD0ADu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 20:03:50 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA9527B01
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 17:00:40 -0700 (PDT)
X-UUID: b233d3033cc143dca46f30c318016835-20220426
X-CPASD-INFO: ec2a26a938a1483594dfecc6402256a9@rrNsgV9rj2lfWKN9g3t-b1lkkIa0pZ1
        WZF5iXlWLs4V6Ul9sWVWEfWxUXWleZWFNe3dzVF1lYGFcWHZ5lHKPVGBeYIJUdJOAp51SkWBm
X-CLOUD-ID: ec2a26a938a1483594dfecc6402256a9
X-CPASD-SUMMARY: SIP:-1,APTIP:-5.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:-5.0
        ,ESV:-5.0,ECOM:-5.0,ML:-5.0,FD:-5.0,CUTS:-5.0,IP:-5.0,MAL:-5.0,PHF:-5.0,PHC:-
        5.0,SPF:4.0,EDMS:-5,IPLABEL:-5.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-5
        ,AUF:3,DUF:38531,ACD:266,DCD:368,SL:0,EISP:0,AG:0,CFC:-5.0,CFSR:-5.0,UAT:0,RA
        F:0,IMG:-5.0,DFA:0,DTA:0,IBL:-5,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:0,EAF
        :0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: b233d3033cc143dca46f30c318016835-20220426
X-CPASD-BLOCK: 0
X-CPASD-STAGE: 4
X-UUID: b233d3033cc143dca46f30c318016835-20220426
X-User: sunliming@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by nksmu.kylinos.cn
        (envelope-from <sunliming@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1719923242; Tue, 26 Apr 2022 20:08:36 +0800
From:   sunliming <sunliming@kylinos.cn>
To:     mingo@redhat.com, rostedt@goodmis.org, tglx@linutronix.de,
        bp@alien8.de, dave.hansen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        x86@kernel.org, sunliming <sunliming@kylinos.cn>
Subject: [PATCH v2] x86,trace: Remove unused headers
Date:   Tue, 26 Apr 2022 20:09:50 +0800
Message-Id: <20220426120950.495950-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,T_SPF_PERMERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4b9a8dca0e58 ("x86/idt: Remove the tracing IDT completely")
removed the tracing IDT from the file arch/x86/kernel/tracepoint.c,
but left the related headers unused, remove it.

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
