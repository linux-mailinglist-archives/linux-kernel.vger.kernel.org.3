Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEE3536BA0
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 10:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiE1I1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 04:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiE1I1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 04:27:00 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98C31838B
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 01:26:58 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y32so9972502lfa.6
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 01:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MdBohn5lqfcigLONJ4tlR9+A0EebTM5wGoV2izTpT+s=;
        b=GSveqXx1fB4DtF+qokOmSKuJx40Nb4rcFrGbdTMAo+w1/aEtd0vMM+AXLBnFKQswcr
         TNxoTCQUPWNcFtuVAEMFUSQmmpU2WxpdgeFPcog18bF4Ii/8+uAfDd3n4HTm12JK827f
         0J0ubSz35p/qWcYLOiX1sh64971D6MeB50jLVTZSsiNfGK7lvqjL8GCAcvhanObAniAZ
         zRW5IucHLt2ug/frUzMU3X5zL8eLKFA5Jhnl+LuT8iF+pUV6FGqeIEFfV4FYe/yRb8rC
         61Fu3J4sFdfA/CYTw1owN9HnzcX7K0tFwAhP/nbtuPzY2Hx/Gtc2/NEGTILQkLxM6yz9
         sSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MdBohn5lqfcigLONJ4tlR9+A0EebTM5wGoV2izTpT+s=;
        b=NpkZrOGWXdh9jPUAPxxj2omAI9tDqbIesmJ4m7eHOiYnREDWiIdoprS3EzyUN8jyVW
         V/ZIW+cJZcttaKkndCtb8TAqqJnNRT7VLD4hMcJeyIah66bg55roYcJcNcTyyxpEI1e/
         /5rE5mnpTezX56jU7ycjJhFZT1ah/7yiaPvrkjb2MVQ1SFbZia7OZYv+X0xDa7tF/dxY
         NMOn/gTI9kcf/88MPgMErdlke9MSxMd1Sf/BttjOqU/x72myVg5ABIp4BGwYXk3TDe2T
         ZHZrAwbRpfxG2YhMAsz/7GmAnY97aPw7C8yzA5EMojwRr8gj4ma6N5jOF+VZc2UBCNYn
         jWdQ==
X-Gm-Message-State: AOAM532Uxf4odvTKlC3wBdtP2xD1MBH9+G2Cce0h2Hx3rV6+r5V5WsdP
        j9SwNbWc+7Cs1nNQFCOrQGMaco1coVrEY+wJcMqmqw==
X-Google-Smtp-Source: ABdhPJw0VnqVAfGGkafG+4wY07hGryCH2b+Rs5r9RjqjltF/tJS1+e4HxHiBTOAptq44bQf9EGzI2GbhxzHqBZzy+9U=
X-Received: by 2002:a05:6512:3f13:b0:464:f55f:7806 with SMTP id
 y19-20020a0565123f1300b00464f55f7806mr33598585lfa.598.1653726416484; Sat, 28
 May 2022 01:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d0437b05dffdd1de@google.com> <CACT4Y+Y8DOKJtwhRsyNT7G26C3Fx_oeibpXn43Ks0RtYYdZG3g@mail.gmail.com>
 <36f4745f-0e47-4f49-8f4e-ff7544f163d8n@googlegroups.com> <CACT4Y+Zy7wLdeRCa+ZH-swo9ut=U6pEk4rP461QE1m-gT6s-uQ@mail.gmail.com>
 <a55430c3-a0bc-4af6-b7e2-20f2e0d091b2n@googlegroups.com> <CACT4Y+ar18tcxx0tOthV0JBrmWsLXtXAjXVFX4sac5k1UGJ7Lw@mail.gmail.com>
 <fcb6d1aa-78bb-cfad-7655-cbab59f8d5c3@ghiti.fr>
In-Reply-To: <fcb6d1aa-78bb-cfad-7655-cbab59f8d5c3@ghiti.fr>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 28 May 2022 10:26:44 +0200
Message-ID: <CACT4Y+a79F0SmG2KTZyYQ1ZTktY7zQ5ofZMdpkCKNq=SeNxbCw@mail.gmail.com>
Subject: Re: [syzbot] riscv/fixes test error: lost connection to test machine
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
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

On Sat, 28 May 2022 at 10:03, Alexandre Ghiti <alex@ghiti.fr> wrote:
> >>>>>> Hello,
> >>>>>>
> >>>>>> syzbot found the following issue on:
> >>>>>>
> >>>>>> HEAD commit: c932edeaf6d6 riscv: dts: microchip: fix gpio1 reg pro=
perty..
> >>>>>> git tree: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linu=
x.git fixes
> >>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1418ad=
d5f00000
> >>>>>> kernel config: https://syzkaller.appspot.com/x/.config?x=3Daa6b570=
2bdf14a17
> >>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=3D2c5da6a0=
a16a0c4f34aa
> >>>>>> compiler: riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110,=
 GNU ld (GNU Binutils for Debian) 2.35.2
> >>>>>> userspace arch: riscv64
> >>>>>>
> >>>>>> IMPORTANT: if you fix the issue, please add the following tag to t=
he commit:
> >>>>>> Reported-by: syzbot+2c5da6...@syzkaller.appspotmail.com
> >>>>> The CONFIG_KASAN_VMALLOC allows riscv kernel to boot, but now Go
> >>>>> processes started crashing with:
> >>>>>
> >>>>> 1970/01/01 00:06:55 fuzzer started
> >>>>> runtime: lfstack.push invalid packing: node=3D0xffffff5908a940 cnt=
=3D0x1
> >>>>> packed=3D0xffff5908a9400001 -> node=3D0xffff5908a940
> >>>>> fatal error: lfstack.push
> >>>>> runtime stack:
> >>>>> runtime.throw({0x30884c, 0xc})
> >>>>> /usr/local/go/src/runtime/panic.go:1198 +0x60
> >>>>> runtime.(*lfstack).push(0xdb3850, 0xffffff5908a940)
> >>>>> /usr/local/go/src/runtime/lfstack.go:30 +0x1a8
> >>>>>
> >>>>> Go runtime tries to shove some data into the upper 16 bits of point=
ers
> >>>>> assuming they are unused.
> >>>>> However, the original pointer node=3D0xffffff5908a940 suggest riscv=
 now
> >>>>> has 56-bit users-space address space?
> >>>>
> >>>> Yes, sv57 was merged recently.
> >>>>
> >>>>> Documentation/riscv/vm-layout.rst claims 48-bit pointers:
> >>>>> "
> >>>>> The RISC-V privileged architecture document states that the 64bit a=
ddresses
> >>>>> "must have bits 63=E2=80=9348 all equal to bit 47, or else a page-f=
ault exception will
> >>>>> occur.":
> >>>>
> >>>> Thanks for pointing that, I extracted that from the specification be=
fore sv57 was specified, I'll fix that.
> >>>>
> >>>> The current kernel code will use sv57 as it is supported and adverti=
sed by qemu, and to my knowledge, you can't downgrade to sv48 unless by re-=
compiling qemu using the following:
> >>>>
> >>>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> >>>> index 6dbe9b541f..a64b50ed75 100644
> >>>> --- a/target/riscv/csr.c
> >>>> +++ b/target/riscv/csr.c
> >>>> @@ -637,7 +637,7 @@ static const char valid_vm_1_10_64[16] =3D {
> >>>> [VM_1_10_MBARE] =3D 1,
> >>>> [VM_1_10_SV39] =3D 1,
> >>>> [VM_1_10_SV48] =3D 1,
> >>>> - [VM_1_10_SV57] =3D 1
> >>>> + [VM_1_10_SV57] =3D 0
> >>>> };
> >>>>
> >>>> /* Machine Information Registers */
> >>>>
> >>>>> ...
> >>>>> 0000000000000000 | 0 | 0000003fffffffff | 256 GB |
> >>>>> user-space virtual memory, different per mm
> >>>>> "
> >>> There is no kernel config to force SV48/39, right?
> >>
> >> No, we rely on what the hardware advertises, if it supports sv57, we'l=
l go for sv57, if not, we'll try sv48...etc. I had some patches to force th=
e downgrade by using the device tree but they never got merged though.
> > +original CC list
> >
> > FTR sent Go runtime change to support SV57:
> > https://go-review.googlesource.com/c/go/+/409055
>
>
> Thank you for that, I'll pull that into Ubuntu when merged. Do you know
> if any other programming language does the same and would need a fix too?

Nothing comes to mind right now.
But this is not only about language runtimes, it's about all software
out there. However, x86 has 5-level pages now as well, it should stomp
on these problems earlier... but somehow it did not happen for Go
runtime.
