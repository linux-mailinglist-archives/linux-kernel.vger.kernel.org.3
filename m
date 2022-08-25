Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9FA5A168A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 18:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242994AbiHYQSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 12:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242986AbiHYQR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 12:17:56 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA11946DB2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:17:54 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id l8so11378094lfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 09:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=b3UlTD9H49Yb98sjK5W5/C8aUP8qYfkMb4AST0yEJIw=;
        b=RJQaploezQ64sQU0Ot6zPj8xVA+m7I0+MIlJYds5HBoULqJXc7p9yh24SdJBjERKH1
         /G2S8P1E0T41DmocxAC14hvkpg53cM/qXp4Wm/pObVX9U/mITxz+4Z8iYlD2ScBXje8p
         p1SHmf2LwMfvY9zCffDhWddepz3T1jkUAAwq2AeWRIuuW12G+OtVw0j7utFTYWVv7L0l
         aTgz1abc3GTnxgWC45ygjbDRLmxYIvyY6C8MsSJtwb0o4A3K9UNKtz97pM9bktptfhLg
         MUIUSyjpMXc362+1MySlwOAQ3ZlX1JjCHs8wMj+NzkAtU35Vhr/n4QFliSiSL9ZvOt/k
         tuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=b3UlTD9H49Yb98sjK5W5/C8aUP8qYfkMb4AST0yEJIw=;
        b=f52+ERnSveLETHbhSggci1mOBiYSrD/puJNwvdQCWToZFdNV9bZbafx1zYOB+xQflk
         ggLUVngwmYO9WBrdL9kZN/vKAcpuPZ173MMi733HpOw7IVKAxXdcFtb2QUYqZT7fcomc
         thbYSoyOn6/nWIG8801yggailT/X5xrqMJAzLgqoy3fxf3COBqzYu+WUjTG85V/8EYgO
         xAjD6m6VBEJzJRapUK6Zbwb8KCuJPXIjS222WaMLL4zLdS6ZpZz+EPu4kHNCBVMmo7ik
         wufAR+WpETsXxX6l/sIRlFJ7iCDzjMPcNlWcC/gEJQT1+nKGm8uYtdSswVwnD0n2d/38
         yvZA==
X-Gm-Message-State: ACgBeo2ZP8LYQZnJMcQbnWpNsEIOVCyT9CCIMpUTTATyYdtZmxt5MvEk
        ZPSGQOpVTzif/ThrZQk/WcU=
X-Google-Smtp-Source: AA6agR5laMtLRk7Pd92ffYg5nd9Khm1va5h/vwpwYSvwp25wKzThzGRCS5LT/uIn6MFQ4uf63wGXTA==
X-Received: by 2002:a05:6512:692:b0:492:ece0:32e5 with SMTP id t18-20020a056512069200b00492ece032e5mr1522974lfe.636.1661444273058;
        Thu, 25 Aug 2022 09:17:53 -0700 (PDT)
Received: from [10.10.53.53] (81-18-220-16.static.chello.pl. [81.18.220.16])
        by smtp.googlemail.com with ESMTPSA id u6-20020a05651206c600b00492e570e036sm573621lff.54.2022.08.25.09.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 09:17:52 -0700 (PDT)
Message-ID: <18737c8a-78f4-5b9f-aea2-588bc65c13d9@gmail.com>
Date:   Thu, 25 Aug 2022 18:17:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 00/35] drm: Analog TV Improvements
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
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
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        Dom Cobley <dom@raspberrypi.com>
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech>
 <987d6114-5fcb-d668-3b0d-ad6d8723dfdb@tronnes.org>
 <20220822074800.qzyctchqn5usr55g@houat>
 <9a15b1cf-692c-1b0d-02a6-316cbd954525@gmail.com>
 <20220825155506.wqurh5r752qfufqs@houat>
From:   Mateusz Kwiatkowski <kfyatek@gmail.com>
In-Reply-To: <20220825155506.wqurh5r752qfufqs@houat>
Content-Type: text/plain; charset=UTF-8
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

Hi Maxime,

W dniu 25.08.2022 o 17:55, Maxime Ripard pisze:
> Hi Mateusz,
>
> On Mon, Aug 22, 2022 at 10:57:26AM +0200, Mateusz Kwiatkowski wrote:
>> Hi Maxime,
>>
>> I tried testing and reviewing your changes properly over the last weekend, but
>> ultimately ran into this ("flip_done timed out" etc.) issue and was unable to
>> mitigate it, at least so far. This seems to pop up every time I try to change
>> modes in any way (either change the TV norm, or just try doing
>> "xrandr --output Composite-1 --off" followed by bringing it back on; it also
>> means that the Pi goes unusable when the DE's screen saving routine kicks in).
>>
>> I'm using a Pi 4, and it works with the rpi-5.13.y branch
>> https://github.com/raspberrypi/linux, but seemingly nothing newer.
>> I specifically tried rpi-5.14.y, rpi-5.15.y and rpi-5.19.y - rpi-5.15.y,
>> which is the current main branch in Raspberry Pi OS, seems to be broken since
>> forever; at least since my patches (originally written for 5.10) landed there.
>>
>> I'll try identifying the issue further, possibly later today, and maybe check
>> the rpi-6.0.y branch as well.
>
> I've tried it this, and I can't reproduce it here. But I'm curious, how
> did you apply this series? rpi-5.13.y is probably full of conflicts
> everywhere?

I applied your patches onto rpi-5.15.y. There were conflicts, but they seemed
relatively minor. I'm not sure if I did a good job at resolving them - I ran
into various problems trying to test your changes, but I chose not to criticize
you before making sure that it's really due to your changes, or without some
remarks more constructive than "doesn't work" ;-)

I can push my rebase onto some Github fork if you're interested.

I was able to work around some of those problems, and also saw that some
of them were already mentioned by other reviewers (such as the generic modes
not matching due to the aspect ratio setting).

Ultimately I got stuck on this bug, so I put testing this series on hold
in favor of debugging the bigger issue. So far unfortunately no luck with it.

I did not try rebasing your changes onto 5.13 or older.

> Maxime

Best regards,
Mateusz Kwiatkowski
