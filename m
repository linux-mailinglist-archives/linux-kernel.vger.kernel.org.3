Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F384E2529
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346742AbiCULXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244534AbiCULXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:23:33 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479598BE07
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:22:08 -0700 (PDT)
Received: from mail-wr1-f51.google.com ([209.85.221.51]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N0Zfg-1oJnn02Sxg-00wU2x for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022
 12:22:06 +0100
Received: by mail-wr1-f51.google.com with SMTP id h23so19596652wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 04:22:06 -0700 (PDT)
X-Gm-Message-State: AOAM530X7E0KC2rIoQRsjD9iOrJqooVD8sbi1Y9vIL0/z+uTvjtcveCP
        CKtIibq/7QVQOHFVgPqQNsNIvmXwvuM5WjjiwD4=
X-Google-Smtp-Source: ABdhPJwXz+ToNHL4TpOoh+HdlcxuOPou7dXTvfzP0iFHuBYr3vtjBj/zXXognFOzrqzkSJ6ZJ2iZfEfVsapaC/m5OFY=
X-Received: by 2002:adf:d081:0:b0:1ef:9378:b7cc with SMTP id
 y1-20020adfd081000000b001ef9378b7ccmr17934085wrh.407.1647856084986; Mon, 21
 Mar 2022 02:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220319142759.1026237-1-chenhuacai@loongson.cn>
 <20220319143817.1026708-1-chenhuacai@loongson.cn> <20220319143817.1026708-6-chenhuacai@loongson.cn>
 <CAK8P3a2kroHVN3fTabuFVMz08SXytz-SC8X11BxxszsUCksJ4g@mail.gmail.com> <CAAhV-H6zE7p6Tq8rg1Fq5cK5L38z-VHjxsZ+qm8+Cp5x=u_bUQ@mail.gmail.com>
In-Reply-To: <CAAhV-H6zE7p6Tq8rg1Fq5cK5L38z-VHjxsZ+qm8+Cp5x=u_bUQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 21 Mar 2022 10:47:49 +0100
X-Gmail-Original-Message-ID: <CAK8P3a38nUyAt8gGEYregqivdP7NsXS0RuU1NX4_EAVvwGQBWA@mail.gmail.com>
Message-ID: <CAK8P3a38nUyAt8gGEYregqivdP7NsXS0RuU1NX4_EAVvwGQBWA@mail.gmail.com>
Subject: Re: [PATCH V8 13/22] LoongArch: Add system call support
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:6Sdg7j3qeyi0JviKcSTH/8653SBzjKu9ug2Sw0Hpt4uS18JxEWY
 KDcZsgk91o0vT2Iy9qivzeTne6MFsz9wNBcfYjBoQX/tApAvCgGyo9S14EIwByHviOiVxzK
 GaCMsk0xfcBM7skGsDjbrHm/Xe4nOfeXuBMttpOfRrDz8y7ttqt+CHrW8aK8YTz6kQtQ4rO
 17Xwk8nV2rx3vgE5nYqsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uiHtc6eMwng=:YAmD1V3uh3qIAn1NWi6kHG
 qmI0ZiuYUhs0w/buIBlo/VvsW9SMI0PaG9lkoBFv7DGDhseAg1LoNt7y8ZBFJ+rA3/CB7Zp0b
 dBnSfyJTlb0jM+tE/VsWoggxFJC8tlwcLHri5CbwaYkz73db+IpKETDPUuLX3vy9nzv+lPAwZ
 SxgIdIRBeQgGV//UUuGdCqKwiHjN4o3r8wi1t0ccF8jbgJGwQHfciWj6X+ysvpwrEW69ldpFt
 zFL+amq1IFojTxMqCntXmmdK68UaWhxLlc30svjUjOAxpOQ0iLURoMWPyUjRP2vl7m8jD6Sar
 lHo3GK7WfgKv8UqQeu/th/XqvmhbXo5LrZtW8QdUxnY4OSDdF8z605D18MgSJpH3pO8dbRoku
 wdcEUTHI/YyjFjiBloCeJyTm7qJcgaDd4kNrYPslY5UVkp1Hk9kdhB/yNQuAEPZIlk9DI3R/t
 ewp4WTxxp1Ea7FwIM3UfOofVYy2w55+3o3TRUDmJJyBBpKAWmTUxQGuQe7SLyF134D8WeY0B2
 sMYYaCmWF9uk2T22RvoJjZ1XlqH/YStZJLapzxNQB9nOX6P0AFOl5LSAjY7InB5Z87RCVf8zl
 xw/PrL9bWO75NDWTPp0QXMf/HxMqgeHSYn6q8kW1el2wtC6638DYZnrQVk3yGmVtE5AvfF/hG
 sxPG/yaSW9MRF8fkRHSq9D93Xd+hAGHn+D8SzmXxtSZOpQlBfiffPdwtHCsHn7AbTF/2oriwt
 txE5BwtEHp/iAND+IRAw12bcp23XJ+Oqlh19PXyvJVZsoenIVd0vHNXjRTTLZ7s4aPxR071gI
 Q+sMO93G/mnKvL7sM3mQ2kCvC6mkzmsF0qtwLk2qlUkYMvKtog=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 10:41 AM Huacai Chen <chenhuacai@kernel.org> wrote:
> On Mon, Mar 21, 2022 at 5:01 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Sat, Mar 19, 2022 at 3:38 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> > >
> > > This patch adds system call support and related uaccess.h for LoongArch.
> > >
> > > Q: Why keep __ARCH_WANT_NEW_STAT definition while there is statx:
> > > A: Until the latest glibc release (2.34), statx is only used for 32-bit
> > >    platforms, or 64-bit platforms with 32-bit timestamp. I.e., Most 64-
> > >    bit platforms still use newstat now.
> > >
> > > Q: Why keep _ARCH_WANT_SYS_CLONE definition while there is clone3:
> > > A: The latest glibc release (2.34) has some basic support for clone3 but
> > >    it isn't complete. E.g., pthread_create() and spawni() have converted
> > >    to use clone3 but fork() will still use clone. Moreover, some seccomp
> > >    related applications can still not work perfectly with clone3.
> >
> > Please leave those out of the mainline kernel support though: Any users
> > of existing glibc binaries can keep using patched kernels for the moment,
> > and then later drop those pages when the proper glibc support gets
> > merged.
> The glibc commit d8ea0d0168b190bdf138a20358293c939509367f ("Add an
> internal wrapper for clone, clone2 and clone3") modified nearly
> everything in order to move to clone3(), except arch_fork() which used
> by fork(). And I cannot find any submitted patches to solve it. So I
> don't think this is just a forget, maybe there are other fundamental
> problems?

I don't think there are fundamental issues, they probably did not consider
it necessary because so far all architectures supported clone().

Adding Christian Brauner and H.J. Lu for clarificatoin.

> > > +#define __get_user(x, ptr) \
> > > +({                                                                     \
> > > +       int __gu_err = 0;                                               \
> > > +                                                                       \
> > > +       __chk_user_ptr(ptr);                                            \
> > > +       __get_user_common((x), sizeof(*(ptr)), ptr);                    \
> > > +       __gu_err;                                                       \
> > > +})
> >
> > It would be good to also provide a
> > __kernel_kernel_nofault()/__put_kernel_nofault()
> > implementation, as the default based on __get_user()/__put_user is not
> > ideal.
> They are provided in this file below.

Ok, I see them now, not sure what I did wrong when I looked earlier.

        Arnd
