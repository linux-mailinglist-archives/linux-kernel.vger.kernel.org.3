Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229FA5A76B4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiHaGeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiHaGe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:34:29 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E5CBD747
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 23:34:27 -0700 (PDT)
X-QQ-mid: bizesmtp81t1661927641to564cr6
Received: from localhost.localdomain ( [182.148.13.26])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 31 Aug 2022 14:33:59 +0800 (CST)
X-QQ-SSF: 01000000000000D0E000000A0000000
X-QQ-FEAT: 0EOhYdNGHFJODcCsJlB+PndVE3HKuxUu2dJoUGjj4nzM/BN4ZgNINucadzpaH
        24ZgGGgIzdHX6gyQOzAsLVPFPIa72oXHvA3skG4n2hMcUrXOvGV0hgtvZGxqzWNmkLzasZ2
        38yRt5bjWYaFdZiMnctDZkIZrTczbB9vqx583Urez6hAVI5h8qPXMLNtH6uiyU0LaMOuvvg
        EExv875xfCQE3qXvMcNIn4o75ANuri0E+Nee3UUK8jvkOrIgFAi61cjQKO4uOrprQSLfsMo
        9h1S8wolg7Ach8O0yijzbT8RvgYSnPZzr9PcocLKnOk6jPKd54VaE69E81qYs8hvIW+p4KC
        IS/JAoKW2kpte5f+hAomg2jMycFktK/0gf7qzLFfniK59t+MxkL23VrKnwthw==
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes@sipsolutions.net
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] um: fix repeated words in comments
Date:   Wed, 31 Aug 2022 14:33:53 +0800
Message-Id: <20220831063353.15700-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_00,RCVD_IN_PBL,
        RCVD_IN_SBL_CSS,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *      [43.155.67.158 listed in zen.spamhaus.org]
        *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'in'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 arch/um/kernel/physmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
index e7c7b53a1435..91485119ae67 100644
--- a/arch/um/kernel/physmem.c
+++ b/arch/um/kernel/physmem.c
@@ -169,7 +169,7 @@ __uml_setup("iomem=", parse_iomem,
 );
 
 /*
- * This list is constructed in parse_iomem and addresses filled in in
+ * This list is constructed in parse_iomem and addresses filled in
  * setup_iomem, both of which run during early boot.  Afterwards, it's
  * unchanged.
  */
-- 
2.36.1

