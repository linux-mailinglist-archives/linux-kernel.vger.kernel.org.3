Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0450052AE07
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiEQWWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbiEQWWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:22:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA8A29800;
        Tue, 17 May 2022 15:22:01 -0700 (PDT)
Date:   Tue, 17 May 2022 22:21:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652826120;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V5PKY8oohaslw9HzUUgaXGtnOVXoU3UAsO2Lo7U+IGU=;
        b=FZLAZ/arc966IFbjO4Lk9oVhiFzo5skPfYc12vqGC9VVwbXA8876vPQkJ8DaX+9ZcJ5PBL
        0F7tJYlh9S6W9imWVrX0vhHwyLsBxGHYx4QkpKIBYfoR94fzQpV/uHB226mFdgTkPrTstJ
        sXvN7OZ9cRaqcJYTaOuFl40RvxT/FrF4i7zbQ1oERe/RkwKikZxHudAqaUb3U7JMiU0rpd
        Q0uYh5fZJWYrhgUDemZr4b3c4JhO+MHbmDTfGDtv5NAxj205m2alUcUDzZ4NE6uyFxL6LV
        vswZ7/VZ2e+mhGLLy+pSvTvRtBmUle9ZjqTTxhg42iuMWVSbf18xi+8LQzBKZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652826120;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V5PKY8oohaslw9HzUUgaXGtnOVXoU3UAsO2Lo7U+IGU=;
        b=Ba6yo+BPOFFzojXf/ca6T78aamy25NJQuoh7lLAyLxP7TdhTWahS7gYhn3FweZKaOvqAjf
        m6x+s8HlWFqOL3Dg==
From:   "tip-bot2 for Tiezhu Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Remove inat-tables.c when make clean
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1652258270-6278-2-git-send-email-yangtiezhu@loongson.cn>
References: <1652258270-6278-2-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Message-ID: <165282611848.4207.8215505152324998987.tip-bot2@tip-bot2>
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

Commit-ID:     f193c32cad2ddc79ad55a2e2fb3bc35e7d92946a
Gitweb:        https://git.kernel.org/tip/f193c32cad2ddc79ad55a2e2fb3bc35e7d92946a
Author:        Tiezhu Yang <yangtiezhu@loongson.cn>
AuthorDate:    Wed, 11 May 2022 16:37:49 +08:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Thu, 12 May 2022 07:28:05 -07:00

objtool: Remove inat-tables.c when make clean

When build objtool on x86, the generated file inat-tables.c is in
arch/x86/lib instead of arch/x86, use the correct dir to remove it
when make clean.

$ cd tools/objtool
$ make
[...]
  GEN     arch/x86/lib/inat-tables.c
[...]

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/1652258270-6278-2-git-send-email-yangtiezhu@loongson.cn
---
 tools/objtool/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 061cf1c..8a90763 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -63,7 +63,7 @@ $(LIBSUBCMD): fixdep FORCE
 clean:
 	$(call QUIET_CLEAN, objtool) $(RM) $(OBJTOOL)
 	$(Q)find $(OUTPUT) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
-	$(Q)$(RM) $(OUTPUT)arch/x86/inat-tables.c $(OUTPUT)fixdep
+	$(Q)$(RM) $(OUTPUT)arch/x86/lib/inat-tables.c $(OUTPUT)fixdep
 
 FORCE:
 
