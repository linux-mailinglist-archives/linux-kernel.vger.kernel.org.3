Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F42374D42C5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 09:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240467AbiCJInQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 03:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237405AbiCJInP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:43:15 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7C513571D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 00:42:13 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 75D103F60D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 08:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646901731;
        bh=cAFDXSKpDn5Z6TlMfaE+wkbrmhm+ae2B/76qxjjTkJs=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=aV+5dyqHaYkaQ+AQsDJCU5MDrLkWnesDMzovye5wdXVTy2O/OSKsSmjHJ4X0VN8Mj
         qNQwqhGnjKEGXizGJ5nPoGSeZTwO2Hv6TvS17BXKaNsSRya7u1HpGYVVj0CfPs3vkR
         naihLsOLcYW/EFOn/TQUQs9ZoSQHC08gxQPGnJHs4EuoEWU4an0hXR7G05O0wW2cKz
         HqgRUVdUESda15+5bcz2xkeozUgXsOEtThqOYg97ER1vJ3am8qU5CWA1wDCRTuqclU
         Re+hl6b4UJeqqDEHU+U+vqkF+wYbNhs+b5r9Q1JhlxlTQRkmteNggpEie0WrW/1WzV
         e7K044+cTeU8A==
Received: by mail-ed1-f71.google.com with SMTP id l14-20020a056402344e00b0041593c729adso2717218edc.18
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 00:42:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cAFDXSKpDn5Z6TlMfaE+wkbrmhm+ae2B/76qxjjTkJs=;
        b=w+sYoWTaMHtm4uuZrlJwpDAa+AXbMfxR9GQBX/nqZv9Va+iJCxPxW0Op0Cg0l6gMEc
         4InVyq7IiHEq3EZNOWxlbso294Ouiy08TedVD5aAb2+IIeIvicr61hrcN44jrCF1PgKa
         L6rG5bH+KM9JxPQ78ameiFwjo8yPo9gTcwAcHU3U4tZYF1r8luzdwfx40tFpUSxTBVs0
         Au38sWF/y0z72LE2Hyi9X8S5TLvCN9rMLcrNM3IEcC8xjXKN7cQHqZ4bwD05IwphaSIQ
         oo5XwMKhj+c+dn6SENXUEQj7Tp90+G1HHu0bij7FXFWRhmRPVJIhwpHQNL9RQ589FHE1
         Gkaw==
X-Gm-Message-State: AOAM5310ViE7edeC6M6WlTBZwI+9904TNfmLyUfFmgIkfEZ0BWvBSNpp
        V31L9A7onrwUQInluXBry8JdK0veI72w1FH+NIeG8OHNtyZAajWhVQVRWC5eydJvuPuctUK4Cz5
        kTD+JHnjr+sf09wSHj+QmiKuAEVzoUlZFBy5FhyT65UKURMz9GxacE+GG+A==
X-Received: by 2002:a17:906:c14e:b0:6da:970b:cc33 with SMTP id dp14-20020a170906c14e00b006da970bcc33mr3147162ejc.307.1646901730952;
        Thu, 10 Mar 2022 00:42:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwxDUo6Mysuzsd4gOWkccYU74PbVAqev8dCIzkzHGx8Anw55nkE9Ac7RB7FbEw8TKS2FI28Nr1avQsLIzX+W2U=
X-Received: by 2002:a17:906:c14e:b0:6da:970b:cc33 with SMTP id
 dp14-20020a170906c14e00b006da970bcc33mr3147131ejc.307.1646901730537; Thu, 10
 Mar 2022 00:42:10 -0800 (PST)
MIME-Version: 1.0
References: <mhng-ffd5d5c5-9894-4dec-b332-5176d508bcf9@palmer-mbp2014>
 <mhng-ef0f4bac-b55e-471e-8e3d-8ea597081b74@palmer-ri-x1c9>
 <CANp29Y6MvZvx4Xjwx=bxZ86D7Kubg0JPwBzP6HH8A6+Zj7YeLQ@mail.gmail.com> <CACT4Y+ZA7CRNfYgPmi6jHTKD9rwvaJy=nh5Gz_c-PFHq3tuziQ@mail.gmail.com>
In-Reply-To: <CACT4Y+ZA7CRNfYgPmi6jHTKD9rwvaJy=nh5Gz_c-PFHq3tuziQ@mail.gmail.com>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Thu, 10 Mar 2022 09:41:57 +0100
Message-ID: <CA+zEjCsCHhaQ4nEC8VEbCyQt3aG0E78S6PoCgzJA5qkoGC10ZA@mail.gmail.com>
Subject: Re: [PATCH -fixes v3 0/6] Fixes KASAN and other along the way
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Aleksandr Nogikh <nogikh@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Nick Hu <nickhu@andestech.com>,
        linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 9, 2022 at 11:52 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, 9 Mar 2022 at 11:45, Aleksandr Nogikh <nogikh@google.com> wrote:
> >
> > I switched the riscv syzbot instance to KASAN_OUTLINE and now it is
> > finally being fuzzed again!
> >
> > Thank you very much for the series!
>
>
> But all riscv crashes are still classified as "corrupted" and thrown
> away (not reported):
> https://syzkaller.appspot.com/bug?id=3Dd5bc3e0c66d200d72216ab343a67c4327e=
4a3452
>
> The problem is that risvc oopses don't contain "Call Trace:" in the
> beginning of stack traces, so it's hard to make sense out of them.
> arch/riscv seems to print "Call Trace:" in a wrong function, not where
> all other arches print it.
>

Does the following diff fix this issue?

diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.=
c
index 201ee206fb57..348ca19ccbf8 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -109,12 +109,12 @@ static bool print_trace_address(void *arg,
unsigned long pc)
 noinline void dump_backtrace(struct pt_regs *regs, struct task_struct *tas=
k,
                    const char *loglvl)
 {
+       pr_cont("%sCall Trace:\n", loglvl);
        walk_stackframe(task, regs, print_trace_address, (void *)loglvl);
 }

 void show_stack(struct task_struct *task, unsigned long *sp, const
char *loglvl)
 {
-       pr_cont("%sCall Trace:\n", loglvl);
        dump_backtrace(NULL, task, loglvl);
 }

Thanks,

Alex

>
>
> > --
> > Best Regards,
> > Aleksandr
> >
> > On Fri, Mar 4, 2022 at 5:12 AM Palmer Dabbelt <palmer@dabbelt.com> wrot=
e:
> > >
> > > On Tue, 01 Mar 2022 09:39:54 PST (-0800), Palmer Dabbelt wrote:
> > > > On Fri, 25 Feb 2022 07:00:23 PST (-0800), glider@google.com wrote:
> > > >> On Fri, Feb 25, 2022 at 3:47 PM Alexandre Ghiti <
> > > >> alexandre.ghiti@canonical.com> wrote:
> > > >>
> > > >>> On Fri, Feb 25, 2022 at 3:31 PM Alexander Potapenko <glider@googl=
e.com>
> > > >>> wrote:
> > > >>> >
> > > >>> >
> > > >>> >
> > > >>> > On Fri, Feb 25, 2022 at 3:15 PM Alexandre Ghiti <
> > > >>> alexandre.ghiti@canonical.com> wrote:
> > > >>> >>
> > > >>> >> On Fri, Feb 25, 2022 at 3:10 PM Alexander Potapenko <glider@go=
ogle.com>
> > > >>> wrote:
> > > >>> >> >
> > > >>> >> >
> > > >>> >> >
> > > >>> >> > On Fri, Feb 25, 2022 at 3:04 PM Alexandre Ghiti <
> > > >>> alexandre.ghiti@canonical.com> wrote:
> > > >>> >> >>
> > > >>> >> >> On Fri, Feb 25, 2022 at 2:06 PM Marco Elver <elver@google.c=
om>
> > > >>> wrote:
> > > >>> >> >> >
> > > >>> >> >> > On Fri, 25 Feb 2022 at 13:40, Alexandre Ghiti
> > > >>> >> >> > <alexandre.ghiti@canonical.com> wrote:
> > > >>> >> >> > >
> > > >>> >> >> > > As reported by Aleksandr, syzbot riscv is broken since =
commit
> > > >>> >> >> > > 54c5639d8f50 ("riscv: Fix asan-stack clang build"). Thi=
s commit
> > > >>> actually
> > > >>> >> >> > > breaks KASAN_INLINE which is not fixed in this series, =
that will
> > > >>> come later
> > > >>> >> >> > > when found.
> > > >>> >> >> > >
> > > >>> >> >> > > Nevertheless, this series fixes small things that made =
the syzbot
> > > >>> >> >> > > configuration + KASAN_OUTLINE fail to boot.
> > > >>> >> >> > >
> > > >>> >> >> > > Note that even though the config at [1] boots fine with=
 this
> > > >>> series, I
> > > >>> >> >> > > was not able to boot the small config at [2] which fail=
s because
> > > >>> >> >> > > kasan_poison receives a really weird address 0x40757063=
01000000
> > > >>> (maybe a
> > > >>> >> >> > > kasan person could provide some hint about what happens=
 below in
> > > >>> >> >> > > do_ctors -> __asan_register_globals):
> > > >>> >> >> >
> > > >>> >> >> > asan_register_globals is responsible for poisoning redzon=
es around
> > > >>> >> >> > globals. As hinted by 'do_ctors', it calls constructors, =
and in
> > > >>> this
> > > >>> >> >> > case a compiler-generated constructor that calls
> > > >>> >> >> > __asan_register_globals with metadata generated by the co=
mpiler.
> > > >>> That
> > > >>> >> >> > metadata contains information about global variables. Not=
e, these
> > > >>> >> >> > constructors are called on initial boot, but also every t=
ime a
> > > >>> kernel
> > > >>> >> >> > module (that has globals) is loaded.
> > > >>> >> >> >
> > > >>> >> >> > It may also be a toolchain issue, but it's hard to say. I=
f you're
> > > >>> >> >> > using GCC to test, try Clang (11 or later), and vice-vers=
a.
> > > >>> >> >>
> > > >>> >> >> I tried 3 different gcc toolchains already, but that did no=
t fix the
> > > >>> >> >> issue. The only thing that worked was setting asan-globals=
=3D0 in
> > > >>> >> >> scripts/Makefile.kasan, but ok, that's not a fix.
> > > >>> >> >> I tried to bisect this issue but our kasan implementation h=
as been
> > > >>> >> >> broken quite a few times, so it failed.
> > > >>> >> >>
> > > >>> >> >> I keep digging!
> > > >>> >> >>
> > > >>> >> >
> > > >>> >> > The problem does not reproduce for me with GCC 11.2.0: kerne=
ls built
> > > >>> with both [1] and [2] are bootable.
> > > >>> >>
> > > >>> >> Do you mean you reach userspace? Because my image boots too, a=
nd fails
> > > >>> >> at some point:
> > > >>> >>
> > > >>> >> [    0.000150] sched_clock: 64 bits at 10MHz, resolution 100ns=
, wraps
> > > >>> >> every 4398046511100ns
> > > >>> >> [    0.015847] Console: colour dummy device 80x25
> > > >>> >> [    0.016899] printk: console [tty0] enabled
> > > >>> >> [    0.020326] printk: bootconsole [ns16550a0] disabled
> > > >>> >>
> > > >>> >
> > > >>> > In my case, QEMU successfully boots to the login prompt.
> > > >>> > I am running QEMU 6.2.0 (Debian 1:6.2+dfsg-2) and an image Alek=
sandr
> > > >>> shared with me (guess it was built according to this instruction:
> > > >>> https://github.com/google/syzkaller/blob/master/docs/linux/setup_=
linux-host_qemu-vm_riscv64-kernel.md
> > > >>> )
> > > >>> >
> > > >>>
> > > >>> Nice thanks guys! I always use the latest opensbi and not the one=
 that
> > > >>> is embedded in qemu, which is the only difference between your co=
mmand
> > > >>> line (which works) and mine (which does not work). So the issue i=
s
> > > >>> probably there, I really need to investigate that now.
> > > >>>
> > > >>> Great to hear that!
> > > >>
> > > >>
> > > >>> That means I only need to fix KASAN_INLINE and we're good.
> > > >>>
> > > >>> I imagine Palmer can add your Tested-by on the series then?
> > > >>>
> > > >> Sure :)
> > > >
> > > > Do you mind actually posting that (i, the Tested-by tag)?  It's les=
s
> > > > likely to get lost that way.  I intend on taking this into fixes AS=
AP,
> > > > my builds have blown up for some reason (I got bounced between mach=
ines,
> > > > so I'm blaming that) so I need to fix that first.
> > >
> > > This is on fixes (with a "Tested-by: Alexander Potapenko
> > > <glider@google.com>"), along with some trivial commit message fixes.
> > >
> > > Thanks!
> > >
> > > >
> > > >>
> > > >>>
> > > >>> Thanks again!
> > > >>>
> > > >>> Alex
> > > >>>
> > > >>> >>
> > > >>> >> It traps here.
> > > >>> >>
> > > >>> >> > FWIW here is how I run them:
> > > >>> >> >
> > > >>> >> > qemu-system-riscv64 -m 2048 -smp 1 -nographic -no-reboot \
> > > >>> >> >   -device virtio-rng-pci -machine virt -device \
> > > >>> >> >   virtio-net-pci,netdev=3Dnet0 -netdev \
> > > >>> >> >   user,id=3Dnet0,restrict=3Don,hostfwd=3Dtcp:127.0.0.1:12529=
-:22 -device \
> > > >>> >> >   virtio-blk-device,drive=3Dhd0 -drive \
> > > >>> >> >   file=3D${IMAGE},if=3Dnone,format=3Draw,id=3Dhd0 -snapshot =
\
> > > >>> >> >   -kernel ${KERNEL_SRC_DIR}/arch/riscv/boot/Image -append
> > > >>> "root=3D/dev/vda
> > > >>> >> >   console=3DttyS0 earlyprintk=3Dserial"
> > > >>> >> >
> > > >>> >> >
> > > >>> >> >>
> > > >>> >> >> Thanks for the tips,
> > > >>> >> >>
> > > >>> >> >> Alex
> > > >>> >> >
> > > >>> >> >
> > > >>> >> >
> > > >>> >> > --
> > > >>> >> > Alexander Potapenko
> > > >>> >> > Software Engineer
> > > >>> >> >
> > > >>> >> > Google Germany GmbH
> > > >>> >> > Erika-Mann-Stra=C3=9Fe, 33
> > > >>> >> > 80636 M=C3=BCnchen
> > > >>> >> >
> > > >>> >> > Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
> > > >>> >> > Registergericht und -nummer: Hamburg, HRB 86891
> > > >>> >> > Sitz der Gesellschaft: Hamburg
> > > >>> >> >
> > > >>> >> > Diese E-Mail ist vertraulich. Falls Sie diese f=C3=A4lschlic=
herweise
> > > >>> erhalten haben sollten, leiten Sie diese bitte nicht an jemand an=
deres
> > > >>> weiter, l=C3=B6schen Sie alle Kopien und Anh=C3=A4nge davon und l=
assen Sie mich bitte
> > > >>> wissen, dass die E-Mail an die falsche Person gesendet wurde.
> > > >>> >> >
> > > >>> >> >
> > > >>> >> >
> > > >>> >> > This e-mail is confidential. If you received this communicat=
ion by
> > > >>> mistake, please don't forward it to anyone else, please erase all=
 copies
> > > >>> and attachments, and please let me know that it has gone to the w=
rong
> > > >>> person.
> > > >>> >>
> > > >>> >> --
> > > >>> >> You received this message because you are subscribed to the Go=
ogle
> > > >>> Groups "kasan-dev" group.
> > > >>> >> To unsubscribe from this group and stop receiving emails from =
it, send
> > > >>> an email to kasan-dev+unsubscribe@googlegroups.com.
> > > >>> >> To view this discussion on the web visit
> > > >>> https://groups.google.com/d/msgid/kasan-dev/CA%2BzEjCsQPVYSV7CdhK=
nvjujXkMXuRQd%3DVPok1awb20xifYmidw%40mail.gmail.com
> > > >>> .
> > > >>> >
> > > >>> >
> > > >>> >
> > > >>> > --
> > > >>> > Alexander Potapenko
> > > >>> > Software Engineer
> > > >>> >
> > > >>> > Google Germany GmbH
> > > >>> > Erika-Mann-Stra=C3=9Fe, 33
> > > >>> > 80636 M=C3=BCnchen
> > > >>> >
> > > >>> > Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
> > > >>> > Registergericht und -nummer: Hamburg, HRB 86891
> > > >>> > Sitz der Gesellschaft: Hamburg
> > > >>> >
> > > >>> > Diese E-Mail ist vertraulich. Falls Sie diese f=C3=A4lschlicher=
weise erhalten
> > > >>> haben sollten, leiten Sie diese bitte nicht an jemand anderes wei=
ter,
> > > >>> l=C3=B6schen Sie alle Kopien und Anh=C3=A4nge davon und lassen Si=
e mich bitte wissen,
> > > >>> dass die E-Mail an die falsche Person gesendet wurde.
> > > >>> >
> > > >>> >
> > > >>> >
> > > >>> > This e-mail is confidential. If you received this communication=
 by
> > > >>> mistake, please don't forward it to anyone else, please erase all=
 copies
> > > >>> and attachments, and please let me know that it has gone to the w=
rong
> > > >>> person.
> > > >>>
> > > >>> --
> > > >>> You received this message because you are subscribed to the Googl=
e Groups
> > > >>> "kasan-dev" group.
> > > >>> To unsubscribe from this group and stop receiving emails from it,=
 send an
> > > >>> email to kasan-dev+unsubscribe@googlegroups.com.
> > > >>> To view this discussion on the web visit
> > > >>> https://groups.google.com/d/msgid/kasan-dev/CA%2BzEjCuJw8N0dUmQNd=
FqDM96bzKqPDjRe4FUnOCbjhJtO0R8Hg%40mail.gmail.com
> > > >>> .
> > > >>>
> > > >>
> > > >>
> > > >> --
> > > >> Alexander Potapenko
> > > >> Software Engineer
> > > >>
> > > >> Google Germany GmbH
> > > >> Erika-Mann-Stra=C3=9Fe, 33
> > > >> 80636 M=C3=BCnchen
> > > >>
> > > >> Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
> > > >> Registergericht und -nummer: Hamburg, HRB 86891
> > > >> Sitz der Gesellschaft: Hamburg
> > > >>
> > > >> Diese E-Mail ist vertraulich. Falls Sie diese f=C3=A4lschlicherwei=
se erhalten
> > > >> haben sollten, leiten Sie diese bitte nicht an jemand anderes weit=
er,
> > > >> l=C3=B6schen Sie alle Kopien und Anh=C3=A4nge davon und lassen Sie=
 mich bitte wissen,
> > > >> dass die E-Mail an die falsche Person gesendet wurde.
> > > >>
> > > >>
> > > >>
> > > >> This e-mail is confidential. If you received this communication by=
 mistake,
> > > >> please don't forward it to anyone else, please erase all copies an=
d
> > > >> attachments, and please let me know that it has gone to the wrong =
person.
