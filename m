Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACB25A254F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245293AbiHZKBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343733AbiHZKBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:01:14 -0400
Received: from smtpout140.security-mail.net (smtpout140.security-mail.net [85.31.212.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680ABD7D03
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:01:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx405.security-mail.net (Postfix) with ESMTP id 9AB4C3237DA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:01:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1661508067;
        bh=gUmMDNVHONWQCwwllNOwQSYYUlJqM6rPPtKjbyOJ0QQ=;
        h=From:To:Cc:Subject:Date;
        b=PS5Hl37gbe/zH87vrED14FiK30yTosXHTyuwPEZEbdnStXQL7xUOVP11RQpNztBtX
         Qt2bGNq9KJawu4CpEpqKq+Gw89SgErQdg1UiJwkP4J6dNDgfbKSBXxSyzmimP7WHlx
         JauMtXtPx/hPKY4vV/5ZScsYv52xT1sNLZm0FQHc=
Received: from fx405 (localhost [127.0.0.1])
        by fx405.security-mail.net (Postfix) with ESMTP id 43DEF3237CE;
        Fri, 26 Aug 2022 12:01:07 +0200 (CEST)
X-Virus-Scanned: E-securemail
Secumail-id: <8c06.630899e2.680d7.0>
Received: from zimbra2.kalray.eu (unknown [217.181.231.53])
        by fx405.security-mail.net (Postfix) with ESMTPS id 6AB763237BC;
        Fri, 26 Aug 2022 12:01:06 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTPS id 48A1B27E02FA;
        Fri, 26 Aug 2022 12:01:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 3069227E0392;
        Fri, 26 Aug 2022 12:01:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 3069227E0392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1661508066;
        bh=NweMvkwuUL9aWcrZ2XSp5kn992gDP/VanWRyvYnL8Vw=;
        h=From:To:Date:Message-Id;
        b=pPCpJt/KFVDpG412JwQAZ+wMTHxAzNlp3NIPCI/KGn7UtAVARzvNjfm9Ha5Ikru2o
         4UHCXqDxga2Ca+EYBFFm6Bti4F3wEnKnS/naPmspbjKKX6aUrshimNvAgh7Ey5m7Ri
         6ctpyqA7nT0YjwGhqgOTtmDswFR6WnJQgG4lbMqA=
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qa_kXKPI9kJn; Fri, 26 Aug 2022 12:01:06 +0200 (CEST)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id 15C0327E02FA;
        Fri, 26 Aug 2022 12:01:06 +0200 (CEST)
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Jules Maselbas <jmaselbas@kalray.eu>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: [PATCH] seqlock: Fix repeated word in comments
Date:   Fri, 26 Aug 2022 12:00:34 +0200
Message-Id: <20220826100052.22945-6-jmaselbas@kalray.eu>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: by Secumail
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant word `the`.

CC: Ingo Molnar <mingo@redhat.com>
CC: Will Deacon <will@kernel.org>
CC: linux-kernel@vger.kernel.org
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
---
 include/linux/seqlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 3926e9027947..4e2ae90554cd 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -863,7 +863,7 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 }
 
 /*
- * For all seqlock_t write side functions, use the the internal
+ * For all seqlock_t write side functions, use the internal
  * do_write_seqcount_begin() instead of generic write_seqcount_begin().
  * This way, no redundant lockdep_assert_held() checks are added.
  */
-- 
2.17.1

