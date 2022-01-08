Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6952488519
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 18:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiAHRsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 12:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiAHRsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 12:48:11 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8140C06173F;
        Sat,  8 Jan 2022 09:48:10 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id j6so35265213edw.12;
        Sat, 08 Jan 2022 09:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HKLi8ROSD1N0wXToisA4xUpZ4tz7KIbvKJEjlY+zaMA=;
        b=PcqwM7NAXcRYpLPiEYfz8ZW5rmZxpmtXiai7y6zR+n4NY3My0rbQigrJBCedZ/3eOu
         wI/l1T+lA0cMqcOenXQCOSVOVy8wUMIn4j+kys9sbU01qzjmrSNfk9Hx4u2VN5PktxSd
         s9h1Ztclpvqx0V8qlFfWyJiE0OilijmlZ9tpsRiiyz4MX+XLIR+Kss1QFd6RU/ETrANN
         /j7PuJmGhgKufed9GjyC7hJlcDPe7gfnPWde1f7ZRcU+qxKOP8JgKGDMdf4d7rP7DOq8
         kWXs9BnYca0Kvhu+hztSbUUswZ/0Z6YzQfMw0aKfnRqsG6nB/vs2qo4EnhJ6ia+mxe7l
         NHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HKLi8ROSD1N0wXToisA4xUpZ4tz7KIbvKJEjlY+zaMA=;
        b=a5oQaB6GJPLnysoScdF2s3l3BdWuanLFO9R57h2/4vSN6Pv4aW/N4mnu4q6TtmeNaw
         ueizkgOaP4VCmyOLdesqQ2BTCMDUK9czMesZxVIgSl+a/pCJeVkrMbkOtAP2WRgbgis5
         jbgE9+WmS/K7wWDhPlgWFkOS2D+7LIprgFdzTHofN/Tqa3HNihtRo2cI9/JJ79EL/OvX
         vleENNF16rNoXHyt5lXXPB1SLwrqgUREcmZBG2i150aU93dORlV5JmK3y4GZ8oZ7AqpY
         DzsqBFNA90rq0xWKECACmE0cQSW8i2LW8zNfdZNLFxFB7O6qsoVE70oLWLYqlrZgr2Xv
         IIgA==
X-Gm-Message-State: AOAM530ZsT4/ihUpEpwsxHUOR/SLFVpFjShqBmNCOmjeOz7uggwIAJ/r
        sFNBv2Fl0Xw9+n92dsTgjwPW0zdjDW9lF/2Jd+c=
X-Google-Smtp-Source: ABdhPJyanEkx9eiDlQV1xTggUJn4Revs/1UtDujKoh9WRgpTMrFstm6S1BQMKo9gsk+Y+tQTRTagKlu9TPLuX8AsFnk=
X-Received: by 2002:a17:906:3ed0:: with SMTP id d16mr52555537ejj.636.1641664089284;
 Sat, 08 Jan 2022 09:48:09 -0800 (PST)
MIME-Version: 1.0
References: <20220107233458.2326512-1-gsomlo@gmail.com> <20220107233458.2326512-4-gsomlo@gmail.com>
 <CAHp75VcHnHpX1=ojmFnujqkf55aS1ePiVW4kKydTJQe=dXbwbQ@mail.gmail.com>
 <YdjvlA7rqQoZe44F@errol.ini.cmu.edu> <CAHp75Vf7o1g0FTAd+Zo6TMzDN3C2nGLhbDo0OJ9Cmwcxm=Kc8Q@mail.gmail.com>
 <YdmPho2GpVcvWUgU@errol.ini.cmu.edu>
In-Reply-To: <YdmPho2GpVcvWUgU@errol.ini.cmu.edu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 8 Jan 2022 19:47:32 +0200
Message-ID: <CAHp75VcSenjpZdA_wujKju5rHr8bAw2VjfL8RMKb7RW6Zmz4QA@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] mmc: Add driver for LiteX's LiteSDCard interface
To:     "Gabriel L. Somlo" <gsomlo@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "kgugala@antmicro.com" <kgugala@antmicro.com>,
        "mholenko@antmicro.com" <mholenko@antmicro.com>,
        "krakoczy@antmicro.com" <krakoczy@antmicro.com>,
        "mdudek@internships.antmicro.com" <mdudek@internships.antmicro.com>,
        "paulus@ozlabs.org" <paulus@ozlabs.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "shorne@gmail.com" <shorne@gmail.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "david.abdurachmanov@sifive.com" <david.abdurachmanov@sifive.com>,
        "florent@enjoy-digital.fr" <florent@enjoy-digital.fr>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 8, 2022 at 3:20 PM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> On Sat, Jan 08, 2022 at 01:26:08PM +0200, Andy Shevchenko wrote:
> > On Sat, Jan 8, 2022 at 3:57 AM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> > > On Sat, Jan 08, 2022 at 01:54:07AM +0200, Andy Shevchenko wrote:
> > > > On Saturday, January 8, 2022, Gabriel Somlo <gsomlo@gmail.com> wrote:

...

> > > >     +       u32 div;
> > > >     +
> > > >     +       div = freq ? host->ref_clk / freq : 256U;
> > > >
> > > >     +       div = roundup_pow_of_two(div);
> > > >     +       div = clamp(div, 2U, 256U);
> > > >
> > > > Logically seems to me that you may join these two together, because clamped
> > > > range is power-of-2 one.
> > >
> > > `div` needs to be a power-of-2 when written to the LITEX_PHY_CLOCKERDIV
> > > register (below). And clamp() will just enforce a min/max range, so if
> > > (div = ref_clk / freq) ends up e.g., 5, I need both roundup_pow_of_two()
> > > to bump it to 8, and clamp() to enforce that it's between 2 and 256.
> > >
> > > Unless you mean I should simply write it like:
> > >
> > >         div = clamp(roundup_pow_of_two(div), 2U, 256U);
> > >
> > > ... as a single line?
> >
> > Yes, that's what I meant.
>
> Turns out, clamp really hates being passed roundup_pow_of_two()
> directly (see below). I think it's probably better if we leave
> them as-is, to avoid going the explicit cast route which Geert
> recommended against.

I see, then ignore my comment on this matter in v9.
Perhaps add a comment in the code explaining that roundup_pow_of_two()
may not be unified with clamp()?

-- 
With Best Regards,
Andy Shevchenko
