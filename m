Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A124E5F6E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348589AbiCXHc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348342AbiCXHcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:32:24 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A54298F7C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:30:53 -0700 (PDT)
Received: from integral2.. (unknown [182.2.71.236])
        by gnuweeb.org (Postfix) with ESMTPSA id C8F6F7E708;
        Thu, 24 Mar 2022 07:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1648107052;
        bh=SlIgbgQas7sKmDCm8jaOP2BZyesVvPCtxtzSSweS7C8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p4kfnUE2HS9CRK3tbFOXyhQKltpoElJep3guWxmbgLW7Dvz0j0KR9QW8VZkGLiImT
         L68NS1H7Gp1vZUaiW9jUxEswwAslrZrrz0UT//4SVdl3ifV/83BAPVWKaGoryqadQ4
         bG9p6BFtnutCGj4p+fXb0n6+9QVoD7zT1P3PwCIfc7zRCPGG3GZK0dVjg/ZPYKfwXk
         M2c9e57Klp5SeIVdAs7f8cTdvAtQMgvcWVFqBkiMBaiSlAmgeNqrgzSqzbzn4QNNbr
         fICC7XT6OrvwYm1c3ysIfTLhzAWmoJRQG3ztWjnOVqo5fHACw6uJBLxQlivjNBMC3N
         6uaIlANRFEXgw==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [PATCH v1 01/11] tools/nolibc: x86-64: Update System V ABI document link
Date:   Thu, 24 Mar 2022 14:30:29 +0700
Message-Id: <20220324073039.140946-2-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220324073039.140946-1-ammarfaizi2@gnuweeb.org>
References: <20220324073039.140946-1-ammarfaizi2@gnuweeb.org>
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

@@ Changelog:

   Link RFC v2: https://lore.kernel.org/lkml/20220322102115.186179-2-ammarfaizi2@gnuweeb.org/
   RFC v2 -> v1:
    * No changes *

   Link RFC v1: https://lore.kernel.org/lkml/20220320093750.159991-2-ammarfaizi2@gnuweeb.org
   RFC v1 -> RFC v2:
    * No changes *
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

