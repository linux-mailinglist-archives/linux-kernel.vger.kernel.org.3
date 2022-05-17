Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC7A52AE08
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiEQWWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiEQWWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:22:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4D528E38;
        Tue, 17 May 2022 15:22:00 -0700 (PDT)
Date:   Tue, 17 May 2022 22:21:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652826118;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7gWrJRdaQkhWfFLeEInc5JQ8L85ZRfZXtw31HOx9UhI=;
        b=kFlVvqkr+9J1JDyTEdHsH9fPVX45kXMyxzH00ba18ZVr4g9Lcd50pSj8O2IQDta8RvngLf
        b3sfzZKe1ZArLOrpIGWnXoClhTwUrq1rjUa+MD6R/+Wow0/SwbsxOtl/N2xfolW7rewYUw
        zG1d+eUss3e1RzA9f+Z5A+nZavIPhLm7/C7dFsb4EnrUq4Q8BO+aHXfQJik6Di/9I4L2LS
        8VvsHMjibFRI1TMOXytHnUjqdTZ7BWYxsT3tNgLU5E0i1XLgtUwdsaKOemxuSq8pgvP1Am
        evBFfFW5fhplxjtnYW0et1X/wCG/xG6gMx2I8tngtRrAnEisRDKV+Lb5fIJP0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652826118;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7gWrJRdaQkhWfFLeEInc5JQ8L85ZRfZXtw31HOx9UhI=;
        b=VjgbUYqFd1uhHu6TyhTNTRKMpVZqs5+5d7DmdYc/xUzTdtZ/oJH/qMiIj6sM6BWuk9ejAY
        3yJckHGK/6DYrlAQ==
From:   "tip-bot2 for Tiezhu Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Remove libsubcmd.a when make clean
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1652258270-6278-3-git-send-email-yangtiezhu@loongson.cn>
References: <1652258270-6278-3-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Message-ID: <165282611715.4207.9392040766164391624.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     4bc78005887f6fca60b624822943708652fda01a
Gitweb:        https://git.kernel.org/tip/4bc78005887f6fca60b624822943708652fda01a
Author:        Tiezhu Yang <yangtiezhu@loongson.cn>
AuthorDate:    Wed, 11 May 2022 16:37:50 +08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Thu, 12 May 2022 07:28:35 -07:00

objtool: Remove libsubcmd.a when make clean

The file libsubcmd.a still exists after make clean, remove it.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/1652258270-6278-3-git-send-email-yangtiezhu@loongson.cn
---
 tools/objtool/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 8a90763..e66d717 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -63,7 +63,7 @@ $(LIBSUBCMD): fixdep FORCE
 clean:
 	$(call QUIET_CLEAN, objtool) $(RM) $(OBJTOOL)
 	$(Q)find $(OUTPUT) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
-	$(Q)$(RM) $(OUTPUT)arch/x86/lib/inat-tables.c $(OUTPUT)fixdep
+	$(Q)$(RM) $(OUTPUT)arch/x86/lib/inat-tables.c $(OUTPUT)fixdep $(LIBSUBCMD)
 
 FORCE:
 
