Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A325A8820
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 23:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbiHaV3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 17:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbiHaV3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:29:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87C312AD5;
        Wed, 31 Aug 2022 14:19:56 -0700 (PDT)
Date:   Wed, 31 Aug 2022 21:19:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661980794;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XzhVrNi6J1T5m/BEp6srs+QkCTsVaCof0plMFx3wRs8=;
        b=jAOcWl/MR9qE63zK4l19mNAvRuoD3Yzj8JohkwGufEQF/5Jz8oJxlXum2x4cmr2MCWyoQ4
        QCgRIfl+tdrq85LaVoVj+6zIa5KdJdjmpnnIgJH7XqXLg+Qfmt4Syl1ff4exOb8CrmCqMJ
        EnyWALF/Iu2RUYuUKUpKIo2i2gN3magNAMH/UEAQ/hxELvrOXkv6w82NOzCE+8rNHtnn+R
        J8BlV0k1qPZAuYE5x6yVBsXrPCJlMCzAUNGDOEHg2WWm2+gfoFL7z/9e/AbN0sUp8YGwqZ
        VLotpCl48hJKtbCds3HnwM+Xu0v0auOxR2jMJ9Mu4M65CEbKIQucflz9Anm30A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661980794;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XzhVrNi6J1T5m/BEp6srs+QkCTsVaCof0plMFx3wRs8=;
        b=59sI/aopzGXxBoFE0/UkPEy61NHgx6Kmp9s4lPepxnTgMEYmi51Y7NZrmGeb/E0zv+ig7K
        VOSCsInkiL+DH2CQ==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Add CPU model numbers for Meteor Lake
Cc:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220824175718.232384-1-tony.luck@intel.com>
References: <20220824175718.232384-1-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <166198079277.401.11078019641098059546.tip-bot2@tip-bot2>
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

Commit-ID:     5515d21c6817bc27b0b13c61edf22b09b58bc647
Gitweb:        https://git.kernel.org/tip/5515d21c6817bc27b0b13c61edf22b09b58bc647
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 24 Aug 2022 10:57:18 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 31 Aug 2022 14:17:00 -07:00

x86/cpu: Add CPU model numbers for Meteor Lake

Add model numbers for client and mobile parts.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20220824175718.232384-1-tony.luck@intel.com
---
 arch/x86/include/asm/intel-family.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index aeb3802..5d75fe2 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -115,6 +115,9 @@
 #define INTEL_FAM6_RAPTORLAKE_P		0xBA
 #define INTEL_FAM6_RAPTORLAKE_S		0xBF
 
+#define INTEL_FAM6_METEORLAKE		0xAC
+#define INTEL_FAM6_METEORLAKE_L		0xAA
+
 /* "Small Core" Processors (Atom) */
 
 #define INTEL_FAM6_ATOM_BONNELL		0x1C /* Diamondville, Pineview */
