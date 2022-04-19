Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2C95066E0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349987AbiDSI0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349963AbiDSI0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:26:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2729633354;
        Tue, 19 Apr 2022 01:23:41 -0700 (PDT)
Date:   Tue, 19 Apr 2022 08:23:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650356618;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GYqxAl/I1rtosKL+7rnk3CKP7bZp0JD+/LP2Cn2sJnw=;
        b=1wZ5poYUNRrXX38kXP/+O8Nzm3T2VN++RaniHR9K9mwB5nC6HR6HGSbXVyKa1NG4GrFjfP
        awi02SapX/QP6YBMYfdpwlt5NCcD05B2IO2UftIvNQJ2Ipyu8uU01YIPSZY1978UxwMuCg
        WdAa8wAQzFvzC3ZDSE+LyUbvF9d57NZRXT63fAgb+PWsrsjO6nx4vs9qFpzuOsrdEdlFML
        ROEqaNI+j0zWS2L153R5T5iYB5lPe9R7i8BP/De/MfwZw10zp/+RSxBm9ohZuhFWxbUg/F
        TTZtWwIGaiEg0sM3+AyqKj3+xXdQFC8JUQUrjCFyglg2k8MN+IrWGGpsJP90OA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650356618;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GYqxAl/I1rtosKL+7rnk3CKP7bZp0JD+/LP2Cn2sJnw=;
        b=5sH2k5i/NvvqXWfgU9m2gRg4YblkmhhFXPEmnl9LGzrhVzK/u28ICvWAK0z9GbDn8Fo0X6
        N188cAFtbrhWTZCQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/boot: Add an efi.h header for the decompressor
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YlCKWhMJEMUgJmjF@zn.tnic>
References: <YlCKWhMJEMUgJmjF@zn.tnic>
MIME-Version: 1.0
Message-ID: <165035661731.4207.6773368723116660049.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     5dc91f2d4f3c160199fea9421d6b08f67a906947
Gitweb:        https://git.kernel.org/tip/5dc91f2d4f3c160199fea9421d6b08f67a906947
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 02 Feb 2022 20:24:30 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 17 Apr 2022 21:15:49 +02:00

x86/boot: Add an efi.h header for the decompressor

Copy the needed symbols only and remove the kernel proper includes.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/YlCKWhMJEMUgJmjF@zn.tnic
---
 arch/x86/boot/compressed/acpi.c       |   3 +-
 arch/x86/boot/compressed/efi.c        |   2 +-
 arch/x86/boot/compressed/efi.h        | 126 +++++++++++++++++++++++++-
 arch/x86/boot/compressed/kaslr.c      |   3 +-
 arch/x86/boot/compressed/misc.h       |   3 +-
 arch/x86/boot/compressed/pgtable_64.c |   3 +-
 6 files changed, 131 insertions(+), 9 deletions(-)
 create mode 100644 arch/x86/boot/compressed/efi.h

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 64b172d..9caf890 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -3,10 +3,9 @@
 #include "misc.h"
 #include "error.h"
 #include "../string.h"
+#include "efi.h"
 
 #include <linux/numa.h>
-#include <linux/efi.h>
-#include <asm/efi.h>
 
 /*
  * Longest parameter of 'acpi=' is 'copy_dsdt', plus an extra '\0'
diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
index 09fa3b5..6edd034 100644
--- a/arch/x86/boot/compressed/efi.c
+++ b/arch/x86/boot/compressed/efi.c
@@ -6,8 +6,6 @@
  */
 
 #include "misc.h"
-#include <linux/efi.h>
-#include <asm/efi.h>
 
 /**
  * efi_get_type - Given a pointer to boot_params, determine the type of EFI environment.
diff --git a/arch/x86/boot/compressed/efi.h b/arch/x86/boot/compressed/efi.h
new file mode 100644
index 0000000..7db2f41
--- /dev/null
+++ b/arch/x86/boot/compressed/efi.h
@@ -0,0 +1,126 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef BOOT_COMPRESSED_EFI_H
+#define BOOT_COMPRESSED_EFI_H
+
+#if defined(_LINUX_EFI_H) || defined(_ASM_X86_EFI_H)
+#error Please do not include kernel proper namespace headers
+#endif
+
+typedef guid_t efi_guid_t __aligned(__alignof__(u32));
+
+#define EFI_GUID(a, b, c, d...) (efi_guid_t){ {					\
+	(a) & 0xff, ((a) >> 8) & 0xff, ((a) >> 16) & 0xff, ((a) >> 24) & 0xff,	\
+	(b) & 0xff, ((b) >> 8) & 0xff,						\
+	(c) & 0xff, ((c) >> 8) & 0xff, d } }
+
+#define ACPI_TABLE_GUID				EFI_GUID(0xeb9d2d30, 0x2d88, 0x11d3,  0x9a, 0x16, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d)
+#define ACPI_20_TABLE_GUID			EFI_GUID(0x8868e871, 0xe4f1, 0x11d3,  0xbc, 0x22, 0x00, 0x80, 0xc7, 0x3c, 0x88, 0x81)
+#define EFI_CC_BLOB_GUID			EFI_GUID(0x067b1f5f, 0xcf26, 0x44c5, 0x85, 0x54, 0x93, 0xd7, 0x77, 0x91, 0x2d, 0x42)
+
+#define EFI32_LOADER_SIGNATURE	"EL32"
+#define EFI64_LOADER_SIGNATURE	"EL64"
+
+/*
+ * Generic EFI table header
+ */
+typedef	struct {
+	u64 signature;
+	u32 revision;
+	u32 headersize;
+	u32 crc32;
+	u32 reserved;
+} efi_table_hdr_t;
+
+#define EFI_CONVENTIONAL_MEMORY		 7
+
+#define EFI_MEMORY_MORE_RELIABLE \
+				((u64)0x0000000000010000ULL)	/* higher reliability */
+#define EFI_MEMORY_SP		((u64)0x0000000000040000ULL)	/* soft reserved */
+
+#define EFI_PAGE_SHIFT		12
+
+typedef struct {
+	u32 type;
+	u32 pad;
+	u64 phys_addr;
+	u64 virt_addr;
+	u64 num_pages;
+	u64 attribute;
+} efi_memory_desc_t;
+
+#define efi_early_memdesc_ptr(map, desc_size, n)			\
+	(efi_memory_desc_t *)((void *)(map) + ((n) * (desc_size)))
+
+typedef struct {
+	efi_guid_t guid;
+	u64 table;
+} efi_config_table_64_t;
+
+typedef struct {
+	efi_guid_t guid;
+	u32 table;
+} efi_config_table_32_t;
+
+typedef struct {
+	efi_table_hdr_t hdr;
+	u64 fw_vendor;	/* physical addr of CHAR16 vendor string */
+	u32 fw_revision;
+	u32 __pad1;
+	u64 con_in_handle;
+	u64 con_in;
+	u64 con_out_handle;
+	u64 con_out;
+	u64 stderr_handle;
+	u64 stderr;
+	u64 runtime;
+	u64 boottime;
+	u32 nr_tables;
+	u32 __pad2;
+	u64 tables;
+} efi_system_table_64_t;
+
+typedef struct {
+	efi_table_hdr_t hdr;
+	u32 fw_vendor;	/* physical addr of CHAR16 vendor string */
+	u32 fw_revision;
+	u32 con_in_handle;
+	u32 con_in;
+	u32 con_out_handle;
+	u32 con_out;
+	u32 stderr_handle;
+	u32 stderr;
+	u32 runtime;
+	u32 boottime;
+	u32 nr_tables;
+	u32 tables;
+} efi_system_table_32_t;
+
+/* kexec external ABI */
+struct efi_setup_data {
+	u64 fw_vendor;
+	u64 __unused;
+	u64 tables;
+	u64 smbios;
+	u64 reserved[8];
+};
+
+static inline int efi_guidcmp (efi_guid_t left, efi_guid_t right)
+{
+	return memcmp(&left, &right, sizeof (efi_guid_t));
+}
+
+#ifdef CONFIG_EFI
+bool __pure __efi_soft_reserve_enabled(void);
+
+static inline bool __pure efi_soft_reserve_enabled(void)
+{
+	return IS_ENABLED(CONFIG_EFI_SOFT_RESERVE)
+		&& __efi_soft_reserve_enabled();
+}
+#else
+static inline bool efi_soft_reserve_enabled(void)
+{
+	return false;
+}
+#endif /* CONFIG_EFI */
+#endif /* BOOT_COMPRESSED_EFI_H */
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 411b268..4a3f223 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -22,15 +22,14 @@
 #include "misc.h"
 #include "error.h"
 #include "../string.h"
+#include "efi.h"
 
 #include <generated/compile.h>
 #include <linux/module.h>
 #include <linux/uts.h>
 #include <linux/utsname.h>
 #include <linux/ctype.h>
-#include <linux/efi.h>
 #include <generated/utsrelease.h>
-#include <asm/efi.h>
 
 #define _SETUP
 #include <asm/setup.h>	/* For COMMAND_LINE_SIZE */
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 75d284e..4ca2857 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -23,7 +23,6 @@
 #include <linux/screen_info.h>
 #include <linux/elf.h>
 #include <linux/io.h>
-#include <linux/efi.h>
 #include <asm/page.h>
 #include <asm/boot.h>
 #include <asm/bootparam.h>
@@ -35,6 +34,8 @@
 #define BOOT_BOOT_H
 #include "../ctype.h"
 
+#include "efi.h"
+
 #ifdef CONFIG_X86_64
 #define memptr long
 #else
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index a173331..2ac12ff 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -1,11 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "misc.h"
-#include <linux/efi.h>
 #include <asm/e820/types.h>
 #include <asm/processor.h>
-#include <asm/efi.h>
 #include "pgtable.h"
 #include "../string.h"
+#include "efi.h"
 
 #define BIOS_START_MIN		0x20000U	/* 128K, less than this is insane */
 #define BIOS_START_MAX		0x9f000U	/* 640K, absolute maximum */
