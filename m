Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC16B4CC266
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234863AbiCCQPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiCCQPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:15:03 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF5817EDBB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 08:14:16 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t11so8618938wrm.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 08:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=EiWdlBLeSii7BF7fhJgTvosOIK7psLAdb2tPEkPGzBs=;
        b=QW/zlldr+uaWGiEiITw09O4hMbDaLBGe9FbVKjB3fazYjRDu5FD1BfaXucr96ZnFzS
         Cl3JmBLbkHbq2S7E0S1FmtCkHI1xJkxUdhnYHqlvB2CaHbRF8G8KAUjlH+o2+UMzUZkG
         dpTtxwPAj5Znpf7dV8QFAx7oMp2lDPblYbQJrRf8zI6KKFXkMQqAwKgolo/VonTyNFxE
         wpAZQffnlsjr6YnzqqnZ622LOTUwmU6lNHxiwT9njPq8QbDEd2/+AjR/MT4EeApZhL7E
         FSoV5nx4wtupNerja8ZvTYrr6Jy5G6haumorkvRuLYPs9lbmhhJpOFlu5249XdQfuaG9
         A0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=EiWdlBLeSii7BF7fhJgTvosOIK7psLAdb2tPEkPGzBs=;
        b=ETbHIhioueUgZ39/pAPcR7A6/qiYyN9FvwBIgRSpAMnodtsJt3G1cSYi56OHc1FyKd
         3G4QeQ9KLBCMdRse01896rbMvFcxMN4iD1e4nBTVSejNXSaSmpaW7Mivxa228v1w2VLD
         Gv+/OnDxpDczcYmwrF92tntKHWfeorAI9Xb/MnFQF3bLQeIufxCNxq6LV7m3o8Fr5KJZ
         +29ss+pBGFcMW/3xTgusa0wzccPX/foZj+c4ugkR3uiJE6eRviYrfbzMmJuRd3zuD98N
         DaSMyz4HaqSihJWwKja/g0htHF1R3JbMSTHyLEAPQEsUIMAEeR01EWvqmOIPyqFVsmzD
         7FqQ==
X-Gm-Message-State: AOAM532DrnoysuA/+EPA7QX8/tTmJK00a4nwdQQKJzQV4dHt9MFPDJI3
        F8TIsG6ZmFnAhcgg+dfaFIHpZw==
X-Google-Smtp-Source: ABdhPJzT3sVllSZTbfjXxQrZ/T7Xkb8VIdjboVZuvHel+BUPVFd0faUP7glzn6sHWW/L1+1zkbYvAg==
X-Received: by 2002:a5d:64cb:0:b0:1ef:d80d:8129 with SMTP id f11-20020a5d64cb000000b001efd80d8129mr14374253wri.21.1646324055016;
        Thu, 03 Mar 2022 08:14:15 -0800 (PST)
Received: from ?IPV6:2001:861:44c0:66c0:2f5b:3553:677f:a39? ([2001:861:44c0:66c0:2f5b:3553:677f:a39])
        by smtp.gmail.com with ESMTPSA id l11-20020a5d674b000000b001f047c49e99sm2388307wrw.2.2022.03.03.08.14.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 08:14:14 -0800 (PST)
Message-ID: <15d2625a-b569-0841-cc0e-ace7cffcd8de@baylibre.com>
Date:   Thu, 3 Mar 2022 17:14:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v16 4/4] drm/bridge: dw-hdmi: fix bus formats negotiation
 for 8 bit modes
Content-Language: en-US
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Paul Boddie <paul@boddie.org.uk>,
        Maxime Ripard <maxime@cerno.tech>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        linux-mips <linux-mips@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Robert Foss <robert.foss@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
References: <cover.1645895582.git.hns@goldelico.com>
 <169afe64b4985c3f420177cd6f4e1e72feeb2449.1645895582.git.hns@goldelico.com>
 <5da069b6-8a99-79c2-109c-c85715165857@baylibre.com>
 <E0D3B7E8-0C8D-4119-8267-0556AB921B24@goldelico.com>
 <fca28594-8d4e-dd2f-93a0-a052cb888d90@baylibre.com>
 <75CBD357-577A-402D-9E3B-DBE82A84BC43@goldelico.com>
 <4cb08b5d-c1ec-f2b4-a107-63a771146ec0@baylibre.com>
 <598F3A49-9CE2-4C59-95D4-CDA888A3B3BF@goldelico.com>
 <3625b23b-9718-640a-1aac-0b30773a26ab@baylibre.com>
 <E95145AB-DEFC-419D-B926-B0BAF0985D09@goldelico.com>
 <d75cd860-2a4c-6f81-b5d0-dc75f37b7150@baylibre.com>
 <890BB299-AB92-4177-83E8-74C8AA551AF1@goldelico.com>
 <1E255C32-3B9C-4556-A4A7-0B575DF0F915@goldelico.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <1E255C32-3B9C-4556-A4A7-0B575DF0F915@goldelico.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/03/2022 16:37, H. Nikolaus Schaller wrote:
> Hi Neil,
> 
>> Am 03.03.2022 um 12:45 schrieb H. Nikolaus Schaller <hns@goldelico.com>:
>>
>> Hi Neil,
>>
>>> Am 03.03.2022 um 12:42 schrieb Neil Armstrong <narmstrong@baylibre.com>:
>>>
>>>> So how can we get that merged? IMHO your proposal should be before we add ingenic-dw-hdmi.
>>>> If you have a version with proper commit message I can add it to the beginning of my
>>>> seried and include it in a v17. Or if you get yours merged to drm-misc/drm-misc-next I
>>>> can build on top.
>>>
>>> You can add it in your v17 patchset with my authorship and my Signed-off-by tag + yours.
>>>
>>> As commit message something like :
>>> ====================
>>> drm/bridge: dw-hdmi: handle unusable or non-configured CSC module
>>>
>>> The dw-hdmi integrates an optional Color Space Conversion feature used
>>> to handle color-space conversions.
>>>
>>> On some platforms, the CSC isn't built-in or non-functional.
>>>
>>> This adds the necessary code to disable the CSC functionality
>>> and limit the bus format negotiation to force using the same
>>> input bus format as the output bus format.
>>> ====================
>>
>> Fine! Will do.
> 
> I was a little too early.
> 
> While preparing the patches I found that I still had the hack to force
> sink_is_hdmi = false in my test branch. Sorry for that.
> 
> Removing this made the panel go black again, even with your latest
> proposal.
> 
> So I looked deeper into your patch and it seems to influence the
> input formats only in dw_hdmi_bridge_atomic_get_input_bus_fmts()?
> 
> While the problem I see is with output formats and we had worked on
> modifying dw_hdmi_bridge_atomic_get_output_bus_fmts().

I just looked and the ingenic drm driver first bridge uses drm_atomic_helper_bridge_propagate_bus_fmt()
which is why this last patch doesn't work, and perhaps would be the main issue here.

Indeed, the core will loop on all the possible output formats for your HDMI monitor :
- MEDIA_BUS_FMT_UYVY8_1X16
- MEDIA_BUS_FMT_YUV8_1X24
- MEDIA_BUS_FMT_RGB888_1X24

For each of these, the dw-hdmi dw_hdmi_bridge_atomic_get_input_bus_fmts() will
return the same format + the possible CSC transformations, for example
for MEDIA_BUS_FMT_UYVY8_1X16 will return as possible inputs:
- MEDIA_BUS_FMT_UYVY8_1X16
- MEDIA_BUS_FMT_YUV8_1X24
- MEDIA_BUS_FMT_RGB888_1X24

The the core will call for each of the those the .atomic_get_input_bus_fmts of
the Ingenic DRM driver, but by using drm_atomic_helper_bridge_propagate_bus_fmt()
it basically sets a pass-through and accepts any format.

This is why MEDIA_BUS_FMT_UYVY8_1X16 is selected, but in this case the ingenic
ingenic_drm_bridge_atomic_check() would fail in the switch.

The Ingenic should implement a proper .atomic_get_input_bus_fmts returning
only the possible supported formats.

Can you check if you hit the default case in ingenic_drm_bridge_atomic_check() ?

Neil

> 
> BR and thanks,
> Nikolaus
> 

