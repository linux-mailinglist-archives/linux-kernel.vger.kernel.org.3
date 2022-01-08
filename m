Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46BCA488524
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 18:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbiAHR4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 12:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiAHR4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 12:56:00 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C24C06173F;
        Sat,  8 Jan 2022 09:55:59 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id q25so26848717edb.2;
        Sat, 08 Jan 2022 09:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0R/bgHibWfpOUod24j2qh0CJvdTR+UyHQ+DqSW1KNwE=;
        b=dPjmlSA+WNP7T5KefRwHVClkd+mr1+2I49hq8DHoAknmoibMR1HoB0UlbIyZKWgvdV
         30KjdjCVWb0lQmA8EmiPSWz0r6VYErWWOADkmN1ymNXSVu0cRVnr3phkIbhmIzV7qnPB
         b9yb/8gyAhnh/RogZYdQLvfnNJ8WrQgU2IYgqJTkFWHano8i+a7LGu0q7b94nOZ4ZGYI
         gIK7hQFIAo+FgyW+tdZfQsSS8zM2nTz/oaqYheOicRzXqT5+bfb/RAtD3qC/KYXiDHgZ
         Ogu19m8lDUvgt81A8XCvitUbcZAfbGoQHcM0uwCM4A19/p5QSApGjO2+F6rcmsK7Zvhd
         Zv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0R/bgHibWfpOUod24j2qh0CJvdTR+UyHQ+DqSW1KNwE=;
        b=drooantsfoDw4iiehDWAJl+CksBHWtXzqt1Lbfm61eLkmCaocbiSsAH2FqO7y152pX
         KcO7737u5L9gIyTHv29aGRbmB1LdvtU6zSTnIa4ZUn4pCTg/Oi4hAFwmMtSe6thknnWA
         744cIvSqrJXD27x3/DEwAlJV7W6c7NWUbjuLgYhVmxutKGc1p9VKSTHBmcBgc7KL+K6l
         dkkG9LPVE3d/k461cPavyxhZ4BWzM4xRAVpQJxQK7FJOBu21pdq9O29G7CE2moZLQ+Uq
         DfitGq6GdH/I4JWLdmiYFhh39Hl6PQqDhmonavjv3nEsax20qCeyYwIgHvDkKs5ZiD3A
         xo+Q==
X-Gm-Message-State: AOAM532ixie6aaJtcHZXfj8/aSbOGAdO95185F1yN2TaPZ83Sg2AMdUM
        hJM6q0QoVePqvjpbi7CsJ84D7LYjOCr37MAoJBc=
X-Google-Smtp-Source: ABdhPJzPY6YaQFWOIUsr6/FJDSgMARqplrEy1CQeW74Ko264I1NgTsElZM6z/nm9LvaHb9vCOWD7Ic5GS/CuIMQ+Mjs=
X-Received: by 2002:a17:906:3ed0:: with SMTP id d16mr52569474ejj.636.1641664557628;
 Sat, 08 Jan 2022 09:55:57 -0800 (PST)
MIME-Version: 1.0
References: <20211222034646.222189-1-liambeguin@gmail.com> <20211222034646.222189-10-liambeguin@gmail.com>
 <CAHp75Vc0aWrFtNK1ZkHkwP62zNXQJaDcn9pc8Uhfq0kOnWzmJg@mail.gmail.com>
 <YcNwt5RFMNFUimD/@shaak> <CAHp75VdrLTNLWZRgWkLXD23RAF28zh29XybywAPyMtb=GNxXbw@mail.gmail.com>
 <YcODglDWiknz2oeV@shaak> <CAHp75Vejfr_S7iK7fAvs7ELxE1TJUECvmKv0-G5Zwunyc6nDQA@mail.gmail.com>
 <Ydm9K3Zx3jPPv70B@shaak>
In-Reply-To: <Ydm9K3Zx3jPPv70B@shaak>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 8 Jan 2022 19:55:21 +0200
Message-ID: <CAHp75Ve5-W7vRGBMaz8jh5DvOCyTovdKaRR_5iB7S7epiWQmfA@mail.gmail.com>
Subject: Re: [PATCH v11 09/15] iio: afe: rescale: reduce risk of integer overflow
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 8, 2022 at 6:34 PM Liam Beguin <liambeguin@gmail.com> wrote:
> On Wed, Dec 22, 2021 at 11:32:24PM +0200, Andy Shevchenko wrote:
> > On Wed, Dec 22, 2021 at 9:59 PM Liam Beguin <liambeguin@gmail.com> wrote:
> > > On Wed, Dec 22, 2021 at 08:56:12PM +0200, Andy Shevchenko wrote:
> > > > On Wed, Dec 22, 2021 at 8:38 PM Liam Beguin <liambeguin@gmail.com> wrote:
> > > > > On Wed, Dec 22, 2021 at 02:29:04PM +0200, Andy Shevchenko wrote:
> > > > > > On Wed, Dec 22, 2021 at 5:47 AM Liam Beguin <liambeguin@gmail.com> wrote:

...

> > > > > > > -               tmp = 1 << *val2;
> > > > > >
> > > > > > At some point this should be BIT()
> > > >
> > > > Forgot to add, If it's 64-bit, then BIT_ULL().
> > > >
> > > > > I'm not against changing this, but (to me at least) 1 << *val2 seems
> > > > > more explicit as we're not working with bitfields. No?
> > > >
> > > > You may add a comment. You may use int_pow(), but it will be suboptimal.
> > > >
> > > > > > Rule of thumb (in accordance with C standard), always use unsigned
> > > > > > value as left operand of the _left_ shift.
> > > > >
> > > > > Right, that makes sense! In practice though, since we'll most likely
> > > > > never use higher bits of *val2 with IIO_VAL_FRACTIONAL_LOG2, would it be
> > > > > enough to simply typecast?
> > > > >
> > > > >         tmp = 1 << (unsigned int)*val2;
> > > >
> > > > No, it's about the _left_ operand.
> > > > I haven't checked if tmp is 64-bit, then even that would be still wrong.
> > >
> > > Okay so your recommendation is to not use a left shift?
> >
> > No, I recommend not to use int type as a _leftside_ operand.
> > BIT() / BIT_ULL() does a left shift anyway.
>
> Oh, got it. Sorry for misreading your message.
> would something like this be good enough?
>
>         s64 tmp;
>         u64 tmp2;

>         tmp2 = 1 << *val2;

This still has a UB according to the C standard. That's why
BIT()/BIT_ULL() is preferable to use since they don't have such
issues. You may open code it, of course (since I remember you wished
to show that this is not a bit, but a number).

>         tmp = tmp2;

> How can I validate this?

By understanding the C standard? I dunno, actually. GCC will generate
correct code, it's just a special warning you may get when supplying a
parameter (Linux kernel doesn't use that one even on W=2 IIRC).

-Wshift-overflow=2

> > > I can look into that but given how unlikely it is to fall into those bad
> > > cases, I'd rather keep things as they are. Would that be okay?
> >
> > > Also, I don't think using BIT() or BIT_ULL() would address this as they
> > > both do the same shift, with no extra checks.
> >
> > They do slightly different versions of it. They use an unsigned int type.
> >
> > Open coded or not, it's up to you. Just convert to unsigned int.

-- 
With Best Regards,
Andy Shevchenko
