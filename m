Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF65507ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352594AbiDSUMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357497AbiDSULa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:11:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E95638BCF;
        Tue, 19 Apr 2022 13:08:47 -0700 (PDT)
Date:   Tue, 19 Apr 2022 20:08:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650398926;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dr9D43cyEIItLhjmCstfgE1otN6PsZi5WlZx0hk2dZY=;
        b=QGnNwB8cyPcMaH/abxt6+NDtRRPyaQ85qaFyLzL3a/S1Mlluy1OwqEo+gC3VXG4xzs3Mgy
        A3Oe3jiOiW+IUobxHgjLy3BelHSFSYuN67R4skTYLsBvYg2B61b9N1njOK5AORd94OkXvf
        96Hig/f2CSI45SdhgIDclzdd0SiI+hhzxCi5/CiGgVKrQcxlOS1zerlr+o+qNZgY2uJ7Zg
        jwSybQo/kOJLVDXPOWe17njRdd24LczYYLBkgzMzAK99oidsVq0bmvev8Fme68hImi818f
        ZKE8JS3iSZ5HLzuzgMziPY9vZ4SqxwvckHcVNRowZYNdBgev0aQf2oNQRA3p3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650398926;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dr9D43cyEIItLhjmCstfgE1otN6PsZi5WlZx0hk2dZY=;
        b=iba0/8T15yE2qDRTpHS8HC3BmtlqFWxxpeACDGX+lJj2mSeND1KLidtJag2EPura9VicxZ
        lR/riXYVOwrk8CCQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] MAINTAINERS: Add x86 unwinding entry
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <db2b764b735a9481df9f7717a3a1f75ba496fcc1.1650387176.git.jpoimboe@redhat.com>
References: <db2b764b735a9481df9f7717a3a1f75ba496fcc1.1650387176.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <165039892495.4207.6630628303987069418.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     610abf3dea1092445b4b185e14ed130d1ec6aa74
Gitweb:        https://git.kernel.org/tip/610abf3dea1092445b4b185e14ed130d1ec6aa74
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Tue, 19 Apr 2022 09:54:41 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 Apr 2022 21:58:47 +02:00

MAINTAINERS: Add x86 unwinding entry

Create a new section for x86 unwinder maintenance.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/db2b764b735a9481df9f7717a3a1f75ba496fcc1.1650387176.git.jpoimboe@redhat.com
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
---
 MAINTAINERS |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 40fa195..63ace80 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21434,6 +21434,15 @@ F:	arch/x86/include/asm/uv/
 F:	arch/x86/kernel/apic/x2apic_uv_x.c
 F:	arch/x86/platform/uv/
 
+X86 STACK UNWINDING
+M:	Josh Poimboeuf <jpoimboe@redhat.com>
+M:	Peter Zijlstra <peterz@infradead.org>
+S:	Supported
+F:	arch/x86/include/asm/unwind*.h
+F:	arch/x86/kernel/dumpstack.c
+F:	arch/x86/kernel/stacktrace.c
+F:	arch/x86/kernel/unwind_*.c
+
 X86 VDSO
 M:	Andy Lutomirski <luto@kernel.org>
 L:	linux-kernel@vger.kernel.org
