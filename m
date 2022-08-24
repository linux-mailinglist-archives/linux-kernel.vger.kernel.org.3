Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754E65A0011
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 19:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239789AbiHXRId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 13:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237537AbiHXRIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:08:31 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D1D7B797
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:08:30 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id d8so12498158lfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc;
        bh=d+0sUP6TSKAiALBIXDZGYdNvi1F0yA0KJXnjoK2G2T8=;
        b=o3Gvvtf7KSV4tiw6VYPIJEAh479Uovr253pXVInVVaECnk6jFELDM6fxh9wl8+9FsW
         17R1qztaIRSST5xXH/PTplmH3+scKpeeAADuFYik2/15xjAz/2n3RdtU80ceqJ/sYCkr
         o7OX+zS4VJqL8EQDEgFSWpqS8tRSAK3rfe4sEEwa1m1m1ThQK4aElW43U7P1TaQIbJiB
         p2lv2+LNFuRXaqnOJbnZNRnrqXJgL66+fz6VBLS9wCEwnmuOM48+6upvyp2JhhRlI1Wr
         jjCcDSezsqKhjLcL8vsnBJkcFKCwQKpT9QQ2M9OJA6RYaN0Wz7tvgxK55ayzuGzRplq9
         KOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc;
        bh=d+0sUP6TSKAiALBIXDZGYdNvi1F0yA0KJXnjoK2G2T8=;
        b=EPPGJDZ1TgQE0bM5i4OuFsF91CoMi5PrpNULJDorwDj4dqJNufvWz+ba/YthdcjaOM
         ACavtvQYzblL6oQTCYBU9USSIjK0Bf2voRcIUSL/9Vf5ywPWkwBPrck/oJ5vJS6a9P/q
         s/01PWLkb2lc+Uwb/v5AukJzSGENHP5PtnaHFQDMfrUWs3wy1fF9Y5UJakFcB1heT6Tr
         HtXmgfLwuYmKF39THlQGDG5PJUcBwK0+RzkE2PpERHb2sc8mW+pYmWaYO8rNZJjUKF6x
         +eucImCtY4B54zo8JihcwjF2upL0LXs2Yizc1jeo3pMukSr9GsSHaYAov1KqKHEV+eQo
         M4ng==
X-Gm-Message-State: ACgBeo2/5gwf9FgBLOvfbffhfdEXqWwPl7YWhtrQruXZ5bOXKGlhcXqR
        /7jFISuuqbqH5076ZNy1liQ=
X-Google-Smtp-Source: AA6agR5cz1tKv0yfrrQuMBGx5Y9mKvqvHWQ2qHORxA31eXjsfhACgWXyuZD/7Wc/aX7wwd3M3XFp3w==
X-Received: by 2002:a05:6512:22d3:b0:48c:df73:d0a4 with SMTP id g19-20020a05651222d300b0048cdf73d0a4mr10044284lfu.584.1661360908835;
        Wed, 24 Aug 2022 10:08:28 -0700 (PDT)
Received: from [10.10.53.53] (81-18-220-16.static.chello.pl. [81.18.220.16])
        by smtp.googlemail.com with ESMTPSA id j24-20020ac253b8000000b00492df78f311sm13975lfh.57.2022.08.24.10.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 10:08:28 -0700 (PDT)
From:   Mateusz Kwiatkowski <kfyatek@gmail.com>
X-Google-Original-From: Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>
Message-ID: <baee6917-dada-9ab2-9244-d6679e91033f@gmail.com>
Date:   Wed, 24 Aug 2022 19:08:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 34/35] drm/modes: Introduce the tv_mode property as a
 command-line option
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
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
        linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        Dom Cobley <dom@raspberrypi.com>
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
 <20220728-rpi-analog-tv-properties-v1-34-3d53ae722097@cerno.tech>
 <eedb1a86-c1fb-cc76-2a43-4ed349d7d826@tronnes.org>
 <20220824154543.bdtpz2evwzsjrdrz@houat>
In-Reply-To: <20220824154543.bdtpz2evwzsjrdrz@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime & Noralf,

W dniu 24.08.2022 o 17:45, Maxime Ripard pisze:
> Hi Noralf,
>
> On Sat, Aug 20, 2022 at 10:18:47PM +0200, Noralf Trønnes wrote:
>> Den 29.07.2022 18.35, skrev Maxime Ripard:
>>> Our new tv mode option allows to specify the TV mode from a property.
>>> However, it can still be useful, for example to avoid any boot time
>>> artifact, to set that property directly from the kernel command line.
>>>
>>> Let's add some code to allow it, and some unit tests to exercise that code.
>>>
>>> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>>>
>>
>> In the subject it says "tv_mode property", but the property is called
>> "tv norm", so the option should be tv_norm?
>
> Yeah... I don't know. mode is taken but it's obviously the best name. So
> I went with norm to avoid the (internal) conflict but I left mode for
> the user facing property.
>
> I'm not sure what's best here, or maybe we can pick another name entirely?

I think "standard" and "system" are also fairly common names for this property.

I once had an old multi-standard Sharp CRT TV that allowed manually selecting
the expected color encoding (PAL/SECAM/NTSC/NTSC-443), and the relevant button
on the remote was labeled "SYSTEM".

V4L2 calls this "standard", see include/uapi/linux/videodev2.h, compare with
v4l2_std_id, V4L2_STD_* etc.

BTW, maybe reusing those V4L2 constants, or aligning the numerical values,
would make some sense?

>
> Maxime

Best regards,
Mateusz Kwiatkowski
