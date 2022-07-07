Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245DB56A8BE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbiGGQ7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbiGGQ7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:59:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247D0220C7;
        Thu,  7 Jul 2022 09:59:37 -0700 (PDT)
Date:   Thu, 07 Jul 2022 16:59:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657213175;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tgibuu+EFRnH1uIrGERfpnS0e8DCu52RTUBeQNCvX90=;
        b=0CxbqQ17oGk16+2Q1FtJwKlyuPtpnr6d2y17NevFwH427tD4QO8oimrsDg8jNSlSyeiHb0
        OcGdhjsbRxshpM4VLadManhlHR0zWEp1QWXizxJmFwbBZY999UclVRif1jZ6yVRONZ4VOf
        +bntJT5tk/gFLp989JoS/xjgazDvys+faMlO28aGOjgtXKQZnZ4Dmu+QxRlUOM2FsP/QCK
        Dbpf86Vy9CzwmVHXDhIUtg5bsDR13stBOyi5Jbd67aRSuNzS7nww70/p5y1QXgEdhN03nu
        HZuuhwU23+4vDleTHxwmvzD/OYpxtXD+eOKUWZlvSS3tekc3YqTvdD/puphRbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657213175;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tgibuu+EFRnH1uIrGERfpnS0e8DCu52RTUBeQNCvX90=;
        b=GJjpYkhn6Ml/K+BeExG2EP+1ZeqHlUCRyAjrw6qeF4wqNJY6T1Qrsa+FfIqtG/fxzaTTTP
        jnevhTQgPgLLHWAw==
From:   "tip-bot2 for Lukas Bulwahn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/mm: Refer to the intended config
 STRICT_DEVMEM in a comment
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220707115442.21107-1-lukas.bulwahn@gmail.com>
References: <20220707115442.21107-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Message-ID: <165721317403.15455.225520286962176252.tip-bot2@tip-bot2>
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

Commit-ID:     9de76f41ea2188f2784f48352f9278819d249afc
Gitweb:        https://git.kernel.org/tip/9de76f41ea2188f2784f48352f9278819d249afc
Author:        Lukas Bulwahn <lukas.bulwahn@gmail.com>
AuthorDate:    Thu, 07 Jul 2022 13:54:42 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Jul 2022 09:51:36 -07:00

x86/mm: Refer to the intended config STRICT_DEVMEM in a comment

Commit a4866aa81251 ("mm: Tighten x86 /dev/mem with zeroing reads") adds a
comment to the function devmem_is_allowed() referring to a non-existing
config STRICT_IOMEM, whereas the comment very likely intended to refer to
the config STRICT_DEVMEM, as the commit adds some behavior for the config
STRICT_DEVMEM.

Most of the initial analysis was actually done by Dave Hansen in the
email thread below (see Link).

Refer to the intended and existing config STRICT_DEVMEM.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/f9074e8d-9314-9d7d-7bf5-5b5538c8be8d@intel.com/
Link: https://lkml.kernel.org/r/20220707115442.21107-1-lukas.bulwahn@gmail.com
---
 arch/x86/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index d8cfce2..5d747a1 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -846,7 +846,7 @@ int devmem_is_allowed(unsigned long pagenr)
 
 	/*
 	 * This must follow RAM test, since System RAM is considered a
-	 * restricted resource under CONFIG_STRICT_IOMEM.
+	 * restricted resource under CONFIG_STRICT_DEVMEM.
 	 */
 	if (iomem_is_exclusive(pagenr << PAGE_SHIFT)) {
 		/* Low 1MB bypasses iomem restrictions. */
