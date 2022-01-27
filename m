Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051FA49DEF3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbiA0KPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiA0KPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:15:17 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A0FC06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 02:15:17 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u15so3807651wrt.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 02:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8x6kPB0xVxvNejSKMZ4lJYgA9YR5Lh9WkR/5tdJIkCM=;
        b=XZHGxUK6B9Khgh5lHZ0qT6x4NI+VjhHIWKeoUY2ORPZtc9Or2eUdDfW/4x356Trv73
         NPX2VyrICKJuD9frvOQNByTBq4dRuw6HGrHRhrQ5HBAZOKKDl2RyqSXSBsNqI9PZOxAa
         K1uS6HrW3U3sR6hxINfGPeIZ/NSLmHwVFdA+/fGmdkbHaqaxOc6jYlTgOW3ailtkIsC9
         g/QbMj8DnoBfKKAqsjLFZHlB4esTvWbU79CSvDf4l8fNj7RYMQvpP/Spl9HVyKXMmP+V
         RFjSxtV+UVdcsCIvccrW39UwICeZ4cfUcuU8FQH1U88J88cFyR0WVXM2VNyaJUlNHUZP
         dnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8x6kPB0xVxvNejSKMZ4lJYgA9YR5Lh9WkR/5tdJIkCM=;
        b=pVlbhIsiAvcJhRqtS2lCA4dZv0xjN0Dc0nkC6XjdtC6m0o9pg4+NwPe8LlwvnAXWfw
         ZdHeGJ88ARHOXPcQ44K7ZIJ09NFOsz+0JcPG4X3BgZ8HiC/lkTWEgizlqyAp3D/59UDl
         Xlf2R967b+QG9JSGeFfbXK3flRVt/DxOh+0vLtZOgM2ZBFNavISFQNQQKuWyzRDCKEw4
         Sk0fgHCmmC3uuJFnr41VlNOVadUL6K+aagUzE1/BaQOOt6HHnt56ZmmsrT+MkJ0l5Ema
         SNcljaClXpaxiE9YPywauWZiIoLuZb4IxRQ8d+V8RXKHJMqfjqbwqFpatDspH88bcrcp
         JgSg==
X-Gm-Message-State: AOAM533jPy/ghXwhtzdFAiLTnlfumpsUa71H1P/vBr6PO2U86qCMhkWo
        vJk2EU0OpAeo1uRmRznrORurZiw79KGsew==
X-Google-Smtp-Source: ABdhPJynl6tia3B2Ag73l8mApp8aa4NGQ/NkhFAo6L6qBbWEicXINtupPkEG7I+fIR2znCUpa5tpyA==
X-Received: by 2002:a5d:408e:: with SMTP id o14mr2374145wrp.83.1643278515238;
        Thu, 27 Jan 2022 02:15:15 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:bd6:ac2b:1e48:f2ff? ([2001:861:44c0:66c0:bd6:ac2b:1e48:f2ff])
        by smtp.gmail.com with ESMTPSA id 16sm1539461wmj.12.2022.01.27.02.15.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 02:15:14 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: meson-sm1-odroid: use correct enable-gpio pin
 for tf-io regulator
To:     Lutz Koschorreck <theleks@ko-hh.de>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220126234325.GA7363@odroid-VirtualBox>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <651adde5-4887-4701-5183-6a35a443574c@baylibre.com>
Date:   Thu, 27 Jan 2022 11:15:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220126234325.GA7363@odroid-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27/01/2022 00:43, Lutz Koschorreck wrote:
> The interrupt pin of the external ethernet phy is used, instead of the
> enable-gpio pin of the tf-io regulator. The GPIOE_2 pin is located in
> the gpio_ao bank.
> Using open drain prevents reboot issues.
> 
> This causes phy interrupt problems at system startup.
> [   76.645190] irq 36: nobody cared (try booting with the "irqpoll" option)
> [   76.649617] CPU: 0 PID: 1416 Comm: irq/36-0.0:00 Not tainted 5.16.0 #2
> [   76.649629] Hardware name: Hardkernel ODROID-HC4 (DT)
> [   76.649635] Call trace:
> [   76.649638]  dump_backtrace+0x0/0x1c8
> [   76.649658]  show_stack+0x14/0x60
> [   76.649667]  dump_stack_lvl+0x64/0x7c
> [   76.649676]  dump_stack+0x14/0x2c
> [   76.649683]  __report_bad_irq+0x38/0xe8
> [   76.649695]  note_interrupt+0x220/0x3a0
> [   76.649704]  handle_irq_event_percpu+0x58/0x88
> [   76.649713]  handle_irq_event+0x44/0xd8
> [   76.649721]  handle_fasteoi_irq+0xa8/0x130
> [   76.649730]  generic_handle_domain_irq+0x38/0x58
> [   76.649738]  gic_handle_irq+0x9c/0xb8
> [   76.649747]  call_on_irq_stack+0x28/0x38
> [   76.649755]  do_interrupt_handler+0x7c/0x80
> [   76.649763]  el1_interrupt+0x34/0x80
> [   76.649772]  el1h_64_irq_handler+0x14/0x20
> [   76.649781]  el1h_64_irq+0x74/0x78
> [   76.649788]  irq_finalize_oneshot.part.56+0x68/0xf8
> [   76.649796]  irq_thread_fn+0x5c/0x98
> [   76.649804]  irq_thread+0x13c/0x260
> [   76.649812]  kthread+0x144/0x178
> [   76.649822]  ret_from_fork+0x10/0x20
> [   76.649830] handlers:
> [   76.653170] [<0000000025a6cd31>] irq_default_primary_handler threaded [<0000000093580eb7>] phy_interrupt
> [   76.661256] Disabling IRQ #36
> 
> Fixes: 1f80a5cf74a6 ("arm64: dts: meson-sm1-odroid: add missing enable gpio and supply for tf_io regulator")
> 
> Signed-off-by: Lutz Koschorreck <theleks@ko-hh.de>
> ---
>  arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
> index 0bd1e98a0eef..ddb1b345397f 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
> @@ -48,7 +48,7 @@ tf_io: gpio-regulator-tf_io {
>  		regulator-max-microvolt = <3300000>;
>  		vin-supply = <&vcc_5v>;
>  
> -		enable-gpio = <&gpio GPIOE_2 GPIO_ACTIVE_HIGH>;
> +		enable-gpio = <&gpio_ao GPIOE_2 GPIO_OPEN_DRAIN>;

Wow, indeed it's not the right GPIO chip... my bad.

>  		enable-active-high;
>  		regulator-always-on;
>  

Concerning the GPIO_OPEN_DRAIN, it's right since the line has a pull-up, does it really fix reboot issues ?

Anyway, can you split the changes ? First for gpio_ao, second for GPIO_OPEN_DRAIN ?

Neil

