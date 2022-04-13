Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E404FF0BB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 09:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbiDMHm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 03:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiDMHmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 03:42:43 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52FE1EAC7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:40:20 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u19so2005315lff.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DJLJUZ5W5QrQNorPuhVBZk31ozNDYTlIXuspQU8iTXA=;
        b=lpbBMv0P981hAOP4gANFVsX43x8TW44Se82vUrOBqgL5z36JtJ8CNvu5vOZz5bqiFQ
         WO/IUpslAiW5L1Dm49lyUsDhrGZGFgLh8EGT46ILedjwhwDFolRubfSBsuIUuuTzZCLW
         YreS6pnwkg60z772Ovpg+sYUniUoak5squK0d2lS27l+95uI/YkzgQDLTknOExNC5ChY
         a1AdbIIXjPT9wBkt+Et3uVbREvxs9Yq28nZMtpD/XlWA1dddvAmWPkHDdiMREcG6gG2+
         X43htRTk9DIdy4Xitb5NpGnXv45quT+wa5VR+J5xPycFoiO1pz6q+7hi404+a16ULSN1
         QG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DJLJUZ5W5QrQNorPuhVBZk31ozNDYTlIXuspQU8iTXA=;
        b=N5zE9sumS43a6yyJAvNQLn3OX5YR03847FueUyrQ82u4eaggwqbl2XFcJxGgo5QhQk
         bdbQ93M9SXQmyQIyH39OtXhw533uYra+e9tziGhDz1LFI5vuc/Lpj/nBEEixYrgYEv37
         Jycorij/s04xArWXUvYAOuU8x7QTwaQClRgkPGi+Uq5ID1cd8pFjuRvDhk/h/zsB4R5p
         NEUqOvWiw2Wj47Z7i29T2AmUrirgEjAFPFmgVyI4YH6aQ/qhP+YMBElTOFXeZdyZnp2P
         z+5KTjWBYStqoxfBR+g2Ol8b8OBe64BG/6ymR0YG8VoBUhjiUXzAjyuoopBdRZuMICQF
         h5nw==
X-Gm-Message-State: AOAM532LrD9NqVYe2J/V5OByP0VsGpHlEp1DDF66YOZFI8hNJh3RKrdr
        aR/3T1O/j/3CCYQKF7N6ssr4YQ==
X-Google-Smtp-Source: ABdhPJyHYuYoE8j30RTzyjwkaVAvL/uPJ0wNi72TAqvVSPv18ZSqs7v78jwe5jwWyIItaFk1NmH7Mw==
X-Received: by 2002:a05:6512:262a:b0:45d:b42d:3e46 with SMTP id bt42-20020a056512262a00b0045db42d3e46mr27259650lfb.22.1649835619138;
        Wed, 13 Apr 2022 00:40:19 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y37-20020a0565123f2500b0044a1e1c6b37sm4010722lfa.53.2022.04.13.00.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 00:40:18 -0700 (PDT)
Message-ID: <32df5270-9df8-c5be-a9d2-9764409a2711@linaro.org>
Date:   Wed, 13 Apr 2022 10:40:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 06/18] ARM: dts: qcom: enable usb phy by default for
 ipq8064
Content-Language: en-GB
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan McDowell <noodles@earth.li>
References: <20220309190152.7998-1-ansuelsmth@gmail.com>
 <20220309190152.7998-7-ansuelsmth@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220309190152.7998-7-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2022 22:01, Ansuel Smith wrote:
> Enable usb phy by default. When the usb phy were pushed, half of them
> were flagged as disabled by mistake. Fix this to correctly init dwc3
> node on any ipq8064 based SoC.

Typically they would be disabled in the platform dtsi file and would be 
enabled one-by-one in the board dts file. So, if half of usb phys are 
enabled by default, I'd kindly ask to perform the opposite change: 
disable all of them by default and enable in board dts files.

> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> Tested-by: Jonathan McDowell <noodles@earth.li>
> ---
>   arch/arm/boot/dts/qcom-ipq8064.dtsi | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> index 9d658fcc1f12..e247bf51df01 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> @@ -1175,8 +1175,6 @@ hs_phy_0: phy@100f8800 {
>   			clocks = <&gcc USB30_0_UTMI_CLK>;
>   			clock-names = "ref";
>   			#phy-cells = <0>;
> -
> -			status = "disabled";
>   		};
>   
>   		ss_phy_0: phy@100f8830 {
> @@ -1185,8 +1183,6 @@ ss_phy_0: phy@100f8830 {
>   			clocks = <&gcc USB30_0_MASTER_CLK>;
>   			clock-names = "ref";
>   			#phy-cells = <0>;
> -
> -			status = "disabled";
>   		};
>   
>   		usb3_0: usb3@100f8800 {


-- 
With best wishes
Dmitry
