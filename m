Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D3C47A746
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 10:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhLTJiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 04:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbhLTJiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 04:38:18 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16491C061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 01:38:18 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id j9so18877044wrc.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 01:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=dYWkmery3XK6vwBBysFrmlhWjVvFlCfPLyck1j0dX7M=;
        b=VjTtLdkTMRyf1qbutj9RgXV8zp1JMbMVxDIWHOvs0MqgQASAnoojM0PRN9MtcTgezK
         ZB+wY94y9vDpqBEWQfAiw/wPs8sd34SSwZg6B2V23juAn5/lJ4tabtcASaPPQxRPCYNt
         V5RWwiy08gXyLF9O1r4IPPhqmIYx1/skL++o18ywv+9NoyPUeVSrvjB5FTgHOoDx1cmG
         4fzS+9MxOS5eiYlDdMYsgrAecYzfOYth3bNJ8IR90eo1O4g32IlLCpzjbilmXcKeduKn
         u08998IdA5tjaHGt7GAw1keytxAm0+h1QjesFbIyQa5HtugpWovZl9C6eKBhdPbKmwzg
         q2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dYWkmery3XK6vwBBysFrmlhWjVvFlCfPLyck1j0dX7M=;
        b=CtffKe5A7+QbNv4dT6Um8HepAjTSB7LzSmNflMkbqM36XjJhfuN6UY0SD5KrXqcHFR
         +8iprEAjPeQDtA9r3ACBu88Qoumo6uHt+k+QeX1GECDipkx4JdiNQ3lQCy5MrIjLmAuB
         JShm/K6lETUvfoIHVZwnrdPPp0ZBvL8tWX6gPa3bQg7+pU7qVg6N0oRNNwYZJ7koMHeq
         qCN5y+9Ifw1oG6W6rDaGbd/+b7TO/8/SRuygf5N4Ie+2AlYCQtFJVCs93XGnkz0dCQtM
         PT+iti50xmyh6lKT7xkKZ8HtZzsfRJ/VX58vU89WShpQkLnlbsTk/bdPn5CZp3sonKIt
         NxIA==
X-Gm-Message-State: AOAM531HBcVfJF7NfMwTMlj8BbHEvMpMYkh3z11WddrzfywuUPvnxVZg
        Esbem9+vF6x69rKn+7g5nE7xGQ==
X-Google-Smtp-Source: ABdhPJy0j6jM/hz3E4ABp8fKZ8cOMV2ncUsVgRdk43pVrGIfjBJuOzi39GvpJ+yWZLBLewQnAqzO/A==
X-Received: by 2002:a5d:610c:: with SMTP id v12mr7437729wrt.410.1639993096472;
        Mon, 20 Dec 2021 01:38:16 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:fa36:a1cd:f64:7a6? ([2a01:e34:ed2f:f020:fa36:a1cd:f64:7a6])
        by smtp.googlemail.com with ESMTPSA id k6sm12820826wrc.38.2021.12.20.01.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 01:38:15 -0800 (PST)
Subject: Re: [PATCH v2 0/2] Add cpuidle driver for Sunplus SP7021
To:     Edwin Chiu <edwinchiu0505tw@gmail.com>, robh+dt@kernel.org,
        edwin.chiu@sunplus.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        linux-pm@vger.kernel.org
References: <cover.1639971376.git.edwinchiu0505tw@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <11fa1686-ae61-8f19-f0a0-d1e0fefedbb2@linaro.org>
Date:   Mon, 20 Dec 2021 10:38:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <cover.1639971376.git.edwinchiu0505tw@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Edwin,

sorry but I don't get the series. The bindings and the generic cpuidle
should already take into account the idle path.

Did I miss something ?


On 20/12/2021 06:37, Edwin Chiu wrote:
> This is a patch series for cpuidle driver for Sunplus SP7021 SoC.
> 
> Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
> many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and 
> etc.) into a single chip. It is designed for industrial control.
> 
> Refer to:
> https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
> https://tibbo.com/store/plus1.html
> 
> Edwin Chiu (2):
>   dt-bingings:arm:sunplus:add sp7021 compatible string to
>     sunplus,idle-state.yaml
>   cpuidle:sunplus:create cpuidle driver for sunplus sp7021
> 
>  .../bindings/arm/sunplus/sunplus,idle-state.yaml   |  55 +++++++
>  MAINTAINERS                                        |   9 ++
>  drivers/cpuidle/Kconfig.arm                        |   7 +
>  drivers/cpuidle/Makefile                           |   1 +
>  drivers/cpuidle/cpuidle-sunplus.c                  | 180 +++++++++++++++++++++
>  include/linux/platform_data/cpuidle-sunplus.h      |  13 ++
>  6 files changed, 265 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/sunplus/sunplus,idle-state.yaml
>  create mode 100644 drivers/cpuidle/cpuidle-sunplus.c
>  create mode 100644 include/linux/platform_data/cpuidle-sunplus.h
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
