Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21314F7EC8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 14:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239489AbiDGMPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 08:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238848AbiDGMPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:15:21 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFFE23CC7A
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 05:13:20 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n6so10339159ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 05:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4RwpkSUqDB0l6cKt7wHht/Va+r9VAPBwORUmjbKGxuI=;
        b=IOjkHAnh1pWx6/i2VRl8VGFDhbScmVYeMIT7FQPJoRzzulxXx7xtZflL8hK5uQ+WGG
         hwmFpuXCO3RlaeFY4Sp2HsozUwO2zXvPz7ojFWxUkDTyt2qAh3bh0bplhRsb751HrrhS
         qXUM9D8p6nSO/JESUbR8jY5csiffSvzwvnSSCo9HFJMKGq9NK9p1m0cuA2mTggZQUn/k
         ki/Q6Y+PBOYR6Y7gmzwn0A0MbhNE7pHbG/08lRfNlD2Mqbq5TXsXiE6rqdslZtOvTM++
         sNB0PxwFcjgKkF7U58yM9jxghqBDMcXUDwMAmC0/U/5pQSyZps/oGxn7W1kRsKAp2joz
         YX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4RwpkSUqDB0l6cKt7wHht/Va+r9VAPBwORUmjbKGxuI=;
        b=SGJ3JHhW6D7CskSWF750teRdsesg24dPQdOpXjRf3Ccmv4qpjC4QKsUPG7fWp/YXIO
         dL0eOI/31qDuP6RXJTKOUqA+OUoByq30gMAl6lSSULzbVbIJ2E7qQJX6KtnkArGBVwJ8
         /jJELRIPwnqrnB0yKZ5uyFikucMSWTmzF+Zg2jCCqR7WUYn7IV37D+XJyrXLgHo0hnix
         E4eVqxzRr5wV52y9cFtKUG6FxssN3cmauHzx9VX4G0ti++9Epaf+Idu52I58b7X3dbz6
         1Lnz2JHmcmVeUvc14+E/aIvKg+CUqZxEZEvthFtnjWDs5oDVAf9hGCCQY+3o18pgXB+k
         Og6w==
X-Gm-Message-State: AOAM530f9tklY/HvuV1M2dwQedILlEhotSEVR+SYW9tlckYpCYezSLSh
        BD3XXYRpQcnI+vLunJ03bFrALg==
X-Google-Smtp-Source: ABdhPJxEFc3pwxCcjRWWqquRyplf/LckBfH88Uh/n2MY+jXL0K8uHf+M5WVvVNwnNRb8aMHBq4N6Tw==
X-Received: by 2002:a17:906:a08b:b0:6b9:2e20:f139 with SMTP id q11-20020a170906a08b00b006b92e20f139mr13597295ejy.463.1649333594458;
        Thu, 07 Apr 2022 05:13:14 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id d12-20020a50cf4c000000b0041cc12dc1f3sm6484690edk.71.2022.04.07.05.13.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 05:13:13 -0700 (PDT)
Message-ID: <1369ae65-5455-f217-c770-570e2472ba47@linaro.org>
Date:   Thu, 7 Apr 2022 14:13:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] ARM: dts: lan966x-pcb8291: Add QSPI0 and SPI NOR
 memory nodes
Content-Language: en-US
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        arnd@arndb.de, robh+dt@kernel.org, krzk+dt@kernel.org,
        alexandre.belloni@bootlin.com, olof@lixom.net, soc@kernel.org,
        nicolas.ferre@microchip.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
        tudor.ambarus@microchip.com, Manohar.Puri@microchip.com
References: <20220407105835.10962-1-kavyasree.kotagiri@microchip.com>
 <20220407105835.10962-3-kavyasree.kotagiri@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220407105835.10962-3-kavyasree.kotagiri@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 12:58, Kavyasree Kotagiri wrote:
> Enable QSPI0 controller and sst26vf016b SPI-NOR flash present on it.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
>  arch/arm/boot/dts/lan966x-pcb8291.dts | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/lan966x-pcb8291.dts b/arch/arm/boot/dts/lan966x-pcb8291.dts
> index 3281af90ac6d..99d96d46661d 100644
> --- a/arch/arm/boot/dts/lan966x-pcb8291.dts
> +++ b/arch/arm/boot/dts/lan966x-pcb8291.dts
> @@ -62,3 +62,18 @@
>  &watchdog {
>  	status = "okay";
>  };
> +
> +&qspi0 {
> +	status = "okay";
> +
> +	spi-flash@0 {

Just "flash" please (to be generic).

> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <20000000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;

Why do you need address/size cells here? You don't have any children.

> +		spi-tx-bus-width = <4>;
> +		spi-rx-bus-width = <4>;
> +		m25p,fast-read;
> +	};
> +};


Best regards,
Krzysztof
