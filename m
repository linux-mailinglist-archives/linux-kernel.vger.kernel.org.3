Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564BE5B1B75
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 13:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiIHLbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 07:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiIHLbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 07:31:40 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1539CD50A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 04:31:39 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id p5so6478776ljc.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 04:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date;
        bh=Pe/I+w+iO2pwgJXl8T4sC38en64C2l3oERN/xelPq20=;
        b=V4sxO+75nLSa4ntHYBDYJK7NyyItm+0ZuqLo4c8gxEblOEQGHihNxBzP1ywfeAMYWP
         A6gbXFUa+oFissD0CGGT9qZjiT57qAO/LcaelBX/nJDUId7ciewfaXSWVpw6M29eM72Z
         q0uRM6YPLLMRxsucdQdim3Ufr73pusbVeQPwM6bfhtQ87iWKRwLxmE3cBBQxY4H9VZIf
         pQM3O1hiKQXGJzsJvyphYtgmgFfp7lXMh65ITn1H0JW5pYN/LHrKWP/ORM0dXXFdRZOf
         6SddjB7+yub2ELpu5aTF2EbiCg6LgO8CuZOMv2TnRuzKXVquW5W4obBFXEUnssRCyD4H
         ta2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=Pe/I+w+iO2pwgJXl8T4sC38en64C2l3oERN/xelPq20=;
        b=ZvC3UKI+kc6ge2qpG2SKByKU5W/EswQfRroPSolPHwZFdxrUz4fwatQU57ivHTppCu
         aSFtOjUJBbXg3RtQ4d+Ybuff7loYoa+JkcISGXuYKSMwfYKqIkgNHxlHdSH02a/lqkG5
         dO6C7XZwUCrEorzdcdCR2hPMNkyQ7HRiTZW2U0I+monFIMYKJplzqdiJKKv3RppT4mDi
         GNvs5zMkPMR+7dSmyzIkWQgXNRK+wDee+hXLvm1165Se/S6laPlPrQBNQC0H8/Qj02No
         dkRu+4mZIpVfNObFsBjYEL1BOLJbx6g+tkb2ymT6v0OYVqKRQvVTR+SwI9+2jCS3prsW
         2ZgQ==
X-Gm-Message-State: ACgBeo2p9FnuUFeXV7Bj4jVrCITYqJG39/Lmg+iE4EMeH4v2IbzQkr9Z
        ktZwAaG0+DNnzugsYkuQzJA=
X-Google-Smtp-Source: AA6agR7hqDYt7a6c30Zzx2HM7qo0bpBArfiiaiAMashCn8pCJhXeqGkG5/jvmcd17AYfIZXNcSfBMg==
X-Received: by 2002:a2e:b16c:0:b0:266:175c:cd54 with SMTP id a12-20020a2eb16c000000b00266175ccd54mr2425837ljm.278.1662636698015;
        Thu, 08 Sep 2022 04:31:38 -0700 (PDT)
Received: from [10.10.53.53] (81-18-220-16.static.chello.pl. [81.18.220.16])
        by smtp.googlemail.com with ESMTPSA id z20-20020a195e54000000b00497a879e552sm930968lfi.291.2022.09.08.04.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 04:31:37 -0700 (PDT)
From:   Mateusz Kwiatkowski <kfyatek@gmail.com>
X-Google-Original-From: Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>
Message-ID: <aa510ec2-a72d-364b-424e-816872ab6923@gmail.com>
Date:   Thu, 8 Sep 2022 13:31:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 32/41] drm/vc4: vec: Convert to the new TV mode
 property
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
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
        Emma Anholt <emma@anholt.net>, Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org, Dom Cobley <dom@raspberrypi.com>,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        linux-sunxi@lists.linux.dev,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
 <20220728-rpi-analog-tv-properties-v2-32-459522d653a7@cerno.tech>
 <199cf4b3-8ace-e047-3050-b810cf0c6b63@tronnes.org>
 <20220908112312.hlb7mzneuxnethhr@houat>
In-Reply-To: <20220908112312.hlb7mzneuxnethhr@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

W dniu 08.09.2022 o 13:23, Maxime Ripard pisze:
> Hi Noralf,
>
> On Tue, Aug 30, 2022 at 09:01:08PM +0200, Noralf Trønnes wrote:
>>> +static const struct drm_prop_enum_list tv_mode_names[] = {
>>
>> Maybe call it legacy_tv_mode_enums?
>>
>>>
>>> +    { VC4_VEC_TV_MODE_NTSC, "NTSC", },
>>>
>>> +    { VC4_VEC_TV_MODE_NTSC_J, "NTSC-J", },
>>>
>>> +    { VC4_VEC_TV_MODE_PAL, "PAL", },
>>>
>>> +    { VC4_VEC_TV_MODE_PAL_M, "PAL-M", },
>>
>> If you use DRM_MODE_TV_MODE_* here you don't need to translate the value
>> using the switch statement in get/set property, you can use the value
>> directly to get/set tv.mode.
>
> I'm sorry, I'm not quite sure what you mean by that. If we expose the
> DRM_MODE_TV_MODE_* properties there, won't that change the values the
> userspace will need to use to set that property?

I'd just like to point out that if numerical values of these enums are your
concern, then you're (or perhaps I am ;) already breaking this by adding new
modes in patch 33/41 in this series.

And the values (and names!) added by that patch (33/41) don't match those
currently used by the downstream version
(https://github.com/raspberrypi/linux/blob/rpi-5.15.y/drivers/gpu/drm/vc4/vc4_vec.c).
If any userspace software is manipulating this property, it's most likely
targeting the downstream code. But since you're not aiming for consistency with
that, I was under the impression that compatibility isn't a concern.

Best regards,
Mateusz Kwiatkowski
