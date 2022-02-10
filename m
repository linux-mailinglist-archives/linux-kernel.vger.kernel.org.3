Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8E24B0E75
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242228AbiBJNaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:30:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240857AbiBJNaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:30:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B948CBC3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 05:30:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70CF2B82542
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 13:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7F5C340EF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 13:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644499817;
        bh=D3YvW4DlVwpDo3QJDnNkz3ju1LQKDPPBLL8nBCf56KA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H2i2UGLj02Xcjphvb+f4dgATUl3J8KGVdHunZml2kNZ1u2fVaqi3EkV3qpB2GLeqE
         HN2wtWgbJHWMixOAyYYMJpFrf+mUK7U6B0WvnAs1vs4V8xFxcdUq5QIXgcwEpPI8Es
         pgMS4XrnezCQg3t3U3iW6gsUstT3t+O9wMbr1lX1R8LOpWqvY7TtR73YjCNVigGjww
         CtwZr0k5ZSYRIijupBtXONQuNqipiJGFjDqRGTVNLassQDabErTyPHpjuNLoaRrv3P
         KNmj5Oxq2PL41bM/TkDGLpvo+HVMrpimDVR/ALs/Zyump2nK5AlntSw/us64Wq0wDV
         jW755tpRfPhUg==
Received: by mail-wr1-f52.google.com with SMTP id v12so9646875wrv.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 05:30:17 -0800 (PST)
X-Gm-Message-State: AOAM531pbYed2WUoRyN5xLN8YCdM03oJtMQu16m9RZnnkS3Jx6dDG4JW
        t7bpITMHwuJ9HEhmGWwvfXPuHR1qCSOxq/mejao=
X-Google-Smtp-Source: ABdhPJxatygHQVyNyGnmrp+ThMdUYjc83ScIKGV99D0944t9/VGH2PZRP50XeAt++6kQ8xnJRVAk0JWT5Swq5QXr+IM=
X-Received: by 2002:a05:6000:3c6:: with SMTP id b6mr6255767wrg.12.1644499815448;
 Thu, 10 Feb 2022 05:30:15 -0800 (PST)
MIME-Version: 1.0
References: <20220209144910.1484686-1-arnd@kernel.org> <80c6df0717014472aa81093ae3894d39@AcuMS.aculab.com>
In-Reply-To: <80c6df0717014472aa81093ae3894d39@AcuMS.aculab.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 10 Feb 2022 14:29:59 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3tZEc30AaiNENbHKf8+x5VOw7Q=4dVDMNwz0F6+v9YrQ@mail.gmail.com>
Message-ID: <CAK8P3a3tZEc30AaiNENbHKf8+x5VOw7Q=4dVDMNwz0F6+v9YrQ@mail.gmail.com>
Subject: Re: [PATCH] microblaze: remove CONFIG_SET_FS
To:     David Laight <David.Laight@aculab.com>
Cc:     Michal Simek <monstr@monstr.eu>,
        Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Thu, Feb 10, 2022 at 10:36 AM David Laight <David.Laight@aculab.com> wrote:
> From: Arnd Sent: 09 February 2022 14:49
> >
> > Remove the address space override API set_fs().  The microblaze user
> > address space is now limited to TASK_SIZE.
> >
> > To support this we implement and wire in __get_kernel_nofault and
> > __set_kernel_nofault.
> >
> > The function user_addr_max is removed as there is a default definition
> > provided when CONFIG_SET_FS is not used.
> ...
> >  static inline int access_ok(const void __user *addr, unsigned long size)
> >  {
> >       if (!size)
> >               goto ok;
> >
> > -     if ((get_fs().seg < ((unsigned long)addr)) ||
> > -                     (get_fs().seg < ((unsigned long)addr + size - 1))) {
> > -             pr_devel("ACCESS fail at 0x%08x (size 0x%x), seg 0x%08x\n",
> > -                     (__force u32)addr, (u32)size,
> > -                     (u32)get_fs().seg);
> > +     if ((((unsigned long)addr) > TASK_SIZE) ||
> > +         (((unsigned long)addr + size - 1) > TASK_SIZE)) {
> > +             pr_devel("ACCESS fail at 0x%08x (size 0x%x)",
> > +                     (__force u32)addr, (u32)size);
> >               return 0;
>
> Isn't that the wrong check?
> If 'size' is big 'addr + size' can wrap.

Ah right, that seems dangerous, and we should probably fix that first, with
a backport to stable kernels before my patch. I see the same bug on csky
and hexagon:

static inline int __access_ok(unsigned long addr, unsigned long size)
{
        unsigned long limit = current_thread_info()->addr_limit.seg;
        return ((addr < limit) && ((addr + size) < limit));
}

#define __access_ok(addr, size) \
        ((get_fs().seg == KERNEL_DS.seg) || \
        (((unsigned long)addr < get_fs().seg) && \
          (unsigned long)size < (get_fs().seg - (unsigned long)addr)))

ia64 and sparc skip the size check entirely but rely on an unmapped page
at the beginning of the kernel address range, which avoids this problem
but may also be dangerous.

m68k-coldfire-mmu has a comment about needing a check, but tests
for neither address nor size.

> It needs to be (addr >= TASK_SIZE || size > TASK_SIZE - addr)
>
> Which is pretty much a generic version.
> Although typical 64bit architectures can use the faster:
>         ((addr | size) >> 62)

I think this is the best version, and it's already widely used:

static inline int __range_ok(unsigned long addr, unsigned long size)
{
        return size <= TASK_SIZE && addr <= (TASK_SIZE - size);
}

since 'size' is usually constant, so this turns into a single comparison
against a compile-time constant.

         Arnd
