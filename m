Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA515A8B58
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 04:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbiIACRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 22:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiIACRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 22:17:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD83EA33E
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 19:17:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71B1DB823C5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:17:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324F2C433D7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 02:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661998634;
        bh=Nk27irCFVQ/B31eOpwb7cfZCo9RX5b6offw8YfVRSqw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dtev6JZbZWYnd1b81x0Di3kF4r40zTCj6UQbkVjfz13h6ODMRfToIeosgkuNHn99o
         Yyz8YxvWc+TEuz9wv5/eCdeaCpP/Ms62a8f0WmeUUmItQe8u95e+QzpEgmxn5Qtf4s
         xahDsjarVYHzXX0papdLOzcwAd3nh5Em6VTCzAJgjvEszS9sa1AcG/Bj9MN2AW6i92
         OvkgLcw6V2dt9bUMQCSScFNct3cGNAdqYRfLh2XZL+y1WmwKnsLZRHmruFFVUzlMdJ
         LnG0GEz99VirUVlGRPX1Z2zWvrm9XCsnwkA9DbQK0TEfFSdPyg+fzivddZCYDqAUP9
         5gjEVjgNYCHkQ==
Received: by mail-vk1-f176.google.com with SMTP id u11so4956837vkk.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 19:17:14 -0700 (PDT)
X-Gm-Message-State: ACgBeo10AjBccBWnRa7LNKM/QoD1Au1E4KTOGeiefssn5BQWGAbSxPFF
        72Oz3A5Y63boDC0SwolgLW2Qg2qRgRuABeQeN6c=
X-Google-Smtp-Source: AA6agR4lL0Odh3mHi3zFiNi1s4o/n89sqW4pL+sKCvo10g3/JzrqZ/VxD9qtYJhLb6wFZKkkkJrMjWMTdzwk14KjlgM=
X-Received: by 2002:a1f:9d13:0:b0:376:7f81:9b85 with SMTP id
 g19-20020a1f9d13000000b003767f819b85mr8039553vke.18.1661998633063; Wed, 31
 Aug 2022 19:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220830104806.128365-1-xry111@xry111.site> <CAAhV-H5bH7xZTWLhqcZ_Bmh=RNaEVBy9523hmj-gTmitqqc8ag@mail.gmail.com>
 <c0ba2e23-5be3-924d-554a-2f10272c05bc@xen0n.name> <CAAhV-H7Dz21qRgwkMcJ0SnA9FNDN19E6mpa7C25LUitrO9LGeA@mail.gmail.com>
 <5b87173faeef587a2ffaaa6f58d34e0940231067.camel@xry111.site>
 <c53303bf-a5d2-098f-8975-efadbe0b2f2e@loongson.cn> <bc323d8578d2f6ec580066bab181788b305ae3c3.camel@xry111.site>
 <CAAhV-H4N_XvmP9KA1M5crU44kHr33MZUVSsMY4Ugu5wQSv_LOQ@mail.gmail.com> <97291c0fe5a660c844475ff019c8db6af77ecf86.camel@xry111.site>
In-Reply-To: <97291c0fe5a660c844475ff019c8db6af77ecf86.camel@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 1 Sep 2022 10:17:01 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6wzw-MV+h225rM4PfK_HY0tAdSXcUG-2Hx+_gfhzQ4_g@mail.gmail.com>
Message-ID: <CAAhV-H6wzw-MV+h225rM4PfK_HY0tAdSXcUG-2Hx+_gfhzQ4_g@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] LoongArch: Support toolchain with new relocation types
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     Jinyang He <hejinyang@loongson.cn>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Youling Tang <tangyouling@loongson.cn>
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

On Wed, Aug 31, 2022 at 11:15 PM Xi Ruoyao <xry111@xry111.site> wrote:
>
> On Wed, 2022-08-31 at 22:40 +0800, Huacai Chen wrote:
> > On Wed, Aug 31, 2022 at 4:09 PM Xi Ruoyao <xry111@xry111.site> wrote:
> > >
> > > On Wed, 2022-08-31 at 14:58 +0800, Jinyang He wrote:
> > > > That's right. Also I am wondering why new toolchain produce .got* in
> > > > kernel. It's unneeded. In the past, gcc create la.global and parsed
> > > > to la.pcrel by gas, and kernel works well. Now it seems we lost this
> > > > feature in gcc. I checked the x86 asm code just now. And some info
> > > > follows,
> > > >
> > > > LoongArch64, ./net/ipv4/udp_diag.s, *have reloc hint*
> > > >           pcalau12i       $r4,%got_pc_hi20(udplite_table)
> > > >           ld.d    $r4,$r4,%got_pc_lo12(udplite_table)
> > > >           b       udp_dump
> > > >
> > > > x86_64, ./net/ipv4/udp_diag.s
> > > >           movq    $udplite_table, %rdi
> > > >           jmp     udp_dump
> > > >
> > > > It seems related to -fno-PIE and -cmodel=kernel on x86_64.
> > > > Hope new gcc with this feature now.
> > >
> > > On x86_64 -mcmodel=kernel means "all code and data are located in [-
> > > 2GiB, 0) range.  We actually don't strictly require a "high" range as
> > > we're mostly a PIC-friendly architecture: note that we use a
> > > pcalau12i/addi.d pair for PIC addressing in [PC-2GiB, PC+2GiB, and a
> > > lu12i.w/addi.d pair for "non-PIC" addressing in [-2GiB, 2GiB), both are
> > > 2-insn sequence.
> > >
> > > If we can put the main kernel image and the modules in one 2GiB VA
> > > range, we can avoid GOT completely.  But it's not possible for now
> > > because main kernel image is loaded in XKPRANGE but the modules are in
> > > XKVRANGE.  So the best we can achieve before implementing
> > > CONFIG_RELOCATION is using GOT in modules, and avoid GOT in the main
> > > kernel image (with a new code model in GCC, which will benefit both the
> > > kernel and statically linked executables).
>
> > Emmm, can you implement this new code model in the near future?
>
> I have a plan to make our toolchain addressing the symbols better:
>
> (1) https://sourceware.org/pipermail/binutils/2022-August/122682.html.
> This change will allow the linker to link a main executable image
> (dynamically linked or statically linked, PIE or non-PIE, kernel or
> userspace) with R_LARCH_COPY instead of GOT.  (Note that R_LARCH_COPY
> will not show up in the kernel because we don't link to shared objects,
> but GOT will be gone.)
>
> (2) Change GCC to stop using GOT unless -fPIC.  (Technically it's a one-
> line change.)
>
> (3) In kernel, for main kernel image the default of toolchain will be
> good enough (no GOT).  For modules we have two options:
>
>   (a) get rid of XKPRANGE.
>   (b) force -mcmodel=extreme globally.
>   (c) use -Wl,nocopyreloc to produce GOT.
>
> (a) is the best, the performance of (b) and (c) will be worse than (a).
> I'm not sure which one in (b) and (c) is better, but as (a) will be the
> final solution we can just choose one in (b) and (c) "randomly" for now.
>
> I don't want to add a new code model now, because if (1) works fine
> we'll not need a new code model.  (1) is also the most tricky step in
> the plan (I've sent the patch but not sure if it's completely correct),
> (2) and (3) should be trivial.
Now all global variable accesses are via got, I think the performance
may be much worse than before when we didn't use explicit-relocs.
I don't know whether "a new code model" or your "(1)(2)(3)" is easier
to implement, but I think it is better to solve the performance issue
before 6.1-rc1.

Huacai

> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University
>
