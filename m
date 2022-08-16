Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC6F5953A1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbiHPHWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiHPHW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:22:26 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E68E2B70BD;
        Mon, 15 Aug 2022 21:56:12 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id z20so9551441ljq.3;
        Mon, 15 Aug 2022 21:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc;
        bh=lMyaBQ0fr/YKfcqNoaKSdb+50RM2Rxj1DLsmzLOg6p8=;
        b=emj3c4qKkUjUv1uibUM0Ft8DTfEO05AQs/3Y741be7NMkNUqfjGZwGCKNZo9C6YjXp
         T3u8ogp+Q7xyqUvWTbVxqcfKvlVXs+sCdEW176mhvN95YWDcTH1MCuzscHr20UM4t23y
         efx6c0daYiXNg01uKsfggL1TIi4sG62wT7fq7xNMdYWmSyv0IojrLQ3X+x3JlfiYjCWI
         ZGleJlTBA7imnc87Mtsd2wKxuRqiB4CfXoOM/VC02Ai37op0ZH3k+3vNM5TFazrPwDbX
         I3K6wSQIq8cyMpVj2t+/iVXSTMsuGrDBGJEDknJ3KmY9XUsqIPVIorSVNOoEmEoQm85s
         ld9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=lMyaBQ0fr/YKfcqNoaKSdb+50RM2Rxj1DLsmzLOg6p8=;
        b=06RuMdOREB1iZHynztVX70X9jzVEPb5+aCMjJLwDUrBp6brrkz54u0d/NP1XjA1t0r
         vLTPtDXbYl3lNx4dprlUjMiOz4fmj+mpgH+MixdP8qHqgzKCDBI3e6fCEgcRX2hOc/Ky
         3FJU9dr/881+QVIaX3facFlua5Prv566fzjbCWTzsz7nuy7/8cqKskEbK1N0RpOsxu8j
         eRPp2iHplznsh6R8X9qNb6E92hKQRWRa+dmxGf8+oMU2BZHD9Ni+snK3r1Kn8FdyscL5
         0ikcCRUc3aNZfyg7bF56N//ky0+qbt8M2cT6OCtW7aUQnAR9XCmWZxRSGdh2MSFFJdTC
         7snw==
X-Gm-Message-State: ACgBeo2PFMiyiGOQqi6dB1A261Fp8aoAnk9y3qZimBklcpmSZ7lp31Fl
        0oXLo7Gn4s2PKG/nXPkB6+c=
X-Google-Smtp-Source: AA6agR5Now0GlaC9p5MWRyZT/Uc6WkRd+5NRB4I7ljhPTH6IshCkE/HR/M28GX+goQncDQyVAAYQYQ==
X-Received: by 2002:a05:651c:1241:b0:261:9313:9cb9 with SMTP id h1-20020a05651c124100b0026193139cb9mr1021791ljh.213.1660625769185;
        Mon, 15 Aug 2022 21:56:09 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16ee:fa00::9? (dc73szyyyyyyyyyyyyyft-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::9])
        by smtp.gmail.com with ESMTPSA id w9-20020ac24429000000b0048a7b1530cesm1254427lfl.284.2022.08.15.21.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 21:56:08 -0700 (PDT)
Message-ID: <57c312b3-ca5b-6efb-6356-43b6513a0c88@gmail.com>
Date:   Tue, 16 Aug 2022 07:56:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        dri-devel@lists.freedesktop.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-amlogic@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
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
        linux-hwmon@vger.kernel.org, linux-clk@vger.kernel.org,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        Robert Foss <robert.foss@linaro.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        David Airlie <airlied@linux.ie>, linux-iio@vger.kernel.org
References: <cover.1660292316.git.mazziesaccount@gmail.com>
 <166057828406.697572.228317501909350108.b4-ty@kernel.org>
 <YvpsRbguMXn74GhR@pendragon.ideasonboard.com>
 <Yvp1Qkuh7xfeb/B2@sirena.org.uk>
 <YvqV9Mq6I3gXQaf2@pendragon.ideasonboard.com>
 <20220815205857.308B1C433D6@smtp.kernel.org>
 <Yvq33T+XCduoqv7Z@pendragon.ideasonboard.com>
 <YvrO+velKdYdGVve@sirena.org.uk>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: (subset) [PATCH v2 0/7] Devm helpers for regulator get and enable
In-Reply-To: <YvrO+velKdYdGVve@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi dee Ho Mark, Laurent, Stephen, all

On 8/16/22 01:55, Mark Brown wrote:
> On Tue, Aug 16, 2022 at 12:17:17AM +0300, Laurent Pinchart wrote:
>> On Mon, Aug 15, 2022 at 01:58:55PM -0700, Stephen Boyd wrote:
> 
>> You will very quickly see drivers doing this (either directly or
>> indirectly):
> 
>> probe()
>> {
>> 	devm_clk_get_enabled();
>> 	devm_regulator_get_enable();
>> }
> 
>> Without a devres-based get+enable API drivers can get the resources they
>> need in any order, possibly moving some of those resource acquisition
>> operations to different functions, and then have a clear block of code
>> that enables the resources in the right order.

I agree. And I think that drivers which do that should stick with it. 
Still, as you know the devm-unwinding is also done in well defined 
order. I believe that instead of fighting against the devm we should try 
educate people to pay attention in the order of unwinding (also when not 
handled by the devm. Driver writers occasionally break things also w/o 
devm for example by freeing resources needed by IRQ handlers prior 
freeing the IRQ.)

If "purging" must not be done in reverse order compared to the 
aquisition - then one should not use devm. I know people have done 
errors with devm - OTOH, I've seen devm also fixing bunch of errors.

>> These devres helpers give
>> a false sense of security to driver authors and they will end up
>> introducing problems, the same way that devm_kzalloc() makes it
>> outrageously easy to crash the kernel by disconnecting a device that is
>> in use.

I think this is going a bit "off-topic" but I'd like to understand what 
is behind this statement? From device-writer's perspective - I don't 
know much better alternatives to free up the memory. I don't see how 
freeing stuff at .remove would be any better? As far as I understand - 
if someone is using driver's resources after the device has gone and the 
driver is detached, then there is not much the driver could do to 
free-up the stuff be it devm or not? This sounds like fundamentally 
different problem (to me).

> TBH I think the problem you have here is with devm not with this
> particular function.

I must say I kind of agree with Mark. If we stop for a second to think 
what would the Laurent's example look like if there were no 
devm_regulator_get_enable() provided. I bet the poor driver author could 
have used devm_clk_get_enabled() - and then implemented a .remove for 
disabling the regulator. That would be even worse, right?

> That's a different conversation, and a totally
> valid one especially when you start looking at things like implementing
> userspace APIs which need to cope with hardware going away while still
> visible to userspace.

This is interesting. It's not easy for me to spot how devm changes 
things here? If we consider some removable device - then I guess also 
the .remove() is ran only after HW has already gone? Yes, devm might 
make the time window when userspace can see hardware that has gone 
longer but does it bring any new problem there? It seems to me devm can 
make hitting the spot more likely - but I don't think it brings 
completely new issues? (Well, I may be wrong here - wouldn't be the 
first time :])

> It's *probably* more of a subsystem conversation
> than a driver one though, or at least I think subsystems should try to
> arrange to make it so.


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

Discuss - Estimate - Plan - Report and finally accomplish this:
void do_work(int time) __attribute__ ((const));
