Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948314FFCE4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 19:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237401AbiDMRhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 13:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237395AbiDMRhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:37:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C806B0A2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 10:35:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83D50B815C9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 17:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC4EC385A4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 17:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649871318;
        bh=0gfyhsy/HDsXchca1M7eJINZ4xLU4qnWyVx75Mofzms=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TkpKYRvvhJu/bI4VAJTcesqHkjVDIFQwQzlJGQrboCnqs2CjtNbwvdKpwjXx9M39A
         cL/35mwthXySWJ7VfuIVmWEjgCoB41R33+ndWsXfE4i4Vu6wCNeJmjb2ykK5DfoHpb
         QuYw3tgbwkI23mOrQjRm+dNhJzweXQedQtA6NNDhMbvJQUXJo0EFj3KfuWebzdi/cR
         doxSt/tvzqlZwnbPC73uwYEzrC5w1Cwn0nEYbVe8wkdCYuoDqhWaNjFPxf93R68tCS
         K0kdBbm3eirw3tEZP6IhFpRzNN91m8sq74ymDjuUG9nyU86/QZA9Qy83xmyB+aiLzA
         lW/yKiANAxEDA==
Received: by mail-ot1-f50.google.com with SMTP id y3-20020a056830070300b005cd9c4d03feso1647986ots.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 10:35:18 -0700 (PDT)
X-Gm-Message-State: AOAM5315kV2yuZwMZOuG+/y3WzwsQRuRw+DIElkrnq11izCkpvzCfOn3
        RHk+7I1bgrpSFQMVQRkxMFoebg80418fyqasUWg=
X-Google-Smtp-Source: ABdhPJxaNm4n7yeG4FMfuQZfS7p9H1Uh78Obrn33RH4sYJI9aTgknOhM/lDRWx2nEAyBFYEkT22/F9uLmhMZJgDKZ4w=
X-Received: by 2002:a05:6830:33eb:b0:5f8:d36d:3831 with SMTP id
 i11-20020a05683033eb00b005f8d36d3831mr128207otu.265.1649871316911; Wed, 13
 Apr 2022 10:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <YlCKWhMJEMUgJmjF@zn.tnic>
In-Reply-To: <YlCKWhMJEMUgJmjF@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 13 Apr 2022 19:35:05 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGvXsZmRkRk32TpueVU1FcFGcDPr-Bd2Op0taWPPEs0SQ@mail.gmail.com>
Message-ID: <CAMj1kXGvXsZmRkRk32TpueVU1FcFGcDPr-Bd2Op0taWPPEs0SQ@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: Add an efi.h header for the decompressor
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Apr 2022 at 21:17, Borislav Petkov <bp@alien8.de> wrote:
>
> Hi,
>
> this is something that has been bothering me for a while: kernel proper
> namespace leaking into the decompressor and causing all kinds of ugly
> conflicts between definitions and us having to do preprocessor hacks to
> fix the build.
>
> We recently started putting shared functionality into
>
> arch/x86/include/asm/shared/
>
> The other thing to do is to copy linux/ namespace symbols into a
> separate decompressor header and then block any further includes of
> headers from there. Future needs would simply copy the required bits
> like I did below.
>
> And this below is converting the efi side of things. It goes ontop of
> the x86/sev branch which adds two more linux/efi.h includes and which
> triggered me to finally productize this.
>
> I'll queue it soon if there are no objections.
>

No objection from me.



> ---
> From: Borislav Petkov <bp@suse.de>
>
> Copy the needed symbols only and remove the kernel proper includes.
>
> No functional changes.
>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/boot/compressed/acpi.c       |   3 +-
>  arch/x86/boot/compressed/efi.c        |   2 -
>  arch/x86/boot/compressed/efi.h        | 126 ++++++++++++++++++++++++++
>  arch/x86/boot/compressed/kaslr.c      |   3 +-
>  arch/x86/boot/compressed/misc.h       |   3 +-
>  arch/x86/boot/compressed/pgtable_64.c |   3 +-
>  6 files changed, 131 insertions(+), 9 deletions(-)
>  create mode 100644 arch/x86/boot/compressed/efi.h
>
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> index 64b172dabd5c..9caf89063e77 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -3,10 +3,9 @@
>  #include "misc.h"
>  #include "error.h"
>  #include "../string.h"
> +#include "efi.h"
>
>  #include <linux/numa.h>
> -#include <linux/efi.h>
> -#include <asm/efi.h>
>
>  /*
>   * Longest parameter of 'acpi=' is 'copy_dsdt', plus an extra '\0'
> diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
> index 09fa3b5d70b8..6edd034b0b30 100644
> --- a/arch/x86/boot/compressed/efi.c
> +++ b/arch/x86/boot/compressed/efi.c
> @@ -6,8 +6,6 @@
>   */
>
>  #include "misc.h"
> -#include <linux/efi.h>
> -#include <asm/efi.h>
>
>  /**
>   * efi_get_type - Given a pointer to boot_params, determine the type of EFI environment.
> diff --git a/arch/x86/boot/compressed/efi.h b/arch/x86/boot/compressed/efi.h
> new file mode 100644
> index 000000000000..7db2f41b54cd
> --- /dev/null
> +++ b/arch/x86/boot/compressed/efi.h
> @@ -0,0 +1,126 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef BOOT_COMPRESSED_EFI_H
> +#define BOOT_COMPRESSED_EFI_H
> +
> +#if defined(_LINUX_EFI_H) || defined(_ASM_X86_EFI_H)
> +#error Please do not include kernel proper namespace headers
> +#endif
> +
> +typedef guid_t efi_guid_t __aligned(__alignof__(u32));
> +
> +#define EFI_GUID(a, b, c, d...) (efi_guid_t){ {                                        \
> +       (a) & 0xff, ((a) >> 8) & 0xff, ((a) >> 16) & 0xff, ((a) >> 24) & 0xff,  \
> +       (b) & 0xff, ((b) >> 8) & 0xff,                                          \
> +       (c) & 0xff, ((c) >> 8) & 0xff, d } }
> +
> +#define ACPI_TABLE_GUID                                EFI_GUID(0xeb9d2d30, 0x2d88, 0x11d3,  0x9a, 0x16, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d)
> +#define ACPI_20_TABLE_GUID                     EFI_GUID(0x8868e871, 0xe4f1, 0x11d3,  0xbc, 0x22, 0x00, 0x80, 0xc7, 0x3c, 0x88, 0x81)
> +#define EFI_CC_BLOB_GUID                       EFI_GUID(0x067b1f5f, 0xcf26, 0x44c5, 0x85, 0x54, 0x93, 0xd7, 0x77, 0x91, 0x2d, 0x42)
> +
> +#define EFI32_LOADER_SIGNATURE "EL32"
> +#define EFI64_LOADER_SIGNATURE "EL64"
> +
> +/*
> + * Generic EFI table header
> + */
> +typedef        struct {
> +       u64 signature;
> +       u32 revision;
> +       u32 headersize;
> +       u32 crc32;
> +       u32 reserved;
> +} efi_table_hdr_t;
> +
> +#define EFI_CONVENTIONAL_MEMORY                 7
> +
> +#define EFI_MEMORY_MORE_RELIABLE \
> +                               ((u64)0x0000000000010000ULL)    /* higher reliability */
> +#define EFI_MEMORY_SP          ((u64)0x0000000000040000ULL)    /* soft reserved */
> +
> +#define EFI_PAGE_SHIFT         12
> +
> +typedef struct {
> +       u32 type;
> +       u32 pad;
> +       u64 phys_addr;
> +       u64 virt_addr;
> +       u64 num_pages;
> +       u64 attribute;
> +} efi_memory_desc_t;
> +
> +#define efi_early_memdesc_ptr(map, desc_size, n)                       \
> +       (efi_memory_desc_t *)((void *)(map) + ((n) * (desc_size)))
> +
> +typedef struct {
> +       efi_guid_t guid;
> +       u64 table;
> +} efi_config_table_64_t;
> +
> +typedef struct {
> +       efi_guid_t guid;
> +       u32 table;
> +} efi_config_table_32_t;
> +
> +typedef struct {
> +       efi_table_hdr_t hdr;
> +       u64 fw_vendor;  /* physical addr of CHAR16 vendor string */
> +       u32 fw_revision;
> +       u32 __pad1;
> +       u64 con_in_handle;
> +       u64 con_in;
> +       u64 con_out_handle;
> +       u64 con_out;
> +       u64 stderr_handle;
> +       u64 stderr;
> +       u64 runtime;
> +       u64 boottime;
> +       u32 nr_tables;
> +       u32 __pad2;
> +       u64 tables;
> +} efi_system_table_64_t;
> +
> +typedef struct {
> +       efi_table_hdr_t hdr;
> +       u32 fw_vendor;  /* physical addr of CHAR16 vendor string */
> +       u32 fw_revision;
> +       u32 con_in_handle;
> +       u32 con_in;
> +       u32 con_out_handle;
> +       u32 con_out;
> +       u32 stderr_handle;
> +       u32 stderr;
> +       u32 runtime;
> +       u32 boottime;
> +       u32 nr_tables;
> +       u32 tables;
> +} efi_system_table_32_t;
> +
> +/* kexec external ABI */
> +struct efi_setup_data {
> +       u64 fw_vendor;
> +       u64 __unused;
> +       u64 tables;
> +       u64 smbios;
> +       u64 reserved[8];
> +};
> +
> +static inline int efi_guidcmp (efi_guid_t left, efi_guid_t right)
> +{
> +       return memcmp(&left, &right, sizeof (efi_guid_t));
> +}
> +
> +#ifdef CONFIG_EFI
> +bool __pure __efi_soft_reserve_enabled(void);
> +
> +static inline bool __pure efi_soft_reserve_enabled(void)
> +{
> +       return IS_ENABLED(CONFIG_EFI_SOFT_RESERVE)
> +               && __efi_soft_reserve_enabled();
> +}
> +#else
> +static inline bool efi_soft_reserve_enabled(void)
> +{
> +       return false;
> +}
> +#endif /* CONFIG_EFI */
> +#endif /* BOOT_COMPRESSED_EFI_H */
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 411b268bc0a2..4a3f223973f4 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -22,15 +22,14 @@
>  #include "misc.h"
>  #include "error.h"
>  #include "../string.h"
> +#include "efi.h"
>
>  #include <generated/compile.h>
>  #include <linux/module.h>
>  #include <linux/uts.h>
>  #include <linux/utsname.h>
>  #include <linux/ctype.h>
> -#include <linux/efi.h>
>  #include <generated/utsrelease.h>
> -#include <asm/efi.h>
>
>  #define _SETUP
>  #include <asm/setup.h> /* For COMMAND_LINE_SIZE */
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index 75d284ec763f..4ca2857ea041 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -23,7 +23,6 @@
>  #include <linux/screen_info.h>
>  #include <linux/elf.h>
>  #include <linux/io.h>
> -#include <linux/efi.h>
>  #include <asm/page.h>
>  #include <asm/boot.h>
>  #include <asm/bootparam.h>
> @@ -35,6 +34,8 @@
>  #define BOOT_BOOT_H
>  #include "../ctype.h"
>
> +#include "efi.h"
> +
>  #ifdef CONFIG_X86_64
>  #define memptr long
>  #else
> diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
> index a1733319a22a..2ac12ff4111b 100644
> --- a/arch/x86/boot/compressed/pgtable_64.c
> +++ b/arch/x86/boot/compressed/pgtable_64.c
> @@ -1,11 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include "misc.h"
> -#include <linux/efi.h>
>  #include <asm/e820/types.h>
>  #include <asm/processor.h>
> -#include <asm/efi.h>
>  #include "pgtable.h"
>  #include "../string.h"
> +#include "efi.h"
>
>  #define BIOS_START_MIN         0x20000U        /* 128K, less than this is insane */
>  #define BIOS_START_MAX         0x9f000U        /* 640K, absolute maximum */
> --
> 2.35.1
>
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
