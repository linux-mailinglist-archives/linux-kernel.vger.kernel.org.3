Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B175A199D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 21:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243192AbiHYTgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 15:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241530AbiHYTgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 15:36:46 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B538B9595
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 12:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hNcXx9nN3QJm/KwwCuUmxJMM/1rNwvQsLqXj+GDGgR0=; b=iAUKq3byUHJUQwjEQdZa4HBdm+
        TnfaOzLFJUDgeEpKCKO7CR9l31QS6Y2TXLx4DoFuYrKWIC4U2+1whY9M0Ya8Eqwj2bvuceT6a7eUh
        snsQja2LrBdkoQsAzUMoXYkjsFgbTxRikuj7dBpISa9HVStMVuOMUkWpV9n4FYoRhbj+cWYUqOhrm
        0f6lxRNMD1+HBAcD2tQz4QuLakPByIEbiEE9cLt2iZQVyp4LxiQlASHmFPyNTfdM+HXDiXxr2L/8+
        +orYmoEZ4/+KkxlQIGBEaFLbduE06L0rynjVgF/4aQ7JsX56hYzkrEls1sJSbV0B1wAZNjC+cnBND
        FTfSSQwQ==;
Received: from [2a01:799:961:d200:cca0:57ac:c55d:a485] (port=57533)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1oRIeg-000615-7S; Thu, 25 Aug 2022 21:36:42 +0200
Message-ID: <32c0b057-02fe-4818-7020-7b8f4942aed6@tronnes.org>
Date:   Thu, 25 Aug 2022 21:36:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v1 00/35] drm: Analog TV Improvements
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
 <987d6114-5fcb-d668-3b0d-ad6d8723dfdb@tronnes.org>
 <20220822074800.qzyctchqn5usr55g@houat>
 <2f279dd9-9a6b-8bd2-9d54-b7bd39852ba9@tronnes.org>
 <20220825162140.oaob4szbssf6cuvq@houat>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <20220825162140.oaob4szbssf6cuvq@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 25.08.2022 18.21, skrev Maxime Ripard:
> On Mon, Aug 22, 2022 at 03:21:29PM +0200, Noralf Trønnes wrote:
>>
>>
>> Den 22.08.2022 09.48, skrev Maxime Ripard:
>>> Hi,
>>>
>>> On Sun, Aug 21, 2022 at 06:33:12PM +0200, Noralf Trønnes wrote:
>>>> Den 29.07.2022 18.34, skrev Maxime Ripard:
>>>>> Hi,
>>>>>
>>>>> Here's a series aiming at improving the command line named modes support,
>>>>> and more importantly how we deal with all the analog TV variants.
>>>>>
>>>>> The named modes support were initially introduced to allow to specify the
>>>>> analog TV mode to be used.
>>>>>
>>>>> However, this was causing multiple issues:
>>>>>
>>>>>   * The mode name parsed on the command line was passed directly to the
>>>>>     driver, which had to figure out which mode it was suppose to match;
>>>>>
>>>>>   * Figuring that out wasn't really easy, since the video= argument or what
>>>>>     the userspace might not even have a name in the first place, but
>>>>>     instead could have passed a mode with the same timings;
>>>>>
>>>>>   * The fallback to matching on the timings was mostly working as long as
>>>>>     we were supporting one 525 lines (most likely NSTC) and one 625 lines
>>>>>     (PAL), but couldn't differentiate between two modes with the same
>>>>>     timings (NTSC vs PAL-M vs NSTC-J for example); 
>>>>>
>>>>>   * There was also some overlap with the tv mode property registered by 
>>>>>     drm_mode_create_tv_properties(), but named modes weren't interacting
>>>>>     with that property at all.
>>>>>
>>>>>   * Even though that property was generic, its possible values were
>>>>>     specific to each drivers, which made some generic support difficult.
>>>>>
>>>>> Thus, I chose to tackle in multiple steps:
>>>>>
>>>>>   * A new TV norm property was introduced, with generic values, each driver
>>>>>     reporting through a bitmask what standard it supports to the userspace;
>>>>>
>>>>>   * This option was added to the command line parsing code to be able to
>>>>>     specify it on the kernel command line, and new atomic_check and reset
>>>>>     helpers were created to integrate properly into atomic KMS;
>>>>>
>>>>>   * The named mode parsing code is now creating a proper display mode for
>>>>>     the given named mode, and the TV standard will thus be part of the
>>>>>     connector state;
>>>>>
>>>>>   * Two drivers were converted and tested for now (vc4 and sun4i), with
>>>>>     some backward compatibility code to translate the old TV mode to the
>>>>>     new TV mode;
>>>>>
>>>>> Unit tests were created along the way. Nouveau, ch7006 and gud are
>>>>> currently broken for now since I expect that work to be reworked fairly
>>>>> significantly. I'm also not entirely sure about how to migrate GUD to the
>>>>> new property.
>>>>>
>>>>> Let me know what you think,
>>>>> Maxime
>>>>>
>>>>
>>>> I don't know if it's related to this patchset or not, but I do get this:
>>>>
>>>> pi@pi4t:~ $ sudo dmesg -C && sudo modprobe -r vc4 && sudo modprobe vc4
>>>> && dmesg
>>>> [  430.066211] Console: switching to colour dummy device 80x30
>>>> [  431.294788] vc4-drm gpu: bound fe400000.hvs (ops vc4_hvs_ops [vc4])
>>>> [  431.295115] vc4-drm gpu: bound fec13000.vec (ops vc4_vec_ops [vc4])
>>>> [  431.295467] vc4-drm gpu: bound fe004000.txp (ops vc4_txp_ops [vc4])
>>>> [  431.295804] vc4-drm gpu: bound fec12000.pixelvalve (ops vc4_crtc_ops
>>>> [vc4])
>>>> [  431.298895] [drm] Initialized vc4 0.0.0 20140616 for gpu on minor 0
>>>> [  441.444250] vc4-drm gpu: [drm] *ERROR* [CRTC:68:crtc-1] flip_done
>>>> timed out
>>>> [  441.446529] Console: switching to colour frame buffer device 90x30
>>>> [  451.684321] vc4-drm gpu: [drm] *ERROR* flip_done timed out
>>>> [  451.684347] vc4-drm gpu: [drm] *ERROR* [CRTC:68:crtc-1] commit wait
>>>> timed out
>>>> [  461.924255] vc4-drm gpu: [drm] *ERROR* flip_done timed out
>>>> [  461.924281] vc4-drm gpu: [drm] *ERROR* [CONNECTOR:45:Composite-1]
>>>> commit wait timed out
>>>> [  472.164006] vc4-drm gpu: [drm] *ERROR* flip_done timed out
>>>> [  472.164031] vc4-drm gpu: [drm] *ERROR* [PLANE:61:plane-1] commit wait
>>>> timed out
>>>> [  482.403877] vc4-drm gpu: [drm] *ERROR* flip_done timed out
>>>> [  482.403903] vc4-drm gpu: [drm] *ERROR* Timed out waiting for commit
>>>> [  492.643799] vc4-drm gpu: [drm] *ERROR* [CRTC:68:crtc-1] flip_done
>>>> timed out
>>>> [  492.647073] vc4-drm gpu: [drm] fb0: vc4drmfb frame buffer device
>>>
>>> Module unloading/reloading has been janky for a while.
>>>
>>> I've fixed it up recently but it doesn't surprise me that there's still
>>> some situation that won't work. Is it on a Pi3?
>>>
>>
>> It's a Pi4.
> 
> With which kernel? I just tested it on last next and it seems to work ok
> there. I've fixed it recently though, so it's only in drm-misc-next and
> linux-next at the moment.
> 

I'm on a week old drm-misc-next.

What's your setup so I can try that.

This is mine:
https://gist.github.com/notro/41c59d77c3022dc6d931d4f9547c4ea6

I can't see anything that should differ significantly from what you
could have done. Only maybe that I use the latest firmware and perhaps
you've got a 64-bit kernel.

Noralf.
