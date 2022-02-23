Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B761F4C184F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242678AbiBWQQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236228AbiBWQQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:16:27 -0500
X-Greylist: delayed 522 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Feb 2022 08:15:58 PST
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E5FC4E12;
        Wed, 23 Feb 2022 08:15:58 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 70C702B0014E;
        Wed, 23 Feb 2022 11:07:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 23 Feb 2022 11:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yotsuba.nl; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; bh=6WaAJK5lyFLmcmFKJl+0M+d6NIX9M8qY6UrRrz5b9zI=; b=eEh3k
        eL6El0y2BpWdZVivRqzzJikfGRKEww/41gQZgykXPMQv/2oIPH4jh/m+SdBtTLtI
        20cI43uQwFWMG1lPao0tT9IaZhDgZzO006IgK0JadDHIDwrbpN1qvkysLlEq5KvW
        jw9kOEekgM6R0MDKNgRFUmcwmZDwbyLGlMhxurpBdrmhFVeh/NWqEEpKjQJljr6i
        qsayVve8o/OXRFwFwYfFeb3Yky2TRss3QVCWfF4Dn+WIJqUOqMGjw1Ux6oU1V34+
        0SO9WeQ4pVBtN2yDF8Fol7Gy7hjN6v1ISces9Oin0WJSwfCtg0DZnTdBA+Y5JXT0
        m3OHSW5j1JwtuC8uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=6WaAJK5lyFLmcmFKJl+0M+d6NIX9M
        8qY6UrRrz5b9zI=; b=HaRTHEgCGe+caz2sQsKoHHme3UB6NQ8YbcSovGCrxHKjP
        otSNGsM1gqQjhEUwIhsTaW2JZGiGGAD/EQ2DyBM5VRgLeJyennBIReyJ8PFmEMz+
        5LmtqrXgPXYI2qt9YNXFAqT4fTTLWgsvDvlL5lc7X/oJAq2YXMfmCBuN6q2urLPr
        Bo35z3leobrdjuvCkLKZM/6UUfaiGfqEnR+pZl9LNdCxiOsvyPPmDDuSuXEYK4y+
        splUPU5JIH0Fktta/JahNbcRtogxuEaglJNkId7ld/0BxJwKXOuoJHcOoYPLp+ol
        kFkcTgIhTQGPeWSPoTSsZx8U14CdkfN/3eC6F+cdg==
X-ME-Sender: <xms:slsWYqoNzUbmSnbWW7HIlb2tFL6XSTWqfv65Cwl0GecxMi_v-hd4kg>
    <xme:slsWYoqpQ6zRqqoWOY8UcZQ_N-wmlPrBO0AYYrmm82V-NLhRS0nC120D8_asCvAZT
    n4mcyX2QpN_clVeGu8>
X-ME-Received: <xmr:slsWYvODuRF8D_NadyrzUYhSy1ILTh4crYtOv-3CFF51J3QrE2GNsJOSZJHISosO9AXBvA51uE_B6h0o0ElVy1mCrjcVEGauS1uUMYbsyjH7gjY8s88KxR06nQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrledtgdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepofgrrhhkucevihhl
    ihhsshgvnhcuoehmrghrkheshihothhsuhgsrgdrnhhlqeenucggtffrrghtthgvrhhnpe
    ehudevhedtleefkefgjeduvefhgffhhedvteffhefgleetleehleegffdtffduheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrkheshi
    hothhsuhgsrgdrnhhl
X-ME-Proxy: <xmx:slsWYp7scNv8-zCXV2_wfWEtpBe4EREL41uJKSxlz_WF53wEm71ZHw>
    <xmx:slsWYp53lkUiJ3SJyTslX0hhOWwBL3TqGnAVs9GqQjUahn7ApZHQRQ>
    <xmx:slsWYph-F5uFCM5U8OXixZfnx5dqcJhJoarPmW3ENc-3VsXQ5JGUhQ>
    <xmx:s1sWYmwtItwewWO-_NDnIP7WYAHxiVs5MzRLDAyijwIWBwlfOrXm6nH2lic>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Feb 2022 11:07:12 -0500 (EST)
From:   Mark Cilissen <mark@yotsuba.nl>
To:     linux-acpi@vger.kernel.org, x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Mark Cilissen <mark@yotsuba.nl>
Subject: [PATCH] x86/acpi: Work around broken XSDT on SEGA AALE board
Date:   Wed, 23 Feb 2022 17:07:08 +0100
Message-Id: <20220223160708.88100-1-mark@yotsuba.nl>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On this board the ACPI RSDP structure points to both a RSDT and an XSDT,
but the XSDT points to a truncated FADT. This causes all sorts of trouble
and usually a complete failure to boot after the following error occurs:

  ACPI Error: Unsupported address space: 0x20 (*/hwregs-*)
  ACPI Error: AE_SUPPORT, Unable to initialize fixed events (*/evevent-*)
  ACPI: Unable to start ACPI Interpreter

This leaves the ACPI implementation in such a broken state that subsequent
kernel subsystem initialisations go wrong, resulting in among others
mismapped PCI memory, SATA and USB enumeration failures, and freezes.

As this is an older embedded platform that will likely never see any BIOS
updates to address this issue and its default shipping OS only complies to
ACPI 1.0, work around this by forcing `acpi=rsdt`. This patch, applied on
top of Linux 5.10.102, was confirmed on real hardware to fix the issue.

Signed-off-by: Mark Cilissen <mark@yotsuba.nl>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/acpi/boot.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 5b6d1a95776f..7caf4da075cd 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1328,6 +1328,17 @@ static int __init disable_acpi_pci(const struct dmi_system_id *d)
 	return 0;
 }
 
+static int __init disable_acpi_xsdt(const struct dmi_system_id *d)
+{
+	if (!acpi_force) {
+		pr_notice("%s detected: force use of acpi=rsdt\n", d->ident);
+		acpi_gbl_do_not_use_xsdt = TRUE;
+	} else {
+		pr_notice("Warning: DMI blacklist says broken, but acpi XSDT forced\n");
+	}
+	return 0;
+}
+
 static int __init dmi_disable_acpi(const struct dmi_system_id *d)
 {
 	if (!acpi_force) {
@@ -1451,6 +1462,20 @@ static const struct dmi_system_id acpi_dmi_table[] __initconst = {
 		     DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 360"),
 		     },
 	 },
+	/*
+	 * Boxes that need ACPI XSDT use disabled due to corrupted tables
+	 */
+	{
+	 .callback = disable_acpi_xsdt,
+	 .ident = "SEGA AALE",
+	 .matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "NEC"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Bearlake CRB Board"),
+		     DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+		     DMI_MATCH(DMI_BIOS_VERSION, "V1.12"),
+		     DMI_MATCH(DMI_BIOS_DATE, "02/01/2011"),
+		     },
+	},
 	{}
 };
 

base-commit: cfb92440ee71adcc2105b0890bb01ac3cddb8507
-- 
2.28.0

