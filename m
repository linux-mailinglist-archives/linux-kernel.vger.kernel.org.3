Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2148563FC7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 13:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbiGBLf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 07:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiGBLf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 07:35:26 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB311836C
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 04:35:24 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 73-20020a9d084f000000b00616b04c7656so3857884oty.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 04:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RFiZUZZVdPzHI8JLiBXe+pUN/57tquJciO81AmMC/BA=;
        b=KN9aXvzietpOoqWtAuIT0/EzLMIFdo7EYJ/20eohQO81UE88xxD8ZynwS5k+eo/5SN
         dVTumsABhTmdi2CmOJdK74+S2kQgl3RZHRjK8aScYGcxEXdtrglRS87eTj7viWNzJpEh
         QnUgEHHfAxWjo+KqHLhaHX10e5sXWmzcWDgb82M0mj/OhB8tVmLsNcsV0HVfT+q5ajop
         8dlMEithwF8n6HlHSVvtLg7vXY61FyOBLwVd+i0oHumWidm87Unh98UmW7ioSbq1rr3A
         j+0eDVcwMHzDlpzoWZJ0GEs4kVw1nxjDXNYpQh6RJ8JxTo6Vuy9PNFgNHaHI3vTitvnl
         cc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RFiZUZZVdPzHI8JLiBXe+pUN/57tquJciO81AmMC/BA=;
        b=2eIiMWFVAEj7hk3w3mfO8lArLxyo3riUmkPuSQkz6/2YhliRLOVuNuMRu3czoiymYo
         QHlfBwTgEWHAB002esVqtpMAJEBr+xa/ojKHn5RNCSZ+xTXrl7ENw5ITLykgMpSX7Uoi
         9BHdksjy0C1jPREFdZjFNjopFf8ub/DEMKEww/sesOkC9bi66eAlz6yZGywWxIx3ZUh+
         cs/SAIwiUfpOBY44GUlJey/Ywpq9l68ZNDN1In47EPeMk83A6qqXDZkvDkDbFjjEJG8G
         yprjPle6O5BIz2t1Tk7QaY/lHwopL5QIPF9sz8gvdFxiWdCG5dVtte1SCfuHDSdsEYXO
         MFGw==
X-Gm-Message-State: AJIora97EHNWGtnhAJsv/co0WcfgjfxeWvQFBvMUVcj643Sw5qp430JO
        BHIaOd5yiXudzYJLpUrxSTm4d9ZOdSjg4+N1B8M=
X-Google-Smtp-Source: AGRyM1uobC4dAaGgs7nDWylHgtCkJQNwSOTPhM+xTt0IrwNmqp6vfZopMuDjj62vnVBzuVqlh6hwKIyO9jvlBgEXOVU=
X-Received: by 2002:a05:6830:2692:b0:618:b992:cbc9 with SMTP id
 l18-20020a056830269200b00618b992cbc9mr5668496otu.117.1656761723858; Sat, 02
 Jul 2022 04:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <00c521b5b872b06c9350145c7d39fe7c@mailhost.ics.forth.gr>
 <CA+zEjCs0n8KA_oaFKJbaP6kNohDA=qJHvUKhePUK+hDFJSbHig@mail.gmail.com>
 <CA+zEjCscL1dWASm7u20p1B7-JeJaGTXiWG=K1XiWtZj=VFX+WQ@mail.gmail.com>
 <d75edc49681473bf8b88e474ae61b524@mailhost.ics.forth.gr> <CA+zEjCsc60mxPynL7DDGxfaUz7uif3uXPx3atnHbvM3ei_TETA@mail.gmail.com>
 <2ec74f4bd0e7b7cb4b579e9e042fc035@mailhost.ics.forth.gr>
In-Reply-To: <2ec74f4bd0e7b7cb4b579e9e042fc035@mailhost.ics.forth.gr>
From:   Yixun Lan <yixun.lan@gmail.com>
Date:   Sat, 2 Jul 2022 11:35:12 +0000
Message-ID: <CALecT5gdqW9Na_s9PiFAZt0u=_uPCu0zYdUCb4UfuSV6fM_Q+w@mail.gmail.com>
Subject: Re: RISC-V: patched kexec-tools on github for review/testing
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Alexandre ghiti <alex@ghiti.fr>,
        Mike Rapoport <rppt@kernel.org>, geert+renesas@glider.be,
        Stephano Cetola <scetola@linuxfoundation.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Nick

On Thu, Nov 25, 2021 at 11:45 PM Nick Kossifidis <mick@ics.forth.gr> wrote:
>
> =CE=A3=CF=84=CE=B9=CF=82 2021-10-15 10:07, Alexandre Ghiti =CE=AD=CE=B3=
=CF=81=CE=B1=CF=88=CE=B5:
> > On Sat, Oct 9, 2021 at 3:25 PM Nick Kossifidis <mick@ics.forth.gr>
> > wrote:
> >>
> >> =CE=A3=CF=84=CE=B9=CF=82 2021-10-06 14:10, Alexandre Ghiti =CE=AD=CE=
=B3=CF=81=CE=B1=CF=88=CE=B5:
> >> >
> >> > So I followed the instructions here:
> >> > https://documentation.suse.com/fr-fr/sles/12-SP3/html/SLES-all/cha-t=
uning-kexec.html#cha-tuning-kexec-basic-usage,
> >> > below the output on an Unmatched board using a vmlinux stored on a s=
d
> >> > card:
> >> >
> >> > ubuntu@ubuntu:~$ sudo sbin/kexec -l vmlinux --append=3D"$(cat
> >> > /proc/cmdline)" --initrd=3D/boot/initrd.img
> >> > Warning: No cmdline provided, using append string as cmdline
> >> > Warning: No dtb provided, using /sys/firmware/fdt
> >> > [ 1813.472671] INFO: task kworker/1:0:988 blocked for more than 120
> >> > seconds.
> >> > [ 1813.478751]       Not tainted 5.15.0-rc1+ #15
> >> > [ 1813.483110] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> >> > disables this message.
> >> > Could not find a free area of memory of 0x3000 bytes...
> >> > locate_hole failed
> >> >
> >> > I used the Ubuntu kernel, so this is pretty large:
> >> > -rwxrwxr-x 1 ubuntu ubuntu 277M Oct  5 15:47 vmlinux
> >> > -rw-r--r-- 1 root root 98M Sep 21 03:25 /boot/initrd.img
> >> >
> >>
> >> ACK, I haven't tested initrd much TBH, I usually don't use an initrd,
> >> and when I do it's a small busybox-based rootfs.
> >>
> >> > Then if I don't load the initrd (I sometimes have the same warning a=
s
> >> > above) I can at least kexec the new kernel but it fails to boot:
> >> >
> >> > ubuntu@ubuntu:~$ sudo ./sbin/kexec -e
> >> > Warning: No cmdline or append string provided
> >> > Warning: No dtb provided, using /sys/firmware/fdt
> >> > [...]
> >> > [    0.000000] SBI v0.2 HSM extension detected
> >> > [    0.000000] CPU with hartid=3D0 is not available
> >> > [    0.000000] ------------[ cut here ]------------
> >> > [    0.000000] kernel BUG at arch/riscv/kernel/smpboot.c:107!
> >> > [    0.000000] Kernel BUG [#1]
> >> > [    0.000000] Modules linked in:
> >> > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.15.0-rc1+ #=
15
> >> > [    0.000000] Hardware name: SiFive HiFive Unmatched A00 (DT)
> >> > [    0.000000] epc : setup_smp+0xcc/0x142
> >> > [    0.000000]  ra : setup_smp+0xc4/0x142
> >> > [    0.000000] epc : ffffffff80a04080 ra : ffffffff80a04078 sp :
> >> > ffffffff81803ec0
> >> > [    0.000000]  gp : ffffffff81a23220 tp : ffffffff81810500 t0 :
> >> > ffffffff81a3551f
> >> > [    0.000000]  t1 : ffffffffffffffff t2 : 0000000000000000 s0 :
> >> > ffffffff81803f00
> >> > [    0.000000]  s1 : 0000000000000000 a0 : 0000000000000000 a1 :
> >> > 0000000000000000
> >> > [    0.000000]  a2 : 0000000000000000 a3 : 0000000000000001 a4 :
> >> > 0000000000000000
> >> > [    0.000000]  a5 : ffffffff80c64500 a6 : 0000000000000004 a7 :
> >> > 000000000000ff00
> >> > [    0.000000]  s2 : 0000000000000005 s3 : 0000000000000000 s4 :
> >> > ffffffff8118f9a8
> >> > [    0.000000]  s5 : 0000000000000007 s6 : ffffffff80c0b790 s7 :
> >> > 0000000080000200
> >> > [    0.000000]  s8 : 0000000000000fff s9 : 0000000081000200 s10:
> >> > 0000000000000018
> >> > [    0.000000]  s11: 000000000000000b t3 : 0000000000ff0000 t4 :
> >> > ffffffffffffffff
> >> > [    0.000000]  t5 : ffffffff80c0b7a0 t6 : ffffffff81803bd8
> >> > [    0.000000] status: 0000000200000100 badaddr: 0000000000000000
> >> > cause: 0000000000000003
> >> > [    0.000000] [<ffffffff80a04080>] setup_smp+0xcc/0x142
> >> > [    0.000000] [<ffffffff80a03d88>] setup_arch+0x56a/0x590
> >> > [    0.000000] [<ffffffff80a00aa2>] start_kernel+0xaa/0xa5c
> >> > [    0.000000] random: get_random_bytes called from
> >> > oops_exit+0x44/0x70 with crng_init=3D0
> >> > [    0.000000] ---[ end trace 0000000000000000 ]---
> >> > [    0.000000] Kernel panic - not syncing: Attempted to kill the idl=
e
> >> > task!
> >> > [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kil=
l
> >> > the idle task! ]---
> >> >
> >> > This reliably fails here.
> >> >
> >>
> >> This looks weird, I'll check it out (we have an unmatched here so I'll
> >> try to get my hands on it sometime next week).
> >>
> >> Did you try kdump ? Do you get the same error ?
> >
> > kdump works fine, it fails to find the rootfs but I think my setup is
> > faulty here.
> > I took a quick look at kexec_relocate.S, and the use of va_pa_offset
> > is also wrong here, we should use va_kernel_pa_offset as it is used to
> > modify a text address But fixing that did not work either.
> >
> > Alex
> >
>
> Sorry for the delay, I finally got some time to work on this. As it
> turns out I'm passing cpu id instead of hart id to the next kernel (that
> comment on smp.h claiming that raw_smp_processor_id returns the hart id
> didn't help much) and interestingly enough cpu id and hart id match on
> qemu and also sometimes match on the unmatched / unleashed board. Also
> on unmatched / unleashed, hart id 0 is used by the non-linux hart so if
> we pass the cpu id of the boot cpu that's always going to be 0 it'll be
> invalid, but that's not always the case, especially for kdump. I'm also
> getting an error when trying to mount the rootfs on kdump on the
> unmatched board, because swiotlb can't allocate bounce buffers and the
> pcie driver doesn't work, so no nvme access. I'm looking for a way to
> make this work without messing things up, in any case I'll send some
> patches over the weekend. For the initrd issue I need to patch
> kexec-tools.
>
> Regards,
> Nick
>

ping, any update for this? any new patch for kexec-tools?

I'd also like to try kexec on unmatched board, and encounter the same error
as Alexandre Ghiti reported, generally I'm using almost same cmdline

Yixun Lan
