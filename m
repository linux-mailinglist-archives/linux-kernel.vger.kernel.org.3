Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F82575AA1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 06:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiGOExH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 00:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiGOExG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 00:53:06 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C5378583;
        Thu, 14 Jul 2022 21:53:05 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id j22so6997100ejs.2;
        Thu, 14 Jul 2022 21:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:cc:references:to:in-reply-to:content-transfer-encoding;
        bh=q64YR+dz3l8N7KWsT2gr8PSkDJ8PbvnFEtZazzJt2ik=;
        b=TZF/1PNOgat33kGEqwm0sKjVGVoe5Z3ryywyXeqsIKSWzKkmOL8q7SB++vfy6dvlx8
         ZGN/Tv7YraG5i0iWboYaHEQ0Ye2spd1Gq8yk0cee9BFlY5PMXd2gLigAH1ZijkgpNn4T
         utJi24RbFfbHVVW+jFTfDk0oXtmImXkBI76XzuQlsAqwVFhb/Po7MgsvKNwZ354GuZSE
         7DnPWe2qfQvfaphiyEASVkLYcdx7dm++u9XTPBLLbEvvaNO6/qBPxmBWT0GwQquVLs/g
         Ln+XkLZlfpb6LhlwkW+uJsqJmEtZDN4nNtKI5qmDZXLUvcBcjrKBkbxttqhmJQtCCHry
         m1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:cc:references:to:in-reply-to
         :content-transfer-encoding;
        bh=q64YR+dz3l8N7KWsT2gr8PSkDJ8PbvnFEtZazzJt2ik=;
        b=mqV5DnZWB4V+dmQggmL+LH00u27tgtttJheck+rnXGAdkr+dmCnBlmvDnmowijKFgs
         KSV2/EFfphx6iJRxOc0kWxrHJHNjpr+SbA7V2HbGaU2PWMIl4bdwiFRsCkuqR7638dZP
         dECPWjucmgBOMqZrTu+rpJSlvXSYw3vhOxC/I9fYEgJm07Os1OHF46+PBgW9/HdZ/L4q
         c/FI1jTkj9/K8IGq6BSCPmLWveHLEbrpapUMQ6m7foqCL11JxXXZ6PHKNewECcf4iv2d
         gfPHpFJupcn6GTEXwQagZJmL74iqv4QSv4CfC7IKUekgmpGd+cpxHBxdP01YLq7+R4Nm
         IcoA==
X-Gm-Message-State: AJIora9Eyu+Og10pMPsj+Pej7GHKpIf2OCGpQ5JJ08ED+3LqW/R42B72
        KiXAF7CJWtv2b299sb1x61U=
X-Google-Smtp-Source: AGRyM1vJS2pPI+Aq0Nn7vFNE0vbKPvqiynIpJzvgmXsbMz9uZoZ7o1vfkFH/s3P6vTPnswF/3kekSg==
X-Received: by 2002:a17:907:1c8f:b0:6e8:f898:63bb with SMTP id nb15-20020a1709071c8f00b006e8f89863bbmr12079765ejc.721.1657860783722;
        Thu, 14 Jul 2022 21:53:03 -0700 (PDT)
Received: from [192.168.0.182] ([79.119.98.153])
        by smtp.gmail.com with ESMTPSA id b6-20020aa7cd06000000b004355998ec1asm2110036edw.14.2022.07.14.21.53.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 21:53:03 -0700 (PDT)
Message-ID: <08a9d34b-f44e-e1f2-ebc6-4123986b3c54@gmail.com>
Date:   Fri, 15 Jul 2022 07:53:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 2/2] iio: adc: ad4130: add AD4130 driver
Content-Language: en-US
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20220715044948.434149-1-cosmin.tanislav@analog.com>
 <20220715044948.434149-3-cosmin.tanislav@analog.com>
To:     Jonathan Cameron <jic23@kernel.org>
In-Reply-To: <20220715044948.434149-3-cosmin.tanislav@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/15/22 07:49, Cosmin Tanislav wrote:
> AD4130-8 is an ultra-low power, high precision, measurement solution for
> low bandwidth battery operated applications.
> 
> The fully integrated AFE (Analog Front-End) includes a multiplexer for up
> to 16 single-ended or 8 differential inputs, PGA (Programmable Gain
> Amplifier), 24-bit Sigma-Delta ADC, on-chip reference and oscillator,
> selectable filter options, smart sequencer, sensor biasing and excitation
> options, diagnostics, and a FIFO buffer.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ...
> +static int ad4130_gpio_init_valid_mask(struct gpio_chip *gc,
> +				       unsigned long *valid_mask,
> +				       unsigned int ngpios)
> +{
> +	struct ad4130_state *st = gpiochip_get_data(gc);
> +	unsigned int i;
> +
> +	/*
> +	 * Output-only GPIO functionality is available on pins AIN2 through
> +	 * AIN5. If these pins are used for anything else, do not expose them.
> +	 */
> +	for (i = 0; i < ngpios; i++) {
> +		unsigned int pin = i + AD4130_AIN2_P1;
> +		bool valid = st->pins_fn[pin] == AD4130_PIN_FN_NONE;
> +
> +		__assign_bit(i, valid_mask, valid);
> +	}
> +
> +

I missed an extra blank line here. Maybe you could fix it while
picking the patchset up, Jonathan?

> +	return 0;
> +}
> +
> ...
