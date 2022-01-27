Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DD249E31D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241569AbiA0NJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiA0NJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:09:28 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E48C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:09:28 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id m14so4435838wrg.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uRCdmsKzTtl/e8jDz5OfS+Xhq/kglPjbOlF4IMlfCvE=;
        b=F/Cv0ihQ8enZVtaffNDyQkCLbbfxIKPGo84+NcxnfYFZlELtVAAyQeqDiPL3FxzhAf
         W6NJlwW3RGIz3C1ah/QKdrX5Pdb4tHS3cKLGEV9zouPkeHs25urzeZ89iOsJUfAtBsBi
         cTqSnSnCvYbNjq7osF+gPD/gymJaL8nsUcp12SNIEs0FPPiPfLpkOR77ZWgY95EKDLOV
         76vsMzX7d5EfxDbZ9cNn0ZMBV4w1wtNV3SOhTAkaswB2SgCgf7XLQNcpFKOZ8iZJ3yqz
         /GlF/FGCnxnXS8TCyV4P3kkqeeZYfV7m1tkwl7HimN/foJXhrurcyE3AOPmiKPDd71yi
         8xQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uRCdmsKzTtl/e8jDz5OfS+Xhq/kglPjbOlF4IMlfCvE=;
        b=5D8IKj+gSaqaTVWlcV5Cgv0OWF7VdyS+aa4tV84ZymGbt5i2QTUTT+GwfkJthNhsjn
         62e5IYG1ZeFLyfWuzZKp+iD8zgW/FePKYnU23NDCVXxRmwO/70BA4zcOYtIzjQMj2yUv
         0TVqqxhIT1CeSYkIdYsx2E5EbuNxxtYqQfxug1+/lk9czDoNHwFMQKQgdRvTwbaOx7Li
         Joydi+08dmzP8PVTOUuIFp6UJEcqR1iGB/8HmT9ZTYsNRUn0J/UquaCJTkTmjEd08lO/
         yOoiHuegmWkI6oTZ7T+cSc8iENroxux0MMWTzA4F3+AV1Mw4UqzGWrp1Va35NAWjt/4a
         bEsw==
X-Gm-Message-State: AOAM531KY35g7XfEwsWuBqq1TaajDUPNgqNVWR3NyYkI/fcj+HBTFIym
        2imln5bjy8QKzyeOT7KAcDBFr7xdtU+c9w==
X-Google-Smtp-Source: ABdhPJykBbM1Vmvz0dqsh3rjV0fxuoQCWwMnI6NcOHp2g9cGLymHkzF9aY+PMP6t71s+84Nmjveg+Q==
X-Received: by 2002:adf:fe01:: with SMTP id n1mr3092587wrr.141.1643288961978;
        Thu, 27 Jan 2022 05:09:21 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:bd6:ac2b:1e48:f2ff? ([2001:861:44c0:66c0:bd6:ac2b:1e48:f2ff])
        by smtp.gmail.com with ESMTPSA id x5sm1857345wmh.27.2022.01.27.05.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 05:09:21 -0800 (PST)
Subject: Re: [PATCH v2] arm64: dts: meson-sm1-odroid: use correct enable-gpio
 pin for tf-io regulator
To:     Lutz Koschorreck <theleks@ko-hh.de>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220127130537.GA187347@odroid-VirtualBox>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <af32f4e8-5ee2-9d16-3880-f681d1c3de6d@baylibre.com>
Date:   Thu, 27 Jan 2022 14:09:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220127130537.GA187347@odroid-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2022 14:05, Lutz Koschorreck wrote:
> The interrupt pin of the external ethernet phy is used, instead of the
> enable-gpio pin of the tf-io regulator. The GPIOE_2 pin is located in
> the gpio_ao bank.
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
> 
> only gpio bank

Spurious lines, will remove while applying

> ---
>  arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
> index 0bd1e98a0eef..ed7cd5f53046 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
> @@ -48,7 +48,7 @@ tf_io: gpio-regulator-tf_io {
>  		regulator-max-microvolt = <3300000>;
>  		vin-supply = <&vcc_5v>;
>  
> -		enable-gpio = <&gpio GPIOE_2 GPIO_ACTIVE_HIGH>;
> +		enable-gpio = <&gpio_ao GPIOE_2 GPIO_ACTIVE_HIGH>;
>  		enable-active-high;
>  		regulator-always-on;
>  
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
