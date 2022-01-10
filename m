Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 682FF489F4B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241276AbiAJSdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241257AbiAJSdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:33:04 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F33BC06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:33:04 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id n30-20020a17090a5aa100b001b2b6509685so1194317pji.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 10:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EdcKV+SsL0jCXV8u1Czp24wEEQPdwJdrZT34tWNtq3Q=;
        b=oJU/NSZJEbIYIt5ZSSnmiVz+walI6/FlD0xbvsZrIQ2QQ0/zJNtwfarhhp/f0T+/Md
         f5dRLoZCJLnykMJu4/FP0brgmCKgEOwCqro3SueoRdrZdHBzdvaf5/wxYbtCm3AVF3Bt
         WYM7ytcfPdO9HkOS7WeMNj/D4wyPL0Mi2T7xePSWTrqz8+vYACjqp3YWQdNhtAm5Uwfs
         zpIKw8KFjL9RW8ekTWnaiTzUKa/OyOlovtw46dTlGfL0g7zGpTOncFn3HP/p17ylIhUv
         WIrUetZXJ8mnqEZe7jU5ZoIj5R2YU+FUoB/KsgzqaKDs2jHEYHhqXYw+55Vu4v+APg6W
         zJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EdcKV+SsL0jCXV8u1Czp24wEEQPdwJdrZT34tWNtq3Q=;
        b=mpbQfkLZSOnNk+Asiot1UgpXw84OJJuvM8V2K3pI9WnKjCcSjGH/fHoK2H/W9gj962
         LcCEg/Bpy0zICgUOjgLBWwDCapBjadgc5Vje3xu3XMNabJ4AnTvg3uVnBaoSun05VVLp
         5YrEvOKqUBQkEwtaqJjBLUtWYcPm6m6TwMTN9fpxKgsKQTtcXnH6SFcG3KFW5Wp2/+oU
         shXhcU97tNpA/Tp2ZbXZMtT8oOLIy1YkK9Jxx6t/aS1O6N2v2bI9p8pOaokg+KzlTHTV
         0bacbV4y2rJilsgLMX3e42LXYJRWc/+aJEE+mU9m9nPXJpB94+/Wvoc5tB5Y2XDjvxEl
         66vQ==
X-Gm-Message-State: AOAM533p89gWPs4q3pHaOiHEVQsxQbQhXvMxPuZ4m6VrgBMEydoXNNgM
        njpNOpRL655UXDpTe7wygBQ+xJkp6Rk+iRevzjp6WA==
X-Google-Smtp-Source: ABdhPJzIMi+WJwGBIcQdP6AIC3ctmNDZzyBtiEhCrobmVpdv6qrrck1nuRCeMAVK9V7JTKKtMqnr4urWwVRE6IFbBoA=
X-Received: by 2002:a17:902:e54f:b0:14a:1bbf:9cf0 with SMTP id
 n15-20020a170902e54f00b0014a1bbf9cf0mr667932plf.158.1641839583767; Mon, 10
 Jan 2022 10:33:03 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a0RDZpLtWjMEU1QVWSjOoqRAH6QxQ+ZQnJc8LwaV7m+JQ@mail.gmail.com>
 <7e480da8-0d54-2d62-0a8e-184901c974b6@gmail.com> <ee2c92da-030c-b92f-0f41-1fdbbeed47c7@gmail.com>
 <CAOesGMgx99GJ3gQmdgauSs3aF8xr4FgcgsELRz4HSVXmujHJnQ@mail.gmail.com> <CAK8P3a3sBADt4Cu=LGbjHQpQ32O-BtFk1aQFwhL8Ar=M_gj6Xw@mail.gmail.com>
In-Reply-To: <CAK8P3a3sBADt4Cu=LGbjHQpQ32O-BtFk1aQFwhL8Ar=M_gj6Xw@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 10 Jan 2022 10:32:52 -0800
Message-ID: <CAOesGMjArmB1J7KasjHZRTNXoZvtUXkTOQAyg5yd29qC8PeS9g@mail.gmail.com>
Subject: Re: [GIT PULL 0/5] SoC changes for 5.17
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 4, 2022 at 5:40 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Tue, Jan 4, 2022 at 7:40 PM Olof Johansson <olof@lixom.net> wrote:
> > On Tue, Jan 4, 2022 at 1:58 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> > > On 12/24/21 9:11 AM, Florian Fainelli wrote:
> > > >
> > > > Should I resend or fix something in those? Thanks!
> > >
> > >
> > > Arnd, Olof, do I need to resend the 3 pull requests mentioned above?
> > > Thanks and happy new year.
> >
> > I'm about to make a pass of merges, likely tomorrow -- I had to get my
> > Honeycomb working again since it hosts all the trees and mailboxes for
> > me.
> >
> > No need to resend at this time.
>
> It's possible that I had accidentally merged them in the end but tagged
> the branch without those merge commits, so have a look if it's in there.

Yeah, it looks like there were a few merges not part of the pull
request (Linus just merged them, so these showed up in
regen-contents). I'll fold them into arm/late.

arm/defconfig
        broadcom/defconfig [sign: Y Arnd Bergmann <arnd@arndb.de>]
                https://github.com/Broadcom/stblinux
tags/arm-soc/for-5.17/defconfig
        broadcom/defconfig64 [sign: Y Arnd Bergmann <arnd@arndb.de>]
                https://github.com/Broadcom/stblinux
tags/arm-soc/for-5.17/defconfig-arm64
        qcom/defconfig [sign: N ]

git://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux
tags/qcom-arm64-defconfig-for-5.17
        patch
                ARM: multi_v7_defconfig: Enable drivers for
DragonBoard 410c [sign: N ]


-Olof
