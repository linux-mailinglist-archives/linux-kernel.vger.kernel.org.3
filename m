Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A27D536670
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 19:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352593AbiE0RNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 13:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349598AbiE0RM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 13:12:58 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8829414041F
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 10:12:55 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id y32so7846291lfa.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 10:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BYfKxzmiSc8SXMi7nnVlNMFrEJWK3jR/x/7p9iLgKOY=;
        b=G3/g96Qs0vJYxzxSnaW8y9z772oSQAHmdbamtPI128d9PFxY1PhF/Z34c5hiRUMv1v
         XkWBKogGtXznBbs2fXp2jBB224/z5aXNhHiC9HnP+HblTC7GxDc+Sh3Ag6x9rdkw2i05
         XjnVA8mJhBLP8ngyCDK/N6xaQ6XDu9gTuv5rUSiBLCHXOUOKQlu0SLvCobCVLSCY3jXt
         C+B2zFmWo3+3ttfHw6rnkgVBVY453wP5C8nvRBggY4GtcF0zoaYsdjJNpu+/vSVGSSO9
         nuImwGA7XFNTrntP5sjWu8uSMYP3ecQxflsMKTlcZgUPmSnhijFXBqF5I3uap0fajY+q
         WKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BYfKxzmiSc8SXMi7nnVlNMFrEJWK3jR/x/7p9iLgKOY=;
        b=hmH+2BeWFtVOsU1Q3uD099D180R/HOW+Jm/cSMeABnt72qqRY3OnPtWPdf52RNmnFS
         lRkhfVrceMyaFIh40Hvp9htVWmGcAYmfQX9tSRn2nx+TVh026pfFRxeihP4dnLFrb+Xg
         b/nVBM1qZGkB1cVDib3G2+dwfb2HrEJFUJJ0l9/6OneNZ6cQfaaQHX3Mgw8DykK7cR7b
         uhLCR2fgDwqatTlUDNB2yT64JSbVwK4/V5dsA2eg9yD0zk9AQ8KWkx85rHNpZw4IV3jo
         8hkf+4x92HhJ8mYZhuISpWvwaa/ZKSWYPJxXCJTSLVcdz8j7X9xB9+LW6hBqVBTnyyzn
         Soiw==
X-Gm-Message-State: AOAM532eoZUTo4EnK0sPzUXz6qLmNKXov4Y3vKMfoe51ISQOb7zDG86K
        LFfXS5vgryMccabljUdBIxcJo53denKwyKnzWSSsOQ==
X-Google-Smtp-Source: ABdhPJwRbUDyn7ize5qWK55exwtEd+JwuttsQLlWEO9yWfY6SHmQBIPsgeNF4FACqMAARkKIDQEiBDG5ZImNr1igk2Y=
X-Received: by 2002:a05:6512:1156:b0:478:79b1:583c with SMTP id
 m22-20020a056512115600b0047879b1583cmr17236563lfg.206.1653671573571; Fri, 27
 May 2022 10:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d0437b05dffdd1de@google.com> <CACT4Y+Y8DOKJtwhRsyNT7G26C3Fx_oeibpXn43Ks0RtYYdZG3g@mail.gmail.com>
 <36f4745f-0e47-4f49-8f4e-ff7544f163d8n@googlegroups.com> <CACT4Y+Zy7wLdeRCa+ZH-swo9ut=U6pEk4rP461QE1m-gT6s-uQ@mail.gmail.com>
 <a55430c3-a0bc-4af6-b7e2-20f2e0d091b2n@googlegroups.com> <CACT4Y+ar18tcxx0tOthV0JBrmWsLXtXAjXVFX4sac5k1UGJ7Lw@mail.gmail.com>
In-Reply-To: <CACT4Y+ar18tcxx0tOthV0JBrmWsLXtXAjXVFX4sac5k1UGJ7Lw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 27 May 2022 19:12:41 +0200
Message-ID: <CACT4Y+ZAazG7UjKE1ZHq72bh4Ve1r3_Hw+zcONYoO1J959sukw@mail.gmail.com>
Subject: Re: [syzbot] riscv/fixes test error: lost connection to test machine
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+2c5da6a0a16a0c4f34aa@syzkaller.appspotmail.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2022 at 19:04, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, 27 May 2022 at 16:01, Alexandre Ghiti
> <alexandre.ghiti@canonical.com> wrote:
> > On Friday, May 27, 2022 at 3:55:24 PM UTC+2 Dmitry Vyukov wrote:
> >>
> >> On Fri, 27 May 2022 at 15:50, Alexandre Ghiti
> >> <alexand...@canonical.com> wrote:
> >> > On Friday, May 27, 2022 at 3:02:01 PM UTC+2 Dmitry Vyukov wrote:
> >> >>
> >> >> On Fri, 27 May 2022 at 14:55, syzbot
> >> >> <syzbot+2c5da6...@syzkaller.appspotmail.com> wrote:
> >> >> >
> >> >> > Hello,
> >> >> >
> >> >> > syzbot found the following issue on:
> >> >> >
> >> >> > HEAD commit: c932edeaf6d6 riscv: dts: microchip: fix gpio1 reg pr=
operty..
> >> >> > git tree: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/lin=
ux.git fixes
> >> >> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1418a=
dd5f00000
> >> >> > kernel config: https://syzkaller.appspot.com/x/.config?x=3Daa6b57=
02bdf14a17
> >> >> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D2c5da6a=
0a16a0c4f34aa
> >> >> > compiler: riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110=
, GNU ld (GNU Binutils for Debian) 2.35.2
> >> >> > userspace arch: riscv64
> >> >> >
> >> >> > IMPORTANT: if you fix the issue, please add the following tag to =
the commit:
> >> >> > Reported-by: syzbot+2c5da6...@syzkaller.appspotmail.com
> >> >>
> >> >> The CONFIG_KASAN_VMALLOC allows riscv kernel to boot, but now Go
> >> >> processes started crashing with:
> >> >>
> >> >> 1970/01/01 00:06:55 fuzzer started
> >> >> runtime: lfstack.push invalid packing: node=3D0xffffff5908a940 cnt=
=3D0x1
> >> >> packed=3D0xffff5908a9400001 -> node=3D0xffff5908a940
> >> >> fatal error: lfstack.push
> >> >> runtime stack:
> >> >> runtime.throw({0x30884c, 0xc})
> >> >> /usr/local/go/src/runtime/panic.go:1198 +0x60
> >> >> runtime.(*lfstack).push(0xdb3850, 0xffffff5908a940)
> >> >> /usr/local/go/src/runtime/lfstack.go:30 +0x1a8
> >> >>
> >> >> Go runtime tries to shove some data into the upper 16 bits of point=
ers
> >> >> assuming they are unused.
> >> >> However, the original pointer node=3D0xffffff5908a940 suggest riscv=
 now
> >> >> has 56-bit users-space address space?
> >> >
> >> >
> >> > Yes, sv57 was merged recently.
> >> >
> >> >>
> >> >> Documentation/riscv/vm-layout.rst claims 48-bit pointers:
> >> >> "
> >> >> The RISC-V privileged architecture document states that the 64bit a=
ddresses
> >> >> "must have bits 63=E2=80=9348 all equal to bit 47, or else a page-f=
ault exception will
> >> >> occur.":
> >> >
> >> >
> >> > Thanks for pointing that, I extracted that from the specification be=
fore sv57 was specified, I'll fix that.
> >> >
> >> > The current kernel code will use sv57 as it is supported and adverti=
sed by qemu, and to my knowledge, you can't downgrade to sv48 unless by re-=
compiling qemu using the following:
> >> >
> >> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> >> > index 6dbe9b541f..a64b50ed75 100644
> >> > --- a/target/riscv/csr.c
> >> > +++ b/target/riscv/csr.c
> >> > @@ -637,7 +637,7 @@ static const char valid_vm_1_10_64[16] =3D {
> >> > [VM_1_10_MBARE] =3D 1,
> >> > [VM_1_10_SV39] =3D 1,
> >> > [VM_1_10_SV48] =3D 1,
> >> > - [VM_1_10_SV57] =3D 1
> >> > + [VM_1_10_SV57] =3D 0
> >> > };
> >> >
> >> > /* Machine Information Registers */
> >> >
> >> >> ...
> >> >> 0000000000000000 | 0 | 0000003fffffffff | 256 GB |
> >> >> user-space virtual memory, different per mm
> >> >> "
> >>
> >> There is no kernel config to force SV48/39, right?
> >
> >
> > No, we rely on what the hardware advertises, if it supports sv57, we'll=
 go for sv57, if not, we'll try sv48...etc. I had some patches to force the=
 downgrade by using the device tree but they never got merged though.
>
> +original CC list
>
> FTR sent Go runtime change to support SV57:
> https://go-review.googlesource.com/c/go/+/409055



Is CONFIG_CMDLINE broken on riscv?
I am running with:

CONFIG_CMDLINE=3D"earlyprintk=3Dserial net.ifnames=3D0
sysctl.kernel.hung_task_all_cpu_backtrace=3D1 ima_policy=3Dtcb
nf-conntrack-ftp.ports=3D20000 nf-conntrack-tftp.ports=3D20000
nf-conntrack-sip.ports=3D20000 nf-conntrack-irc.ports=3D20000
nf-conntrack-sane.ports=3D20000 binder.debug_mask=3D0
rcupdate.rcu_expedited=3D1 no_hash_pointers page_owner=3Don
sysctl.vm.nr_hugepages=3D4 sysctl.vm.nr_overcommit_hugepages=3D4
secretmem.enable=3D1 sysctl.max_rcu_stall_to_panic=3D1
msr.allow_writes=3Doff dummy_hcd.num=3D2 smp.csd_lock_timeout=3D300000
watchdog_thresh=3D165 workqueue.watchdog_thresh=3D420
sysctl.net.core.netdev_unregister_timeout_secs=3D420 panic_on_warn=3D1"

But getting BUGs with the default timeout:
watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [kworker/0:4:2039]
