Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51CE48BFBB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350183AbiALITm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351580AbiALITi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:19:38 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67059C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:19:38 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v6so2674722wra.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 00:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N65x+okBqwUwEt3rIQ+NIW+LytKbN9dsX1fy1vfrCfI=;
        b=SW98+bEGXg9kLnzJ/Wwc1NHVh8cpZxfiyWuV2nGuJ74fgv45ymJw6JemuQAKIArNtE
         5DG1Lvl/4pk6ePJLHplSmtJIGixksULeN7oycvXq0sRHaw/4lS/qVfJAvoc8aJzPYJrI
         bu99OyB1WGiRnjZ8R698wf4TY0nB6PSdMvu0I0WVoj9h9PvxXwNW4SXrQXAaDcFLOauK
         oksO6kEvCFpQXgxhIYdwL8HhuTJcxAZwjAnsbsKzbGn6ZPbWputKpy32zfY0Dc8P8gcT
         5Y4Kkf1SoAroY0F0bMlIoGFd5/EqnI63psov11WvPWXEj0TAeGUeO2GO9FaqWwlkQb/C
         ltAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=N65x+okBqwUwEt3rIQ+NIW+LytKbN9dsX1fy1vfrCfI=;
        b=4iMUZjgJ3ST9hdN0cdV2K4B65N7fTiReVFat+VejuGuF7iJ22QWnU4S0zNP5egF3vU
         wwpGewpyYvQ4aSHnUMulMwbrDEetyQnML3Z6uRbQU5tyfov3i/uR5cWh/9frsS5v/pUQ
         ZTAVVbq0brilUZ3dHovRet1wjAp0vfyU06oVP+s4S4d/9GOBy3mtApMBx+Rp/3eRjxnU
         Of96/k6/HvbK2ChSZfU6LHAE1Qkn9XnghozOzLgYnY2z8/zamwourKGeS9+xK4CyIgWp
         HwKlaRCx6+1P4kDjJLOI58DPxDx8WFmY/bCT63+G1pAzjbT+GmzUshFJ7GpPdbc+2eMM
         qlrQ==
X-Gm-Message-State: AOAM533/epqT/hchzRRj9px9eiRy/wcXllUnMChyT3UkkMky2/YF+NOD
        MVhRqw9fzFkovBp6MXT/Tq+SEw==
X-Google-Smtp-Source: ABdhPJyuElpnJODcDGKEk++EbHO+Un+WeepU7Q/OryifjLA3PhxRGHAWWF2yBRHvGTJDk1mAUoD/sA==
X-Received: by 2002:a5d:584b:: with SMTP id i11mr6667217wrf.433.1641975576862;
        Wed, 12 Jan 2022 00:19:36 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:381b:6e50:a892:5269? ([2001:861:44c0:66c0:381b:6e50:a892:5269])
        by smtp.gmail.com with ESMTPSA id i8sm14694212wry.108.2022.01.12.00.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 00:19:35 -0800 (PST)
Subject: Re: [PATCH 6/6] drm/meson: add support for MIPI-DSI transceiver
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     daniel@ffwll.ch, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20200907081825.1654-1-narmstrong@baylibre.com>
 <20200907081825.1654-7-narmstrong@baylibre.com>
 <CAMty3ZBEmafG8LS_yv4eektvUoHwYFoV=-8wohUXgsvpRbZqtA@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <70d1af3f-bc00-4afd-1157-1cf70d3b2c88@baylibre.com>
Date:   Wed, 12 Jan 2022 09:19:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAMty3ZBEmafG8LS_yv4eektvUoHwYFoV=-8wohUXgsvpRbZqtA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/01/2022 08:24, Jagan Teki wrote:
> Hi Neil,
> 
> On Mon, Sep 7, 2020 at 1:48 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>>
>> The Amlogic AXg SoCs embeds a Synopsys DW-MIPI-DSI transceiver (ver 1.21a), with a custom
>> glue managing the IP resets, clock and data input similar to the DW-HDMI Glue on other
>> Amlogic SoCs.
>>
>> This adds support for the Glue managing the transceiver, mimicing the init flow provided
>> by Amlogic to setup the ENCl encoder, the glue, the transceiver, the digital D-PHY and the
>> Analog PHY in the proper way.
>>
>> The DW-MIPI-DSI transceiver + D-PHY are directly clocked by the VCLK2 clock, which pixel clock
>> is derived and feeds the ENCL encoder and the VIU pixel reader.
>>
>> An optional "MEAS" clock can be enabled to measure the delay between each vsync feeding the
>> DW-MIPI-DSI transceiver.
>>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---

[..]

>> +
>> +static const struct component_ops meson_dw_mipi_dsi_ops = {
>> +       .bind   = meson_dw_mipi_dsi_bind,
>> +       .unbind = meson_dw_mipi_dsi_unbind,
>> +};
> 
> Do you thought of non-component based meson DSI like STM DSI? It
> require changes from meson drm but just to understand if you have any
> such plan.

I have no such plans for now, note this serie has been rewritten at [1] but still
with based with components.

If worth it, the plan is to get it with components and than yes if it's simpler
drop components completely.

I'll have a look at how ST does

Neil

[1] https://lore.kernel.org/r/20220107145515.613009-1-narmstrong@baylibre.com

> 
> Thanks,
> Jagan.
> 

