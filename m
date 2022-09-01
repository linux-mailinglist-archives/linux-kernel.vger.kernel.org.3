Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90ADA5A9C96
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 18:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbiIAQIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 12:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbiIAQIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 12:08:25 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAB390808
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 09:08:23 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q16so18383097ljp.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 09:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=KYvFkyrPz2x0IYdeTE0W89ngYIK6SP7fOgbckJJ8zd4=;
        b=AhvHAeuH6sqLp7A9IVsiRIbH1K2UWoVW2sqI4+XMgxdsE89ppFuHFya8dPZJx0ZnSk
         qNElNT+9M/ETdG3XfV4IfmzNm6gUvYyIFrc7fXjTF8Up32R63T9MEJu/DMcxu/5Y+rFQ
         h01k/Onijh6Hz2JyYaTRJWPsGoyMq5Rz7GlCjmmJDXPgMjMpU13cL43WUPoKf1bukSkw
         t9csYFdmo24eP4Okhi1hDS+glV1xOVgj6clFVe/TTGEH5f4NpzfoofsClv4gZtegjYPi
         cmXqpE61ISgmkY74sKBMfiKiPSMb/eiIuE+okehYnAucUW5szHn9wafaydst48Ru5ZRw
         q4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=KYvFkyrPz2x0IYdeTE0W89ngYIK6SP7fOgbckJJ8zd4=;
        b=rfrbzYlDQJxexaQV5lCuYdsTNIJMLdE/q2DD+nvvTb4qmGTiNTxilNQCQ56Ou5GOW5
         ji83B9B/vwB9I6ZtIZqlcD1moHXpHyUhP+WACz0Iy1aJg1Dii2sqJqJJkM/zBr5BFttG
         tWYKPMs3rOmAm0meWiYfEwmMpkJfnxHrpY0biNNiC3abmyOXF5dRkkpqc10XftYSvmu4
         RabbWXl+kcJqJxbRhe/sxN5nPoTGQs5TLis6Kr7qOoLbWRIfq6libxxVCnmQYdqIEU/S
         7vTkVdPZgZM1Go4oou00p7Ax92hLa64PRX1bVW9nESGUz4IYV3Xp9xa0+3H5LrnzMOzH
         /0+w==
X-Gm-Message-State: ACgBeo37ItyNR6OkmguEpI7AL31vLCeco0d1S2W1LpLXqm4xeMaohkz2
        GpFJYN7UvdupYArKr2qn4ApV+Q==
X-Google-Smtp-Source: AA6agR5utYpXb3hJTQVHi9X8ggWxlHrM7ptKBoh5n5p8CD6vKZiy0YksAgNVhPDZQN/SPhoMb/pfyw==
X-Received: by 2002:a05:651c:1591:b0:261:c388:aa58 with SMTP id h17-20020a05651c159100b00261c388aa58mr10247625ljq.277.1662048501903;
        Thu, 01 Sep 2022 09:08:21 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id o17-20020a05651205d100b0048b045a5c3asm1067234lfo.201.2022.09.01.09.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 09:08:21 -0700 (PDT)
Message-ID: <339df7b9-bc7d-039d-99d8-ecdd480419d8@linaro.org>
Date:   Thu, 1 Sep 2022 19:08:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 07/14] arm64: dts: qcom: sm6115: Add sdhci nodes and
 related pinctrl
Content-Language: en-US
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20220901072414.1923075-1-iskren.chernev@gmail.com>
 <20220901072414.1923075-8-iskren.chernev@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220901072414.1923075-8-iskren.chernev@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 01/09/2022 10:24, Iskren Chernev wrote:
> Add support for the two sdhci's present on the SM6115 and the related
> pinctrl.
> 


>  
>  		gcc: clock-controller@1400000 {
> @@ -449,6 +553,73 @@ rpm_msg_ram: memory@45f0000 {
>  			reg = <0x45f0000 0x7000>;
>  		};
>  
> +		sdhc_1: sdhci@4744000 {
> +			compatible = "qcom,sm6115-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0x4744000 0x1000>, <0x4745000 0x1000>, <0x4748000 0x8000>;
> +			reg-names = "hc", "cqhci", "ice";
> +
> +			interrupts = <GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> +				 <&gcc GCC_SDCC1_APPS_CLK>,
> +				 <&xo_board>,
> +				 <&gcc GCC_SDCC1_ICE_CORE_CLK>;
> +			clock-names = "iface", "core", "xo", "ice_core_clk";

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

> +

Best regards,
Krzysztof
