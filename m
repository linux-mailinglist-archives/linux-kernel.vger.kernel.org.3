Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75475A3EB7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 19:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiH1RGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 13:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiH1RG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 13:06:28 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1E22714B
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 10:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VB+iShHArjJp41BB5dqP4/59fbHxHAh8j4VWglqFn7E=; b=U1fK7sWUEHCoKWz84mzGfnRtEQ
        UrW5fXCEBL4DXz/NpfWik98RVrmZoEVwrwKWPWqQ0D7qmdd5DmT5KDBvnK7BW36hkK2ZBwHN6yVBQ
        add4aNGQ0gHcc64K2WMXXFCgY/ZT2ZWuJK7zFKRwTtuWXhz3HEcrGpvUxT3KW0F4xQSlzDG+x9qrb
        a6lUJ/EOI1KyvNFg+KoWOfNGa4TOD9W0e1vfCMmejMqaO4B5WgI9T3oUX781k9Pz/ajsBNJwi/AkG
        e6l5w3Yg/B8Vlc/dOtdyU30knuOvm5MIZcPp7eyelDP/khmC6e1nNYIFzqScoH8s7FpI/pgIDN42X
        onXXhHAg==;
Received: from [2a01:799:961:d200:cca0:57ac:c55d:a485] (port=60461)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1oSLjq-0002PX-L9; Sun, 28 Aug 2022 19:06:22 +0200
Message-ID: <3b6ec59d-4fad-52f9-e96a-55a25ff3cfb4@tronnes.org>
Date:   Sun, 28 Aug 2022 19:06:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1 34/35] drm/modes: Introduce the tv_mode property as a
 command-line option
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
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
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        Dom Cobley <dom@raspberrypi.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
 <20220728-rpi-analog-tv-properties-v1-34-3d53ae722097@cerno.tech>
 <eedb1a86-c1fb-cc76-2a43-4ed349d7d826@tronnes.org>
 <20220824154543.bdtpz2evwzsjrdrz@houat>
 <3cc08f9d-9f01-b771-c16f-ea95acd7e7cd@tronnes.org>
 <20220826064646.ug2djacis7whybpd@houat>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220826064646.ug2djacis7whybpd@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 26.08.2022 08.46, skrev Maxime Ripard:
> On Thu, Aug 25, 2022 at 02:41:27PM +0200, Noralf Trønnes wrote:
>> Den 24.08.2022 17.45, skrev Maxime Ripard:
>>> Hi Noralf,
>>>
>>> On Sat, Aug 20, 2022 at 10:18:47PM +0200, Noralf Trønnes wrote:
>>>> Den 29.07.2022 18.35, skrev Maxime Ripard:
>>>>> Our new tv mode option allows to specify the TV mode from a property.
>>>>> However, it can still be useful, for example to avoid any boot time
>>>>> artifact, to set that property directly from the kernel command line.
>>>>>
>>>>> Let's add some code to allow it, and some unit tests to exercise that code.
>>>>>
>>>>> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>>>>>
>>>>
>>>> In the subject it says "tv_mode property", but the property is called
>>>> "tv norm", so the option should be tv_norm?
>>>
>>> Yeah... I don't know. mode is taken but it's obviously the best name. So
>>> I went with norm to avoid the (internal) conflict but I left mode for
>>> the user facing property.
>>>
>>> I'm not sure what's best here, or maybe we can pick another name entirely?
>>>
>>
>> Why not just call it "tv mode" or even better "TV Mode". The state
>> member can be called tv_mode, but the mode_config member will need a
>> temporary name until the "mode" property is removed. tv_tv_mode or maybe
>> connector_tv_mode?
> 
> Yeah, that seems like a good idea. Would legacy_tv_mode work for you?
> 

Oh yeah, renaming the "mode" property, that works fine.

Noralf.
