Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6441C533E55
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237947AbiEYN4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiEYN4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:56:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B778D6B7;
        Wed, 25 May 2022 06:56:46 -0700 (PDT)
Date:   Wed, 25 May 2022 13:56:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653487005;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6svJIhgsNotYCM2gnWaDCgcV12dIHd2Me3m7GcUKNyo=;
        b=0SQidgDzaLUDbuK0RFRoBnkABs4FEplKLKDgvZD7nbQas/HnQsFbFoLGzD++2UeIaK8Sy1
        XMgt4iFwRNg/26K6z23PrQr5YNUgUZJ+BgkC9dH+x4zHOKyEiHvIGSP/0yUjlvbrjEfnje
        Jf6+g9V0Qr89XRG7kGfLhpL32ZTANQk5nGRztr4NkdpjoPtuVnlILeKodbVcqajUKqplMm
        jSFXMpTchZUVNwOTO8aItiYTItnqRtwQkOoqyZTwoNi8hNR8cznzU7kpC+7cqlk4mHYg1J
        Pl7wFp3IKTYokqYPTob29vUyTBaASSOjMGgjP6QMSeiwhpiFCDJQxKwuZwLTGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653487005;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6svJIhgsNotYCM2gnWaDCgcV12dIHd2Me3m7GcUKNyo=;
        b=3K+piQWMy8ji3Yu6aBOu6s174OOQQFwGscaYuunro4jC3kpfdzdDACoOFHBfxyIncgyATY
        0C0hMef8wvCPBMCA==
From:   "tip-bot2 for Juerg Haefliger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/Kconfig: Fix indentation in the Kconfig file
Cc:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220525133949.53730-1-juerg.haefliger@canonical.com>
References: <20220525133949.53730-1-juerg.haefliger@canonical.com>
MIME-Version: 1.0
Message-ID: <165348700360.4207.4712455380719142556.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     108ea7eb3e754be735a1c33d2713a19527fb2065
Gitweb:        https://git.kernel.org/tip/108ea7eb3e754be735a1c33d2713a19527fb2065
Author:        Juerg Haefliger <juerg.haefliger@canonical.com>
AuthorDate:    Wed, 25 May 2022 15:39:49 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 25 May 2022 15:54:26 +02:00

perf/x86/Kconfig: Fix indentation in the Kconfig file

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20220525133949.53730-1-juerg.haefliger@canonical.com
---
 arch/x86/events/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/Kconfig b/arch/x86/events/Kconfig
index 09c5696..dabdf3d 100644
--- a/arch/x86/events/Kconfig
+++ b/arch/x86/events/Kconfig
@@ -6,24 +6,24 @@ config PERF_EVENTS_INTEL_UNCORE
 	depends on PERF_EVENTS && CPU_SUP_INTEL && PCI
 	default y
 	help
-	Include support for Intel uncore performance events. These are
-	available on NehalemEX and more modern processors.
+	  Include support for Intel uncore performance events. These are
+	  available on NehalemEX and more modern processors.
 
 config PERF_EVENTS_INTEL_RAPL
 	tristate "Intel/AMD rapl performance events"
 	depends on PERF_EVENTS && (CPU_SUP_INTEL || CPU_SUP_AMD) && PCI
 	default y
 	help
-	Include support for Intel and AMD rapl performance events for power
-	monitoring on modern processors.
+	  Include support for Intel and AMD rapl performance events for power
+	  monitoring on modern processors.
 
 config PERF_EVENTS_INTEL_CSTATE
 	tristate "Intel cstate performance events"
 	depends on PERF_EVENTS && CPU_SUP_INTEL && PCI
 	default y
 	help
-	Include support for Intel cstate performance events for power
-	monitoring on modern processors.
+	  Include support for Intel cstate performance events for power
+	  monitoring on modern processors.
 
 config PERF_EVENTS_AMD_POWER
 	depends on PERF_EVENTS && CPU_SUP_AMD
