Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A1957C612
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiGUITV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiGUITU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:19:20 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4079C5E815
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 01:19:16 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 965EB1E80D78;
        Thu, 21 Jul 2022 16:14:50 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AhSljf4Xb1IQ; Thu, 21 Jul 2022 16:14:47 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id CE28B1E80D40;
        Thu, 21 Jul 2022 16:14:47 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Subject: [PATCH] linux/tracepoint: Fix typo
Date:   Thu, 21 Jul 2022 16:19:04 +0800
Message-Id: <20220721081904.3798-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reading this note, CONFIG_TRACEPOINT searches my configuration
file, and the result is CONFIG_TRACEPOINTS, the search results are
consistent with the following macro definitions. I think it should be
repaired.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 include/linux/tracepoint.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 28031b15f878..2908cc5ed70e 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -151,7 +151,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 /*
  * Individual subsystem my have a separate configuration to
  * enable their tracepoints. By default, this file will create
- * the tracepoints if CONFIG_TRACEPOINT is defined. If a subsystem
+ * the tracepoints if CONFIG_TRACEPOINTS is defined. If a subsystem
  * wants to be able to disable its tracepoints from being created
  * it can define NOTRACE before including the tracepoint headers.
  */
-- 
2.18.2

