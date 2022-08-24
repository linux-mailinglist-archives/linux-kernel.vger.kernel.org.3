Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05E25A0072
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 19:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240191AbiHXRc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 13:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239329AbiHXRc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:32:26 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E744B7D798;
        Wed, 24 Aug 2022 10:32:24 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id caaf97ed744133c6; Wed, 24 Aug 2022 19:32:23 +0200
Received: from kreacher.localnet (unknown [213.134.169.54])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 075BF66D192;
        Wed, 24 Aug 2022 19:32:21 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm: amd: amdgpu: ACPI: Add comment about ACPI_FADT_LOW_POWER_S0
Date:   Wed, 24 Aug 2022 19:32:21 +0200
Message-ID: <1831630.tdWV9SEqCh@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.169.54
X-CLIENT-HOSTNAME: 213.134.169.54
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejuddgudduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeevtdehuddvteduffejgeegueehheekfedtgeevkeeuffffudeffefgheevkeelgfenucffohhmrghinhepuhgvfhhirdhorhhgnecukfhppedvudefrddufeegrdduieelrdehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudefrddufeegrdduieelrdehgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepledprhgtphhtthhopegrlhgvgigrnhguvghrrdguvghutghhvghrsegrmhgurdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrkhhovghnihhgsegrmhgurdgtohhmpdhrtghpthhtohepighinhhhuhhirdfrrghnsegrmhgurdgtohhmpdhrtghpthhtoheprghmugdqghhfgieslhhishhtshdrfhhrvggvuggvshhk
 thhophdrohhrghdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=9 Fuz1=9 Fuz2=9
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

According to the ACPI specification [1], the ACPI_FADT_LOW_POWER_S0
flag merely means that it is better to use low-power S0 idle on the
given platform than S3 (provided that the latter is supported) and it
doesn't preclude using either of them (which of them will be used
depends on the choices made by user space).

However, on some systems that flag is used to indicate whether or not
to enable special firmware mechanics allowing the system to save more
energy when suspended to idle.  If that flag is unset, doing so is
generally risky.

Accordingly, add a comment to explain the ACPI_FADT_LOW_POWER_S0 check
in amdgpu_acpi_is_s0ix_active(), the purpose of which is otherwise
somewhat unclear.

Link: https://uefi.org/specs/ACPI/6.4/05_ACPI_Software_Programming_Model/ACPI_Software_Programming_Model.html#fixed-acpi-description-table-fadt # [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c |    6 ++++++
 1 file changed, 6 insertions(+)

Index: linux-pm/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
===================================================================
--- linux-pm.orig/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ linux-pm/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1066,6 +1066,12 @@ bool amdgpu_acpi_is_s0ix_active(struct a
 	    (pm_suspend_target_state != PM_SUSPEND_TO_IDLE))
 		return false;
 
+	/*
+	 * If ACPI_FADT_LOW_POWER_S0 is not set in the FADT, it is generally
+	 * risky to do any special firmware-related preparations for entering
+	 * S0ix even though the system is suspending to idle, so return false
+	 * in that case.
+	 */
 	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
 		dev_warn_once(adev->dev,
 			      "Power consumption will be higher as BIOS has not been configured for suspend-to-idle.\n"



