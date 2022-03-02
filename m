Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A734C9C5C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 05:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239394AbiCBEJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 23:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiCBEJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 23:09:55 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C71D3BA50;
        Tue,  1 Mar 2022 20:09:11 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7F522580135;
        Tue,  1 Mar 2022 23:09:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 01 Mar 2022 23:09:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yotsuba.nl; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; bh=ZPLV2jqAeH65KycreS1nxk1J+/tPHQWJCXOf2WrHUzE=; b=IPimP
        JQa1EyYNtMQMZWlrOK+OvIapkwCxrplbQ2z6qIgTYaPBiQETpCjJwzmslFjTy5Jl
        UvL04YRs1MKm+oFacw8iOHGFr1WyasBL5Iew0Z03LF3cQAHXKqVKdiZjTBc8mKNn
        DCr1SicWBCTbfHD64yISNf9EuhwOJFn09bXPjN2LtNdx+ghL4Z22w4sGKVOgGbNO
        gGoxo2a6UowlfAj9tnLbxjC1IpW4flIUHVGQnszCHALY27avifp2mG6QPcgMLo36
        buZ89TglRYV77G1yAAK4qNpYCXAFEoZzPAmOjMPwrcFxF7PyiTWGdRzu3HRkAuCM
        mDEYKCWRTpWWWMpcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=ZPLV2jqAeH65KycreS1nxk1J+/tPH
        QWJCXOf2WrHUzE=; b=TCsjVPYFOn/dsuejo4rHXMcnE+vlw0/wHEq1YnFUq0pBs
        JrxEuz/5C0bMozhVu3jdyCNg9/ape5aAYk8hsmWBt67d6qEAWP5inuB2uLdf4oSE
        SVeqv34wqfCFjoE38Az/ZWgEUrUyFFi4bTuaUDPvN846u0wfnrIErP58Kq8xGERf
        VdECNCJOebpjr7t5DXvJFSCS7tbEPGxSaqbrWSTetKe8QSJMzgEPxS9guCk1QPI1
        NXh+M06eawxbhAsLh9Jwc+fpxiJWjUXN9zGXaQCYE+dSXHMqU+K0nezqmhQjtnEi
        gwoMNAB8qsIuh/t3DcSDlyUmi8j/6ykv5Q6TC+42Q==
X-ME-Sender: <xms:4u0eYkQwNC43VIoFVj5op_uSrhhDHa1eJmqPj8jwDculkDcc4TY8Sg>
    <xme:4u0eYhzBO05DkxJ2qAajWKklSDdF5v1a0cG-UgMQYHE52MUn2tqFdBNLhDB4xxSgq
    4EU5-B1epOJvffad2c>
X-ME-Received: <xmr:4u0eYh25IERg4hxn5Q_T7Ij1yFY_XeDEuP-_3zk-ENVZ98RbsmGECmuTTZKWovMQ8lDbw8nxbNDlGd_2xq87-Klm1386GrogFkifayPCH-spUqQMlBV0xxI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtfedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcuvehi
    lhhishhsvghnuceomhgrrhhkseihohhtshhusggrrdhnlheqnecuggftrfgrthhtvghrnh
    epheduveehtdelfeekgfejudevhffghfehvdetffehgfelteelheelgefftdffudehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhkse
    ihohhtshhusggrrdhnlh
X-ME-Proxy: <xmx:4-0eYoBL3nmekOAnfmiSGYuxFYRJOqjZ__YETxkY_2NzHbFmDdIzqw>
    <xmx:4-0eYtjpvnHvhiFwrBeos2D4AKLcTSHxapq6ArA3CeK8hHCZGHS6sA>
    <xmx:4-0eYko9aFiTK_frG-cn87j-GKDG1EeU0g_RwxUy3RrOvfwdrjJx7g>
    <xmx:5O0eYoo2EAfyzqmdD0zkVTZZfy1eBjkAkZB3dqRCMpSovcSR5v3i9A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Mar 2022 23:09:05 -0500 (EST)
From:   Mark Cilissen <mark@yotsuba.nl>
To:     linux-acpi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Mark Cilissen <mark@yotsuba.nl>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] ACPI / x86: Work around broken XSDT on Advantech DAC-BJ01 board
Date:   Wed,  2 Mar 2022 05:08:00 +0100
Message-Id: <20220302040800.10355-1-mark@yotsuba.nl>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
v2:
- Reduce DMI match count to 4 to not overflow dmi_system_id structure
Reported-by: kernel test robot <lkp@intel.com>
- Change board ident to correct name
- Fix small style issue
- Fix up subject as per Rafael's changes

As this patch is CC'd to stable, it seemed wiser to submit a V2 rather
than an additional fixup patch to process.
---
 arch/x86/kernel/acpi/boot.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 5b6d1a95776f..b47338cd579d 100644
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
@@ -1451,6 +1462,19 @@ static const struct dmi_system_id acpi_dmi_table[] __initconst = {
 		     DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 360"),
 		     },
 	 },
+	/*
+	 * Boxes that need ACPI XSDT use disabled due to corrupted tables
+	 */
+	{
+	 .callback = disable_acpi_xsdt,
+	 .ident = "Advantech DAC-BJ01",
+	 .matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "NEC"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Bearlake CRB Board"),
+		     DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
+		     DMI_MATCH(DMI_BIOS_VERSION, "V1.12"),
+		     },
+	 },
 	{}
 };
 

base-commit: 038101e6b2cd5c55f888f85db42ea2ad3aecb4b6
-- 
2.28.0

