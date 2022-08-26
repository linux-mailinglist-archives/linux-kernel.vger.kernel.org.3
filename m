Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18DC5A2A21
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 16:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbiHZO4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 10:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiHZO4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 10:56:30 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D5682842
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 07:56:29 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id 10so1354869iou.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 07:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=WfP7PKK/kP/UQn6JDVR+ao9+K/wbktbl89yGlLt1XDA=;
        b=qSriLe6sGxvcFbE/UHHD2rI2XMDjAW0dHY7O7RcRp7Us3ZJw9H8hpT+s/MJgZyqjES
         riAXklRISS8D2FV5i5FXSxtAgiq7SZJTZ2osW8Z7a9i7LkvOYOTVRVTAuVxSdiS8lhQu
         4nBlp0HhwuO/O5FxkF2GOa7t+NodiQtKbTuBvAqfMKBPnjlia9SJhH1VTgzw4QlOlucO
         JNWKaV8jw4rzRhOEYM8SvQDbyVM2fnncFlNdJ45d9V+UuXFFsOEQ/WQmNTIBZo34/QVi
         3x6jHlYcMiCAH5TeYyOg9Aa90XVIZIg9PrgRDtDU+rGiMF/f6XMYWUMEFEDQRPdo5QKz
         vweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WfP7PKK/kP/UQn6JDVR+ao9+K/wbktbl89yGlLt1XDA=;
        b=M04ezvgrKqFL2VGGnScRlfgoKjec9CzIWLzu07C842UEWUGN0SmXFzFyasuUGDOGP9
         ZlGmtKByYd2erh6UgXPI4BenHl88D3JMPvoEKYkHJPMwyf3go1mLHMpeWj40EhkCDz8r
         Qm7Nn6JFeW4+WcLrug8r5yCEccjnRIBAj6IN2teOrT+DugRDUqVJAidL7nywl+tfjJs9
         e69/UvkqvmJQETG/0aGRh5vLQOIqed5E3HKH1mudhXf1F+zjom57m/6tuAd8nBSGMLDN
         ith3jsTCKd6+qG1AHIpHoWMhBrwZpgPVi4MqjtnQeQCAyc4sjyhHeOGt4qOETRD1AjiK
         uAPA==
X-Gm-Message-State: ACgBeo2LCYjCsIz97zWXWe2kTbTTLX3MtGtq2qNV8OnTS8XTsmrC3sLt
        kDv/i3UPCsAZ/Ed3M7jxcqXCKEgCEcqc2w5yGt9hng==
X-Google-Smtp-Source: AA6agR6NYFhimbin+zyrq+sDMrYVT/drrxOiPOtliWNwKfkaSwhjjkNjiz6pmebIrhxHD/9opEX+9yjdpWBkP9XvnLw=
X-Received: by 2002:a05:6638:3722:b0:349:41f1:7ff5 with SMTP id
 k34-20020a056638372200b0034941f17ff5mr4067740jav.283.1661525789304; Fri, 26
 Aug 2022 07:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
 <987d6114-5fcb-d668-3b0d-ad6d8723dfdb@tronnes.org> <20220822074800.qzyctchqn5usr55g@houat>
 <9a15b1cf-692c-1b0d-02a6-316cbd954525@gmail.com> <20220825155506.wqurh5r752qfufqs@houat>
 <18737c8a-78f4-5b9f-aea2-588bc65c13d9@gmail.com> <9d9ba040-99d7-25cb-ba10-1c132d7f7663@gmail.com>
In-Reply-To: <9d9ba040-99d7-25cb-ba10-1c132d7f7663@gmail.com>
From:   Dom Cobley <dom@raspberrypi.com>
Date:   Fri, 26 Aug 2022 15:56:18 +0100
Message-ID: <CANUESCG22TrxasYoE2U0OJ7TVzNAcs_9zkuAfBQfZrEbM4h9dg@mail.gmail.com>
Subject: Re: [PATCH v1 00/35] drm: Analog TV Improvements
To:     Mateusz Kwiatkowski <kfyatek@gmail.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
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
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2022 at 05:08, Mateusz Kwiatkowski <kfyatek@gmail.com> wrote:
> - Commenting out the pm_runtime_put() / pm_runtime_get_sync() calls in vc4_vec.c
> - Reverting this PR by Dom Cobley a.k.a. popcornmix:
>    https://github.com/raspberrypi/linux/pull/4639
>
> Either of these approaches makes VEC mode switching work again. Obviously
> neither is appropriate for a permanent solution.

Might be worth trying the latest rpi-update firmware.
There was a change that affects restoring PIXEL/VEC clocks after a
power domain cycle.
There is also a fix for a USB boot breakage.

If you still have an issue that occurs in downstream pi tree but not
upstream, then create a linux github issue.
