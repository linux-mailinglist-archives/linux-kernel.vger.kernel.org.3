Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86394464137
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344893AbhK3WRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:17:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36118 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344592AbhK3WPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:15:07 -0500
Date:   Tue, 30 Nov 2021 22:11:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638310293;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Da4qoGLkXk4oc5CJFif4JE9e/icdZitIkAFfPm7Z7g8=;
        b=DBzkjw/aaBCIab1lldv3KsWsoDjU/rq6MzqQ3r4l3vTkckDLcY3c2sWqVbyyiKhePqYKZN
        w2ZMnx3AidTtvx86gnOiXbbdfWmam3bcj2IZoMqPJMmGDFqJFpwzFBK2CHjZafef/M7tLh
        8FP5dXV4uiKBLAPfG0m5ggN8ZO+MR0TMVHsqCgnF+GXKY5zg2a5mOVXV7PwJyvDu63wG2r
        bdObMlPlHBShGg5BrUzG6HS6QcLeg+7sSW5ImI67bjq4LN2eSY6jvmciPzV/DVND17+eDR
        xdop2woLhtRyyLefZ/Iyo6UlAbT0SVWpmASen8PHr+oephvZQ5DVTfNa1kWvXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638310293;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Da4qoGLkXk4oc5CJFif4JE9e/icdZitIkAFfPm7Z7g8=;
        b=hy4bOutgmoJXj3Fy4vXN6poEEopxpceyQ2gB+TzfwREXEsPYh00pRFDmkuug9aDbOohTEs
        yl4ryWEZIfWjSBCQ==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Drop spurious underscore from RAPTOR_LAKE #define
Cc:     Rui Zhang <rui.zhang@intel.com>, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211119170832.1034220-1-tony.luck@intel.com>
References: <20211119170832.1034220-1-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <163831029203.11128.6368283864833885477.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     7d697f0d5737768fa1039b8953b67c08d8d406d1
Gitweb:        https://git.kernel.org/tip/7d697f0d5737768fa1039b8953b67c08d8d406d1
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 19 Nov 2021 09:08:32 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 30 Nov 2021 14:05:48 -08:00

x86/cpu: Drop spurious underscore from RAPTOR_LAKE #define

Convention for all the other "lake" CPUs is all one word.

So s/RAPTOR_LAKE/RAPTORLAKE/

Fixes: fbdb5e8f2926 ("x86/cpu: Add Raptor Lake to Intel family")
Reported-by: Rui Zhang <rui.zhang@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20211119170832.1034220-1-tony.luck@intel.com
---
 arch/x86/include/asm/intel-family.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 5a0bcf8..048b6d5 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -108,7 +108,7 @@
 #define INTEL_FAM6_ALDERLAKE		0x97	/* Golden Cove / Gracemont */
 #define INTEL_FAM6_ALDERLAKE_L		0x9A	/* Golden Cove / Gracemont */
 
-#define INTEL_FAM6_RAPTOR_LAKE		0xB7
+#define INTEL_FAM6_RAPTORLAKE		0xB7
 
 /* "Small Core" Processors (Atom) */
 
