Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5289A58D32F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 07:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbiHIFbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 01:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbiHIFa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 01:30:57 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585FE21B5
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 22:30:56 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t1so15552024lft.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 22:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sKwNIt+Su79UppYhwI6KzTX7lzsG54zDOaS458PPq0U=;
        b=rvIJKHD9j94DMkpsYlJg3wlog0UPCoFTp0kA1NMcJYKV8rCjD+gncCpD/1ZZsUUARL
         hCGGZEGskm9SXouLFtNhMMEY54eFrCf6lFMWG2uLIkJG9WYlmfbeGQ+SY2ziW4fv6PeX
         yEQ0HxZqW+oKYoniUoE7HQjVKavsG2YOQu3f7BYpW0ZlRrQ4NVVlts7VRhrVO754cyri
         q9gndgD+u2WjFyVinTQkjDR2ooQScBxEeP2dHwsY6GZhOVEiSwf9HMFdTZBZmmGQIvyF
         J/RfZPOb7Leq8OK0PUHNoZ+ccLAw/4pVgBRwMEDrpose5n2n6y2coD+a39O5007ezT7t
         Rvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sKwNIt+Su79UppYhwI6KzTX7lzsG54zDOaS458PPq0U=;
        b=OT9ZP3PqqPfXqwalq4otiMN+5a3jmQTg42zFsvkQNpUduR/4ynrk2qrgACfR3FeP7B
         2Tgx03shIkTVE32mQpZS1Bmqc7dOD2zi77W2XhOa6fPWnEDRST6GwMn9bAOkwGEb+wD0
         dhj/H/TSZ+vg/9ULMAxxFZVGolnMqeHB22odP2dO2yD6K5uinm3LC6N8D6Ynd2p+8rA6
         CJ5k222st/KKpilVfYPjUAaWCyUmucPkFlvzPMoUQ+7fNtEQWs5wo8fzBASnTdG0vMkv
         S0PMi90o1vF1oWZ0M728d5joomObG+rTtttP0h6l1Pp57nQULdzfeSd9DGCiIPZLmssG
         LK/Q==
X-Gm-Message-State: ACgBeo04778pLPN0bbT1Zgc5hPGkCjJa9LBckYUp8YfwFroVPp0RcOUh
        xA1T1VJy6jXp1PJbl+7GvPsYBw==
X-Google-Smtp-Source: AA6agR6BzACfIJmBVjmp3EG4nPvz2giX+6BEYM6KC8E4LFpoYhpibF1aKDUpao68Wituea3Vd8vUmw==
X-Received: by 2002:a19:3859:0:b0:48b:2523:d26c with SMTP id d25-20020a193859000000b0048b2523d26cmr7750713lfj.88.1660023054752;
        Mon, 08 Aug 2022 22:30:54 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id m9-20020a056512358900b0048abf3a550asm1634905lfr.224.2022.08.08.22.30.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 22:30:54 -0700 (PDT)
Message-ID: <4b39c749-5685-c821-6723-4a950287656d@linaro.org>
Date:   Tue, 9 Aug 2022 08:30:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] ARM: msm8960: Rename cxo_board to cxo-board and add
 alias
Content-Language: en-US
To:     Rudraksha Gupta <guptarud@gmail.com>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, david@ixit.cz,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
References: <20220808234723.5184-1-guptarud@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220808234723.5184-1-guptarud@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2022 02:47, Rudraksha Gupta wrote:
> This patch renames cxo_board to be up to date with the current naming
> style. It also adds an alias

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> 
> Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile     | 1 +
>  drivers/clk/qcom/gcc-msm8960.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 05d8aef6e5d2..d55f196ad733 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1049,6 +1049,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
>  	qcom-msm8660-surf.dtb \
>  	qcom-msm8916-samsung-serranove.dtb \
>  	qcom-msm8960-cdp.dtb \
> +	qcom-msm8960-samsung-expressatt.dtb \

This does not look related at all.

>  	qcom-msm8974-lge-nexus5-hammerhead.dtb \
>  	qcom-msm8974-sony-xperia-rhine-amami.dtb \
>  	qcom-msm8974-sony-xperia-rhine-honami.dtb \
> diff --git a/drivers/clk/qcom/gcc-msm8960.c b/drivers/clk/qcom/gcc-msm8960.c
> index 051745ef99c8..56ce05a846dd 100644
> --- a/drivers/clk/qcom/gcc-msm8960.c
> +++ b/drivers/clk/qcom/gcc-msm8960.c
> @@ -3624,7 +3624,7 @@ static int gcc_msm8960_probe(struct platform_device *pdev)
>  	if (!match)
>  		return -EINVAL;
>  
> -	ret = qcom_cc_register_board_clk(dev, "cxo_board", "cxo", 19200000);
> +	ret = qcom_cc_register_board_clk(dev, "cxo-board", "cxo", 19200000);

... and this does not look related to subject prefix.

Best regards,
Krzysztof
