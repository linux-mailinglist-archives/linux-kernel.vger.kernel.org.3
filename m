Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4D4583EC6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238388AbiG1MZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238371AbiG1MZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:25:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB52A2BEC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:25:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A2BC61CA0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 12:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8514C43470
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 12:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659011122;
        bh=g5InCYzCGrDsbPmc+ADfWHf+9LhwtsQs5DQCtq4x3RU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jO3kLyLgR+n8cMt9gOJShwFvtFGDYvS4eeGB4xuZezR2yy9CaAp6008KcP72+wn4o
         v3IFjw7o9pHXr2AksMzkAl+smt9NBPvmE0HU+dfRqtyTTWQYjW63WsZnP5Sd4QUkHC
         GR3+rmLwiGQH4YHHaK3EfWl1DMDUyfk9kqKmlMiKN2MwaVLnvWICtjk+QmwB4T9rQT
         h3W/GPRj95XCmWO8UgSyHAViTuy4Xh26hcgKesfMXAEtGhGTct322FjSVoyVNFeWeo
         8bve5R8tpcW3TVRxySFqf2CKJ/QjHtj96/Y9UXq+nVKgWvsaQzgNEx1Rd2VF4gtpUS
         Mx5M0oPDeWkZg==
Received: by mail-vk1-f181.google.com with SMTP id r188so754018vkf.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:25:22 -0700 (PDT)
X-Gm-Message-State: AJIora/DjCuqsl9+zRGKGDOFv6RMD0TEC4q54RrSdTsb7eKkpV3Ylhq7
        ozD7ujoQak8C6peFoIp6RUbo/gqIl8KrhUkOY2k=
X-Google-Smtp-Source: AGRyM1tq3HvSmAJKxeFZVp3d0YyXdYAyfn4sr97qDBntOs7KlpKPn8omNlIOvAwCqY15GzcPetU6WfjSRLae19gBvic=
X-Received: by 2002:a1f:aa8b:0:b0:376:e14b:c10e with SMTP id
 t133-20020a1faa8b000000b00376e14bc10emr953045vke.19.1659011121683; Thu, 28
 Jul 2022 05:25:21 -0700 (PDT)
MIME-Version: 1.0
References: <c596e7a73953a1c49e8f5e94ec2db642f72e7813.camel@xry111.site> <e95cfe70e2e5faa5b9cdc9452bdb3ab8d664aff0.camel@xry111.site>
In-Reply-To: <e95cfe70e2e5faa5b9cdc9452bdb3ab8d664aff0.camel@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 28 Jul 2022 20:25:08 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5nuP2xYREtZuJnq3Sr+JpVbOzLDw+N1ep5yFSUd1+nFQ@mail.gmail.com>
Message-ID: <CAAhV-H5nuP2xYREtZuJnq3Sr+JpVbOzLDw+N1ep5yFSUd1+nFQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] LoongArch: Stop using undocumented assembler options
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     loongarch@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ruoyao,

On Thu, Jul 28, 2022 at 8:03 PM Xi Ruoyao <xry111@xry111.site> wrote:
>
> Now we can handle GOT and GOT-based relocations properly, remove the
> undocumented `-Wa,-mla-{global,local}-with-{pcrel,abs}` assembler hacks.
I think "-Wa,-mla-{global,local}-with-{pcrel,abs}" may be regular
options rather than "hacks". If I'm right, the title and commit
message should be updated. And we can send patches to binutils to make
them "documented".

Huacai
>
> And, -fplt is the default of all supported compilers (GCC, and maybe
> Clang in the future), so it can be removed as well.
>
> Adjust assembly code to explicitly use "la.pcrel" where necessary.
>
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  arch/loongarch/Makefile      |  4 ----
>  arch/loongarch/kernel/head.S | 10 +++++-----
>  2 files changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index 039dcc4fe1f3..800349ea9310 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -40,10 +40,6 @@ endif
>
>  cflags-y                       += -G0 -pipe -msoft-float
>  LDFLAGS_vmlinux                        += -G0 -static -n -nostdlib
> -KBUILD_AFLAGS_KERNEL           += -Wa,-mla-global-with-pcrel
> -KBUILD_CFLAGS_KERNEL           += -Wa,-mla-global-with-pcrel
> -KBUILD_AFLAGS_MODULE           += -Wa,-mla-global-with-abs
> -KBUILD_CFLAGS_MODULE           += -fplt -Wa,-mla-global-with-abs,-mla-local-with-abs
>
>  cflags-y += -ffreestanding
>  cflags-y += $(call cc-option, -mno-check-zero-division)
> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/head.S
> index 74ea7bf6c8d6..193329ed6e8c 100644
> --- a/arch/loongarch/kernel/head.S
> +++ b/arch/loongarch/kernel/head.S
> @@ -60,17 +60,17 @@ SYM_CODE_START(kernel_entry)                        # kernel entry point
>         la.abs          t0, 0f
>         jirl            zero, t0, 0
>  0:
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
> @@ -78,7 +78,7 @@ SYM_CODE_START(kernel_entry)                  # kernel entry point
>         /* GPR21 used for percpu base (runtime), initialized as 0 */
>         or              u0, zero, zero
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
>
