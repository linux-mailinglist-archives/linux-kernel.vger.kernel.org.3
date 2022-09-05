Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1AF5AD77B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 18:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiIEQcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 12:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiIEQcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 12:32:20 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D0A2A960
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 09:32:18 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id x10so9756562ljq.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 09:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date;
        bh=8JQHR0mNkkvaucEp4HNFvrtWVwipxgdCyYirWkcxCuc=;
        b=Ee8/zXiC17K5Rmn0dM8r0JytBnfg1FnzFfKZcmoJMYt08MtgAEUEjpKH7+0UHsqlkK
         BZrCCHBnA1Je5o+/sxNlA3yrl0TxM37U7XpZXjbsaVxHKMl2x7PzYQchiiwPobO+z7V/
         tYJCFJd1YCvEbeeLM6BvAS/M1DUr6tpSFJVdgoRwA8WStFNY9E6PPHdk4RZZCOrggakT
         xyQ8/6DOwLr6S51gainQauwtIl7r4PsEHnn/94yga+F5jpf0cp7C0OxDPl+JWqQDMoGv
         UZySK3bX2kiLPPNYAc06FY4U1q0dxZf5LlWu/claShZQeiMPrvC2bab0MTV9I+5YA40i
         L12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=8JQHR0mNkkvaucEp4HNFvrtWVwipxgdCyYirWkcxCuc=;
        b=vddds149QsyZOeHcfeeZmchKo0g4tfCYKvmZnVk1bAu2oGhf7BdiB3HVM+PZ5f0xzk
         HYC3fuS1Zxxm/Wa1tZmVe81yEk33o5nekYz++RAVcD0apY/H8JpgKC1hMBHnx4YW2sJQ
         pVAcXkegW4DEoWlr4itnWoS/O8H0C5Eitc/1r5VrYQ18xXTaVnlU+ZZFfc4HUhVFJuU/
         GszC1smxTVK5MaMIUjdQxiJMeLNx+i2TnmrAgrOSAY+H9opkxszoitgVPUAe6YWBYFx8
         eYK20YvjSxbsxtUgDxykb8RSFAq3roDfNb8qAONTY6eNEwUM2VTd2GTCE41XI9HNzxl1
         IPYA==
X-Gm-Message-State: ACgBeo1bGSkGnspeFGAEKRiSeNKZX1sWBeFsTEq0XOGZLBHlCQMt+DyA
        Gwh156snJpi44kJ5UMzsXsc=
X-Google-Smtp-Source: AA6agR47yvdHHgnlIjy9Ip2njnz0g5/SwgXMzTGVjcmNgzpxzvtvdxNNmmfmzBYcTnu1KYoufiDMaA==
X-Received: by 2002:a2e:88d2:0:b0:263:2c63:d784 with SMTP id a18-20020a2e88d2000000b002632c63d784mr11481762ljk.12.1662395536908;
        Mon, 05 Sep 2022 09:32:16 -0700 (PDT)
Received: from ?IPV6:2a02:a31a:a240:1700:9c45:8fa1:8ce7:8852? ([2a02:a31a:a240:1700:9c45:8fa1:8ce7:8852])
        by smtp.googlemail.com with ESMTPSA id q13-20020a056512210d00b004946a758d21sm1235189lfr.161.2022.09.05.09.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 09:32:16 -0700 (PDT)
From:   Mateusz Kwiatkowski <kfyatek@gmail.com>
X-Google-Original-From: Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>
Message-ID: <6ac67d1f-e5b5-2687-372f-4146eed5cc5d@gmail.com>
Date:   Mon, 5 Sep 2022 18:32:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH v2 10/41] drm/modes: Add a function to generate analog
 display modes
Content-Language: pl
To:     Maxime Ripard <maxime@cerno.tech>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Karol Herbst <kherbst@redhat.com>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Emma Anholt <emma@anholt.net>, Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Dom Cobley <dom@raspberrypi.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nouveau Dev <nouveau@lists.freedesktop.org>,
        linux-sunxi@lists.linux.dev
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
 <20220728-rpi-analog-tv-properties-v2-10-459522d653a7@cerno.tech>
 <242d272b-5b79-986c-9aaf-64e62f6b37ff@gmail.com>
 <CAMuHMdWq3aOO4-2AReDeaC2VBJb=QJF2dTMZP=DGmwCg6ZOffA@mail.gmail.com>
 <20220905133251.js26hxdosibx4r4i@houat>
In-Reply-To: <20220905133251.js26hxdosibx4r4i@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

W dniu 5.09.2022 o 15:32, Maxime Ripard pisze:
> Hi,
>
> On Wed, Aug 31, 2022 at 10:14:28AM +0200, Geert Uytterhoeven wrote:
>>>> +enum drm_mode_analog {
>>>> +    DRM_MODE_ANALOG_NTSC,
>>>> +    DRM_MODE_ANALOG_PAL,
>>>> +};
>>>
>>> Using "NTSC" and "PAL" to describe the 50Hz and 60Hz analog TV modes is common,
>>> but strictly speaking a misnomer. Those are color encoding systems, and your
>>> patchset fully supports lesser used, but standard encodings for those (e.g.
>>> PAL-M for 60Hz and SECAM for 50Hz). I'd propose switching to some more neutral
>>> naming scheme. Some ideas:
>>>
>>> - DRM_MODE_ANALOG_60_HZ / DRM_MODE_ANALOG_50_HZ (after standard refresh rate)
>>> - DRM_MODE_ANALOG_525_LINES / DRM_MODE_ANALOG_625_LINES (after standard line
>>>   count)
>>
>> IMHO these are bad names, as e.g. VGA640x480@60 is also analog, using
>> 60 Hz and 525 lines.  Add "TV" to the name?
>>
>>> - DRM_MODE_ANALOG_JM / DRM_MODE_ANALOG_BDGHIKLN (after corresponding ITU System
>>>   Letter Designations)
>>
>> Or DRM_MODE_ITU_*?
>> But given the long list of letters, this looks fragile to me.
>
> Does it matter at all? It's an internal API that isn't exposed at all.
> I'd rather have a common name that everyone can understand in this case
> rather than a *perfect* name where most will scratch their head
> wondering what it's about.

You may have a point. But in that case, maybe it'd make sense to at least add
a short comment explaining what do you mean by "NTSC" and "PAL" in this context?

Best regards,
Mateusz Kwiatkowski
