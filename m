Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C18507ACA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357557AbiDSULe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356867AbiDSULV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:11:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A7A3879C;
        Tue, 19 Apr 2022 13:08:36 -0700 (PDT)
Date:   Tue, 19 Apr 2022 20:08:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650398915;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2kD4ywRaqj0s2MQf1+bpeu4ipLBeV6oEDw7TDbAH+Bs=;
        b=cIkt5L6XXXEsSscwqRKdEzu/HhaMvBH/i4ySvOEkpsLtWqt+v7HQzcrxJjmZ+JZ7Hs/g9M
        cFH2HKFbwjdaaanQe4qf+yufwBLuZc2ruhLfcwg/O4jkRubFG+w0mzkTz8/TeDq7f/mHIF
        kcGGjha0GYgeJRnJhhpJ4a3zenRvdGJvRBMp1XT+gy7ph/t1HDmFds4V5Fk9p3Nv4Je0Iz
        hpST6Ti+7otUQ4X1NFsMJuWKCPYbFCmbbZgBJ5DVrNYaBnQEOME2ioMEGbAx+nrxUQ9Dhw
        Lj1TLsNf1SBxL5LSeoCdLNc4Ob2SQfwe/DC02Z+HTQlVfPJyTHMIk55HwOBUsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650398915;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2kD4ywRaqj0s2MQf1+bpeu4ipLBeV6oEDw7TDbAH+Bs=;
        b=ekEQvPKt37kIiWNwF7YfC05IhLoFPLB0ffBoyrpDsZWKdrvJYTYVSIn4tnH8i7Gce72V14
        ZwsPFZZtECgyU1AQ==
From:   "tip-bot2 for Nur Hussein" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/Kconfig: fix the spelling of 'becoming' in
 X86_KERNEL_IBT config
Cc:     Nur Hussein <hussein@unixcat.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220417192454.10247-1-hussein@unixcat.org>
References: <20220417192454.10247-1-hussein@unixcat.org>
MIME-Version: 1.0
Message-ID: <165039891412.4207.17273859318386786001.tip-bot2@tip-bot2>
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

Commit-ID:     4cdfc11b2836e659c0b7b31152a8b0d976167b59
Gitweb:        https://git.kernel.org/tip/4cdfc11b2836e659c0b7b31152a8b0d976167b59
Author:        Nur Hussein <hussein@unixcat.org>
AuthorDate:    Mon, 18 Apr 2022 03:24:54 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 19 Apr 2022 21:58:50 +02:00

x86/Kconfig: fix the spelling of 'becoming' in X86_KERNEL_IBT config

There is only one m in becoming.

Signed-off-by: Nur Hussein <hussein@unixcat.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220417192454.10247-1-hussein@unixcat.org
---
 arch/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b0142e0..4bed3ab 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1866,7 +1866,7 @@ config X86_KERNEL_IBT
 	  code with them to make this happen.
 
 	  In addition to building the kernel with IBT, seal all functions that
-	  are not indirect call targets, avoiding them ever becomming one.
+	  are not indirect call targets, avoiding them ever becoming one.
 
 	  This requires LTO like objtool runs and will slow down the build. It
 	  does significantly reduce the number of ENDBR instructions in the
