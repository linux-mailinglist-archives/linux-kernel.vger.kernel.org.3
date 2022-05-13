Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F1E526269
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353574AbiEMM4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbiEMM4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:56:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A50A972A5;
        Fri, 13 May 2022 05:56:41 -0700 (PDT)
Date:   Fri, 13 May 2022 12:56:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652446599;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c2Rc5VpqkX82WaIoIA+gihkv0EYEJSgha/ojItAr5FI=;
        b=A6DEnqmQo5vBHWB9Xq4g/DR9HlDy1t1ZdZaT1TSTgF5HlS0qL3g5E3/kMxY8M/3w6D6sy9
        z2+0FycNqvD8d5kiuHxOIk4t87YKAWEDtqbM1rUesXoezGGTbZ3tC47rY5/Pea0UVxedj4
        VUUnXstbqqAHNVyFyQ5okvQwiSldz8tZagPORrKIMMkv5cLJJ1W4lWwTFpG75/Y7FlaFDS
        9XexZa9djMcO3ruHXTHChdrRqpRelXV6Mneohzij2AftIRLyJ8MePe9Iw3uWcQIWNMCTg+
        qhFIhTYpLWrlMFdryQ5kYNb30jiJulk8sEBg1P273mDI27Xb9TOxjjy+E+7wwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652446599;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c2Rc5VpqkX82WaIoIA+gihkv0EYEJSgha/ojItAr5FI=;
        b=GT2tb/epI/l5X0QUZuiNDh/UNXtofoPisl6/QJOkO2dt5BvwyFGyYwJuqgeQsWHKGIYFeR
        BKdY27UXiMlCU7Bw==
From:   "tip-bot2 for Xiao Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/speculation: Add missing srbds=off to the
 mitigations= help text
Cc:     Xiao Yang <yangx.jy@fujitsu.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20220513101637.216487-1-yangx.jy@fujitsu.com>
References: <20220513101637.216487-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Message-ID: <165244659875.4207.17281650412201582456.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     553b0cb30b5452198de3187f1a79989eba38df00
Gitweb:        https://git.kernel.org/tip/553b0cb30b5452198de3187f1a79989eba38df00
Author:        Xiao Yang <yangx.jy@fujitsu.com>
AuthorDate:    Fri, 13 May 2022 18:16:37 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 13 May 2022 14:48:50 +02:00

x86/speculation: Add missing srbds=off to the mitigations= help text

The mitigations= cmdline option help text misses the srbds=off option.
Add it.

  [ bp: Add a commit message. ]

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220513101637.216487-1-yangx.jy@fujitsu.com
---
 Documentation/admin-guide/kernel-parameters.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3f1cc5e..93e9b15 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3103,6 +3103,7 @@
 					       mds=off [X86]
 					       tsx_async_abort=off [X86]
 					       kvm.nx_huge_pages=off [X86]
+					       srbds=off [X86,INTEL]
 					       no_entry_flush [PPC]
 					       no_uaccess_flush [PPC]
 
