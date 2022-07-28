Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92FC583C24
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbiG1KhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbiG1KhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:37:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2609550A2;
        Thu, 28 Jul 2022 03:36:57 -0700 (PDT)
Date:   Thu, 28 Jul 2022 10:36:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659004616;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JVccKH/+cS/nkRyUbjIqFuCIi86SXRUxMIXY8M6McjY=;
        b=kKI+sr9bBnHJ4MPpbIOmLqbvbl9JFYuAdP6wN41kDnXFNAuPHEclPqAbtzpYtTdzvVCWW0
        FZ6+nmnnWDDMd8wPUo5qo1H0NKGLerWg2cwsrH/yDKqb2zmHdIxyVtCdDYjuXL4MZgMj84
        C8sjS6xrj8AlT3g/4VTG13I5t9bdrmD2YpQJ+xnHQjuJjO4h4AfXTSzBiRSi4itcYLtyDk
        6Vpk9hQNR/hj3GjQQlUj1oWiz/Vd7JGH7UFOGFAayp21OKVDNHuPh9kv/VaahCe0KDWlIU
        WOqIwkaYwniFtRtrHzBEIWfbRT1hiOsrSUj6RdxZbPGqdKaNk4uQbTFlfgJdzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659004616;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JVccKH/+cS/nkRyUbjIqFuCIi86SXRUxMIXY8M6McjY=;
        b=s24o7FXdwQ2xBCF7wDtiq11NEfBG98H3alR3rYCn4NtSmxw2TqX68F737KcfZnpy6YhzvQ
        etOGwH8vqhJxrCDg==
From:   "tip-bot2 for Lukas Bulwahn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/configs: Update configs in x86_debug.config
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220722121815.27535-1-lukas.bulwahn@gmail.com>
References: <20220722121815.27535-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Message-ID: <165900461486.15455.1011348453705809248.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     871808fd6981bcc6bb48f71032f983ca77748e96
Gitweb:        https://git.kernel.org/tip/871808fd6981bcc6bb48f71032f983ca77748e96
Author:        Lukas Bulwahn <lukas.bulwahn@gmail.com>
AuthorDate:    Fri, 22 Jul 2022 14:18:15 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 27 Jul 2022 18:09:11 +02:00

x86/configs: Update configs in x86_debug.config

Commit

  4675ff05de2d ("kmemcheck: rip it out")

removed kmemcheck and its corresponding build config KMEMCHECK.

Commit

  0f620cefd775 ("objtool: Rename "VMLINUX_VALIDATION" -> "NOINSTR_VALIDATION"")

renamed the debug config option.

Adjust x86_debug.config to those changes in debug configs.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220722121815.27535-1-lukas.bulwahn@gmail.com
---
 kernel/configs/x86_debug.config | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/configs/x86_debug.config b/kernel/configs/x86_debug.config
index dcd86f3..6fac5b4 100644
--- a/kernel/configs/x86_debug.config
+++ b/kernel/configs/x86_debug.config
@@ -7,12 +7,11 @@ CONFIG_DEBUG_SLAB=y
 CONFIG_DEBUG_KMEMLEAK=y
 CONFIG_DEBUG_PAGEALLOC=y
 CONFIG_SLUB_DEBUG_ON=y
-CONFIG_KMEMCHECK=y
 CONFIG_DEBUG_OBJECTS=y
 CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=1
 CONFIG_GCOV_KERNEL=y
 CONFIG_LOCKDEP=y
 CONFIG_PROVE_LOCKING=y
 CONFIG_SCHEDSTATS=y
-CONFIG_VMLINUX_VALIDATION=y
+CONFIG_NOINSTR_VALIDATION=y
 CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
