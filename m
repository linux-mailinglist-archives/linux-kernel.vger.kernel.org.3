Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6274E1AE4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 10:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243508AbiCTJkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 05:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243323AbiCTJkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 05:40:11 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8D311A20
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 02:38:48 -0700 (PDT)
Received: from integral2.. (unknown [182.2.42.189])
        by gnuweeb.org (Postfix) with ESMTPSA id 89E937E324;
        Sun, 20 Mar 2022 09:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647769127;
        bh=CqkJi4gcwtTSWVKYAtlVVoCfJnF5oK9/pwQGZcP0YAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mGobdSn1ABsRF1yZIw4UyIDUlCf6GLC/BcGhWqquifBfpRLRVigYYA3QVTyau/AzM
         RODzfjiCsBtSKmg1Vm+Fgcds7AASdN/On/Q/j9s4K0bMaGt4UenVh5rpfhO71iNdk9
         jPJjIPhfJ8m6ODIfznfjq0Bl3sQ1E/iPGWsZq8TBZmYPWOJRn4Z32hcJYo0uKN5mno
         8S9+rI+nkTT7pULN5HRakimI58lIYnOEq5/7wDt9BiT2DDrEq5z2EUfvl8YsiAshR9
         +b+T64414N+X/Mi78/xtzlsWQA6g8KcNiYj7SJMc5zatdIGfndyrymBS0j43E/V43f
         UHKKIdWrKSOLw==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [RFC PATCH v1 1/6] tools/nolibc: x86-64: Update System V ABI document link
Date:   Sun, 20 Mar 2022 16:37:45 +0700
Message-Id: <20220320093750.159991-2-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220320093750.159991-1-ammarfaizi2@gnuweeb.org>
References: <20220320093750.159991-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old link no longer works, update it.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/include/nolibc/arch-x86_64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index fe517c16cd4d..a7b70ea51b68 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -61,7 +61,7 @@ struct sys_stat_struct {
  *   - see also x86-64 ABI section A.2 AMD64 Linux Kernel Conventions, A.2.1
  *     Calling Conventions.
  *
- * Link x86-64 ABI: https://gitlab.com/x86-psABIs/x86-64-ABI/-/wikis/x86-64-psABI
+ * Link x86-64 ABI: https://gitlab.com/x86-psABIs/x86-64-ABI/-/wikis/home
  *
  */
 
-- 
Ammar Faizi

