Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E4658C8EF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242838AbiHHNDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237483AbiHHNDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:03:49 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EEFC19
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 06:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sm06QmZFBfpM+CVfRuCk8ilv4zuVsgxBKZv+QTHnC4M=; b=BVZBner5wyuQ/jxHxNSURaeBFT
        6RsH7EuNQGZjRvNdavFNOfqtEG4CRh+R2BOZEdE1+T6IuZljSjAqEhzbC1V/nMbKSXMnnvHdyWui6
        4CwfkVM3X2vz7xOaFhlW8B6oYb4d8NdWucidNGTzEk/ApPUJNowlxL4E9p05qVujRoqmb69hltCRI
        PSv6GAgOKCUc03fviQwuObft6lQa79J75srgEbnHBpxwjZ7mwkLF6o0zWQ1FaRjpLdrO5LtNuR9P2
        QkzN8ELFv8r4Oj80NxqyuDAwswPeUSjSny7v0USaDhIYUjnVnKs7McWrM6h56c5Jc0tG3dcBeSGtX
        swidYSWw==;
Received: from [2a01:799:961:d200:c193:6d77:c9c8:8] (port=65002)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1oL2Q5-00019X-Ru; Mon, 08 Aug 2022 15:03:45 +0200
Message-ID: <14fb938c-f9db-bbea-3dd1-96fc409155f8@tronnes.org>
Date:   Mon, 8 Aug 2022 15:03:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 00/35] drm: Analog TV Improvements
To:     Maxime Ripard <maxime@cerno.tech>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        Dom Cobley <dom@raspberrypi.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 29.07.2022 18.34, skrev Maxime Ripard:
> Hi,
> 
> Here's a series aiming at improving the command line named modes support,
> and more importantly how we deal with all the analog TV variants.
> 
> The named modes support were initially introduced to allow to specify the
> analog TV mode to be used.
> 
> However, this was causing multiple issues:
> 
>   * The mode name parsed on the command line was passed directly to the
>     driver, which had to figure out which mode it was suppose to match;
> 
>   * Figuring that out wasn't really easy, since the video= argument or what
>     the userspace might not even have a name in the first place, but
>     instead could have passed a mode with the same timings;
> 
>   * The fallback to matching on the timings was mostly working as long as
>     we were supporting one 525 lines (most likely NSTC) and one 625 lines
>     (PAL), but couldn't differentiate between two modes with the same
>     timings (NTSC vs PAL-M vs NSTC-J for example); 
> 
>   * There was also some overlap with the tv mode property registered by 
>     drm_mode_create_tv_properties(), but named modes weren't interacting
>     with that property at all.
> 
>   * Even though that property was generic, its possible values were
>     specific to each drivers, which made some generic support difficult.
> 
> Thus, I chose to tackle in multiple steps:
> 
>   * A new TV norm property was introduced, with generic values, each driver
>     reporting through a bitmask what standard it supports to the userspace;
> 
>   * This option was added to the command line parsing code to be able to
>     specify it on the kernel command line, and new atomic_check and reset
>     helpers were created to integrate properly into atomic KMS;
> 
>   * The named mode parsing code is now creating a proper display mode for
>     the given named mode, and the TV standard will thus be part of the
>     connector state;
> 
>   * Two drivers were converted and tested for now (vc4 and sun4i), with
>     some backward compatibility code to translate the old TV mode to the
>     new TV mode;
> 
> Unit tests were created along the way. Nouveau, ch7006 and gud are
> currently broken for now since I expect that work to be reworked fairly
> significantly. I'm also not entirely sure about how to migrate GUD to the
> new property.
> 

I have looked at gud and I think the future proof solution is to add a
new TV_NORM property to the GUD protocol and add backwards compatibility
for the GUD_TV_MODE property (just for the modes that Raspberry Pi
supports since the gadget driver is out of tree). I don't bother
supporting the tv.mode property in userspace (I haven't seen anything
that uses the property).

I have written up most of the host driver changes but I have to do the
gadget side as well to make sure it works. I'll post some patches when
I'm done. In hindsight I should have used a bitmask for the TV standards
in the first place ;)

Noralf.
