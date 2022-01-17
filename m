Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBAB4909F4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 15:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbiAQOHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 09:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiAQOHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 09:07:49 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A62C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 06:07:48 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id s6-20020a7bc386000000b0034a89445406so20813838wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 06:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=roHVGOW9LS4xw5VwWVB4J43flzmTf4uk7sQSSfGZIHg=;
        b=C2l5IHhQhIYVIfT2xnMr7nGiyaB0QWTSdpXoXYd1C9CO8xQlwVmHDbkPAip11iz5lw
         7OCBG4JSwrtkaNZUXqC0GdvGcZoAyF7UvDnSdFZ3uzOSDspRO3U4hfsLzjmmLTYKYwxE
         x+EjBaqXA6PkF82TiHhbncTYjDIHJpW7Gngquonn/mPUN43j6tUFi5W11HFZR/6ZV8ZD
         u7urgTMwTyQtVsM6bhMueGxPZTaFccABkiz73lPcYH5kZba2/tvoET8s08Mz/9RXRWjF
         qcoY3xqgqFG8q+gJgm1Divs5dLB574QsuicdLeemU8fejDAQYr0Osnghg3Mfu6sFcriV
         1I/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=roHVGOW9LS4xw5VwWVB4J43flzmTf4uk7sQSSfGZIHg=;
        b=wUhA8x/bN8XW9gdlFdHm51texZM7axcRHAoSt6cLxiB3PYbwX5PlswKHoczOAt8H/h
         oZWxk9YB+gqdMmf0qC2RdSRgiJm9WjZ7z7tAmaEjMc96I24aB9o0Q9rUo2iDNbT4dea3
         UbJT8inV9KOZnhyN9o8dbPvZQ+4oQleZeP0JWDhLBW6xAcGzzdx+MrA+ag28jbiCwszX
         hfK3HMkqIP5fR+xwY+QAmXd62ZQT4urtebXeg/Wy9+DRXws/iDKy9nlxBvbYSS4OcHmr
         7Pu/8jwDQFHaVlC0QEhIxojCdELOuMA6WOslkGu8UUU5hha8Frvl7ysIHP7zBy8maYyz
         ItfA==
X-Gm-Message-State: AOAM5311B+Z76Ob8McH4zjsz+nTdo8kzZZByqcvinSJzol1lWavlH5Oe
        QP1GvYwGQiphiURAR48JV7+9Iw==
X-Google-Smtp-Source: ABdhPJyyNEqXAM/wCh4fH2lhaS6KFq89p3ZJ0qvxvaA1mkzRq2/irbC2SFkDubnPdY1WTfWmZ2HELw==
X-Received: by 2002:a05:6000:1885:: with SMTP id a5mr10222325wri.591.1642428467182;
        Mon, 17 Jan 2022 06:07:47 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:c004:9fe1:fbda:2d0c? ([2001:861:44c0:66c0:c004:9fe1:fbda:2d0c])
        by smtp.gmail.com with ESMTPSA id d22sm13660475wrb.83.2022.01.17.06.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 06:07:46 -0800 (PST)
Subject: Re: dw_hdmi is showing wrong colour after commit
 7cd70656d1285b79("drm/bridge: display-connector: implement bus fmts
 callbacks")
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "robert.foss@linaro.org" <robert.foss@linaro.org>,
        "jonas@kwiboo.se" <jonas@kwiboo.se>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
References: <OS0PR01MB59221ED76B74231F5836D5FB86539@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <OS0PR01MB592224EC8F50F41B7FF1DEE286549@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <19dd6013-8a31-b2ed-29d5-93fc44193ce4@baylibre.com>
 <OS0PR01MB5922F442759BE6F228EE0B4486549@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <538b8da4-1201-5f45-2abf-ecd22c867358@baylibre.com>
 <OS0PR01MB5922BC31FBCF85F99F17737B86549@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ebaff694-a2d7-7eb8-5850-980e9d4e1e68@baylibre.com>
 <80fdc5a0-ddb8-5a0f-eb8c-ef7988ced638@baylibre.com>
 <164241711700.10801.9011781958267060147@Monstersaurus>
 <4f214ea2-5f9f-1217-6e65-f92e434ed826@baylibre.com>
 <164242831905.10801.10615379536917395435@Monstersaurus>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <92f37b42-23db-4aab-5262-911d07b6301f@baylibre.com>
Date:   Mon, 17 Jan 2022 15:07:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <164242831905.10801.10615379536917395435@Monstersaurus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2022 15:05, Kieran Bingham wrote:
> Quoting Neil Armstrong (2022-01-17 13:53:47)
>> On 17/01/2022 11:58, Kieran Bingham wrote:
>>> Hi Neil,
> 
> <big snips to clear up contexts>
> 
>>> This fixes the issue for me here on an H3 Salvator-XS.
>>>
>>> Could you add...
>>>
>>> Bisected-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>>> Tested-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
>>>
>>> alongside Biju's Reported-by: tag when posting as a fix please?
>>
>>
>> Which patch did you test ?
> 
> Ah, yes that's not clear is it - sorry! I replied in the wrong place on
> the thread when I went back to the mail ... see below...
> 
>>>> I'm not happy with this version since it's merely a hack which makes it work.
>>>>
>>>> Can you test the following change instead, it's correctly handles your situation in a generic manner.
>>>>
>>>> ========================><=============================
>>>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>>> index 54d8fdad395f..9f2e1cac0ae2 100644
>>>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>>> @@ -2551,8 +2551,9 @@ static u32 *dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
>>>>         if (!output_fmts)
>>>>                 return NULL;
>>>>
>>>> -       /* If dw-hdmi is the only bridge, avoid negociating with ourselves */
>>>> -       if (list_is_singular(&bridge->encoder->bridge_chain)) {
>>>> +       /* If dw-hdmi is the first or only bridge, avoid negociating with ourselves */
>>>> +       if (list_is_singular(&bridge->encoder->bridge_chain) ||
>>>> +           list_is_first(&bridge->chain_node, &bridge->encoder->bridge_chain)) {
>>>>                 *num_output_fmts = 1;
>>>>                 output_fmts[0] = MEDIA_BUS_FMT_FIXED;
>>>>
>>>> @@ -2673,6 +2674,10 @@ static u32 *dw_hdmi_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
>>>>         if (!input_fmts)
>>>>                 return NULL;
>>>>
>>>> +       /* If dw-hdmi is the first bridge fall-back to safe output format */
>>>> +       if (list_is_first(&bridge->chain_node, &bridge->encoder->bridge_chain))
>>>> +               output_fmt = MEDIA_BUS_FMT_FIXED;
>>>> +
>>>>         switch (output_fmt) {
>>>>         /* If MEDIA_BUS_FMT_FIXED is tested, return default bus format */
>>>>         case MEDIA_BUS_FMT_FIXED:
>>>> ========================><=============================
> 
> Sorry, I replied in the wrong part of the thread.
> 
> Here's the direct diff on my local tree:
> 
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 54d8fdad395f..cac9a87949f1 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -2551,8 +2551,10 @@ static u32 *dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
>         if (!output_fmts)
>                 return NULL;
>  
> -       /* If dw-hdmi is the only bridge, avoid negociating with ourselves */
> -       if (list_is_singular(&bridge->encoder->bridge_chain)) {
> +       /* If dw-hdmi is the first or only bridge, avoid negociating with ourselves */
> +       if (list_is_singular(&bridge->encoder->bridge_chain) ||
> +           list_is_first(&bridge->chain_node, &bridge->encoder->bridge_chain)) {
> +
>                 *num_output_fmts = 1;
>                 output_fmts[0] = MEDIA_BUS_FMT_FIXED;
>  
> @@ -2673,6 +2675,10 @@ static u32 *dw_hdmi_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
>         if (!input_fmts)
>                 return NULL;
>  
> +       /* If dw-hdmi is the first bridge fall-back to safe output format */
> +       if (list_is_first(&bridge->chain_node, &bridge->encoder->bridge_chain))
> +               output_fmt = MEDIA_BUS_FMT_FIXED;
> +
>         switch (output_fmt) {
>         /* If MEDIA_BUS_FMT_FIXED is tested, return default bus format */
>         case MEDIA_BUS_FMT_FIXED:
> 
> Which I believe matches the above.

Ok thanks of clarifying !

let me post it asap.

Neil

> 
> --
> Kieran
> 

