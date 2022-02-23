Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF90D4C139C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 14:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240708AbiBWNLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 08:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiBWNLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:11:35 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADCA97B96
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 05:11:07 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9E7F33FCAC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 13:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645621866;
        bh=UXKLKyZvqZuicoDX6WsicwD+NuWstrOluCAJwIKeGTs=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=fhvGXdJRNPrJzGOIASK1TI8Tm+6JOE4FAJmoxoDLn9UzycfB5046UArIHQc3J7I9i
         NpiRUCGY4M7jkVchHT3clkJW/P4OH23qtV0Ys8hSza1OHgEQ1et5WCgIY/W5Uf70vO
         ewHThLX0ZXXHutmX7x86+dH1nowXSZ0+ij5DIK/svYaTNGEtUMg92X+c1AQBaeLTS6
         b31tL9vkV1OwyOUU9N0CrWiaEwsqxjDfc8anW2c+SxfP6hsHtp6NAywiFg4eDxJm1o
         nKu52C3+ZVl/MZLPTbUw5cl6K7Y6pMd0/KkptHsEBPJphT2an7cGVYYeCcJQDV/m/W
         cDZ3tIocr6qLQ==
Received: by mail-ej1-f72.google.com with SMTP id go11-20020a1709070d8b00b006cf0d933739so7114832ejc.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 05:11:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UXKLKyZvqZuicoDX6WsicwD+NuWstrOluCAJwIKeGTs=;
        b=2gmT/GeODjEgUPd2HYgUTkTJSo92R9g9E83qUsIx2gG+x6tOytkKKp6pLDYq21N851
         P21nAGjDyrvMPh44bwhlhrZHPLL3yixa/xRyGZ7n9KHSqOhRqP8UMK38lJ5Ufkxc8s9a
         kJdne2pWIj1R35H4miK0mXBMLtQWr7QVZzpJyHySEc8U15Qt/M5EFeUMfhZfDXyHIGAy
         DO4UQF+wLD7IxxMWvxpHbiEoBdrDcW/QXJNvZ05oZzys/42uLF2Aqk7swIsLz7F+CCTN
         pGYx4+lca/+nXZg0Rpc9aS94GyoAoNsdrvMD4uErfZtY+jlpW+p/zKRXsdJpPfHtu9tg
         LQ8A==
X-Gm-Message-State: AOAM531kQVQiIhCHKBjdk2oM8XTwAj7agofOlAXgh+YN9PPB8o+gMElJ
        EBoAnUkvNj69QAdddNngbmnv5uJVtEFYzKbSrZgeJNCOTcPFG4+8jD0n2Yk93CH6+HDNEr8oVSC
        Zc2HIGH6/HhgvtKgU/oFvGWUp6eytP5C+8ILBcFsk9D2zKv3FPID9uakQKA==
X-Received: by 2002:a17:906:d9db:b0:6ce:8bfb:53c9 with SMTP id qk27-20020a170906d9db00b006ce8bfb53c9mr22490683ejb.10.1645621865035;
        Wed, 23 Feb 2022 05:11:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwwfwzNpAYIVgE7reRUJKUajrHRzMqRRe2Abz2bXiKaC8Mok6ZuxByqkcTiP4VdlcCzzvouoi25V+9aste03gA=
X-Received: by 2002:a17:906:d9db:b0:6ce:8bfb:53c9 with SMTP id
 qk27-20020a170906d9db00b006ce8bfb53c9mr22490660ejb.10.1645621864802; Wed, 23
 Feb 2022 05:11:04 -0800 (PST)
MIME-Version: 1.0
References: <20220221161232.2168364-1-alexandre.ghiti@canonical.com>
 <20220221161232.2168364-5-alexandre.ghiti@canonical.com> <CANp29Y7M=wSLBE8m0-CHKtYPkqgcxNiUPEyRNv-VHeR5O2BTYQ@mail.gmail.com>
In-Reply-To: <CANp29Y7M=wSLBE8m0-CHKtYPkqgcxNiUPEyRNv-VHeR5O2BTYQ@mail.gmail.com>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Wed, 23 Feb 2022 14:10:53 +0100
Message-ID: <CA+zEjCt02Cx1Q1yDGN9V6Wvgx0+jvcqft6U56M3wsidkW5sMjg@mail.gmail.com>
Subject: Re: [PATCH -fixes v2 4/4] riscv: Fix config KASAN && DEBUG_VIRTUAL
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nick Hu <nickhu@andestech.com>,
        linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aleksandr,

On Tue, Feb 22, 2022 at 11:28 AM Aleksandr Nogikh <nogikh@google.com> wrote:
>
> Hi Alexandre,
>
> Thanks for the series!
>
> However, I still haven't managed to boot the kernel. What I did:
> 1) Checked out the riscv/fixes branch (this is the one we're using on
> syzbot). The latest commit was
> 6df2a016c0c8a3d0933ef33dd192ea6606b115e3.
> 2) Applied all 4 patches.
> 3) Used the config from the cover letter:
> https://gist.github.com/a-nogikh/279c85c2d24f47efcc3e865c08844138
> 4) Built with `make -j32 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu-`
> 5) Ran with `qemu-system-riscv64 -m 2048 -smp 1 -nographic -no-reboot
> -device virtio-rng-pci -machine virt -device
> virtio-net-pci,netdev=net0 -netdev
> user,id=net0,restrict=on,hostfwd=tcp:127.0.0.1:12529-:22 -device
> virtio-blk-device,drive=hd0 -drive
> file=~/kernel-image/riscv64,if=none,format=raw,id=hd0 -snapshot
> -kernel ~/linux-riscv/arch/riscv/boot/Image -append "root=/dev/vda
> console=ttyS0 earlyprintk=serial"` (this is similar to how syzkaller
> runs qemu).
>
> Can you please hint at what I'm doing differently?

A short summary of what I found to keep you updated:

I compared your command line and mine, the differences are that I use
"smp=4" and I add "earlycon" to the kernel command line. When added to
your command line, that allows it to boot. I understand why it helps
but I can't explain what's wrong...Anyway, I fixed a warning that I
had missed and that allows me to remove the "smp=4" and "earlycon".

But this is not over yet...Your command line still does not allow to
reach userspace, it fails with the following stacktrace:

[   11.537817][    T1] Unable to handle kernel paging request at
virtual address fffff5eeffffc800
[   11.539450][    T1] Oops [#1]
[   11.539909][    T1] Modules linked in:
[   11.540451][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
5.17.0-rc1-00007-ga68b89289e26-dirty #28
[   11.541364][    T1] Hardware name: riscv-virtio,qemu (DT)
[   11.542032][    T1] epc : kasan_check_range+0x96/0x13e
[   11.542654][    T1]  ra : memset+0x1e/0x4c
[   11.543388][    T1] epc : ffffffff8046c312 ra : ffffffff8046ca16 sp
: ffffaf8007337b70
[   11.544037][    T1]  gp : ffffffff85866c80 tp : ffffaf80073d8000 t0
: 0000000000046000
[   11.544637][    T1]  t1 : fffff5eeffffc9ff t2 : 0000000000000000 s0
: ffffaf8007337ba0
[   11.545409][    T1]  s1 : 0000000000001000 a0 : fffff5eeffffca00 a1
: 0000000000001000
[   11.546072][    T1]  a2 : 0000000000000001 a3 : ffffffff8039ef24 a4
: ffffaf7ffffe4000
[   11.546707][    T1]  a5 : fffff5eeffffc800 a6 : 0000004000000000 a7
: ffffaf7ffffe4fff
[   11.547541][    T1]  s2 : ffffaf7ffffe4000 s3 : 0000000000000000 s4
: ffffffff8467faa8
[   11.548277][    T1]  s5 : 0000000000000000 s6 : ffffffff85869840 s7
: 0000000000000000
[   11.548950][    T1]  s8 : 0000000000001000 s9 : ffffaf805a54a048
s10: ffffffff8588d420
[   11.549705][    T1]  s11: ffffaf7ffffe4000 t3 : 0000000000000000 t4
: 0000000000000040
[   11.550465][    T1]  t5 : fffff5eeffffca00 t6 : 0000000000000002
[   11.551131][    T1] status: 0000000000000120 badaddr:
fffff5eeffffc800 cause: 000000000000000d
[   11.551961][    T1] [<ffffffff8039ef24>] pcpu_alloc+0x84a/0x125c
[   11.552928][    T1] [<ffffffff8039f994>] __alloc_percpu+0x28/0x34
[   11.553555][    T1] [<ffffffff83286954>] ip_rt_init+0x15a/0x35c
[   11.554128][    T1] [<ffffffff83286d24>] ip_init+0x18/0x30
[   11.554642][    T1] [<ffffffff8328844a>] inet_init+0x2a6/0x550
[   11.555428][    T1] [<ffffffff80003220>] do_one_initcall+0x132/0x7e4
[   11.556049][    T1] [<ffffffff83201f7a>] kernel_init_freeable+0x510/0x5b4
[   11.556771][    T1] [<ffffffff831424e4>] kernel_init+0x28/0x21c
[   11.557344][    T1] [<ffffffff800056a0>] ret_from_exception+0x0/0x14
[   11.585469][    T1] ---[ end trace 0000000000000000 ]---

0xfffff5eeffffc800 is a KASAN address that points to the very end of
vmalloc address range, which is weird since KASAN_VMALLOC is not
enabled.
Moreover my command line does not trigger the above bug, and I'm
trying to understand why:

/home/alex/work/qemu/build/riscv64-softmmu/qemu-system-riscv64 -M virt
-bios /home/alex/work/opensbi/build/platform/generic/firmware/fw_dynamic.bin
-kernel /home/alex/work/kernel-build/riscv_rv64_kernel/arch/riscv/boot/Image
-netdev user,id=net0 -device virtio-net-device,netdev=net0 -drive
file=/home/alex/work/kernel-build/rootfs.ext2,format=raw,id=hd0
-device virtio-blk-device,drive=hd0 -nographic -smp 4 -m 16G -s
-append "rootwait earlycon root=/dev/vda ro earlyprintk=serial"

I'm looking into all of this and will get back with a v3 soon :)

Thanks,

Alex






>
> A simple config with KASAN, KASAN_OUTLINE and DEBUG_VIRTUAL now indeed
> leads to a booting kernel, which was not the case before.
> make defconfig ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu-
> ./scripts/config -e KASAN -e KASAN_OUTLINE -e DEBUG_VIRTUAL
> make olddefconfig ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu-
>
> --
> Best Regards,
> Aleksandr
>
> On Mon, Feb 21, 2022 at 5:17 PM Alexandre Ghiti
> <alexandre.ghiti@canonical.com> wrote:
> >
> > __virt_to_phys function is called very early in the boot process (ie
> > kasan_early_init) so it should not be instrumented by KASAN otherwise it
> > bugs.
> >
> > Fix this by declaring phys_addr.c as non-kasan instrumentable.
> >
> > Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> > ---
> >  arch/riscv/mm/Makefile | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> > index 7ebaef10ea1b..ac7a25298a04 100644
> > --- a/arch/riscv/mm/Makefile
> > +++ b/arch/riscv/mm/Makefile
> > @@ -24,6 +24,9 @@ obj-$(CONFIG_KASAN)   += kasan_init.o
> >  ifdef CONFIG_KASAN
> >  KASAN_SANITIZE_kasan_init.o := n
> >  KASAN_SANITIZE_init.o := n
> > +ifdef CONFIG_DEBUG_VIRTUAL
> > +KASAN_SANITIZE_physaddr.o := n
> > +endif
> >  endif
> >
> >  obj-$(CONFIG_DEBUG_VIRTUAL) += physaddr.o
> > --
> > 2.32.0
> >
