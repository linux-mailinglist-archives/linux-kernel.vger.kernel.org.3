Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB5D595798
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbiHPKIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbiHPKID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:08:03 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB1E356F4;
        Tue, 16 Aug 2022 01:42:58 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id b2so7628325qkh.12;
        Tue, 16 Aug 2022 01:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=M8+zN5n51GohpbStdjKXmJWXHgqhXr7wmE0QoYJl1Tg=;
        b=qLuGJVydbZapmuhh/ri/mPvYA5bm4nMtIaG76TKtA3Mvo/gBhkJK17beJcQl4lBkM0
         iPBdZSSrCNgcezsRIABTJwp7UtgOhSIzqLsuYw6uKZIdWj2+EzGX4Ynvo2pcygJ3ES0H
         rNv2bDiwY+8yFgEBX8y3Q+RZ0w+7z61uHWS67T1C+ZdmOf9xIz3+Ss494E0LnAKj62KJ
         uuV7tjhnSgJ133uq7dK9dc8YkqzpGgSLl11+J0G8NNyLbKRknzb7wyR2X4f7YRD/3396
         ChRcoJ8Z8tpfDVeQs7eHQAwLSDOEU4j8m9CRydpoEnGFQI0rjqmOED+9BOVCNq8moS5U
         UQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=M8+zN5n51GohpbStdjKXmJWXHgqhXr7wmE0QoYJl1Tg=;
        b=Nepdhtws48v2xij5S/nWebWOJnxuWP4JOjF/2KqaCvOgfmk3TiLhtYBKBiom95hkNS
         gjU0XOwr5MW8JOxkNuPDG6BBnecPqoc09gvIePtGlb7iPAGaRs4Qo+5b28OYCPcgC+43
         6Pty5tXDIzbhTHaXVTpEIitd1Qn2ZlJScZDw8ffK/aZUzgt22Xf+Z/o51x/oYWOVoAqF
         gndFTmrZnjwe7UmD2gFmx9lPVUwkOnsUldY6hrO2HaZOHoRcb5eVIxDxyuyTBIZ/xz/M
         uiDUCOmdl7judNDA1Pv8TNapNmlFTMwTYeev0jkQKrr4gRq7KWUX8Nhr7Hr/7OT2JfAW
         Pinw==
X-Gm-Message-State: ACgBeo0uJw2fp/LLnGgtYGDsjU4qdXa/Lai1LTrrKIn0na9QclHQfC75
        hAcLSuZIYCKtjqJHK9m8xBDMqPvqpvdgcDp7bds=
X-Google-Smtp-Source: AA6agR4R4lk0CDBQHZmGfGnS3MaEvTJE6k0Sqbe/jCHB+ee624GaEK+KH/pS5yDyRz1iFyVysOe/Lnz9Oes4idkTrfs=
X-Received: by 2002:ae9:e311:0:b0:6ba:e711:fb27 with SMTP id
 v17-20020ae9e311000000b006bae711fb27mr11131735qkf.320.1660639377250; Tue, 16
 Aug 2022 01:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660292316.git.mazziesaccount@gmail.com>
 <166057828406.697572.228317501909350108.b4-ty@kernel.org> <YvpsRbguMXn74GhR@pendragon.ideasonboard.com>
 <Yvp1Qkuh7xfeb/B2@sirena.org.uk> <YvqV9Mq6I3gXQaf2@pendragon.ideasonboard.com>
 <20220815205857.308B1C433D6@smtp.kernel.org> <Yvq33T+XCduoqv7Z@pendragon.ideasonboard.com>
In-Reply-To: <Yvq33T+XCduoqv7Z@pendragon.ideasonboard.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 16 Aug 2022 11:42:20 +0300
Message-ID: <CAHp75VefRphjAhSmrUVC8aaAhrwMD+9Jr=OROFU-0JuNhuFYDw@mail.gmail.com>
Subject: Re: (subset) [PATCH v2 0/7] Devm helpers for regulator get and enable
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Kevin Hilman <khilman@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Michael Turq uette <mturquette@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-hwmon@vger.kernel.org, linux-clk <linux-clk@vger.kernel.org>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Robert Foss <robert.foss@linaro.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        David Airlie <airlied@linux.ie>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 8:37 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Mon, Aug 15, 2022 at 01:58:55PM -0700, Stephen Boyd wrote:
> > Quoting Laurent Pinchart (2022-08-15 11:52:36)
> > > On Mon, Aug 15, 2022 at 05:33:06PM +0100, Mark Brown wrote:

...

> > > we'll run into trouble. Supplying active high input signals
> > > to a device that is not powered can lead to latch-up, which tends to
> > > only manifest after a statistically significant number of occurrences of
> > > the condition, and can slowly damage the hardware over time. This is a
> > > real concern as it will typically not be caught during early
> > > development. I think we would still be better off with requiring drivers
> > > to manually handle powering off the device until we provide a mechanism
> > > that can do so safely in an automated way.
> >
> > Can you describe the error scenario further? I think it's driver author
> > error that would lead to getting and enabling the regulator after
> > getting and enabling a clk that drives out a clock signal on some pins
> > that aren't powered yet. I'm not sure that's all that much easier to do
> > with these sorts of devm APIs, but if it is then I'm concerned.
>
> You will very quickly see drivers doing this (either directly or
> indirectly):
>
> probe()
> {
>         devm_clk_get_enabled();
>         devm_regulator_get_enable();
> }

And how is it devm specific? If the author puts the same without devm
the ordering would be wrong, correct? devm allows us to focus on
ordering in a *single* place, which is a win. You seem to be proposing
to make a high burden on a driver's author to focus on ordering in the
*three* places. I disagree with that. Yet the driver author has to
understand many issues with any tool they use. So the root cause of
your whining is rather on the edge of documentation and education.
(Yes, I have heard about issues with object lifetime in v4l2
subdevices regarding to devm, but it seems irrelevant to devm
mechanism itself.)

> Without a devres-based get+enable API drivers can get the resources they
> need in any order, possibly moving some of those resource acquisition
> operations to different functions, and then have a clear block of code
> that enables the resources in the right order. These devres helpers give
> a false sense of security to driver authors and they will end up
> introducing problems, the same way that devm_kzalloc() makes it
> outrageously easy to crash the kernel by disconnecting a device that is
> in use.



-- 
With Best Regards,
Andy Shevchenko
