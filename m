Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDF5488700
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 00:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiAHXvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 18:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiAHXva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 18:51:30 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A18CC06173F;
        Sat,  8 Jan 2022 15:51:30 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id 131so10603973qkk.2;
        Sat, 08 Jan 2022 15:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iGeVrl5hxkXsgar4Td7HcCi64u2Dd4z9ULlAQfYLQns=;
        b=JFEf8HIYNIlRidbPVBRlruDv/cs2unbjbK015EmXVexO+vAtpP2Bgvw5ffbvK84oYA
         8j70FNVMhPQzp/2XwOsGaA4eYXc4S3fcDzlXvTcg7Zy/uS9HGbqn9bcTKbc7ZTusZb/3
         ePHVLEy3E6vTsKIn/ZFca246FpDvom+EFZuQZv/JOwHVcxtJumh5oAqY+RJ5FwuXOKV3
         JNY3BE5W+sRiHnBiZtfp4rj/IsWNbcz34zf21Xsdd2MTBA2TEz3v649HfdZSFEcsWGEY
         udRf9H6mkmM+2WHmovLovcFs5w1K/sY34mSbPx1xrcewin7bphgloKh6GFMdf1RJu+/u
         qn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iGeVrl5hxkXsgar4Td7HcCi64u2Dd4z9ULlAQfYLQns=;
        b=X+rxTRkP3yMjFDlOu6NEdAyoFLTGzt+mx9TlNUTIWdR60FjAD6BDBjaDsLy12AeWst
         MWXYFDIu25a4yH8N2URLJKFWZFT2z2lPRig22mTMH1UntNeWvkTjcPX4QNOrNHvAFpUJ
         iuDij3Q/NEgbMAJJP63SanCW5d9LTnPieJdghQRc5zIG/Ex9Uz1NBXWrUSI0BsHQX/hq
         aRI3AQ+lFCcjBiW63ODDvROIkwUd+DmkQSNzF+7+i+CCxrq4+V/j/fx8q5UfAnS0XinK
         y47GVSP0UIUb8I8LcqKVnocl3FsAd7U5qfELmCPNUDRVIZreGJMHXU3zbGiEQ6E1jHH3
         vyOQ==
X-Gm-Message-State: AOAM530im/NM79lZjUYbVONNUtzXZpt216V2bAjnfWB3Fd1W81ouF7fA
        OqFaf3ANv6dRXRhccAuq6grsQsBooAL4uMeh
X-Google-Smtp-Source: ABdhPJxZgO+ounp7QfK6llV/f2bIce4l5G+anmz+/+gtcKrqTddAFswI3pA9lTdXrmHBvEsyy8r+cw==
X-Received: by 2002:a05:620a:430a:: with SMTP id u10mr48650392qko.552.1641685889090;
        Sat, 08 Jan 2022 15:51:29 -0800 (PST)
Received: from errol.ini.cmu.edu (pool-108-39-235-221.pitbpa.fios.verizon.net. [108.39.235.221])
        by smtp.gmail.com with ESMTPSA id bm12sm1807726qkb.86.2022.01.08.15.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 15:51:28 -0800 (PST)
Date:   Sat, 8 Jan 2022 18:51:26 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
Subject: Re: [PATCH v8 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Message-ID: <YdojfnOXxT0ZISNB@errol.ini.cmu.edu>
References: <20220107233458.2326512-1-gsomlo@gmail.com>
 <20220107233458.2326512-4-gsomlo@gmail.com>
 <CAHp75VcHnHpX1=ojmFnujqkf55aS1ePiVW4kKydTJQe=dXbwbQ@mail.gmail.com>
 <YdjvlA7rqQoZe44F@errol.ini.cmu.edu>
 <CAHp75Vf7o1g0FTAd+Zo6TMzDN3C2nGLhbDo0OJ9Cmwcxm=Kc8Q@mail.gmail.com>
 <YdmPho2GpVcvWUgU@errol.ini.cmu.edu>
 <CAHp75VcSenjpZdA_wujKju5rHr8bAw2VjfL8RMKb7RW6Zmz4QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcSenjpZdA_wujKju5rHr8bAw2VjfL8RMKb7RW6Zmz4QA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2022 at 07:47:32PM +0200, Andy Shevchenko wrote:
> On Sat, Jan 8, 2022 at 3:20 PM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> > On Sat, Jan 08, 2022 at 01:26:08PM +0200, Andy Shevchenko wrote:
> > > On Sat, Jan 8, 2022 at 3:57 AM Gabriel L. Somlo <gsomlo@gmail.com> wrote:
> > > > On Sat, Jan 08, 2022 at 01:54:07AM +0200, Andy Shevchenko wrote:
> > > > > On Saturday, January 8, 2022, Gabriel Somlo <gsomlo@gmail.com> wrote:
> 
> ...
> 
> > > > >     +       u32 div;
> > > > >     +
> > > > >     +       div = freq ? host->ref_clk / freq : 256U;
> > > > >
> > > > >     +       div = roundup_pow_of_two(div);
> > > > >     +       div = clamp(div, 2U, 256U);
> > > > >
> > > > > Logically seems to me that you may join these two together, because clamped
> > > > > range is power-of-2 one.
> > > >
> > > > `div` needs to be a power-of-2 when written to the LITEX_PHY_CLOCKERDIV
> > > > register (below). And clamp() will just enforce a min/max range, so if
> > > > (div = ref_clk / freq) ends up e.g., 5, I need both roundup_pow_of_two()
> > > > to bump it to 8, and clamp() to enforce that it's between 2 and 256.
> > > >
> > > > Unless you mean I should simply write it like:
> > > >
> > > >         div = clamp(roundup_pow_of_two(div), 2U, 256U);
> > > >
> > > > ... as a single line?
> > >
> > > Yes, that's what I meant.
> >
> > Turns out, clamp really hates being passed roundup_pow_of_two()
> > directly (see below). I think it's probably better if we leave
> > them as-is, to avoid going the explicit cast route which Geert
> > recommended against.
> 
> I see, then ignore my comment on this matter in v9.
> Perhaps add a comment in the code explaining that roundup_pow_of_two()
> may not be unified with clamp()?

I worry that commenting on why things are not done some other way at
that location would detract from the legibility of the code itself.

Perhaps we could use a cast after all, and write it out like this:

	div = clamp((u32)roundup_pow_of_two(div), 2U, 256U);

which compiles fine without any warnings, accomplishes your "do it in
a single line" desired behavior, and doesn't require me commenting on
which linux library functions do or don't work well with others... :)

Geert, what do you think?

Thanks,
--Gabriel
