Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0A057C670
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbiGUIgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbiGUIga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:36:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729D33B946
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 01:36:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C280B82375
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:36:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95CEC36AF2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658392581;
        bh=nKpz/OqRztg5EzCK42ZfWepbK8TN0TvfFCyvjm5mdIY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A+bMhyz+nHDfKK4NfWjEW+Vv65X+YF922kXyOusZOYcgGfruM+e6flOuE99wPPcHT
         dl4geEg4tuNIBIZpKpJqAVrlBGI82HGMfVVOSHjTpG/wyOqyVjii1hXCfq8bLj+kiv
         0lhMS18hTlbxo0g6TsB1cz9pU9ltIzBTGStm4VKFJrsjs7++0e/1qNqdVFE0t94yLf
         b7XO4QFmkJvlSu+3N+zB9xI49PajgB6WuhwV+QzQhDQFMqcaVJIV9o8uXlRuZNXTng
         FjgDS8Sd+4A2+uLWjRmieS6Hqoh/nZIznpUGitL/IdrFGy+AWndZOT/ei0BP1NBsxg
         l5qRuGqNhEHAw==
Received: by mail-ua1-f47.google.com with SMTP id p8so296349uam.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 01:36:21 -0700 (PDT)
X-Gm-Message-State: AJIora8UeD6DChE5VE0wOCLf8HEcXJOlYqJYvvtU7YCwboiKrsy7CCF5
        m5Ry9haxneba5lvznwXfsLE64Uy80tuJzV+Rn2k=
X-Google-Smtp-Source: AGRyM1s3YfCfLq6toB5w0XxbU0n07z9DjrkLgoEL84RlBpFnEkguxwPqkVoRBkP0FWDYxyCvF7QqKys2qruTxPL8kPE=
X-Received: by 2002:ab0:37d7:0:b0:384:47a1:eb8e with SMTP id
 e23-20020ab037d7000000b0038447a1eb8emr2239729uav.23.1658392580666; Thu, 21
 Jul 2022 01:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220721021127.1086628-1-yijun@loongson.cn> <CAAhV-H4YL-8tj+-329tWguwxrPaL7DpiTT2QkXBPh_feT7M5jA@mail.gmail.com>
 <dcfac9ad-d6e0-b157-4f11-cc2d3e2f1376@xen0n.name> <CAAhV-H6RGZwKjV4Shm9fvH_XJ1+yqq9KpxkXNEWwOaPRmahSLQ@mail.gmail.com>
 <4a8f5963-28f1-7439-9b52-7084d51707b2@xen0n.name>
In-Reply-To: <4a8f5963-28f1-7439-9b52-7084d51707b2@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 21 Jul 2022 16:36:08 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4fqirffgyhc1Ros9KiOtM32vHqVKprLfvaROE3DHzYdw@mail.gmail.com>
Message-ID: <CAAhV-H4fqirffgyhc1Ros9KiOtM32vHqVKprLfvaROE3DHzYdw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Remove unused header compiler.h
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Jun Yi <yijun@loongson.cn>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, please update the commit message and send V2, please.

On Thu, Jul 21, 2022 at 1:38 PM WANG Xuerui <kernel@xen0n.name> wrote:
>
> On 2022/7/21 11:22, Huacai Chen wrote:
> > Hi, Xuerui,
> >
> > On Thu, Jul 21, 2022 at 11:17 AM WANG Xuerui <kernel@xen0n.name> wrote:
> >> Hi YI Jun and Huacai,
> >>
> >> On 2022/7/21 10:52, Huacai Chen wrote:
> >>> Hi, Jun,
> >>>
> >>> On Thu, Jul 21, 2022 at 10:11 AM Jun Yi <yijun@loongson.cn> wrote:
> >>>> Loongarch not used arch-specific compiler.h
> >>> I'm not sure whether compiler.h will be used in future. If it will be
> >>> used, I want to keep it as is. Xuerui, what do you think about it?
> >> I surveyed all the existing arch compiler.h in the tree:
> >>
> >> $ find ./arch -name compiler.h
> >> ./arch/alpha/include/asm/compiler.h
> >> ./arch/alpha/include/uapi/asm/compiler.h
> >> ./arch/arm/include/asm/compiler.h
> >> ./arch/arm64/include/asm/compiler.h
> >> ./arch/mips/include/asm/compiler.h
> >> ./arch/loongarch/include/asm/compiler.h
> >>
> >> Of all these occurrences:
> >>
> >> - alpha needs to ensure a certain insn is being emitted from time to
> >> time, with plain C constructs (or built-ins) on compiler versions with
> >> said support, falling back to inline asm otherwise;
> >> - arm and arm64 both need some inline assembly help (of different sort),
> >> with arm64 stuffing some pointer authentication helpers into this file too;
> >> - mips, which is obviously what the loongarch version is based on, needs
> >> (1) a kludge for older compilers to fix delay slot filling around
> >> __builtin_unreachable, (2) definitions for explicit arch level
> >> selection. There is also the historical GCC_OFF_SMALL_ASM() constraint
> >> definition that was rendered redundant by commit 4abaacc704729 ("MIPS:
> >> remove GCC < 4.9 support").
> >>
> >> For loongarch, the "ZC" constraint (I don't think it was a coincidence
> >> BTW) should be usable for all present and future hardware, so I do think
> >> the GCC_OFF_SMALL_ASM() here is redundant. We may want to remove the
> >> mips one too. And the arch level thing is not currently needed either,
> >> future revisions to the LoongArch ISA should be largely backwards
> >> compatible, so it could be a long time before such explicit selection of
> >> arch level is necessary, for exact control over emitted insn.
> >>
> >> So overall, I'm in favor of removing this header for now.
> > Have you considered the new relocation types will be added in the near
> > future? I think we need compiler.h at that time.
>
> I assume you mean the proposal being discussed at [1] [2] and [3].
>
> For new reloc types that affect module loading, asm/elf.h and
> kernel/module.c need modification to add awareness, but this doesn't
> involve compiler.h. The kernel image itself is not affected.
>
> There is also the case of building LoongArch kernel sources without
> support for the new reloc types, but on a newer compiler that emits the
> new-style reloc records by default. In this case, a switch reverting the
> compiler to the old-style relocs is needed in CFLAGS, but (1) not all
> essential support are merged for LoongArch so practically we don't need
> to care about non-kernel-ABI compatibility at this time, and (2) CFLAGS
> tweaks don't involve compiler.h either.
>
> [1]: https://sourceware.org/pipermail/binutils/2022-July/121849.html
> [2]: https://sourceware.org/pipermail/binutils/2022-July/121933.html
> [3]: https://github.com/loongson/LoongArch-Documentation/pull/57
>
>
