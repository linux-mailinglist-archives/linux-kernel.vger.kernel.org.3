Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AE758D332
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 07:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbiHIFcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 01:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiHIFct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 01:32:49 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DB417A9B
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 22:32:48 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a9so15513275lfm.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 22:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jXrsz+hPo7uM9Ts7BZ1QcFnFvHqlv6WfJx8qylXeF5o=;
        b=FtXlMk39aN21nXaPR77Y1ZtEnDupnVhhExSRhXnX0OO5lXmwpqR12SSv5p82ppX7VM
         Aql+1vmRahqbO54KIIl8w/Qiau50kPzcjSkYELCfvBhQ21mqMG94UXeZLaZN9Hh0SXRR
         z8t/mvV3tIfzci8lEUZyGd1uTqBzv4ZoKJGYyVdcdMGVf89zKjD7DdBJ0agerNkS+3kd
         0lDIOMf8JFBXL2f0GuhL0IG+o7mylYy3UI5EpzfAazAMryvdjHarAEnruGqQGfUWLzJm
         6wyavCH/opPMCny6PwsYNza5yIrp1RzhxhH5q++n3EYJ4KNkgtjNt0OcU/n5iOViDw96
         gOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jXrsz+hPo7uM9Ts7BZ1QcFnFvHqlv6WfJx8qylXeF5o=;
        b=12QGJNmEQFQWwZfYZJ52riuzSPJZLflZhIc6DEu7arj8vL7zA8fsB5mlobP908zLyG
         IK924CFEOgOhE/Xk0F6T2A0ki1q6BtYXkoSDH5rZbKBR1VNKXAmXiYc8yH3BLt3i2NlU
         n89aLUx6RlzWO66Ts6m8DlFznR//SpzjDIkRmy+Y1kxkVa+LW5B70/3QdgqIBceFJf8Z
         qurdYXqAsfIUe/u8OAclq1V0vGUsOMKzTEAHLMkBSqhAZW+/sLcGPotj3ywyWEipy+MG
         6xwbk0hGHZoo56DRIwsy8ylp4x0b1/+Cq6dSoOl/XRjnI1ceKwUf+urhK7sqs+tOnzX5
         ha1A==
X-Gm-Message-State: ACgBeo154gvPCzCRtyW4KZ2986lcduC+l/2oE4nBfLjmODPCYq4tk5YS
        YZwJj007euUn+wZLnX+EKoB0xg==
X-Google-Smtp-Source: AA6agR5AT8zfAo/4iJU4TuqAZVPu2vYEWKLzbFO3EHMVZ/Z/CGOtQTYoZBa0e1bf3+2iM8rMK3l+YA==
X-Received: by 2002:a05:6512:c02:b0:48a:80f:b92d with SMTP id z2-20020a0565120c0200b0048a080fb92dmr7801928lfu.675.1660023167051;
        Mon, 08 Aug 2022 22:32:47 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id k11-20020ac257cb000000b0048a73208cbbsm1627637lfo.280.2022.08.08.22.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 22:32:46 -0700 (PDT)
Message-ID: <9199f9a4-f527-ad90-917d-3121c41082b2@linaro.org>
Date:   Tue, 9 Aug 2022 08:32:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/2] ARM: msm8960: Rename cxo_board to cxo-board and
 add alias
Content-Language: en-US
To:     Rudraksha Gupta <guptarud@gmail.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, david@ixit.cz,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
References: <20220808234723.5184-2-guptarud@gmail.com>
 <20220809000300.6384-1-guptarud@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220809000300.6384-1-guptarud@gmail.com>
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

On 09/08/2022 03:02, Rudraksha Gupta wrote:
> This patch renames cxo_board to be up to date with the current naming
> style. It also adds an alias.

Same comment as v1.

Additionally you do not explain why you are doing it.

> 
> Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
> ---
> v2:
>  - Group the correct changes together

Don't link new patchsets to some other threads.
> 
>  arch/arm/boot/dts/qcom-msm8960.dtsi | 2 +-
>  drivers/clk/qcom/gcc-msm8960.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
> index 0e099aa7c889..2ed969785b78 100644
> --- a/arch/arm/boot/dts/qcom-msm8960.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
> @@ -58,7 +58,7 @@ cpu-pmu {
>  	};
>  
>  	clocks {
> -		cxo_board {
> +		cxo_board: cxo-board {
>  			compatible = "fixed-clock";
>  			#clock-cells = <0>;
>  			clock-frequency = <19200000>;
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


My comment from v1 still applies - this does not match subsystem.
Additionally DTS change and driver change *cannot* go together.
Basically your commit is non-bisectable which is indication it is not
correct approach.

Best regards,
Krzysztof
