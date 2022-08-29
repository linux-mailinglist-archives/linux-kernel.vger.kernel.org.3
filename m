Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09645A4FC7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 17:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiH2PES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 11:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiH2PEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:04:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DF48D3D8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 08:04:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF241B810A8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 15:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6457EC4347C
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 15:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661785446;
        bh=8eJuDB16eU5LU6ppquAMaWG5LuqKScHnNNnD8rj7QnQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d6USsR6Gh8cg6sOFS0+b4JJfar1vV4T70orRmGfQTmfJe/gNOf4zByaRKAHSjUqMu
         B8F4PukRkklZcbNa2AK/Kx2Un2HrUatGZa7Bp6c8ohqH3dtqik+XNVgXcnomKCkK77
         2x9S/1fvJbryGS8x2CPnvsMdvZ3tIenCtnlbHuOh1t4UiWpgOd5zJE6CeNmR+Ee/59
         g80C+NizjpBhpPRHixvkyBx4lzwNVpNzWu3Kyqs46c1liGQGu6/CxrLd3qs+gKrgrZ
         EO3aTV1FJCAUKmazF7BCL7SuWA27wng3KUdFWCPsLxCAadGc1CMtOOa7KVbHryUgIh
         YOdq3oO5numbA==
Received: by mail-ua1-f53.google.com with SMTP id s5so3215477uar.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 08:04:06 -0700 (PDT)
X-Gm-Message-State: ACgBeo3UVAVAf7PQ6F30ELbezeWrjbZwxbHakGuJdemSyUHSym68YzTw
        BAe7POPwLeg5Z/WI0gQ2WrtFbM9TEL4aF72z30c=
X-Google-Smtp-Source: AA6agR5/eepFMoWVz2guDngMAWQmbG0so8ekrWz0Sbei/pkHEOeCwYpumRhlxi/cGs6K4I5qoW+oCD1FyTydBk7AuC8=
X-Received: by 2002:a05:6130:c13:b0:39f:58bb:d51c with SMTP id
 cg19-20020a0561300c1300b0039f58bbd51cmr3700437uab.104.1661785445212; Mon, 29
 Aug 2022 08:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220829133146.15236-1-xry111@xry111.site> <20220829133146.15236-3-xry111@xry111.site>
In-Reply-To: <20220829133146.15236-3-xry111@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 29 Aug 2022 23:03:51 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7V-gK+RQYKdhiukQ9BT0Yw5dDy9KEAqb5hWSjMfquQJQ@mail.gmail.com>
Message-ID: <CAAhV-H7V-gK+RQYKdhiukQ9BT0Yw5dDy9KEAqb5hWSjMfquQJQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] LoongArch: Adjust CFLAGS for CONFIG_AS_HAS_EXPLICIT_RELOCS
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
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

Hi, Ruoyao,

On Mon, Aug 29, 2022 at 9:35 PM Xi Ruoyao <xry111@xry111.site> wrote:
>
> If explicit relocation hints is used by the toolchain, -Wa,-mla-*
> options will be useless for C code.  Only use them for
> !CONFIG_AS_HAS_EXPLICIT_RELOCS.
>
> Replace "la" with "la.pcrel" in head.S to keep the semantic consistent
> with new and old toolchains for the low level startup code.
>
> Remove -fplt because it's the default for all known LoongArch C
> compilers.
>
> The behavior with different assemblers and compilers are summarized in
> the following table:
>
> AS has            CC has
> explicit reloc    explicit reloc    Behavior
> ==============================================================
> No                No                Use la.* macros.
>                                     No change from Linux 6.0.
> --------------------------------------------------------------
> No                Yes               Disable explicit reloc.
>                                     No change from Linux 6.0.
> --------------------------------------------------------------
> Yes               No                Not supported.
> --------------------------------------------------------------
> Yes               Yes               Use explicit relocs.
>                                     No -Wa,-mla* options.
> ==============================================================
>
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  arch/loongarch/Makefile      | 19 ++++++++++++++++++-
>  arch/loongarch/kernel/head.S | 10 +++++-----
>  2 files changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index 7051a95f7f31..1563747c4fa8 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -40,10 +40,27 @@ endif
>
>  cflags-y                       += -G0 -pipe -msoft-float
>  LDFLAGS_vmlinux                        += -G0 -static -n -nostdlib
> +
> +# When the assembler supports explicit relocation hint, we must use it.
> +# GCC may have -mexplicit-relocs off by default if it was built with an old
> +# assembler, so we force it via an option.
> +#
> +# When the assembler does not supports explicit relocation hint, we can't use
> +# it.  Disable it if the compiler supports it.
> +#
> +# If you've seen "unknown reloc hint" message building the kernel and you are
> +# now wondering why "-mexplicit-relocs" is not wrapped with cc-option: the
> +# combination of a "new" assembler and "old" compiler is not supported.  Either
> +# upgrade the compiler or downgrade the assembler.
> +ifdef CONFIG_AS_HAS_EXPLICIT_RELOCS
> +cflags-y                       += -mexplicit-relocs
> +else
> +cflags-y                       += $(call cc-option,-mno-explicit-relocs)
>  KBUILD_AFLAGS_KERNEL           += -Wa,-mla-global-with-pcrel
>  KBUILD_CFLAGS_KERNEL           += -Wa,-mla-global-with-pcrel
>  KBUILD_AFLAGS_MODULE           += -Wa,-mla-global-with-abs
> -KBUILD_CFLAGS_MODULE           += -fplt -Wa,-mla-global-with-abs,-mla-local-with-abs
> +KBUILD_CFLAGS_MODULE           += -Wa,-mla-global-with-abs,-mla-local-with-abs
Though -fplt is the default, keep it can make code clearer.

Huacai
> +endif
>
>  cflags-y += -ffreestanding
>  cflags-y += $(call cc-option, -mno-check-zero-division)
> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> index 01bac62a6442..eb3f641d5915 100644
> --- a/arch/loongarch/kernel/head.S
> +++ b/arch/loongarch/kernel/head.S
> @@ -55,17 +55,17 @@ SYM_CODE_START(kernel_entry)                        # kernel entry point
>         li.w            t0, 0x00                # FPE=0, SXE=0, ASXE=0, BTE=0
>         csrwr           t0, LOONGARCH_CSR_EUEN
>
> -       la              t0, __bss_start         # clear .bss
> +       la.pcrel        t0, __bss_start         # clear .bss
>         st.d            zero, t0, 0
> -       la              t1, __bss_stop - LONGSIZE
> +       la.pcrel        t1, __bss_stop - LONGSIZE
>  1:
>         addi.d          t0, t0, LONGSIZE
>         st.d            zero, t0, 0
>         bne             t0, t1, 1b
>
> -       la              t0, fw_arg0
> +       la.pcrel        t0, fw_arg0
>         st.d            a0, t0, 0               # firmware arguments
> -       la              t0, fw_arg1
> +       la.pcrel        t0, fw_arg1
>         st.d            a1, t0, 0
>
>         /* KSave3 used for percpu base, initialized as 0 */
> @@ -73,7 +73,7 @@ SYM_CODE_START(kernel_entry)                  # kernel entry point
>         /* GPR21 used for percpu base (runtime), initialized as 0 */
>         move            u0, zero
>
> -       la              tp, init_thread_union
> +       la.pcrel        tp, init_thread_union
>         /* Set the SP after an empty pt_regs.  */
>         PTR_LI          sp, (_THREAD_SIZE - 32 - PT_SIZE)
>         PTR_ADD         sp, sp, tp
> --
> 2.37.0
>
>
