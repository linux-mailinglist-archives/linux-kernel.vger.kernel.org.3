Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAD85181E2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbiECKEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbiECKEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:04:09 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAE860CC
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 03:00:37 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id m20so32405682ejj.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 03:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cJekG2V4/xCYn7K3kZ4RKVbj+3+JgO2tqnr3BxrJVbs=;
        b=tV9e0NedvR5Gc1M7ULfpXh1nheq4ghSbxn9rGujRrSsOTp1aS5JkXh8IkMN6WpyVlU
         699veOVvWlBSHf5gkUrXgqfWAMgDwy8bAPceEmx/6PS1QsJenJmvymjR9q5hiLD//4F/
         y5YqU4L05oezF3rMjjvrFJotUGOr3S0qgVUidmxa1pvFuR3RpvMMg1rIT1kFdESbrOcj
         VVe3+e4iRN0xvJsACOoh8sG4Z8p7ap0BO0MzGIWuh5XyO3/Za9cJskcaSt6XQ7LPUbfL
         mywb6JIGT8tnOQl6lGsAIO+BdAv3j5x+DZz7Bcb2TZ1VfEIr7708wpqHMP+fGYbF0KDA
         +LqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cJekG2V4/xCYn7K3kZ4RKVbj+3+JgO2tqnr3BxrJVbs=;
        b=e41R/rNaP5U3pRRbT/WdVZ2dUMZtl45bAiFmYQA5pVhZlBqCKKxSysc/3Sj9qYHmJk
         bSxa2LteDgnAE+4YOiy/aBitC4Mzig+T1rMb3u9wVAfO6GDwXalbge1hjRinGSK9CfMc
         dlmOAJy9k8zsQ+yqXC57woCcJySVrLnBkemk2wlM6dGsL2oLW3bxAG1PC4ajL/kd19sR
         1PmtBLG4fQjhxYVUEfGjTyyWkiLd6O5uLES6tsSE0Oax1+Xtxpl/QCxsSKbIOiCzuEiH
         jpwoYbGJoSjArm5/3leEro6nOOI6xzzwxuQUhNQlMTsXAdPooL35I96ZRx/tnPOOlAMM
         +hAQ==
X-Gm-Message-State: AOAM533f10lmc9kJR5VI2RabiMvw/lR4OwD4CKr68JWgPp0FpUzCMl/l
        IoTrmBF7s6nm6jeFol7NXPuPLTWQRIV9MQ==
X-Google-Smtp-Source: ABdhPJyp3lcm3LeMaC93XD3a+S2w50andcYhrxX+G6SpHnTA0QNjS2VWlOyuNaWoYpuvnRRbb51fTg==
X-Received: by 2002:a17:906:3104:b0:6ce:6b85:ecc9 with SMTP id 4-20020a170906310400b006ce6b85ecc9mr14179264ejx.339.1651572036179;
        Tue, 03 May 2022 03:00:36 -0700 (PDT)
Received: from [192.168.0.201] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id gz25-20020a170907a05900b006f3ef214e63sm4464440ejc.201.2022.05.03.03.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 03:00:35 -0700 (PDT)
Message-ID: <c4d85ebc-05f1-95d5-ac71-ba92527a32d5@linaro.org>
Date:   Tue, 3 May 2022 12:00:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 7/8] ARM: dts: Introduce HPE GXP Device tree
Content-Language: en-US
To:     nick.hawkins@hpe.com, verdun@hpe.com, nick@hpe.com, joel@jms.id.au,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
References: <20220502204050.88316-1-nick.hawkins@hpe.com>
 <20220502204050.88316-7-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220502204050.88316-7-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2022 22:40, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> The HPE SoC is new to linux. A basic device tree layout with minimum
> required for linux to boot including a timer and watchdog support has
> been created.
> 
> The dts file is empty at this point but will be updated in subsequent
> updates as board specific features are enabled.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> 
> ---
> v6:
> * Added cache-controller to CPU
> * Removed hpe,gxp-wdt and removed simple-mfd from hpe,gxp-timer
> * Added space after ',' in compatible lists containing more than one
>   item

Hmmm....

>  	integratorap-im-pd1.dtb \
> diff --git a/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts b/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
> new file mode 100644
> index 000000000000..69e9c6672ea8
> --- /dev/null
> +++ b/arch/arm/boot/dts/hpe-bmc-dl360gen10.dts
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Device Tree file for HPE DL360Gen10
> + */
> +
> +/include/ "hpe-gxp.dtsi"
> +
> +/ {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "hpe,gxp-dl360gen10","hpe,gxp";

Missing space after ','

With this fixed:
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
