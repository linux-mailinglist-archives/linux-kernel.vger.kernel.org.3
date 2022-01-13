Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED84E48D499
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbiAMI7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 03:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbiAMI6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 03:58:14 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83C0C029820
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 00:57:49 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id e9so8831213wra.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 00:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0EWMr6KitlRWDO5arnJCvWClLIIvkp/yLaDhRRbKQPU=;
        b=KrDvC0T2RkDm2S10PdyyDxIPGujwx2mMzNvpQr5OeKbYdtmkeeiJTrvkYNCTpxFztK
         FYFI1+5uWv9k7dbdh06gSvpB07XseM31gcJsHImOSvdONPW9kGVcnqkgaTIvC3l7D4cd
         Hx3BrEI/pOHsRKnJ9rCpP8uEC/Yxl2TI/ibTx4m8gGtJFg4zJ+nwZihosW9of4MnRmCB
         3JcucSDwWvrUegVoxpLg9RJm/Xtdx1TpXWM0TtJk/IBJIrtEWiQ6CHIryUAf1qyG0adz
         yQrhVOQqTg5hi+ySeIL3Qoe7AYI/7dxVZ3lhmCcydZf50dc1NYZkKRobOqZZGzS5ZUj+
         ab1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=0EWMr6KitlRWDO5arnJCvWClLIIvkp/yLaDhRRbKQPU=;
        b=OmiDK7eMOLtGyJ1CopriLd2gCTAksLBF1EbWKf8FhrhPSNEkbj2zf2JfKQ2oygCQGg
         ZwvsN3Zx9iQRWu/K+ce7n4M45hDD157TRMBGFz9sIW+C/1mdHzaRGWEAUMdZcHl7WPe8
         wayl8BaLKCtp7zubcbaLi1V5+ij/yXd1KqVgM6+2BGTefBfazFQZfYx0xdc+dvupfbwQ
         /3JX4PbJ76UCfkzY8XFylOYMJlna1ch7VzeI7JIVDJ+k01TYXABa9JSvloePHXpCVmRP
         30oGhFxBsQk0um0Xlx8TcjeSUwX5MgMWp95mdNqv+1xys/xu7jeVwCPHcNJUDVnGl2Xs
         iOTQ==
X-Gm-Message-State: AOAM530NrVBgmOOBAg9h6NF0udSzRfJobvncZhfnbv41FUko2NAwKafy
        I1p9ZjN4/toP8voHARRTRaB0O3XAEnOliQ==
X-Google-Smtp-Source: ABdhPJwzp7BlKb4wIp3XPCOF5PL3ihQEqq3SYQ39aZWcM7ZbYisYAeReeY5uo9mESQLZDRWV0YfjxQ==
X-Received: by 2002:a05:6000:1a85:: with SMTP id f5mr2179980wry.463.1642064267839;
        Thu, 13 Jan 2022 00:57:47 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:bece:ab45:7469:4195? ([2001:861:44c0:66c0:bece:ab45:7469:4195])
        by smtp.gmail.com with ESMTPSA id o11sm7392798wmq.15.2022.01.13.00.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 00:57:47 -0800 (PST)
Subject: Re: [PATCH v2 3/3] arm64: dts: meson-g12-common: add uart_ao_b pins
 muxing
To:     Gary Bisson <gary.bisson@boundarydevices.com>,
        linux-amlogic@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220103154616.308376-1-gary.bisson@boundarydevices.com>
 <20220112211642.2248901-1-gary.bisson@boundarydevices.com>
 <20220112211642.2248901-4-gary.bisson@boundarydevices.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <78e5049b-5e39-ff70-7c77-9f233c7b2fd2@baylibre.com>
Date:   Thu, 13 Jan 2022 09:57:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220112211642.2248901-4-gary.bisson@boundarydevices.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/2022 22:16, Gary Bisson wrote:
> - RX/TX signals can be mapped on 2 different pairs of pins so supporting
>   both options
> - RTS/CTS signals however only have 1 option available
> 
> Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
> ---
> Changes v1->v2:
> - renamed nodes as suggested by Neil
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  .../boot/dts/amlogic/meson-g12-common.dtsi    | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> index af1357c48bee..62350c408e16 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> @@ -1952,6 +1952,33 @@ mux {
>  						};
>  					};
>  
> +					uart_ao_b_2_3_pins: uart-ao-b-2-3 {
> +						mux {
> +							groups = "uart_ao_b_tx_2",
> +								 "uart_ao_b_rx_3";
> +							function = "uart_ao_b";
> +							bias-disable;
> +						};
> +					};
> +
> +					uart_ao_b_8_9_pins: uart-ao-b-8-9 {
> +						mux {
> +							groups = "uart_ao_b_tx_8",
> +								 "uart_ao_b_rx_9";
> +							function = "uart_ao_b";
> +							bias-disable;
> +						};
> +					};
> +
> +					uart_ao_b_cts_rts_pins: uart-ao-b-cts-rts {
> +						mux {
> +							groups = "uart_ao_b_cts",
> +								 "uart_ao_b_rts";
> +							function = "uart_ao_b";
> +							bias-disable;
> +						};
> +					};
> +
>  					pwm_a_e_pins: pwm-a-e {
>  						mux {
>  							groups = "pwm_a_e";
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks !
Neil
