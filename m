Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5F5481710
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 22:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbhL2V3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 16:29:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38832 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbhL2V3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 16:29:11 -0500
Date:   Wed, 29 Dec 2021 21:29:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640813350;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7JyYfEIlbBTEZDmgEpDhmh0ucnhHpCNiUT1SyO9shh8=;
        b=QykDMx+bwKabjEICEIs71KK0XDdWlfO+Vch29GpGDy5VZqTv5ZssuOtGGHB5P49zuBIrPm
        eJjKEVrBSsnWxZSvyJU9Kqz8TF1r38S9PbyBUbJjA1thcUDHAC02k38uBNO+cHbsY+lktI
        L7nFMtLs6qXbpn8HZ8AVDucVAb4pKj1Pt4sIajfsFwJ5MK740dSi/HX6QOrEnGUnOId5zQ
        OVHK+R214uqoMV1eL+MHB9WYZp8AsQYmdGOUjSY7iH2cR5+VkKVWH5tWGU6T/vK6tcMqjL
        0oHUMC6IaBPqqsRERgYSdCT/vlsqafle2K7+KKsdqCHuohX99qp4BMJVVH7oTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640813350;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7JyYfEIlbBTEZDmgEpDhmh0ucnhHpCNiUT1SyO9shh8=;
        b=3eSpJzE9OOBkb/UpKw47lSYa/AXAUgwE4UB99yrvScADDrOwhDQYoqibnm8lTlZq9dz7NQ
        QIh1d/zh4bZMg5DA==
From:   "tip-bot2 for Lukas Bulwahn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/build: Use the proper name CONFIG_FW_LOADER
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211229111553.5846-1-lukas.bulwahn@gmail.com>
References: <20211229111553.5846-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Message-ID: <164081334864.16921.320515650534204653.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d6f12f83989bb356ac6880a954f62c7667e35066
Gitweb:        https://git.kernel.org/tip/d6f12f83989bb356ac6880a954f62c7667e35066
Author:        Lukas Bulwahn <lukas.bulwahn@gmail.com>
AuthorDate:    Wed, 29 Dec 2021 12:15:53 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 29 Dec 2021 22:20:38 +01:00

x86/build: Use the proper name CONFIG_FW_LOADER

Commit in Fixes intends to add the expression regex only when FW_LOADER
is enabled - not FW_LOADER_BUILTIN. Latter is a leftover from a previous
patchset and not a valid config item.

So, adjust the condition to the actual name of the config.

  [ bp: Cleanup commit message. ]

Fixes: c8dcf655ec81 ("x86/build: Tuck away built-in firmware under FW_LOADER")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lore.kernel.org/r/20211229111553.5846-1-lukas.bulwahn@gmail.com
---
 arch/x86/tools/relocs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index c736cf2..e2c5b29 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -68,7 +68,7 @@ static const char * const sym_regex_kernel[S_NSYMTYPES] = {
 	"(__parainstructions|__alt_instructions)(_end)?|"
 	"(__iommu_table|__apicdrivers|__smp_locks)(_end)?|"
 	"__(start|end)_pci_.*|"
-#if CONFIG_FW_LOADER_BUILTIN
+#if CONFIG_FW_LOADER
 	"__(start|end)_builtin_fw|"
 #endif
 	"__(start|stop)___ksymtab(_gpl)?|"
