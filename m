Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84654875C9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237568AbiAGKjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237563AbiAGKjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:39:06 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB9CC061212;
        Fri,  7 Jan 2022 02:39:05 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id j21so20417483edt.9;
        Fri, 07 Jan 2022 02:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6kF6QNdEdLIGPZXL6xrp3BMX3yppOkG2cr7XK0jDG4I=;
        b=qQoHfItOU32zPICBiNvCCw5PGS/807h893gdXdNoFFERRnQmrPy/VEY3ogBvItLuh8
         yPK09MgW8Uxa9h7OVyh2QvabSyVBlTqjRve/0l0s1z9S3xxyKpmTav8WjHJ6OgptrANy
         VIrqetmuX5JnYAeTefqDTaQ4gsUOT1AOGdYSrk4N1j+sEw6wtXHkFeaz7Dn38CtR/4qb
         xaIQpEK6dTRnAXej5SndFj2C9xcVy8vLILjytzLIrmSLj9PLiqR257NtX9buF4M2Aa5h
         6YYUM2ywavh2UzTCd6F7+6VkTNzSkBscUPu6sas0Jcld5rtF5Pb7mkgKOG0tV9q2Eq4m
         HRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6kF6QNdEdLIGPZXL6xrp3BMX3yppOkG2cr7XK0jDG4I=;
        b=bWKWNopL1G3fQC20F/aTwphAf6lllfOzMMJBq4Dr805HiiDTbxiHKsMZDNozflZK6r
         adEzEi5YeQA60S3Mdtt11VErTjnOhnCIl26VCLyKd+eiW5lZX+u+Yz7SokSto+nK1ZNH
         2EA8cL4SVFu50+zv/UWVA18ZnwiVtQ8m9CL1MGP8QaImqES/EWDmAbSyHyE/fh9fq1oI
         qk4tt6JyTGZIA4mCkLC0SJx78/H3V291ePw8wAX19+7YojzP92usBz7eHUQixPndoi0+
         r0FUv/7CwmLC1RoCoCNt5yd/DdodJqWg/xyIXGDg9Gvo5cp4h5ox3b4usuImnI2yPJKe
         XY9A==
X-Gm-Message-State: AOAM5315uRntWFhAFD7mHWcoJNRDyksjR5/lRrVw+/x84oDXj1JQqlLq
        TzzZEfOLcOKtEpstYsMU7tPhKMJVRz/hYOhP1pk=
X-Google-Smtp-Source: ABdhPJyyVdqXUzev2sipj9GEZKB31GiS3lG0T2gedo6UvYiF+KxnsH5wy5GUpRbvHTjwDzpaA9SN4wyGgbqNOv8lCY0=
X-Received: by 2002:a17:907:76d4:: with SMTP id kf20mr49164332ejc.44.1641551943981;
 Fri, 07 Jan 2022 02:39:03 -0800 (PST)
MIME-Version: 1.0
References: <20220106174803.1773876-1-gsomlo@gmail.com> <20220106174803.1773876-4-gsomlo@gmail.com>
 <CAHp75Ve_jWmo3+Es0G5SyMpcdC_=hWfxHoa866Difd+X3F0uxg@mail.gmail.com>
 <YddyMI7hJE7u0jQ/@errol.ini.cmu.edu> <CAMuHMdX2ujViu9GivVHtgAqC6AdiL3CvdJM58pVteJe9KdvdqQ@mail.gmail.com>
 <YdgSG7t2eG9YzkaG@antec> <CAHp75VdjP4jmUQHUV=eF2Ot+s=3==ZqUS7BFxMoPDw=NkCBm6Q@mail.gmail.com>
 <CAMuHMdU1UqwKzE=tT4fdJb9EjJRJTsG2fGoLrBSOs_K22rY-sQ@mail.gmail.com> <CAMuHMdUCsEHKRS1hayf_u4dY=_ZsPdoHjjDs-kzcR8A5Vvhb1Q@mail.gmail.com>
In-Reply-To: <CAMuHMdUCsEHKRS1hayf_u4dY=_ZsPdoHjjDs-kzcR8A5Vvhb1Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 7 Jan 2022 12:38:27 +0200
Message-ID: <CAHp75VdrnG8vEHBecwZgZGaVrQvLpY9sOGyCiy8nDZHSHS=dLw@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] mmc: Add driver for LiteX's LiteSDCard interface
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Stafford Horne <shorne@gmail.com>,
        "Gabriel L. Somlo" <gsomlo@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Kamil Rakoczy <krakoczy@antmicro.com>,
        mdudek@internships.antmicro.com,
        Paul Mackerras <paulus@ozlabs.org>,
        Joel Stanley <joel@jms.id.au>, david.abdurachmanov@sifive.com,
        Florent Kermarrec <florent@enjoy-digital.fr>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 7, 2022 at 12:30 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Fri, Jan 7, 2022 at 11:29 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, Jan 7, 2022 at 11:25 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Fri, Jan 7, 2022 at 12:12 PM Stafford Horne <shorne@gmail.com> wrote:

...

> > > And for this particular case I dare to advertise a script I wrote [1]
> > > to help with recursive searches.
> > >
> > > [1]: https://github.com/andy-shev/home-bin-tools/blob/master/gl4func.sh
> >
> > Cool!
> >
> > My fingers are used to type
> >
> >     git grep -w <pat1> -- $(git grep -lw <pat2> -- ...)
> >
> > ;-)
>
> Actually you can just use git grep --and?

Thanks for the hint (and patches are welcome :-).
The last time I have read the man of git grep was a long time ago, and
I definitely missed any new features.

-- 
With Best Regards,
Andy Shevchenko
