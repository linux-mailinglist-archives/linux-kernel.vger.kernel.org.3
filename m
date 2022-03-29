Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849954EAB1A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbiC2KTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbiC2KTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:19:32 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D92E23EC44
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 03:17:50 -0700 (PDT)
Received: from integral2.. (unknown [182.2.70.161])
        by gnuweeb.org (Postfix) with ESMTPSA id 3DEE67E730;
        Tue, 29 Mar 2022 10:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1648549070;
        bh=nXwybG2xj7FxsXwg0gN7BG4ukSnulUCxgiiQFmEs6/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FQ8oyaOm9NRfA/ABKI83d5foWeJ6Q8BsplJtun2CZatV9EjyMpslVCQlr2tTh8Nub
         pJXNz/wuAzDUCgHUHewb0GR5Ke3C8rrwfeMDKRmtvpwNJpFpR1gcQ0UJT/OybqdSWp
         LSi1Ua1Jzm6aC5Bpstm5TiitabZgJ7MkAl0VXQA42TOMhgT7vviENyCas6axzUi4Ty
         G3Un8D4RY1GyVrlxSeMCe9ksnBRYm2HdruNn1MWwyO1BxfI4lAXzWUwLMogoMw9/B6
         dN2wL+Feoq7oCzrjyIqS4qHJs89xkCehmN1JZepFj/6cCEvIpEIr8oxcfNCwgeetS9
         UDnA/PxVQ5FFA==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: [PATCH v2 1/9] tools/nolibc: x86-64: Update System V ABI document link
Date:   Tue, 29 Mar 2022 17:17:29 +0700
Message-Id: <20220329101737.58985-2-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220329101737.58985-1-ammarfaizi2@gnuweeb.org>
References: <20220329101737.58985-1-ammarfaizi2@gnuweeb.org>
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
===

@@ Changelog:

   Link v1: https://lore.kernel.org/lkml/20220324073039.140946-2-ammarfaizi2@gnuweeb.org
   v1 -> v2:
    * No changes *

   Link RFC v2: https://lore.kernel.org/lkml/20220322102115.186179-2-ammarfaizi2@gnuweeb.org
   RFC v2 -> v1:
    * No changes *

   Link RFC v1: https://lore.kernel.org/lkml/20220320093750.159991-2-ammarfaizi2@gnuweeb.org
   RFC v1 -> RFC v2:
    * No changes *

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

