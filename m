Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFAD47D290
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 14:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245133AbhLVNAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 08:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245111AbhLVNAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 08:00:17 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DC4C061401;
        Wed, 22 Dec 2021 05:00:17 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id d10so6443346ybe.3;
        Wed, 22 Dec 2021 05:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aaB61a7c9DxINzPtdKQI5VfQqfkyBLUL6KJtFjoHoH4=;
        b=DYobZKni1BvZMsQQkn6f6UUD4Sv4gOwlFq7ovNWSefQjSaJucfTCmxdJhvP8QTEvc7
         VnJNrt/md64qoG3R/lc/Nt/Em01gBKJmQtu9TJr8v4gmetHni/EEWyVC3IGJKlDHcM8z
         /jDqAM39BQAK0o5oj0/Df4IP2IFjtrPS7nMb19Cm633+vuWcDTipL6ra8zVph8UUGT2Z
         mXcLbOqRjCb975sz9ziMCm+dveThuvPs8k0UdU+xPyYiqZp5yNgX7uNGLYSgDzy1JOYY
         GhA+hWg3dJ9RmgH5mgIfMW2lAE//Xz6wG2U8pcGbgf40880moNKE6jxavOiEghOSBPec
         pU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aaB61a7c9DxINzPtdKQI5VfQqfkyBLUL6KJtFjoHoH4=;
        b=YH7jryhjyzRdygK1Ar4SoJFkAfi5UmChCyiDky8baM7GqqU0/QC5K+fm9Llw9imqGa
         Lu3S8hZTTeBVZ9cMczC8vUzrJ6KawocdQvkb7egwZT5YwvupS5ydaw2h8XvcPmWT/4z4
         29jzFb8HtfQWX/JU5bCyUDTMWkwTTvDK4izq1kQbst+mhlBWK8SGk5yDBCL0J3LeAN0R
         ZY34DzT6AgQApWy3Ndbt70LfacMVcP4bU16B1QrOuAF7PFtxRBPfD48P5ghlJp/jz/aN
         IH/4Vvbju0L4IAAIwuD+6s8jj3l7W2R2l5dGDyDA5wY4LBYPe4I5ASniKSUIBl2v5XJn
         gSCA==
X-Gm-Message-State: AOAM531DQrkp7ugc+52sBKqJT9yMSfv6m4FbRZw2DBI0cbklOMhpbW+0
        FuNQ0Q1+lOUyJI3Z9RROY6WLHi/cvt7/JMSW4KU=
X-Google-Smtp-Source: ABdhPJwrKuxap0lZ5lBtIC4T5EzGhxynqD8xxXeZzrcsqHwSveQZaQTiNDvUYFWwkR/+k21dEGN0bwkMvOiv1T49PcY=
X-Received: by 2002:a25:ade0:: with SMTP id d32mr4102956ybe.510.1640178016160;
 Wed, 22 Dec 2021 05:00:16 -0800 (PST)
MIME-Version: 1.0
References: <20210803113531.30720-1-lukas.bulwahn@gmail.com>
 <f9074e8d-9314-9d7d-7bf5-5b5538c8be8d@intel.com> <CAKXUXMxQ83T7beOTuZ928=-eo2Tsr94TGxsaYh3+MHOJrDO8Bg@mail.gmail.com>
 <0bc1734f-39c5-cf19-a77e-e0d08978b3d0@intel.com>
In-Reply-To: <0bc1734f-39c5-cf19-a77e-e0d08978b3d0@intel.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 22 Dec 2021 14:00:05 +0100
Message-ID: <CAKXUXMxW7-_D=u4GcsmASzM0Oa8qR-K7kmB945B=W+Zgg9WLgA@mail.gmail.com>
Subject: Re: [PATCH 0/9] Kconfig symbol clean-up on ./arch/x86/
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Lubomir Rintel <lkundrak@v3.sk>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        platform-driver-x86@vger.kernel.org,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 5:40 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 8/3/21 8:12 AM, Lukas Bulwahn wrote:
> >> It's a pretty safe guess that STRICT_IOMEM refers to CONFIG_STRICT_DEVMEM.
> > Thanks, Dave.
> >
> > If the maintainers consider updates to comments making them consistent
> > with the code as worth being picked, I will turn your analysis into a
> > proper commit message and provide a patch to update that comment.
>
> I'd happily ack a patch that does that.  Might as well fix that kind of
> stuff now before more time passes and it gets harder to track down.

Sorry, Dave, it took me a bit longer to come back to my second pass on
references to non-existing configs in the kernel tree...

I have just sent out a quick fix for this issue, now in your and other
x86 maintainers' mailbox:

https://lore.kernel.org/all/20211222125347.13054-1-lukas.bulwahn@gmail.com/

I am happy to get an ack for that patch.

Lukas
