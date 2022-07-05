Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1308F566F1E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbiGENWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbiGENWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:22:10 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9AA3DA5F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 05:43:02 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z25so2765692lfr.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 05:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LhRP3Fs8es0YSIO5OURsnRUsMb+iHyPX4K2ymrrkIcY=;
        b=ympMdoL9ALTNzr927Sb6ZJpQBn1/XzX7lw2jckNZOQCx6b7BOW3EXmgotZo4oO3c2Q
         LLh9EiG+BTlD3yuKpUJUNJCgpC6AQQk3G8AU/I0dok7F5DWqOYMrHLilaB4EjmqAdNzX
         xL0XHKTIbb9ZB1dkq790GWmmihXJCV54gmrOHbOEx+mmt5AWZkOeQ5oeCgejCDjMs7nQ
         5cWuB3BWYBDyu+1XcNrSR+BuF3Z2Z/vQqoiUf1GITrDg/9xO4yLPGpGEFUFY9jBDDbLg
         mwE+VvMkgtGkabn3ldqLmIiQ3fXY2It375m0/t4+Lxy07eNFIQjG7Wv99Wdy3gBRqHxI
         3/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LhRP3Fs8es0YSIO5OURsnRUsMb+iHyPX4K2ymrrkIcY=;
        b=qop6ULEbYi8/Cu8c8x1VPo7lwL/Y8cPpXeXpqrIOZFOGwb7JLL0ToXkX4I+XtQYnjO
         XuNItcr9mkYmoNPcv+XsjvF8zkyBo5VTSHYkmPEfZEobS/WhBxD95LHXIOEEuOxogqXe
         NRfNwzEnUtqCoEMxAdz8x/akSmpJRHeeZBgo42rnPLIylMXmu1232vvG9RpEWmB8dpo3
         2TJgjIbWex09kLTVCkNzkVS3vCga2hyZ1tdC/aE2RKyCqVBoVzkzJ6RqgVLf3a8nBm4j
         PtQXVJ8sK3H1uQsoDQ8MC1XE0SwoYhyv5wGa9jKkckHAhaQejNBUiUW6d3utYrH5NWjk
         qBxQ==
X-Gm-Message-State: AJIora+DAWENUEEvpZl0gK1nTJNYVgYSCpbh58CdEJLoAe39W5ua6bgq
        ev1aoAYT+9Eqx0rcjtdk8D+6Pg==
X-Google-Smtp-Source: AGRyM1uc/CKohVgiEjxCCTModTLEDHqFjosQAOpUaERzggdyeboWzBSEXyVmRJeK2dFrGPobqKoTcA==
X-Received: by 2002:a05:6512:2208:b0:480:ff57:ab31 with SMTP id h8-20020a056512220800b00480ff57ab31mr21792943lfu.144.1657024980446;
        Tue, 05 Jul 2022 05:43:00 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id j13-20020ac253ad000000b0047f7f4cb583sm5659745lfh.288.2022.07.05.05.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 05:43:00 -0700 (PDT)
Message-ID: <cc41d10e-8c3d-7911-560e-88158c91f4fe@linaro.org>
Date:   Tue, 5 Jul 2022 15:42:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 02/14] arm64: dts: qcom: sm8250: add missing PCIe PHY
 clock-cells
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220705114032.22787-1-johan+linaro@kernel.org>
 <20220705114032.22787-3-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220705114032.22787-3-johan+linaro@kernel.org>
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
> Add the missing '#clock-cells' properties to the PCIe QMP PHY nodes.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Fixes: e53bdfc00977 ("arm64: dts: qcom: sm8250: Add PCIe support")


> ---
>   arch/arm64/boot/dts/qcom/sm8250.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 53e0b57c13e4..f45a6cca397f 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -1892,6 +1892,8 @@ pcie0_lane: phy@1c06200 {
>   				clock-names = "pipe0";
>   
>   				#phy-cells = <0>;
> +
> +				#clock-cells = <0>;
>   				clock-output-names = "pcie_0_pipe_clk";
>   			};
>   		};
> @@ -1998,6 +2000,8 @@ pcie1_lane: phy@1c0e200 {
>   				clock-names = "pipe0";
>   
>   				#phy-cells = <0>;
> +
> +				#clock-cells = <0>;
>   				clock-output-names = "pcie_1_pipe_clk";
>   			};
>   		};
> @@ -2104,6 +2108,8 @@ pcie2_lane: phy@1c16200 {
>   				clock-names = "pipe0";
>   
>   				#phy-cells = <0>;
> +
> +				#clock-cells = <0>;
>   				clock-output-names = "pcie_2_pipe_clk";
>   			};
>   		};


-- 
With best wishes
Dmitry
