Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C4C567A65
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 00:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbiGEWwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 18:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbiGEWvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 18:51:42 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E8710CF;
        Tue,  5 Jul 2022 15:51:24 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so8147466wme.0;
        Tue, 05 Jul 2022 15:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=eMncdBp8XQ0HqjxrA7dE8vuHr+oeCntxs6OK8BSU4UA=;
        b=p0GCxoBhOXGEzVRl/7kwoRmj9iv9UAAyjFK+9X8YkC/a7V184Cic4V13/VKjUrmFC0
         Jdhec0cQHJFISKY/pJS5WlcNDVcyuKlAcpZogGV3N3xqpN5aQicAjQrXe465HcjAcyZb
         1ZefIOQVxetbepaef9vJpNh23Ls95lkNIqL6gEpPW/xPObVXIb7oVw18UPc0G33XBpsW
         /90Fds4o/gPkPq2KQqLkfVbPnr1g4OEfvdFbLvw07ial2JDPCYpYxm50YVKAjYl5vPUN
         bvePdNFmhEKdReGylYamqOksBAF4nw+kLy7tLm9bOuQvqnKBCATQ4Fzlrj6XT2TPVsVt
         Qs4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=eMncdBp8XQ0HqjxrA7dE8vuHr+oeCntxs6OK8BSU4UA=;
        b=2sTNLknkvlSUnSbBd6tYCYyK9TTfTgbNl66aSJMeZ0kPLc/YuFJUAUxYzBtt9Ugutu
         8u5KBNj36NoC/bXbNKt6rZ9c0YUhepk9ea8OhcGmb6vlFqB6v10d+RTchyrE9IUUMPMo
         trsSGJwSQD/hsMuRpCfbIrE+12JjKu8t8dcLouwAE119l898c8IeJLaHIr1bz86SUEcr
         XfU+U6S+pw/z5w+VViOpFlwWpqiSzcwMxxXGdX7eAcR3W3/6N5cdHsZicm6MRBRywPDY
         DSq7NtjEzUiuGNJyhL1l8kr/on4yi1wygTSXpdAJ2kYpjCYoSaoVN2iGrRQrI49S9YVJ
         RLKw==
X-Gm-Message-State: AJIora+c22/Q8ckjJ8fhhiDeUBKOjW7DGP+UnbIdoOC2Kv3HBpyaC/OR
        oqBNFndGTk/dpsFurjYbhu1mwT70WkQ=
X-Google-Smtp-Source: AGRyM1tG8eUQVdJezKwkfwBs6Ion1dhORXY3SmzfAwjIs7fstyleyel9aqN6IkiTLT2OGSoXI7mz3w==
X-Received: by 2002:a05:600c:284a:b0:3a1:996f:3cad with SMTP id r10-20020a05600c284a00b003a1996f3cadmr18214378wmb.95.1657061483016;
        Tue, 05 Jul 2022 15:51:23 -0700 (PDT)
Received: from [192.168.90.207] (214.red-83-37-4.dynamicip.rima-tde.net. [83.37.4.214])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c348100b003a03be22f9fsm19207259wmq.18.2022.07.05.15.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 15:51:22 -0700 (PDT)
Message-ID: <b9280ecbf78424882878ef2ff6c3da6671064ed5.camel@gmail.com>
Subject: Re: [PATCH v2 5/5] iio: pressure: bmp280: Adds more tunable config
 parameters for BMP380
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 06 Jul 2022 00:51:03 +0200
In-Reply-To: <CAHp75VdBv8BJVzBCMzWKpm0RrqX=K_QPQ4cgdshqXP3Uy+hVHQ@mail.gmail.com>
References: <20220704003337.208696-1-ang.iglesiasg@gmail.com>
         <CAHp75VdBv8BJVzBCMzWKpm0RrqX=K_QPQ4cgdshqXP3Uy+hVHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.module_f35+14217+587aad52) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your comments!

On Mon, 2022-07-04 at 22:08 +0200, Andy Shevchenko wrote:
> On Mon, Jul 4, 2022 at 2:41 AM Angel Iglesias <ang.iglesiasg@gmail.com> wrote:
> > 
> > Allows to configure the IIR filter coefficient and the sampling frequency
> > The IIR filter coefficient is exposed using the sysfs attribute
> > "filter_low_pass_3db_frequency"
> 
> In all your commit messages, please pay attention to English grammar.
> Here you forgot all the periods.
> 
> ...
> 
> > +       BMP380_ODR_0_0015HZ
> 
> Keep a comma here.
> 
> ...
> 
> > +       /* BMP380 devices introduce sampling frequecy configuration. See
> 
> frequency.
> 
> > +        * datasheet sections 3.3.3. and 4.3.19.
> > +        *
> > +        * BMx280 devices allowed indirect configuration of sampling
> > frequency
> > +        * changing the t_standby duration between measurements. See
> > datasheet
> > +        * section 3.6.3
> > +        */
> 
> /*
>  * Multi-line comment style
>  * example. Use it.
>  */
> 
> ...
> 
> > +               if (unlikely(!data->chip_info->sampling_freq_avail)) {
> 
> Why unlikely() ? How does this improve code generation / performance?
> 
> ...

As Jonathan Cameron sugested on a previous version of the patch, even thought
this code should be safe (as if we are checking sampling frequency is because
the sensor is a BMP380 and has that property), it would be better to have a
sanity check just to be sure the property is really available. I used unlikely
macro to take into account that the property would be almost always initialized.

Now that you mention, probably this code won't be called too often to make the
"unlikely" branching hint make a meaningful performance difference

> > +               if (unlikely(!data->chip_info->iir_filter_coeffs_avail)) {
> 
> Ditto.
> 
> ...
> 
> > +                               /*
> > +                                * Error applying new configuration. Might
> > be
> > +                                * an invalid configuration, will try to
> > +                                * restore previous value just to be sure
> 
> Missed period. Please, check all your texts (commit messages,
> comments, etc) for proper English grammar.

Apologies, I'll be more careful before sending the revised patches next time

> 
> > +                                */
> 
> ...
> 
> > +                               /*
> > +                                * Error applying new configuration. Might
> > be
> > +                                * an invalid configuration, will try to
> > +                                * restore previous value just to be sure
> 
> Ditto.
> 
> > +                                */
> 
> ...
> 
> > +                               /*
> > +                                * Error applying new configuration. Might
> > be
> > +                                * an invalid configuration, will try to
> > +                                * restore previous value just to be sure
> 
> Ditto.
> 
> > +                                */
> 
> ...
> 
> > +                               /*
> > +                                * Error applying new configuration. Might
> > be
> > +                                * an invalid configuration, will try to
> > +                                * restore previous value just to be sure
> 
> Ditto.
> 
> > +                                */
> 
> ...
> 
> > +                               /*
> > +                                * Error applying new configuration. Might
> > be
> > +                                * an invalid configuration, will try to
> > +                                * restore previous value just to be sure
> 
> Ditto.
> 
> > +                                */
> 
> Why do you need to copy'n'paste dozens of the very same comment?
> Wouldn't it be enough to explain it somewhere at the top of the file
> or in the respective documentation (if it exists)?
> 
> ...
> 
> >         u8 osrs;
> >         unsigned int tmp;
> >         int ret;
> > +       bool change, aux;
> 
> Move them up, and probably use reversed xmas tree ordering ("longest
> line first" rule).
> 
> Also should be
>   bool change = false, aux;
> 
> ...
> 
> > +       change = change || aux;
> 
> change ||= aux;

I think I'm missing something, do you mean to use '|='?

> 
> And in other cases.
> 
> ...
> 
> > +               /* cycle sensor state machine to reset any measurement in
> > progress
> > +                * configuration errors are detected in a measurment cycle.
> 
> measurement
> 
> > +                * If the sampling frequency is too low, it is faster to
> > reset
> > +                * measurement cycle and restart measurements
> > +                */
> 
> Completely wrong comment style. Be consistent and follow the common
> standards in the Linux kernel.
> 
> ...
> 
> > +               /* wait before checking the configuration error flag.
> > +                * Worst case value for measure time indicated in the
> > datashhet
> 
> datasheet
> 
> > +                * in section 3.9.1 is used.
> > +                */
> 
> Ditto.
> 

