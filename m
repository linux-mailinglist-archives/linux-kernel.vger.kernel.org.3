Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F9457822A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbiGRMWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbiGRMWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:22:45 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29085252B5;
        Mon, 18 Jul 2022 05:22:37 -0700 (PDT)
X-QQ-mid: bizesmtp76t1658146914t4wjcjlp
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 20:21:52 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: Chk1D9siCl8X3rljEWiyDyOssf3yyAflpwUlZXf7I0WQJTLZEAQ0hH4vVQU6f
        f4MOrpbtLy7YeBjwqrhE8g8Drn4iDbF3pWXS0c6V3HBNMX4RrOi4l3xLHVWMKCsgurcsa5p
        4Vfs48M39itNmyN8Mca1L3Dx2UIvpy9v1CiVom+xf8X9nlmP23pVxxPNbPo20x8MD0EnPha
        FxmUsKOFg81iOCguyIW8lXynFV9NOWhKKvmZ3qb10cEfCxPsuJoFkiH807TTZHT5s/3oGRB
        J+4TMW/Y1mFH5gvwyap9k8is27YYYFmy3PxA+KvKo6AVqk4AIfZa8/HUB/tKlY/DYnGXY4h
        ArTF5A3h2fKJpFXbblLpcJfs2kF985gWBWQZK1v6bAYCH0xoA/sZUdEfq1AzIIDWJ7+LRhH
        zLtq1uLYvqY=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     davem@davemloft.net
Cc:     ebiederm@xmission.com, arnd@arndb.de, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] sparc64: Fix comment typo
Date:   Fri, 15 Jul 2022 12:19:56 +0800
Message-Id: <20220715041956.13973-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `new' is duplicated in line 914, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/sparc/kernel/traps_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 5b4de4a89dec..511756cc7aaa 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -911,7 +911,7 @@ void __init cheetah_ecache_flush_init(void)
 	memset(cheetah_error_log, 0, PAGE_SIZE << order);
 
 	/* Mark all AFSRs as invalid so that the trap handler will
-	 * log new new information there.
+	 * log new information there.
 	 */
 	for (i = 0; i < 2 * NR_CPUS; i++)
 		cheetah_error_log[i].afsr = CHAFSR_INVALID;
-- 
2.35.1

