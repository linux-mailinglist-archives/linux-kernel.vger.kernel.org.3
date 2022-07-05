Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADEB566F9B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbiGENmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbiGENmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:42:31 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E665D2BB02
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 06:06:21 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id t19so19802859lfl.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 06:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ioYfpThi9nRqg/GAIvq073p5ZZ7ox+oQ40EYBD9d07g=;
        b=v05hZ3sTiVWV3MwWmpC2T5XDz1MtkZv1o3pEj6pQYcF7zeW4KUig1Ul0jfhgbR69DB
         OcrOOzuu5TqnO96WcR3mDTvR1ESoledOIRnzTqTLQ062q6+vTrk/wzrKD5zFNVMdtmhk
         /kfYPoVMbpV0fDezcBk4JF9/v2/QS2ZZB4CKu8wswVhJlOdMimQrTdI7ySU2eDoEGTWe
         JUxQp+JzUR1cYZ3Q8k57hbe3HBeV6FFD4OmXi6fByUR3WOfjc8Mfb9fWLwSrNG40RTNH
         LpWbM6gID07GZTgKTI5XtiEIKGBq16wbXTssI9Ym45rH+Vlk642qDgWNKgmdbV6Qe7PM
         xViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ioYfpThi9nRqg/GAIvq073p5ZZ7ox+oQ40EYBD9d07g=;
        b=sv8RoSCvSRQ3ASvN55jBU3nlh6sNOBFKEV6YiW3mXNJaj26iyuS3FqD1fXebmEejIk
         3Yiht1IyzmxbPaxlKRu8aLPI2tjn6m1uMnV3tn/eFzMx2P2bYGX9fFfNn8ZPCxtDIPZu
         bNSBUh5hVHBIuRO2fQn8qKIDzK+pSTOFeWeeOlAWclNKb042ui0Lrvmpxlz9LhBSIsgc
         FKopHzMjgKvuoIp5hGe6iI0ptzmO7FGKWUc9T1qriC2RrzpJGKSxTU7REw3v/0aU8SD2
         pzK0oRvX1jY0GJ4nIEVIfFasvcSyJ+OcT1U7oybmjFwvyPbTLe866SD4tt71OP1qwdd2
         +zlQ==
X-Gm-Message-State: AJIora859GEk2IBhf+Da8w2PrdKfR6HXtIgDrtpj0ZEcuiwarx5rPASj
        VlVLe88+1TVaHM5IzfrUcNwclQ==
X-Google-Smtp-Source: AGRyM1uQbhvJrF9cX/r2cmWaf83M/XE+BQANqUaARiClJfwqr9ID2qAXVFLJ2o6Bgkim191JnT6qyg==
X-Received: by 2002:ac2:4bcc:0:b0:481:25b8:51b9 with SMTP id o12-20020ac24bcc000000b0048125b851b9mr21783387lfq.207.1657026380324;
        Tue, 05 Jul 2022 06:06:20 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y13-20020a056512044d00b00483a339a4e8sm308795lfk.144.2022.07.05.06.06.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 06:06:19 -0700 (PDT)
Message-ID: <f8e44194-4a9f-be6f-a170-e59757476837@linaro.org>
Date:   Tue, 5 Jul 2022 16:06:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 09/14] arm64: dts: qcom: sc8280xp: drop UFS PHY
 clock-cells
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220705114032.22787-1-johan+linaro@kernel.org>
 <20220705114032.22787-10-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220705114032.22787-10-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 05/07/2022 14:40, Johan Hovold wrote:
> The QMP UFS PHY provides more than one symbol clock and would need an
> index to differentiate the clocks, but none of this is described by the
> binding currently.
> 
> Drop the incorrect '#clock-cells' property for now.

Could you please take a glance whether 
https://lore.kernel.org/linux-arm-msm/20220620153956.1723269-2-dmitry.baryshkov@linaro.org/ 
makes a sense to the sc8280xp platform?

> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 345a19a6e874..ce4df4e814fe 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -1447,7 +1447,6 @@ ufs_mem_phy_lanes: phy@1d87400 {
>   				      <0 0x01d87800 0 0x108>,
>   				      <0 0x01d87a00 0 0x1e0>;
>   				#phy-cells = <0>;
> -				#clock-cells = <0>;
>   			};
>   		};
>   
> @@ -1517,7 +1516,6 @@ ufs_card_phy_lanes: phy@1da7400 {
>   				      <0 0x01da7800 0 0x108>,
>   				      <0 0x01da7a00 0 0x1e0>;
>   				#phy-cells = <0>;
> -				#clock-cells = <0>;
>   			};
>   		};
>   


-- 
With best wishes
Dmitry
