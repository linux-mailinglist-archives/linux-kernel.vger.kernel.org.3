Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E3453DB01
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 11:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350924AbiFEJa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 05:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiFEJay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 05:30:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7C123BDE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 02:30:54 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654421452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=aJ0fAHN0yfhhL1zRJAkcqIWN5QZJxsV5PH13sVjVwSs=;
        b=RLC9pIWO0RtQND5Y165rJTRxEES2SQWt1fCU4AX9Pdki8VVMtg3TKksEwa+blK9VxfNuX4
        KGFejW7Kc43aUrSKmCWqQJB4PzHPdkTVvbxgX4KsLlEh4i4QLKiqbKkU/RH1uPAze/gwZ2
        UdkgFLbYFmwfVvQLf89iLru4otTQBQElbK1IahJu7FSjJOreueIAQXn4kau05XMlsIQqmW
        ctCzQvmBa68YySdu4Kig7ApBxFFcSGInbBdVf+CAqnMGKsp8NdwcZi+QufR/I3mb32QOEw
        dKhMuUgSF29pDeHZhb1O2FRLbePnkVeS7wvUGiE/5fElnYDOsR80nFxnTdn3sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654421452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=aJ0fAHN0yfhhL1zRJAkcqIWN5QZJxsV5PH13sVjVwSs=;
        b=wO2JNGgBtbogMN0BXdUNjKx6gDXOcmpJuMLTw16WbnBG1UhgPG07po5TvAijhDyW+WlLcl
        p8OJKnxyq9gUkADw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] perf/core for v5.19-rc1
References: <165442136963.152751.14259048792272164569.tglx@xen13>
Message-ID: <165442137112.152751.11088244246622721652.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun,  5 Jun 2022 11:30:51 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest perf/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-core-2022-0=
6-05

up to:  108ea7eb3e75: perf/x86/Kconfig: Fix indentation in the Kconfig file


Trivial indentation fix in Kconfig

Thanks,

	tglx

------------------>
Juerg Haefliger (1):
      perf/x86/Kconfig: Fix indentation in the Kconfig file


 arch/x86/events/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/Kconfig b/arch/x86/events/Kconfig
index 09c56965750a..dabdf3d7bf84 100644
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
=20
 config PERF_EVENTS_INTEL_RAPL
 	tristate "Intel/AMD rapl performance events"
 	depends on PERF_EVENTS && (CPU_SUP_INTEL || CPU_SUP_AMD) && PCI
 	default y
 	help
-	Include support for Intel and AMD rapl performance events for power
-	monitoring on modern processors.
+	  Include support for Intel and AMD rapl performance events for power
+	  monitoring on modern processors.
=20
 config PERF_EVENTS_INTEL_CSTATE
 	tristate "Intel cstate performance events"
 	depends on PERF_EVENTS && CPU_SUP_INTEL && PCI
 	default y
 	help
-	Include support for Intel cstate performance events for power
-	monitoring on modern processors.
+	  Include support for Intel cstate performance events for power
+	  monitoring on modern processors.
=20
 config PERF_EVENTS_AMD_POWER
 	depends on PERF_EVENTS && CPU_SUP_AMD

