Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B3A51A1A8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 15:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351036AbiEDOCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 10:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350700AbiEDOCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 10:02:41 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0616427B08
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 06:59:05 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id h10so2506552ybc.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 06:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SPZZPIZ3tMBmU2J1+dZLu8mQ0Ktfd9UqnJWzWh7GFsY=;
        b=LRu+SOgpWQ2b+0XE6XdI/GPR0EVOYpYkODREs06fm4JhpU/+whc8uYsRe84PoV/JSE
         ZPYr0vcwK13wBePNL3HhRS1K5KCawgiM+8nA3JodO3TFcvqxV/SXUB6XsDpnbMmKrl/O
         UwA2935dhr1JZ5IYE7VJe+x5YlZKUuTtthD6ZyullhDMhoGCelzR7b+dyGOKwbpY8+Tl
         RweTMuhP01HvNGL4Iux7lkE+85f7iPo/miEVmHQz9pI4KJfovUn2gIuynUdyEaLBRKaA
         ujGpZ1FPiKdjVCRW8uSeCvuoFeYdMaQr3Xp7ltKPvVz9kuiXOYxJwAk3C8iXVlnNOxgF
         Hv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SPZZPIZ3tMBmU2J1+dZLu8mQ0Ktfd9UqnJWzWh7GFsY=;
        b=4Yo2jUVaPx6AhtT4qkQyuZFH0OTr2pv3zmKBdW4bSwaVq/q/tCn0xU5Y45sMO6iaET
         aUymTydDIaV1gDNpKw/bhmHhWCLYUgdfTzta9kVJQlt6ip+hTzTXdRDwptBwna45lO1o
         mEdJPMrbiMwRtwX/Xp9cELWJ5FXfgndXnxkpy6VreFhYMOtebLc/Odv/Fd2vFG7I8uzb
         koQ9WJg3QGsNdwa1Jr1EXNH7Ud+iN0PhV/U30/jpij1u1qmIkvJw/42hfRsWZJ34yl1Z
         UHjoKX5lw4iY7kN0lZWt6jrCYpqrzfB4gEzIS0kDm8T92ihT60uuAC1WNXcCo6fpcomf
         wi9Q==
X-Gm-Message-State: AOAM530FHOnElFJBNvzapF9iO87GaiKI3IOXYXH4fUugN/bRj3QjOPLB
        VDv7lUmQXG58daza2biyvnDm/H3ThFN7iAmD5UkZ8aKhic8=
X-Google-Smtp-Source: ABdhPJwFdnRNBegT96HZOCc6rf5V5GfnGTph+kAaVdv0O4+9BngcElxeohXGSrJ+jPxr8dcRqOpnRK6wxVA02Kq9C40=
X-Received: by 2002:a25:c1c3:0:b0:648:e9af:111f with SMTP id
 r186-20020a25c1c3000000b00648e9af111fmr19203938ybf.168.1651672743992; Wed, 04
 May 2022 06:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220504070941.2798233-1-elver@google.com> <CABVgOSnkROn18i62+M9ZfRVLO=E28Eiv7oF_RJV+14Ld73axLw@mail.gmail.com>
 <CANpmjNPKyGUV4fXui5hEwc9+4y70kP_XgSnHbPObWBGyDeccYA@mail.gmail.com> <CABVgOSkLGryZeWVXdfBDkQKWvSkYTk2LWx+yC9J+4FYQpn2bpQ@mail.gmail.com>
In-Reply-To: <CABVgOSkLGryZeWVXdfBDkQKWvSkYTk2LWx+yC9J+4FYQpn2bpQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 4 May 2022 15:58:27 +0200
Message-ID: <CANpmjNNHwpmVnrbRcibyu7F7r3cU9p_+ZHGTx=GGB7Y8LfVxGg@mail.gmail.com>
Subject: Re: [PATCH -kselftest/kunit] kcsan: test: use new suite_{init,exit} support
To:     David Gow <davidgow@google.com>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 4 May 2022 at 15:54, David Gow <davidgow@google.com> wrote:
>
> On Wed, May 4, 2022 at 9:48 PM Marco Elver <elver@google.com> wrote:
> >
> > On Wed, 4 May 2022 at 15:43, David Gow <davidgow@google.com> wrote:
> > >
> > > On Wed, May 4, 2022 at 3:09 PM Marco Elver <elver@google.com> wrote:
> > > >
> > > > Use the newly added suite_{init,exit} support for suite-wide init and
> > > > cleanup. This avoids the unsupported method by which the test used to do
> > > > suite-wide init and cleanup (avoiding issues such as missing TAP
> > > > headers, and possible future conflicts).
> > > >
> > > > Signed-off-by: Marco Elver <elver@google.com>
> > > > ---
> > > > This patch should go on the -kselftest/kunit branch, where this new
> > > > support currently lives, including a similar change to the KFENCE test.
> > > > ---
> > >
> > > Thanks! This is working for me. I ran it as a builtin using kunit_tool
> > > under (I had to add an x86_64-smp architecture), then use:
> > > ./tools/testing/kunit/kunit.py run --arch=x86_64-smp
> > > --kconfig_add=CONFIG_KCSAN=y --kconfig_add=CONFIG_DEBUG_KERNEL=y
> > > --timeout 900 'kcsan'
> > >
> > > To add the x86_64 smp architecture, I added a file
> > > ./tools/testing/kunit/qemu_configs/x86_64-smp.py, which was a copy of
> > > x86_64.py but with 'CONFIG_SMP=y' added to XXXX and '-smp 16' added to
> > > YYYY.
>
> (Whoops, forgot to copy this in properly: XXXX was 'kconfig' and YYYY
> was 'extra_qemu_params'.)
>
> The x86_64-smp.py file ends up looking like this:
> ---8<---
> from ..qemu_config import QemuArchParams
>
> QEMU_ARCH = QemuArchParams(linux_arch='x86_64',
>                           kconfig='''
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SMP=y
>                           ''',
>                           qemu_arch='x86_64',
>                           kernel_path='arch/x86/boot/bzImage',
>                           kernel_command_line='console=ttyS0',
>                           extra_qemu_params=['-smp 16'])
> ---8<---
> > > It took about 10 minutes on my system, so the default 5 minute timeout
> > > definitely wasn't enough.
> >
> > The trick to reduce the KCSAN test time is to set
> > CONFIG_KCSAN_REPORT_ONCE_IN_MS=100 or lower. So should you consider a
> > special KUnit config, I'd add that.
> >
>
> Ah: it might be worth adding a dedicated kcsan .kunitconfig, in which
> case this would be helpful. It'd also need the SMP qemu config above
> before it's particularly useful, and 16 was a randomly-picked number
> of CPUs -- not sure if there's a better default.
>
> If you're likely to use it, though, we can definitely add it in. I'm
> sure there'll eventually be other uses for an SMP config under
> kunit_tool, too.

I currently have some other frankenscript to run it, but I wouldn't
mind just using kunit_tool to do so. So having real SMP support there
would be very useful.

Thanks,
-- Marco
