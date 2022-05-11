Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351E4523DDB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347170AbiEKTrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347115AbiEKTrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:47:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA94537A38;
        Wed, 11 May 2022 12:46:59 -0700 (PDT)
Date:   Wed, 11 May 2022 19:46:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652298418;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wmmMT3SgKn2fUDYzEVne1iTZDAgs1kt67CYyRUT4DPc=;
        b=juWcbmoU63z2JYbRxVnt14Xw9T40wTzMvaUOkpemTsluI7ElyISOLEEpS0i1kG5UZY8WdO
        WQGF7bQUKWFBekHLvr4d5Y7dXEIx0ICNyBbdvca44jY/uyxyZzeIHub52rkFcyXu7SaNZe
        9MhgDUn6IrsNnDkXe+POu6P+NnATteQ67DKxsusLOQZsG83EevSixpt8ydslMB9+ywWf0H
        1c9rVzOiiQqYAUmaIuPhqtrw9MITdH7uU/feU3rFK0jBchp+U5dXtvzTGiMZEnvdxKld1t
        PFeJqKRcyrrzI3PsbOU0c4pFeUWhPo0FZlOefzkQLIEes3lAX4emiYVjnATolA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652298418;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wmmMT3SgKn2fUDYzEVne1iTZDAgs1kt67CYyRUT4DPc=;
        b=I4fAT1SFwmYfjnLXo33dbjaXCOtdUrCJ6+ixfYMhOw9h6bmCyfgrIPsJscNynu9/bMAX1L
        lVt4XLodMGxi6kCg==
From:   "tip-bot2 for Ravi Bangoria" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/ibs: Fix comment
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220509044914.1473-9-ravi.bangoria@amd.com>
References: <20220509044914.1473-9-ravi.bangoria@amd.com>
MIME-Version: 1.0
Message-ID: <165229841735.4207.7266070474291537425.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9cb23f598c641c1dcbe18defd219cdc439bc94a8
Gitweb:        https://git.kernel.org/tip/9cb23f598c641c1dcbe18defd219cdc439bc94a8
Author:        Ravi Bangoria <ravi.bangoria@amd.com>
AuthorDate:    Mon, 09 May 2022 10:19:14 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 11 May 2022 16:27:10 +02:00

perf/ibs: Fix comment

s/IBS Op Data 2/IBS Op Data 1/ for MSR 0xc0011035.

Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220509044914.1473-9-ravi.bangoria@amd.com
---
 arch/x86/include/asm/amd-ibs.h       | 2 +-
 tools/arch/x86/include/asm/amd-ibs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/amd-ibs.h b/arch/x86/include/asm/amd-ibs.h
index 46e1df4..aabdbb5 100644
--- a/arch/x86/include/asm/amd-ibs.h
+++ b/arch/x86/include/asm/amd-ibs.h
@@ -49,7 +49,7 @@ union ibs_op_ctl {
 	};
 };
 
-/* MSR 0xc0011035: IBS Op Data 2 */
+/* MSR 0xc0011035: IBS Op Data 1 */
 union ibs_op_data {
 	__u64 val;
 	struct {
diff --git a/tools/arch/x86/include/asm/amd-ibs.h b/tools/arch/x86/include/asm/amd-ibs.h
index 174e7d8..765e9e7 100644
--- a/tools/arch/x86/include/asm/amd-ibs.h
+++ b/tools/arch/x86/include/asm/amd-ibs.h
@@ -49,7 +49,7 @@ union ibs_op_ctl {
 	};
 };
 
-/* MSR 0xc0011035: IBS Op Data 2 */
+/* MSR 0xc0011035: IBS Op Data 1 */
 union ibs_op_data {
 	__u64 val;
 	struct {
