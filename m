Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7004048CAB5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 19:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356198AbiALSKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 13:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356107AbiALSJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 13:09:43 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76140C029834;
        Wed, 12 Jan 2022 10:08:59 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id t66so4212333qkb.4;
        Wed, 12 Jan 2022 10:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EDpP5BkSfVrXQLoiBPnrUZ5VNaZ5uqmL8NCRcHOHSTU=;
        b=evpWdIcOMt/XbPkRX8hDk8EuJ6MGM4xP1Yycp07PlzohqInsQKq/B8z0K26p+ReePN
         W4Eih0x5CIc5IGt7qwT0kLd+nXO/7mKLMnHgRCCwKoROykLnsMdqGjhwt7pGYl6E38KI
         ViqEiM7lbNHcsKJI/pa+ONpKsNLl0b0gIShOywK4VeYyWXr4tgtwgJoH0Yo2mGZ7xeRf
         IItt7AsVH6BPtGZ/Sw2+rFl04U2jgVmC/XiadHJ70BiTh76yRWOOoLzlZiLiQWjuUJSz
         21Vu1luQisRIf4o56lJ9uu0Szl9NI3ozQqgcKdZFLALYmfj26OrPFOaqtXX/GFuz2bl9
         paJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EDpP5BkSfVrXQLoiBPnrUZ5VNaZ5uqmL8NCRcHOHSTU=;
        b=J/7VudIMrZOVf7J5Ga8IbUTRyfLSl+j2HP7HeoIJsXXfqtnTnR4Htu5NRIhDqMPKsY
         QlzHF+I3oxfITheIPUvLQNnFDr8CN9frdyVX40rzTE/02m51SP4L0SQUCDwLb9YeUAJA
         YAxPCPRaIzaKVy8lRHZYsTYrqSrmSwCDu09BiIb3FWDlJgFUYGkw4u1vzC4W+0jsN1NK
         ci2MTyuPsf5SlAdCpgk7fRW0DSt29sAqTaBT+pjV8ltlU7RBfAJy8F4l57C8Bw+CEJgi
         aPHQHwhkfZraTGcL31Q6wTbYEmbLQreiVmtkZtBqlFCmIw4skm350QB1oiBuBF0mLaLx
         XvnQ==
X-Gm-Message-State: AOAM531oylTxF1QOz4h5Vu2EevAzTF3RdxxAWvZf+PAhEzQRCbcDLvxB
        fen9NjpWL2KagBdGK7LRZSM=
X-Google-Smtp-Source: ABdhPJyvrDQMsomsglymirlbslr4rZRTSffkBUkLDpkWF/2B360yFmtcd7R23vLgS20F4HB+HS2WdA==
X-Received: by 2002:a37:a006:: with SMTP id j6mr693999qke.11.1642010938520;
        Wed, 12 Jan 2022 10:08:58 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id z5sm285546qti.57.2022.01.12.10.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 10:08:58 -0800 (PST)
Date:   Wed, 12 Jan 2022 13:08:50 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org, andy.shevchenko@gmail.com, hdanton@sina.com
Subject: Re: [PATCH v5 3/3] mmc: Add driver for LiteX's LiteSDCard interface
Message-ID: <Yd8ZMtLINkLVNARv@glsvmlin.ini.cmu.edu>
References: <20211215130711.111186-1-gsomlo@gmail.com>
 <20211215130711.111186-4-gsomlo@gmail.com>
 <CAPDyKFqo5sZy8aVbOcfS_cxT9T5r214GKCL-FKRg_0P0yQJTFQ@mail.gmail.com>
 <YdOUbYpGFNyxz3iD@errol.ini.cmu.edu>
 <CAPDyKFohOHYu_bdXsAYvDmMLqnGUW=9pG+yJDwP5-db1B6F1Dw@mail.gmail.com>
 <Yd4JdBArPn9rBj5b@errol.ini.cmu.edu>
 <CAPDyKFq18AWsaWHcEkU6H1Sh4NsqRfUeQhbRz9MorGfnKzxHwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFq18AWsaWHcEkU6H1Sh4NsqRfUeQhbRz9MorGfnKzxHwQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 11:24:34AM +0100, Ulf Hansson wrote:
> [...]
> 
> > > > > [...]
> > > > >
> > > > > > +
> > > > > > +       mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
> > > > >
> > > > > I noticed that you use these hard coded values and don't really care
> > > > > to manage voltage changes via ->set_ios().
> > > > >
> > > > > Rather than doing it like this, I would prefer if you can hook up a
> > > > > fixed vmmc regulator in the DTS. Then call mmc_regulator_get_supply()
> > > > > to fetch it from here, which will let the mmc core create the
> > > > > mmc->ocr_avail mask, based upon the voltage level the regulator
> > > > > supports.
> > > > >
> > > > > This becomes more generic and allows more flexibility for the platform
> > > > > configuration.
> > > >
> > > > The LiteSDCard "hardware" (i.e., *gateware*) does not allow modification
> > > > or selection of voltage from the software side. When a CMD8 is issued,
> > > > the "voltage supplied" bit pattern is expected to be '0001b', which per
> > > > the spec means "2.7-3.6V".
> > >
> > > If you provide a range (2.7-3.6V), that means that your hardware
> > > supports the entire range, not just one single part of it.
> >
> > The "gateware" (open source migen/verilog at
> > https://github.com/enjoy-digital/litesdcard)
> > supports any value provided by the underlying FPGA dev board
> > (typically 3.3v) -- by not attempting to manage it in any way.
> >
> > SD media presumably doesn't care as long as voltage is somewhere
> > within 2.7-3.6V (at least that's how I read the spec, there's only
> > one register value representing anything within that range).
> >
> > > >
> > > > I tried adding this to the overall DTS:
> > > >
> > > >         vreg_mmc: vreg_mmc_3v {
> > > >                 compatible = "regulator-fixed";
> > > >                 regulator-min-microvolt = <3300000>;
> > > >                 regulator-max-microvolt = <3300000>;
> > > >         };
> > > >
> > > > and then added a reference to it to the LiteSDCard "mmc0" node in DTS,
> > > > like so:
> > > >
> > > >         mmc0: mmc@12005000 {
> > > >                 compatible = "litex,mmc";
> > > >                 reg = <0x12005000 0x100>,
> > > >                         <0x12003800 0x100>,
> > > >                         <0x12003000 0x100>,
> > > >                         <0x12004800 0x100>,
> > > >                         <0x12004000 0x100>;
> > > >                 reg-names = "phy", "core", "reader", "writer", "irq";
> > > >                 clocks = <&sys_clk>;
> > > >                 vmmc-supply = <&vreg_mmc>; /* <-------- HERE !!! */
> > > >                 interrupt-parent = <&L1>;
> > > >                 interrupts = <4>;
> > > >         };
> > > >
> > > > Finally, I replaced the hardcoded setting of `mmc->ocr_avail` with a
> > > > call to `mmc_regulator_get_supply(mmc)`. Now, I get a bunch of timeouts
> > > > during attempts to send e.g., CMD8 and CMD55.
> > > > (going for 3200000 and 3400000 for min- and max-microvolt, respectively,
> > > >  -- or anything else in the allowed 2.7-3.6 range -- doesn't help either).
> > > >
> > > > I might be doing something subtly wrong in the way I set things up
> > > > above, but it feels a bit overengineered, and IMHO fragile.
> > >
> > > At a quick glance, the above looks correct to me. Maybe there is
> > > something wrong with the code in the driver instead?
> >
> > After some more hacking, I learned that:
> >
> >         - an additional `regulator-name` line
> >           (e.g. `regulator-name = "vreg_mmc";`) is required
> >
> >         - setting `regulator-always-on;` seems to help reduce attempts
> >           by the kernel to "manage" the regulator, but does not appear
> >           to be required
> >
> > In other words:
> >
> >         ...
> >         vreg_mmc: vreg_mmc {
> >                 compatible = "regulator-fixed";
> >                 regulator-name = "vreg_mmc";
> >                 regulator-min-microvolt = <3300000>;
> >                 regulator-max-microvolt = <3300000>;
> >                 regulator-always-on;
> >         };
> >         ...
> >
> > Additionally, CONFIG_REGULATOR=y and CONFIG_REGULATOR_FIXED_VOLTAGE=y
> > *MUST* be enabled in the kernel's .config file, to prevent either
> > litex_mmc_probe() from being deferred, or mmc_regulator_get_supply()
> > from simply returning 0 without having set mmc->ocr_avail to anything
> > at all!
> >
> > Presumably this would also mean either `select REGULATOR_FIXED_VOLTAGE`
> > or `depends on REGULATOR_FIXED_VOLTAGE` in the mmc driver's Kconfig
> > entry.
> 
> Yep, that's correct.
> 
> If you don't like to manage that dependency in the Kconfig, an option
> is to check if mmc->ocr_avail is zero and if so, we could log a
> message *and* assign mmc->ocr_avail a default value.
> 
> >
> > Predictably, the "regulator-[min|max]-microvolt = <3300000>" setting
> > gets us
> >
> >         ocr_avail == MMC_VDD_32_33 | MMC_VDD_33_34
> >
> > > >
> > > > OTOH, going all out and setting:
> > > >
> > > >         /* allow for generic 2.7-3.6V range, no software tuning available */
> > > >         mmc->ocr_avail = MMC_VDD_27_28 | MMC_VDD_28_29 | MMC_VDD_29_30 |
> > > >                          MMC_VDD_30_31 | MMC_VDD_31_32 | MMC_VDD_32_33 |
> > > >                          MMC_VDD_33_34 | MMC_VDD_34_35 | MMC_VDD_35_36;
> > > >
> > > > seems to work just fine... :) Please do let me know what you think!
> > >
> > > No, this isn't the way we want it to work. That's because it means
> > > that we would lie to the card about what voltage range the HW actually
> > > supports.
> > >
> > > It's better to let the DTS file give that information about the HW.
> >
> > I may be needlessly concerned, but it feels a bit weird to me to drag
> > in CONFIG_REGULATOR_FIXED_VOLTAGE as an added dependency for what is
> > ultimately a roundabout way of setting a constant... :)
> 
> The point is, it shouldn't really be a constant set by the driver,
> because it would mean initialising a card under potentially wrong
> conditions.
> 
> However, I am fine assigning it a default value as a fallback and best
> effort, if it turns out that DT didn't provide us information about
> what the HW is capable of.
> 
> >
> > Thanks in advance for any additional clue!
> 
> Looks like there are two options, just pick one of them, then I am happy. :-)

Sounds like a plan! I'll send out lucky v13 once I've had a chance to
test it on my FPGA, later this evening.

Thanks again,
--Gabriel
