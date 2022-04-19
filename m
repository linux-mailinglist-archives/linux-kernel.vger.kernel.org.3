Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60909506898
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 12:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350621AbiDSKTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 06:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350568AbiDSKS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 06:18:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3CD13FB2;
        Tue, 19 Apr 2022 03:16:16 -0700 (PDT)
Date:   Tue, 19 Apr 2022 10:16:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650363373;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CW1NXCgiNAzbXzfcrafdpfU2FxzYnCrzANb6OMyU+Z0=;
        b=r/DXOAYvQgUZzFfaI7ZTUTmF0nkTsn5+0v9GW989rC+Ynd1kmXCRxQ6Ghc7xh2toKb+KpK
        9nA4y4XP9/xw29s9S1xQPTVB2lNUpGMzNSx+NnfTGDTE0nkO5e3jYm14vIGtj+gx22CYgK
        xAuGRQGs+NiUHp2wiv30t1UabHqrwtVDaxY58L2pP05LHN1pDm4NFK3gi+t4+xBH+exh+V
        yqMSmgX0zSTTjyOhHsktxKbjGGsBteWWRCvPCFS6kaTz26DqDCPm0qNztDte7ApI+1euNg
        onlNqMtCf+aA5E9RE028eXv4WkVtmyKdKzs/C8d8xAUwUYXbNUsSSZTiAOONHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650363373;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CW1NXCgiNAzbXzfcrafdpfU2FxzYnCrzANb6OMyU+Z0=;
        b=DtyYuz6Js8DYYk/8P3TfUBOzDNc1YT0laXuFoIfMWd0cBhCcEa+UGhpScJc1A8wX/3GpOg
        C3bPs6R2qgjQrgCQ==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Add new Alderlake and Raptorlake CPU model numbers
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YlS7n7Xtso9BXZA2@agluck-desk3.sc.intel.com>
References: <YlS7n7Xtso9BXZA2@agluck-desk3.sc.intel.com>
MIME-Version: 1.0
Message-ID: <165036337168.4207.8004054711117742734.tip-bot2@tip-bot2>
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

Commit-ID:     3ccce9340326df40ba4462d4d2a1692b6387a68e
Gitweb:        https://git.kernel.org/tip/3ccce9340326df40ba4462d4d2a1692b6387a68e
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Mon, 11 Apr 2022 16:37:03 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 19 Apr 2022 12:04:51 +02:00

x86/cpu: Add new Alderlake and Raptorlake CPU model numbers

Intel is subdividing the mobile segment with additional models
with the same codename. Using the Intel "N" and "P" suffices
for these will be less confusing than trying to map to some
different naming convention.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/YlS7n7Xtso9BXZA2@agluck-desk3.sc.intel.com
---
 arch/x86/include/asm/intel-family.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 048b6d5..def6ca1 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -26,6 +26,7 @@
  *		_G	- parts with extra graphics on
  *		_X	- regular server parts
  *		_D	- micro server parts
+ *		_N,_P	- other mobile parts
  *
  *		Historical OPTDIFFs:
  *
@@ -107,8 +108,10 @@
 
 #define INTEL_FAM6_ALDERLAKE		0x97	/* Golden Cove / Gracemont */
 #define INTEL_FAM6_ALDERLAKE_L		0x9A	/* Golden Cove / Gracemont */
+#define INTEL_FAM6_ALDERLAKE_N		0xBE
 
 #define INTEL_FAM6_RAPTORLAKE		0xB7
+#define INTEL_FAM6_RAPTORLAKE_P		0xBA
 
 /* "Small Core" Processors (Atom) */
 
