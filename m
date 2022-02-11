Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97594B2BDA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352222AbiBKRgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:36:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245333AbiBKRga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:36:30 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E5238F;
        Fri, 11 Feb 2022 09:36:29 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id j2so27220106ybu.0;
        Fri, 11 Feb 2022 09:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ht7fW7XN0BAh+gkkGIftbM1jepL7WlEtPAVMav2pC54=;
        b=qpBHbmOH56uBqmz6laAUiecwff8yxOfd+OQpbfUs/4m5i6XY7YOftcQfmrcV3GPi3M
         ieUWItI8gzpejTSvxM25FLNtkPN/1txl1ksjFZsZedhHSWsmy2PZAl4mjPaxtwSw/S0S
         QhH2mkq77Ax6u/kY7qlTJN71wgzEdM6U7w+78hy/z5UpBpXYrb7vWLBIF4/ZLOCdQzXE
         X9t9WuYNYwbNLYUCi8W2QtoqIYuHNP+jF0B4sxErEKSuGAAQm+wV71iScGtEQJnbO/NX
         shiWcQIP5q+wVbdamVIPHVZPmDKxJcf76qOSx+kBacgpSb3czqk+vJDdghttyY6jcd/Y
         aLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ht7fW7XN0BAh+gkkGIftbM1jepL7WlEtPAVMav2pC54=;
        b=zxgbM7tTThlAkERDcTm/12EfvX0cjboh8D1OvzwbNZHPXxeqk3g+EP/aY5GMqJs+yh
         csWEVij/U8UvM6Ezf8xppPbDVmhHJh475dE0YCyUoaFEuLEfF7zrOBF1QUS6+1X7/X33
         OQZONgMO3pC+puIQU5ND0HGuH8CZsC9SYkOKbxBr91BJ+pjSln17M31Znil0UevkCRpi
         qy04Qq79NAgYNZCpDoSzTxDCIy5B4A5OuSW+kyatp43n/ryL4qyBFvfmRsa7Y7uJWVXL
         pSeCYoDrNOIemvH3pqqGcyu4DUekCgs6BDCTYsi+9NHs4gzh37COfzX57Y8aopw68d7Z
         eSMQ==
X-Gm-Message-State: AOAM531Ri1HU/Ob8IOrWEr4w/zmGoy9oxt4p+UgncECZe0r24z1Oo/Bs
        icWasU+FW3lHMJ3VT4AtQscC/urqpbXyzJPIy28NkfXS4og1Dw==
X-Google-Smtp-Source: ABdhPJyduuEfNltVqvgKzwHxtFr8/1XdWQpZ/VYWWTJ8KpKHH3QMuFWjnSjNNL7Xa+kO/QFkpvuPbA0kAeJrmmMq20s=
X-Received: by 2002:a81:c644:: with SMTP id q4mr2894693ywj.206.1644600988653;
 Fri, 11 Feb 2022 09:36:28 -0800 (PST)
MIME-Version: 1.0
References: <20220210184340.7eba108a@canb.auug.org.au> <CAA5qM4BKwS9W5UCbnfo_xSTJKBuUEyNzUrg0UfGhoxWK5WK3RQ@mail.gmail.com>
 <20220211124302.7b0f0ec0@canb.auug.org.au>
In-Reply-To: <20220211124302.7b0f0ec0@canb.auug.org.au>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Fri, 11 Feb 2022 09:36:17 -0800
Message-ID: <CAA5qM4Der1X+sESjPY0eQ-Qo_x0YEYZLo7d6Xjk6fPc1zXzZcA@mail.gmail.com>
Subject: Re: linux-next: boottime warning from todays linux-next
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Domenico Andreoli <domenico.andreoli@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 5:43 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Tong,
>
> On Thu, 10 Feb 2022 15:35:30 -0800 Tong Zhang <ztong0001@gmail.com> wrote:
> >
> > I am trying to see if I can reproduce this.
> > Could you share the QEMU command line and pseries_le_defconfig?
> > Latest kernel does not have pseries_le_defconfig so I assume you have
> > your own version.
>
> This is a ARCH=powerpc build and qemu run.
>
> qemu-system-ppc64 -M pseries -cpu POWER8 -m 2G -vga none -nographic -kernel $vmlinux -initrd $initrd
>
> I have a simple initrd that just boots to a login prompt.
>
> Anyway, it seems that the mystery has been solved (hopefully).
> --
> Cheers,
> Stephen Rothwell

Thanks for providing the configuration.
I tried the same setup and it worked. No crash whatsoever.

As mentioned by Luis, if I enable the line below, the kernel will
throw out a similar message like in your original mail.

@@ -2773,7 +2761,6 @@ int __init sysctl_init_bases(void)
{
register_sysctl_base(kernel);
register_sysctl_base(vm);
+ register_sysctl_base(fs);
register_sysctl_base(debug);
register_sysctl_base(dev);

[    0.190779][    T1] Call Trace:
[    0.190836][    T1] [c0000000073e3a90] [c0000000007bc2e0]
dump_stack_lvl+0x74/0xa8 (unreliable)
[    0.190940][    T1] [c0000000073e3ad0] [c000000000581d9c]
__register_sysctl_table+0x59c/0x8f0
[    0.191054][    T1] [c0000000073e3bd0] [c0000000020416fc]
init_fs_stat_sysctls+0x48/0x60
[    0.191110][    T1] [c0000000073e3bf0] [c000000000012190]
do_one_initcall+0x60/0x2c0
[    0.191139][    T1] [c0000000073e3cc0] [c000000002004a24]
kernel_init_freeable+0x33c/0x3dc
[    0.191189][    T1] [c0000000073e3da0] [c0000000000127a4]
kernel_init+0x34/0x1a0
[    0.191231][    T1] [c0000000073e3e10] [c00000000000cd64]
ret_from_kernel_thread+0x5c/0x64

I believe this issue can be marked as resolved now.

- Tong
