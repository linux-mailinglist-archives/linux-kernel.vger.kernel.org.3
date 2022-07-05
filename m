Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A359B566F17
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbiGENVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiGENUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:20:49 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F4C3BBE9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 05:42:13 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bu42so482829lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 05:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ShCrJ4hyEx4vHUXU6iKjtj3Ok0nVe/BM9eUFlsSXi44=;
        b=JzmVzJA4dIVMLfeMhkcD8TkJf4Dhaw5aFkZ/vxR42AzuPuMS65TpOHdxsK8diBpyOK
         D7gjCqMOh+EDffLsnXSXNkTT4+4+8snyflCytiWIK7+84hhUoAjDqF7dDhE/ROkMjfB8
         1TyLmD1qJNz6hF4zO8pF81pbqarxwFAVDVKIzCiA2LHWfykK4Z+XSY0Y8ts4EXAV1n0/
         ArJJeaGDl/zfyADJSbqJSY9UxqG7GscZ70Z4YSfmL4PSkcdTlg+4t1q2LE0z08nv8xg9
         2BcpwWulYhiRJ2hUnHkiiveVfFUulQPVYZtmq2IGwBexsH89zo5/sFu/p2wvGOhBGyIu
         zrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ShCrJ4hyEx4vHUXU6iKjtj3Ok0nVe/BM9eUFlsSXi44=;
        b=DZL5hU6dyErwidGqK6Zwncx743c6iciZakWTyIUGIgXiXrpZ/PYusHKHMpyw76hUJ4
         ugGC9nkn0XcI/7djK+z7p0c+NIF+nLIOBlXbOHoXJ5CAfkLcq8Aya8IB7KydSDMgXrgs
         PF51IputVwcmqOyvk5aGwDhQretxRQO1lAjj8QyaxOj25l9b+luO7qEFaHSPgl3B5z98
         DXX7zCxwnVf6TvaGctceWGzlz/CqROIq6t1kkC2A4FjPE/VWzAFXkYxtwWDt1lLSIU70
         Z4tIWeCeYOrArUfJQDDWXXM5h6zw/CdzZRLzfhaT5WXNL9NgOYqD7gaZEVKf48s0QrfY
         4SLA==
X-Gm-Message-State: AJIora/Ch3BJZchswP07dol0Q19xxpUOLmQ2gHPJUENWk6EY5rZ6RgxV
        fp1Qk4vlT+bSx2aLTrob02YFTw==
X-Google-Smtp-Source: AGRyM1vdICLYmSOmQ9/Rc7nIkxH0E0qUR6oXT6Sir3njqmqkWHDhkB6/IPMiO7T1OLEE8aSUphi7Fw==
X-Received: by 2002:a05:6512:3ca5:b0:481:3378:b9b7 with SMTP id h37-20020a0565123ca500b004813378b9b7mr22304277lfv.56.1657024929537;
        Tue, 05 Jul 2022 05:42:09 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id n10-20020a0565120aca00b0047f77c979f3sm5674924lfu.235.2022.07.05.05.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 05:42:09 -0700 (PDT)
Message-ID: <e3b344e7-4100-e0d4-0dcd-aeef4893ad43@linaro.org>
Date:   Tue, 5 Jul 2022 15:42:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 01/14] arm64: dts: qcom: sc7280: drop PCIe PHY clock index
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220705114032.22787-1-johan+linaro@kernel.org>
 <20220705114032.22787-2-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220705114032.22787-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2022 14:40, Johan Hovold wrote:
> The QMP PCIe PHY provides a single clock so drop the redundant clock
> index.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Hmm. After checking the source code, the clocks entry of the phy@1c0e000 
node also needs to be fixed.

And also maybe:

Fixes: bd7d507935ca ("arm64: dts: qcom: sc7280: Add pcie clock support")
Fixes: 92e0ee9f83b3 ("arm64: dts: qcom: sc7280: Add PCIe and PHY related 
nodes")


> ---
>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index e66fc67de206..b0ae2dbba50f 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -818,7 +818,7 @@ gcc: clock-controller@100000 {
>   			reg = <0 0x00100000 0 0x1f0000>;
>   			clocks = <&rpmhcc RPMH_CXO_CLK>,
>   				 <&rpmhcc RPMH_CXO_CLK_A>, <&sleep_clk>,
> -				 <0>, <&pcie1_lane 0>,
> +				 <0>, <&pcie1_lane>,
>   				 <0>, <0>, <0>, <0>;
>   			clock-names = "bi_tcxo", "bi_tcxo_ao", "sleep_clk",
>   				      "pcie_0_pipe_clk", "pcie_1_pipe_clk",
> @@ -2110,7 +2110,7 @@ pcie1_lane: phy@1c0e200 {
>   				clock-names = "pipe0";
>   
>   				#phy-cells = <0>;
> -				#clock-cells = <1>;
> +				#clock-cells = <0>;
>   				clock-output-names = "pcie_1_pipe_clk";
>   			};
>   		};


-- 
With best wishes
Dmitry
