Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED8A57D195
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiGUQcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiGUQcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:32:23 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF1989A5C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:32:21 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id u19so3692372lfs.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PMTz2Yy7eX0OLuWGsHne5sObvYwaGJFYNT4TztuyWn8=;
        b=PQm7aYZ33ELOxkmXRdndLEA9HsEdv542cb44Henwb27bHr5RWyfdobu89UJVIxWIwS
         GzasgX6jGCzfCgctkloPVvfsIKCn+wBbKBggKA8iaogsN6dbqwq+66dlqQWvlr0pq7VV
         /9QsQ4jvEkXZApgIS1UiEpUZz9ESS6o7zFLqVQpkm2JRerjz56DH9ATW/0kLbL0q1aWu
         ZSmpbsa5/BMqvyN+Pdjv6FkMOEWZfddz56pErWEyrhSCnMG045VRiw39My6imIRnDWSr
         Q2Igu5Ib8YEijviJcui66qv+IeON/hUK5KASI0eBW9NnFcSEL213jTeIWKHYocbfWo8p
         O9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PMTz2Yy7eX0OLuWGsHne5sObvYwaGJFYNT4TztuyWn8=;
        b=eihnSFk3UZzszDr2/L9waTCzKEboXLtLH+MMJccGTu+kAg76Jd32zytrZl40WUYHgt
         CKphIjlkSe2zQ0SqklCxhhRZyiD02+2kLQRlyg8+Hy/nM1cUup7Cy+/M9fDw6IrceuT5
         zxQpy7Rt79ONpBrzSB3m7NqaNMJSUg05Y+EClW1/MJZf7xioWSuXatrEbvsD0WM/PzxK
         hEs839SwNXJbXCgfIsMLY8Enn2+l0oHrPo5hSdaT+FOf5M+tg44N9yYwpOzy13du4gZg
         9Wi1nLIlEMJ3EQg4dtFYt2X7X4jNan/TwEkzx9ScMQhhQXn/DuJWD7d6tUtpd+TAN6Zb
         hj8w==
X-Gm-Message-State: AJIora9cO0Yth2S10BBlHXv+02SY9HZRjpMnQsi19DsD0LK/yw+IUZS0
        2gKIIVDYxbwfOwuv8+COSbxNEg==
X-Google-Smtp-Source: AGRyM1tgG0kWlEhuCQ9FFmWivGt8MrVKTDBjqz3VTmyi7sOfPlP1oHHDgJpiV/3qtHyIbQJgVLGk0Q==
X-Received: by 2002:a05:6512:3a85:b0:48a:7229:ca59 with SMTP id q5-20020a0565123a8500b0048a7229ca59mr1251075lfu.453.1658421140269;
        Thu, 21 Jul 2022 09:32:20 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id f4-20020a05651c02c400b0025de685f3e9sm530394ljo.139.2022.07.21.09.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 09:32:19 -0700 (PDT)
Message-ID: <c7e13adb-8584-6e24-11f3-9a27c7122da4@linaro.org>
Date:   Thu, 21 Jul 2022 18:32:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] ARM: dts: stm32: add spi nodes into stm32mp131.dtsi
Content-Language: en-US
To:     Alain Volmat <alain.volmat@foss.st.com>,
        alexandre.torgue@foss.st.com
Cc:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        amelie.delaunay@foss.st.com
References: <20220721153455.3805586-1-alain.volmat@foss.st.com>
 <20220721153455.3805586-2-alain.volmat@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220721153455.3805586-2-alain.volmat@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2022 17:34, Alain Volmat wrote:
> Add the 5 instances of spi busses supported by the stm32mp131.
> 
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> ---
>  arch/arm/boot/dts/stm32mp131.dtsi | 70 +++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
> index da9e8a6ca663..db3d1b900d5c 100644
> --- a/arch/arm/boot/dts/stm32mp131.dtsi
> +++ b/arch/arm/boot/dts/stm32mp131.dtsi
> @@ -97,6 +97,34 @@ scmi_shm: scmi-sram@0 {
>  			};
>  		};
>  
> +		spi2: spi@4000b000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "st,stm32h7-spi";
> +			reg = <0x4000b000 0x400>;

Unusual order... rather first compatible then reg.

Best regards,
Krzysztof
