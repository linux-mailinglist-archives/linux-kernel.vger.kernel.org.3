Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763DD4F5164
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1846108AbiDFCCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352567AbiDEOB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 10:01:56 -0400
X-Greylist: delayed 321 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Apr 2022 05:57:29 PDT
Received: from leifhenriksen.net (www.leifhenriksen.net [51.91.79.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6A4154050
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 05:57:29 -0700 (PDT)
Received: from YD-CND7506QL7.rd.francetelecom.fr (unknown [161.105.209.130])
        by leifhenriksen.net (Postfix) with ESMTPSA id A1DAA13BD40;
        Tue,  5 Apr 2022 12:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leifhenriksen.net;
        s=mail; t=1649163125;
        bh=+YmyOSc/ChSmISgvPqD35a+/+LmKQGqLsBAqtL6Glmw=;
        h=From:To:Cc:Subject:Date:From;
        b=LrYHS6C8XrbEH4Aeg2Ilt1iwvZt2gsGONZmzui/KDWXRH0vQM6u3xP5kLwRL0FO7T
         gHeR/c6CV+VQsUE8fN7nHaZZpBa/7+RWR7uFrA8KwxPpQPVANdyK96/0DCV8STBoWd
         kuHNJbW8cEedMYMDPWkV6MOcUmZ+pVHdmyoj0N0g8yAOkbAtvtmiplV/lItofkKaWI
         DgRYogMmuEMrdweBIPTQwRv8dYfWmN+Azt/gNfM8R4kPpTaRtx7X4w6KT/+7pGoGtH
         CbgB/9boyGAWCZ+hG2wA9lV1vNeEd8d1Jemd04MGb9nIhvDAfNXkkwy3zjfqH5P+v3
         TaJceu3emwi9w==
From:   Leif Henriksen <leif@leifhenriksen.net>
To:     keescook@chromium.org
Cc:     leif@leifhenriksen.net, Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/seccomp.c : struct seccomp_filter comment reordering
Date:   Tue,  5 Apr 2022 14:51:45 +0200
Message-Id: <20220405125145.404131-1-leif@leifhenriksen.net>
X-Mailer: git-send-email 2.25.1
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

Swapped the @log and @cache field comment to
match the same order as the struct declaration.

Signed-off-by: Leif Henriksen <leif@leifhenriksen.net>
---
 kernel/seccomp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index b5ac87f6dbd4..ad0fed6bdf9b 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -198,8 +198,8 @@ static inline void seccomp_cache_prepare(struct seccomp_filter *sfilter)
  *	   this filter after reaching 0. The @users count is always smaller
  *	   or equal to @refs. Hence, reaching 0 for @users does not mean
  *	   the filter can be freed.
- * @cache: cache of arch/syscall mappings to actions
  * @log: true if all actions except for SECCOMP_RET_ALLOW should be logged
+ * @cache: cache of arch/syscall mappings to actions
  * @prev: points to a previously installed, or inherited, filter
  * @prog: the BPF program to evaluate
  * @notif: the struct that holds all notification related information
-- 
2.25.1

