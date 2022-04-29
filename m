Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE12514FAD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343710AbiD2Pkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344267AbiD2Pkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:40:41 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24604D64E2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:37:21 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id v4so10943624ljd.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=tX5B+XNuprxeTIlbG/3H80IXDOGiNxtXPtXER0/ilC4=;
        b=vMpBLAWofJB14kAEHBpFa1NC+M7Xli8t96vO27YJcrZbbvDae0THbnSOs/DVKdddCJ
         TkDlo+al/pq8PvU5q07Wlsj7A499DxWEpYGvR3nThJe5ASqtPWBp23YJwFuyAtuyty46
         q8cLDnhKLFUpu8bW8YVCpGK0E38IR2r2V3q4CdrW6xVN6WOtDaJ90SbHkRhgU3pj/a/v
         UWUWH9xu8dsnM339mhngjhCtIgWEPi+0oVEjCy+DMLO7ZsoQbk8iU/+9QTr0UjBUYEbQ
         9Ou4r+Oal1LwfxbG7Wcmv2EekpglJNKoBVgQ1NI9ZQhzjH8wiFWROovtZgbx4w4WatCD
         LeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tX5B+XNuprxeTIlbG/3H80IXDOGiNxtXPtXER0/ilC4=;
        b=E29DBXHAnFDjew79yyGeZi+3Hq/np7RLCFlAQn0hVbSJP2Zk42knL0T3grw6vMV8XT
         KPvDfLST6AC1/gg0ymtKVYqKRoirbHF7Smetpv+trJzvxnbsBEI6SvLELbqMUMJ6Rm0y
         ngY11yqYTzKwd38KAU8TuCmA+09se8ZNodVbliA06ebjT0+FVmkcQIhYDmZ88urjIEsU
         ZL/n4VMzXFfgbDEkwGHnoidqvCffBVf6HicOqaVkPhfqs7b3F/CaAdgOaBMz+xwtWIdl
         7D+6MY/IreonxOT2Q75Rgfgr5a0K9SqQxUB/yszoCqo2y00IedCZ3KkXcjrYgV+6RL+a
         ZHBQ==
X-Gm-Message-State: AOAM5312NREc9pUmqot0AJ3ra8o4/S/QFdQU3nbheAe1jVzx0FT2clj2
        tb5gpaw6arrOgIvsmsl5c7NSRw==
X-Google-Smtp-Source: ABdhPJz0MkxQGLGnvyGJvXL0G1mJRGSzAa8m+lcGzUyGNkLb1KxdXRVLuJsuhMrQwqZbPpz1LUmhJQ==
X-Received: by 2002:a2e:8346:0:b0:24d:ac67:42c7 with SMTP id l6-20020a2e8346000000b0024dac6742c7mr24657567ljh.323.1651246639214;
        Fri, 29 Apr 2022 08:37:19 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id f2-20020a193802000000b004721714d2a2sm263121lfa.214.2022.04.29.08.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 08:37:18 -0700 (PDT)
Message-ID: <65d2fc77-fb4b-b53b-d1bd-41c9688891e2@linaro.org>
Date:   Fri, 29 Apr 2022 18:37:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 8/9] arm64: dts: qcom: sm8350: Power up dispcc using
 MMCX regulator
Content-Language: en-GB
To:     Robert Foss <robert.foss@linaro.org>, bjorn.andersson@linaro.org,
        agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, jonathan@marek.ca,
        tdas@codeaurora.org, anischal@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220429151247.388837-1-robert.foss@linaro.org>
 <20220429151247.388837-8-robert.foss@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220429151247.388837-8-robert.foss@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2022 18:12, Robert Foss wrote:
> Add regulator controlling MMCX power domain to be used by display clock
> controller on SM8350.

NAK. rgulator-fixed-domain is deprecated and is going to be removed shortly.

> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8350.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index c0137bdcf94b..c49735d1b458 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -278,6 +278,14 @@ memory@80000000 {
>   		reg = <0x0 0x80000000 0x0 0x0>;
>   	};
>   
> +	mmcx_reg: mmcx-reg {
> +		compatible = "regulator-fixed-domain";
> +		power-domains = <&rpmhpd SM8350_MMCX>;
> +		required-opps = <&rpmhpd_opp_nom>;
> +		regulator-name = "MMCX";
> +		regulator-always-on;
> +	};
> +
>   	pmu {
>   		compatible = "arm,armv8-pmuv3";
>   		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;


-- 
With best wishes
Dmitry
