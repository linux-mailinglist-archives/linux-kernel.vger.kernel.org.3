Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF5558CB1C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 17:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243741AbiHHPQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 11:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbiHHPQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 11:16:23 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF90D10AF
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 08:16:20 -0700 (PDT)
X-QQ-mid: bizesmtp72t1659971776t7o87n9q
Received: from harry-jrlc.. ( [182.148.14.53])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 08 Aug 2022 23:16:04 +0800 (CST)
X-QQ-SSF: 0100000000200030C000B00A0000020
X-QQ-FEAT: UMQM+3VOEYugTYxy/3qdT57U6306eboGSBKchY3c73RC8lnbSZlOKCEKqEclc
        jV/py7hub2sQJWCnoXXvzfaFFLTBUbh9IAOK2pd5wtUyH9zzv1bhuo0D21O7KntCw9ZFn53
        jklnRje3+CUta8Y11yQTac2yt5RfsEd2+YWs//bQmb3xTus4MdevmfZ/6mm2Yb70LQzXJky
        psIwCzQF6UGTKa3mSYHFp7P8MN1Kxx8FIoKClXOaellsoFwz/k6kTjWmTWAggBSN7yu9e4M
        6YUMJK8X6+9eLRAD6Ap+WZ+WM5vZRcRMpUsmrkeRM/9ryaexdzvZlNKoZQ+C91kIwbUB+XN
        gCLgcLqw40crkSAaIVca+5AfvpW48LfwnyXxoRjmJ/MYYFFEo12Pi0zxh5UAA==
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] KVM: x86/mmu: Variable type completion
Date:   Mon,  8 Aug 2022 23:16:02 +0800
Message-Id: <20220808151602.59140-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'unsigned int' is better than 'unsigned', which has several changes.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 tools/lib/traceevent/plugins/plugin_kvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/traceevent/plugins/plugin_kvm.c b/tools/lib/traceevent/plugins/plugin_kvm.c
index 9ce7b4b68e3f..068d4b8cfdd3 100644
--- a/tools/lib/traceevent/plugins/plugin_kvm.c
+++ b/tools/lib/traceevent/plugins/plugin_kvm.c
@@ -225,7 +225,7 @@ static struct str_values svm_exit_reasons[] = {
 };
 
 static struct isa_exit_reasons {
-	unsigned isa;
+	unsigned int isa;
 	struct str_values *strings;
 } isa_exit_reasons[] = {
 	{ .isa = 1, .strings = vmx_exit_reasons },
@@ -233,7 +233,7 @@ static struct isa_exit_reasons {
 	{ }
 };
 
-static const char *find_exit_reason(unsigned isa, int val)
+static const char *find_exit_reason(unsigned int isa, int val)
 {
 	struct str_values *strings = NULL;
 	int i;
@@ -358,7 +358,7 @@ static int kvm_nested_vmexit_handler(struct trace_seq *s, struct tep_record *rec
 }
 
 union kvm_mmu_page_role {
-	unsigned word;
+	unsigned int word;
 	struct {
 		unsigned level:4;
 		unsigned cr4_pae:1;
-- 
2.30.2

