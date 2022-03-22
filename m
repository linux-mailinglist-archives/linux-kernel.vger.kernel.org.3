Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450674E3C5A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbiCVKXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbiCVKXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:23:03 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6017EB3B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:21:36 -0700 (PDT)
Received: from integral2.. (unknown [182.2.69.158])
        by gnuweeb.org (Postfix) with ESMTPSA id 22F1B7E33D;
        Tue, 22 Mar 2022 10:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647944495;
        bh=223IIXvAVF8dvE1omCKX0nJn3bhN+15baNDRjWgZABw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FBwOO27KcIc0I6tBNoeyls7EqfAwxtDkaKmPrOtjOqszEaYtEFw3w6XP132DKTIMQ
         7Id6ESH3s5FppDJ1S/iE/K5nswQ8VfjV7wTMedWZpqvf5lV03tcWbAfmt14389a5C5
         syOBLaMpm8EUmOe4oxoCTg2YXZtFISwAVkiH1Vwsu3NCjndMdl64ku49sfWH9XiRkg
         HYqlpKGX8WKoDfZYwc4RuQSYi2kDjmbkeSKi6y0FYp7xztxffJR6baBAfKRBPtXwRE
         GrW6jVKXtK19DZD5i6tvOYBQNADCpPr52Z3+fAniSNBsodc2jV55mLgfgigD0gfRXk
         aQ0gc14Haaf3w==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [RFC PATCH v2 1/8] tools/nolibc: x86-64: Update System V ABI document link
Date:   Tue, 22 Mar 2022 17:21:08 +0700
Message-Id: <20220322102115.186179-2-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
References: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
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

