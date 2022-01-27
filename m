Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4FF49D817
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 03:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbiA0Cd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 21:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbiA0CdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 21:33:24 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0B5C06161C;
        Wed, 26 Jan 2022 18:33:24 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id 71so1420410qkf.4;
        Wed, 26 Jan 2022 18:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8GyXdLlhnsgNAVFJ9za+5cXDmt66YlUHV1TYza3TEgY=;
        b=OiuOyVWWHTywzF33MqVpuIVLx3MWnw2IEbxayj/a4C8eU5bB71UOltlNY7/B0MZcw4
         FhIHZXi0ddnycalGF0F//cwAGqCl9/u6tAGyfE5pV43+SfuVhdPq61c7qiaqjN6HO0SH
         HmHYAfKj+iw7iJdXlPsrddMGyzZ5CbqpBXNbWSabd7OpOD1JdG0um9hQA0qHtPZheptq
         ElkB2gTdnXZOw0UZ3AvcmH3cXWPxWjdwD4a8wA2nCI1US04lzvkEBbEnYQUj080WDdSv
         fG90gu5lPy0TDLo4GimpPXzjHTh4FOaa7xpdtPKIdeSWJrh+pav0Gcz9MnVWbW86NK5w
         bCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8GyXdLlhnsgNAVFJ9za+5cXDmt66YlUHV1TYza3TEgY=;
        b=yP3FRKeT5a2HcWZ5l4wGgv5mk+CMLI6lBUp2/4/tPaeoo25h9IgCKotVFl6NqlCFiY
         +1ZvRlpoaqGibUSKxuPfJzr7SiBY1XD+cV1dX0XXFc6CZWuENNNBjzCad2y/AZ2vHD4d
         qqk/VN2OjOLupNTxseuybQP/P45D1EQvJVOtoFEMaoSgkKHy9Vpex9ksfk2a6+o7xv4P
         gawEbuPbqaMhf64sgLDZpuZBvSlAtLGw3jmRwJLEaUasLnSqqncI1FMxKgEqSC3ZsOof
         zuC0X4Eh80MHU+x4rqbntqh0igAp46bligNbkiUBvMggaEFqJSENuDJEweLxROVN9wX8
         pUDA==
X-Gm-Message-State: AOAM531Wrgixe0aAeUj7Pg++RUnssFH+tTZHKhxhD20wHYJ1/Mh7amBi
        8uYDoAhcWPHuEVQfsn4c9/SPGSkM9xs=
X-Google-Smtp-Source: ABdhPJwHLCBho7YHFxTCSZTDMKMGTVRgogiyPY7ZU9TCq5x0GSVY896MyQ2D5p+qAztp0Hn8O0t6CA==
X-Received: by 2002:a05:620a:4594:: with SMTP id bp20mr1212315qkb.381.1643250803205;
        Wed, 26 Jan 2022 18:33:23 -0800 (PST)
Received: from Dell-Inspiron-15 (c-73-149-219-1.hsd1.ma.comcast.net. [73.149.219.1])
        by smtp.gmail.com with ESMTPSA id r7sm562904qti.69.2022.01.26.18.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 18:33:22 -0800 (PST)
Date:   Wed, 26 Jan 2022 21:33:19 -0500
From:   Ben Wolsieffer <benwolsieffer@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linus.walleij@linaro.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] ARM: dts: qcom: basic HP TouchPad support
Message-ID: <YfIEb+BSNI3maH79@Dell-Inspiron-15>
References: <cover.1643075547.git.benwolsieffer@gmail.com>
 <9f19df2a0017b71547445ac34df221e827c45bd0.1643075547.git.benwolsieffer@gmail.com>
 <YfDKTGQDh3tDMECz@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfDKTGQDh3tDMECz@builder.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 10:13:00PM -0600, Bjorn Andersson wrote:
> On Mon 24 Jan 20:07 CST 2022, Ben Wolsieffer wrote:
> 
> > Modify the Dragonboard device tree to support the most basic hardware on
> > the HP TouchPad. The headphone UART port and eMMC are supported.
> > 
> 
> We typically don't have one commit for the cloning and then one to
> update the content, in particular since your diffstat became rather
> weird.
> 
> That said, got some comments below, things that I wouldn't have spotted
> if you sent this as just a new file.

Ok, I'll squash those for v2.

> > -			dragon_sdcc1_pins: sdcc1 {
> > +			/* eMMC pins, all 8 data lines connected */
> > +			emmc_pins: sdcc1 {
> >  				mux {
> >  					pins = "gpio159", "gpio160", "gpio161",
> >  					     "gpio162", "gpio163", "gpio164",
> >  					     "gpio165", "gpio166", "gpio167",
> >  					     "gpio168";
> > -					     function = "sdc1";
> > +					function = "sdc1";
> >  				};
> >  				clk {
> >  					pins = "gpio167"; /* SDC1 CLK */
> [..]
> > @@ -171,205 +77,33 @@ pinconf {
> >  				};
> >  			};
> >  
> > -			dragon_gsbi12_i2c_pins: gsbi12_i2c {
> > -				mux {
> > -					pins = "gpio115", "gpio116";
> > -					function = "gsbi12";
> > -				};
> > -				pinconf {
> > -					pins = "gpio115", "gpio116";
> > -					drive-strength = <16>;
> > -					/* These have external pull-up 4.7kOhm to 1.8V */
> > -					bias-disable;
> > -				};
> > -			};
> > -
> > -			/* Primary serial port uart 0 pins */
> > -			dragon_gsbi12_serial_pins: gsbi12_serial {
> > +			/* Headphone UART pins */
> > +			headphone_uart_pins: gsbi12_serial {
> >  				mux {
> >  					pins = "gpio117", "gpio118";
> >  					function = "gsbi12";
> >  				};
> > -				tx {
> > -					pins = "gpio117";
> > -					drive-strength = <8>;
> > -					bias-disable;
> > -				};
> >  				rx {
> > -					pins = "gpio118";
> > +					pins = "gpio117";
> >  					drive-strength = <2>;
> >  					bias-pull-up;
> >  				};
> > -			};
> 
> I find it hard to conclude what the resulting snippet is from this
> chunk, did rx swap place from gpio118 to gpio117?

Yes, I made that swap based on comments in the downstream kernel, but,
now that I think about it, there's a good chance those comments are
wrong. The downstream kernel configures both pins as 8 mA drive with no
bias, so no one would ever notice that they were swapped. I think I'll
swap them back in v2. In practice I think the pin configuration makes
little difference, but should I keep the config from the Dragonboard or
match the downstream kernel?

> [..]
> > @@ -814,14 +378,16 @@ l20 {
> >  					bias-pull-down;
> >  				};
> >  				l21 {
> > -					// 1.1 V according to schematic
> >  					regulator-min-microvolt = <1200000>;
> >  					regulator-max-microvolt = <1200000>;
> >  					bias-pull-down;
> > -					regulator-always-on;
> > +					/*
> > +					 * RPM driver can't handle always-on regulators that are
> > +					 * supplied by regulators initialized after them.
> > +					 */
> 
> That looks like an oversight that should be corrected, perhaps it needs
> similar attention that was given to the smd-rpm driver recently?
> 
> But this makes me wonder, how can this work on the other board? Linus?

It probably doesn't work as intended, but doesn't cause a major
problem either. I only noticed the failure while looking through dmesg.
As soon as the RPM driver probe gets to an always on regulator with a not
yet initialized supply, devm_regulator_register() returns -EAGAIN, it
breaks out of the loop, and the rest of the regulators don't get
initialized. The initialization is retried several times during boot
(because of -EAGAIN), but always fails at the same spot. This doesn't
actually seem to cause any visible problem, other than errors in dmesg.

I tried making the driver continue to initialize the rest of the
regulators even if one fails with -EAGAIN, but still return -EAGAIN from
probe(). My thought was that this would cause probe to be retried later,
and initialization would succeed now that the supply regulators were
available, but instead it seems to hang before any console output.

I don't know if the regulator supplies are correct either, because the
downstream kernel doesn't specify them. I also know next to nothing about
the RPM, so I would definitely appreciate a review from someone familiar
with it.

> > +					// regulator-always-on;
> >  				};
> >  				l22 {
> > -					// 1.2 V according to schematic
> >  					regulator-min-microvolt = <1150000>;
> >  					regulator-max-microvolt = <1150000>;
> >  					bias-pull-down;
> > @@ -845,7 +411,7 @@ l25 {
> >  				};
> >  
> >  				s0 {
> > -					// regulator-min-microvolt = <500000>;
> > +					// regulator-min-microvolt = <800000>;
> >  					// regulator-max-microvolt = <1325000>;
> 
> This looks like the full range the regulator could do, do you see a
> reason for documenting that here? Unless there's a good reason I think
> you should leave the commented min/max out.

That was just copied from the Dragonboard DTS, with updated values from
the downstream kernel. I assume some kind of voltage/frequency scaling
driver is needed to actually support a range of voltages here, so I
guess the comments could serve as a reference if that was ever
implemented.

