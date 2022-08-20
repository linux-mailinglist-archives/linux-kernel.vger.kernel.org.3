Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7279059AAA8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 04:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240367AbiHTCTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 22:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiHTCTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 22:19:30 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62998F962
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 19:19:27 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id y10-20020a9d634a000000b006167f7ce0c5so4223982otk.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 19:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kq6vfjFZNBDSv1cVPne0kStOBJmXAhYIZ+nQEBFFCrA=;
        b=e42+aHBNR31eV+SvF6JkAdXxPEKnw9sFB7pYNNtquQgM41tC35qhKhNHFhnU9soEM7
         c50TRzKQobfBx0k85Q93IRU3g+e+3ywK36QCZIqDmb3yK/NL0ujHt1a24FtxyKIl/Cxs
         vV325As6WSV/cX6a77aOqVFujfqAZbOvomoziM1GZKcg7f5lFNuuwlUutMOb71gdJJ1f
         EC2989gQtYb5xODiL/Vsj1RM9umZ+oaj7f6ZogwMY6qTUWIXr0ahOAZEEvsRHXUAbqu/
         zOfaCRDQyvKMMRrA9Yk58FQROrYaJ+zQKbAkW63giUQGl63HA3Cu4Okg3a9qoFrmtup7
         /sNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kq6vfjFZNBDSv1cVPne0kStOBJmXAhYIZ+nQEBFFCrA=;
        b=wxBCr2y+84sYY8Q/JiQJbzkx3aPY4+FxVKX1J4dwzJXce+JfpdccLLxTID2kz03LG7
         RqHUiNhiFfAjaNFqxk+Xp6r9qxQu3sirZA3DEs8lVd8wpyxeAyfzhSpTfqA+FB5VPudz
         hFSoW8cZpZuzFzQY/0SgTOn8IJLOLoeXZ5s4tsBh8hxWrt1/0L6ndAeWP52jsrbjgknm
         1pQj6gUkUF5YN40VB/XnwuU5fdcCP+Egbs0cnbqBUaP9vK+qDpmiXPxD2yyoyk270We/
         eIwKWLLAMjfaMzX7MigXHJA/f9bbNeYXa0TzGHi4cW4k8RTIYhR6MO5moE1QZnV1EG1t
         JUoQ==
X-Gm-Message-State: ACgBeo3od+D+pkud6aeXPB4f3eHj/8udxO4Cm5L3WKKXvK5B/Vg8M3Ym
        TyTrbu0Cb4Z0oMhIsAl9GKC9BDIzNNmeUuBtdW8=
X-Google-Smtp-Source: AA6agR705E38AcvqtTJs4JmmU240yY+S5k3XbAT9XgD0Ag5CRBn/kVbJTzeWLT8SNSpEcc1Mx0ayCxhWfRI9xH9vxV8=
X-Received: by 2002:a9d:66cf:0:b0:637:1d30:d72b with SMTP id
 t15-20020a9d66cf000000b006371d30d72bmr3962024otm.35.1660961966755; Fri, 19
 Aug 2022 19:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <00c521b5b872b06c9350145c7d39fe7c@mailhost.ics.forth.gr>
 <CA+zEjCs0n8KA_oaFKJbaP6kNohDA=qJHvUKhePUK+hDFJSbHig@mail.gmail.com> <CA+zEjCscL1dWASm7u20p1B7-JeJaGTXiWG=K1XiWtZj=VFX+WQ@mail.gmail.com>
In-Reply-To: <CA+zEjCscL1dWASm7u20p1B7-JeJaGTXiWG=K1XiWtZj=VFX+WQ@mail.gmail.com>
From:   Yixun Lan <yixun.lan@gmail.com>
Date:   Sat, 20 Aug 2022 02:19:15 +0000
Message-ID: <CALecT5gQWn0PRO4Q24b6qkrfVE5OxsCp65TuhWTb30ceK_OJ0A@mail.gmail.com>
Subject: Re: RISC-V: patched kexec-tools on github for review/testing
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     Nick Kossifidis <mick@ics.forth.gr>, ebiederm@xmission.com,
        kexec@lists.infradead.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Alexandre ghiti <alex@ghiti.fr>,
        Mike Rapoport <rppt@kernel.org>, geert+renesas@glider.be,
        Stephano Cetola <scetola@linuxfoundation.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre, Nick:

On Wed, Oct 6, 2021 at 11:15 AM Alexandre Ghiti
<alexandre.ghiti@canonical.com> wrote:
>
> Hi Nick,
>
> On Tue, Oct 5, 2021 at 4:07 PM Alexandre Ghiti
> <alexandre.ghiti@canonical.com> wrote:
> >
> > On Tue, Oct 5, 2021 at 2:15 PM Nick Kossifidis <mick@ics.forth.gr> wrote:
> > >
> > > Hello all,
> > >
> > > I've uploaded my kexec-tools patches for riscv on github for
> > > testing/review before sending them upstream.
> > > https://github.com/riscv-collab/kexec-tools/tree/riscv
> > >
> > > Both kexec and kdump were tested on latest rv64 qemu, using for-next
> > > branch with this patch applied:
> > > https://patchwork.kernel.org/project/linux-riscv/patch/20211002122026.1451269-1-mick@ics.forth.gr/
> > >
> >
> > I'll test that asap and review your patch too.
> >
> > Thanks for your time Nick!
> >
> > Alex
> >
>
> So I followed the instructions here:
> https://documentation.suse.com/fr-fr/sles/12-SP3/html/SLES-all/cha-tuning-kexec.html#cha-tuning-kexec-basic-usage,
> below the output on an Unmatched board using a vmlinux stored on a sd
> card:
>
> ubuntu@ubuntu:~$ sudo sbin/kexec -l vmlinux --append="$(cat
> /proc/cmdline)" --initrd=/boot/initrd.img
> Warning: No cmdline provided, using append string as cmdline
> Warning: No dtb provided, using /sys/firmware/fdt
> [ 1813.472671] INFO: task kworker/1:0:988 blocked for more than 120 seconds.
> [ 1813.478751]       Not tainted 5.15.0-rc1+ #15
> [ 1813.483110] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> Could not find a free area of memory of 0x3000 bytes...
> locate_hole failed

I've finally spent some time debugging this, and found the fix:

--- a/kexec/arch/riscv/kexec-riscv.c
+++ b/kexec/arch/riscv/kexec-riscv.c
@@ -120,7 +120,7 @@ int load_extra_segments(struct kexec_info *info,
uint64_t kernel_base,
                               initrd_base + initrd_size);

                dbgprintf("Base addr for initrd image: 0x%lX\n", initrd_base);
-               min_usable = initrd_base;
+               max_usable = initrd_base;
        }

the initrd image has been put at end of memory space( from high
address down to low address),
for example, my case here:
  the crash memory: 0x90000000 - 0xA0000000
  and the initrd base: 0x9F78F000

so, the max_usable address need to update
>
> I used the Ubuntu kernel, so this is pretty large:
> -rwxrwxr-x 1 ubuntu ubuntu 277M Oct  5 15:47 vmlinux
> -rw-r--r-- 1 root root 98M Sep 21 03:25 /boot/initrd.img
>
> Then if I don't load the initrd (I sometimes have the same warning as
> above) I can at least kexec the new kernel but it fails to boot:
>
> ubuntu@ubuntu:~$ sudo ./sbin/kexec -e
> Warning: No cmdline or append string provided
> Warning: No dtb provided, using /sys/firmware/fdt
> [...]
> [    0.000000] SBI v0.2 HSM extension detected
> [    0.000000] CPU with hartid=0 is not available
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] kernel BUG at arch/riscv/kernel/smpboot.c:107!
> [    0.000000] Kernel BUG [#1]
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.15.0-rc1+ #15
> [    0.000000] Hardware name: SiFive HiFive Unmatched A00 (DT)
> [    0.000000] epc : setup_smp+0xcc/0x142
> [    0.000000]  ra : setup_smp+0xc4/0x142
> [    0.000000] epc : ffffffff80a04080 ra : ffffffff80a04078 sp :
> ffffffff81803ec0
> [    0.000000]  gp : ffffffff81a23220 tp : ffffffff81810500 t0 :
> ffffffff81a3551f
> [    0.000000]  t1 : ffffffffffffffff t2 : 0000000000000000 s0 :
> ffffffff81803f00
> [    0.000000]  s1 : 0000000000000000 a0 : 0000000000000000 a1 :
> 0000000000000000
> [    0.000000]  a2 : 0000000000000000 a3 : 0000000000000001 a4 :
> 0000000000000000
> [    0.000000]  a5 : ffffffff80c64500 a6 : 0000000000000004 a7 :
> 000000000000ff00
> [    0.000000]  s2 : 0000000000000005 s3 : 0000000000000000 s4 :
> ffffffff8118f9a8
> [    0.000000]  s5 : 0000000000000007 s6 : ffffffff80c0b790 s7 :
> 0000000080000200
> [    0.000000]  s8 : 0000000000000fff s9 : 0000000081000200 s10:
> 0000000000000018
> [    0.000000]  s11: 000000000000000b t3 : 0000000000ff0000 t4 :
> ffffffffffffffff
> [    0.000000]  t5 : ffffffff80c0b7a0 t6 : ffffffff81803bd8
> [    0.000000] status: 0000000200000100 badaddr: 0000000000000000
> cause: 0000000000000003
> [    0.000000] [<ffffffff80a04080>] setup_smp+0xcc/0x142
> [    0.000000] [<ffffffff80a03d88>] setup_arch+0x56a/0x590
> [    0.000000] [<ffffffff80a00aa2>] start_kernel+0xaa/0xa5c
> [    0.000000] random: get_random_bytes called from
> oops_exit+0x44/0x70 with crng_init=0
> [    0.000000] ---[ end trace 0000000000000000 ]---
> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
> [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill
> the idle task! ]---
>
> This reliably fails here.
>
> > > Regards,
> > > Nick
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
