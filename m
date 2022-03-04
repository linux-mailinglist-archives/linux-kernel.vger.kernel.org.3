Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6524CDDF4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 21:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiCDUDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 15:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiCDUDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:03:03 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1CB1AF8C9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 11:54:04 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id qx21so19538301ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 11:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ETvfGVoGLXwDhWPGfvHwKsO/zr0ji0OYPvNdqU+p67c=;
        b=jWz+XRpv+mw5fFBHNcSDIuUw96ucnDzuIlqQnDDKWkAtP0g3jcvohja1IbZoolKrqs
         QXK0ZLrPl16cNWRZ8xdl8uVMs2ATrPO8t/Ile0J31U3qX36fVyvbq6Xp3wO99dssUw/G
         9glD2oaj5XdVP858LqiDcCgqrKzvvBJbKiRT2o4TgXj7FVGTD5AKVWq+XwmG+IxI9LC3
         P3we66PEZVOOWF67TeHAa392lhrrtzfhle/V++6Kx8rR5B31wmrsAJuVl6uecgUplbT7
         xFIKJTxRxiykxF1DeTwuOwBR9aex/kHiS7kNcfynnemvNL7te9c736eKtaOhnDA4Ermh
         1cDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ETvfGVoGLXwDhWPGfvHwKsO/zr0ji0OYPvNdqU+p67c=;
        b=dqQIlJLnsGfpI1Ua2Hi33COu249TEtB1dXkObNg5NmYm1zlQHzsrVzu0QCx1eql9FE
         sxI6PCMDB8uNxDQcdWe36Mf7tRUGwrkdSLCxjSXqRrdqN10GHLGQQLvSh0w/6Whux2wm
         P5PoeL77Jb4rwJSoPpMgFbhon/OsOhUshNng455saaCfSMqIsuChIa95MS7/PtKGzq4y
         j6JAL9Ycc9F1jBmArooXMa5MKzSwf5VntrS/ANI6zW7VK9n6LR+Juf0zDep6xc/lqMvN
         G+PrZ5oMXK+13siVxMgB36wWEcMpdB5At8X7q/EwSJCTLt4chUN1TsiZM8IeeJ0nB2q3
         AR1A==
X-Gm-Message-State: AOAM5305zd86E1pu8SvNOgFXWMqQWbdkpf/Zc/XZXYvYRHb5Y8aMLAGl
        r77gFZVtczc0gq8JUukkpRmX0//uYrVszg==
X-Google-Smtp-Source: ABdhPJxm9tqRyk8xsBN77c/Xmt6AJupjBLplMEQ+2Kmms6Qrh+W4GHJMNEDXhpMLq5aO4v57wA0w6Q==
X-Received: by 2002:a5d:4992:0:b0:1f0:68bd:4c34 with SMTP id r18-20020a5d4992000000b001f068bd4c34mr242607wrq.670.1646423198257;
        Fri, 04 Mar 2022 11:46:38 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:c62:d373:a349:12ac? ([2a01:e34:ed2f:f020:c62:d373:a349:12ac])
        by smtp.googlemail.com with ESMTPSA id f186-20020a1c38c3000000b00382a9b91515sm10314281wma.37.2022.03.04.11.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 11:46:37 -0800 (PST)
Message-ID: <80f949af-ddab-b54d-b6ee-0fbcb1f74b51@linaro.org>
Date:   Fri, 4 Mar 2022 20:46:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 0/6] clocksource/drivers/timer-microchip-pit64b: fixes
 and improvements
Content-Language: en-US
To:     Claudiu Beznea <claudiu.beznea@microchip.com>, tglx@linutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220304133601.2404086-1-claudiu.beznea@microchip.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220304133601.2404086-1-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Claudiu,

I would like to pick patches 1,2,3 but not the others one because I'm 
not convinced about the suspend / resume changes and need some time to 
think about it.

   -- D.


On 04/03/2022 14:35, Claudiu Beznea wrote:
> Hi,
> 
> The series adds one fix and few improvement for PIT64B timer. Patch 1/7
> was initially posted at [1].
> 
> Thank you,
> Claudiu Beznea
> 
> [1] https://lore.kernel.org/lkml/20210707054415.92832-1-claudiu.beznea@microchip.com/
> 
> Changes in v3:
> - removed patch "clocksource/drivers/timer-microchip-pit64b: remove timer-of depenency"
>    as it breaks build on other platforms
> - adapt patch 6/6 to comply with kernel-doc specification
> 
> Changes in v2:
> - removed patch 5/7 "clocksource/drivers/timer-microchip-pit64b: add delay timer"
>    to avoid compilation errors on non ARM platforms; will re-introduce it after
>    a bit of rework on AT91 specific Kconfig
> - added patch "clocksource/drivers/timer-microchip-pit64b: fix compilation warnings"
> - in patch "clocksource/drivers/timer-microchip-pit64b: use mchp_pit64b_{suspend,
>    resume}" remove gclk_unprepare, pclk_unprepare labels and code under them
> 
> 
> Claudiu Beznea (6):
>    clocksource/drivers/timer-microchip-pit64b: remove mmio selection
>    clocksource/drivers/timer-microchip-pit64b: use notrace
>    clocksource/drivers/timer-microchip-pit64b: use 5MHz for clockevent
>    clocksource/drivers/timer-microchip-pit64b: remove suspend/resume ops
>      for ce
>    clocksource/drivers/timer-microchip-pit64b: use mchp_pit64b_{suspend,
>      resume}
>    clocksource/drivers/timer-microchip-pit64b: fix compilation warnings
> 
>   drivers/clocksource/Kconfig                  |  1 -
>   drivers/clocksource/timer-microchip-pit64b.c | 72 ++++++++------------
>   2 files changed, 30 insertions(+), 43 deletions(-)
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
