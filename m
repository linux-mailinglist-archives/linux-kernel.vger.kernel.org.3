Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EE150A6C2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390617AbiDURQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiDURQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:16:30 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2348F49F28
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:13:38 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id l127so5582876pfl.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0wWl4FXsIp8hLfZULG/A/XCUJAdHvbIInSU0lqStIPU=;
        b=Nz1ffXf4DLO/Z+REYJ+MklBjcQz3120iMfPJxRRLBbs3je06vjyBBG5FDxrRZpUAVc
         CzrHppcMnYY8wINlwLWWHBR45H7waLoKxA9BRQg/lghY2I2Bvq9cv2Aatsw1aAyHZaaR
         aILgytnNGQRyQ6d1JtLVuUSY4+56lr1DC3R+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0wWl4FXsIp8hLfZULG/A/XCUJAdHvbIInSU0lqStIPU=;
        b=EsVt6YhLWOxM5NGPi850EVayQ8XgRcvew6G/kvmU15ib6NRedkWyLQ71ZiYJCwItVI
         aTp8fH80wbmZekNXk9la45WPS3hg58epIFCSyYjk0B8aoztVhqP2HWArRjr2Tx9k/4RB
         6SVQ/C2PfvKC0TS1zG2Iks0Fef5Z7QuokmH97ICbBqTlTUOtSBo5JEUIUUSgovzjp5CM
         MbKX1vYCV2+17ifl8VRNz+WOhOt5dU8tqJ1hJsG50ePfOR59xCpM4MSPIXvsRO7JgWfo
         tdd1/T/3z9fsjXhThzsjyfph2FjClikgRA51P72nNX00mSB25WmrdVaq6VVXHaz+Z7Gp
         iqbw==
X-Gm-Message-State: AOAM532w2Z3oLWrhbcqi98y6z8DhJzcksDzXDk9pmyHfDCTi75FMZOdC
        7Xvha/6xSyELcpYlZk6m2oJczg==
X-Google-Smtp-Source: ABdhPJwwizAL1y5+YlDSH/nBYQykBSinMWD2PTa2LRu98o8m53hvdOoP+pi54/Xtb62Gp/3J7indrA==
X-Received: by 2002:a62:1a0d:0:b0:50a:cf43:d757 with SMTP id a13-20020a621a0d000000b0050acf43d757mr734350pfa.5.1650561217681;
        Thu, 21 Apr 2022 10:13:37 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:d426:5807:a72:7b27])
        by smtp.gmail.com with UTF8SMTPSA id p3-20020a056a000b4300b0050a4e73bf89sm21807495pfo.66.2022.04.21.10.13.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 10:13:37 -0700 (PDT)
Date:   Thu, 21 Apr 2022 10:13:35 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v9 09/12] arm64: dts: qcom: sc7280: Enable lpass cpu node
 for CRD 1.0 and CRD 2.0
Message-ID: <YmGQv7CN16yoLn82@google.com>
References: <1650552459-21077-1-git-send-email-quic_srivasam@quicinc.com>
 <1650552459-21077-10-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1650552459-21077-10-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 08:17:36PM +0530, Srinivasa Rao Mandadapu wrote:

> Subject: arm64: dts: qcom: sc7280: Enable lpass cpu node for CRD 1.0 and CRD 2.0

nit: and the IDP boards?

> Enable lpass cpu node for audio on sc7280 based platforms of revision 3
> and 4 (aka CRD 1.0 and 2.0) boards.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 24196a1..2e991e8 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -274,6 +274,34 @@
>  	modem-init;
>  };
>  
> +&lpass_cpu {
> +	status = "okay";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mi2s1_data0>, <&mi2s1_sclk>, <&mi2s1_ws>;
> +
> +	dai-link@1 {
> +		reg = <MI2S_SECONDARY>;
> +		qcom,playback-sd-lines = <0>;
> +	};
> +
> +	dai-link@5 {
> +		reg = <LPASS_DP_RX>;
> +	};
> +
> +	dai-link@6 {
> +		reg = <LPASS_CDC_DMA_RX0>;
> +	};
> +
> +	dai-link@19 {
> +		reg = <LPASS_CDC_DMA_TX3>;
> +	};
> +
> +	dai-link@25 {
> +		reg = <LPASS_CDC_DMA_VA_TX0>;
> +	};
> +};
> +
>  &lpass_rx_macro {
>  	status = "okay";
>  };
> -- 
> 2.7.4
> 
