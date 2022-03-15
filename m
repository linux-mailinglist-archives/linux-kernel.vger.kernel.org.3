Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F7E4DA355
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351388AbiCOTi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241699AbiCOTi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:38:27 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C5B51E61;
        Tue, 15 Mar 2022 12:37:15 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 89ee1a4e3178a2f0; Tue, 15 Mar 2022 20:37:13 +0100
Received: from kreacher.localnet (unknown [213.134.162.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 1FEE366B893;
        Tue, 15 Mar 2022 20:37:13 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v1 1/2] cpuidle: intel_idle: Update intel_idle() kerneldoc comment
Date:   Tue, 15 Mar 2022 20:35:47 +0100
Message-ID: <5558236.DvuYhMxLoT@kreacher>
In-Reply-To: <2630560.mvXUDI8C0e@kreacher>
References: <2630560.mvXUDI8C0e@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.162.1
X-CLIENT-HOSTNAME: 213.134.162.1
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudeftddguddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdejlefghfeiudektdelkeekvddugfeghffggeejgfeukeejleevgffgvdeluddtnecukfhppedvudefrddufeegrdduiedvrddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeivddruddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepfedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=3 Fuz1=3 Fuz2=3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit bf9282dc26e7 ("cpuidle: Make CPUIDLE_FLAG_TLB_FLUSHED generic")
moved the leave_mm() call away from intel_idle(), but it didn't update
its kerneldoc comment accordingly, so do that now.

Fixes: bf9282dc26e7 ("cpuidle: Make CPUIDLE_FLAG_TLB_FLUSHED generic")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c |    3 ---
 1 file changed, 3 deletions(-)

Index: linux-pm/drivers/idle/intel_idle.c
===================================================================
--- linux-pm.orig/drivers/idle/intel_idle.c
+++ linux-pm/drivers/idle/intel_idle.c
@@ -122,9 +122,6 @@ static unsigned int mwait_substates __in
  * If the local APIC timer is not known to be reliable in the target idle state,
  * enable one-shot tick broadcasting for the target CPU before executing MWAIT.
  *
- * Optionally call leave_mm() for the target CPU upfront to avoid wakeups due to
- * flushing user TLBs.
- *
  * Must be called under local_irq_disable().
  */
 static __cpuidle int intel_idle(struct cpuidle_device *dev,



