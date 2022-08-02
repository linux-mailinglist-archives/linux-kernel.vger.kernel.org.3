Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C595878AD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 10:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbiHBIFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 04:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236304AbiHBIFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 04:05:25 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A595F5B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 01:05:22 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x39so11255735lfu.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 01:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=56zrn37C4l7p2DAkni03ePVpqDUmjAfKCMc+oB4Stlk=;
        b=zU6yAKCdfwACj1LN8M8wvnZF8gHg+PW6MbaJtxOXfjPZTwJFcbsX5rh/4PcyIWFme1
         7U3JuH6zupd8cH8x4qCM0FHKfjfSOT6oqCxTeBe5iYp/cla6mcBJ6lT6OVcXC5NFs4PH
         nwLe/i8HdU1F3EaiUhFefSu+O0CnNTDpzr9XET2CF+sSPkT3cfq5eqeTUiyD73P3gTPW
         td+OZMByUgxO/Xn5SDPI2aJR6TKFVzFjrnRRARwQWY3bzO0BzIq0XTKJifXR2B9sQBt0
         HH5llronv3dhWHsrTL7p/qsgSkDXD95M2lxNP+KXHPOy6YZsi6aXySPVvltlGIXeUj9w
         J3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=56zrn37C4l7p2DAkni03ePVpqDUmjAfKCMc+oB4Stlk=;
        b=h7BPC9zKfJyT+V/CDTvA9WmFw+bx0bbFiyGuPCebNkqTGdBve5IshNY6wLVIC655Jg
         f7c0PugF4AS+yoss3W5V4vnkH5w7X2Kqaon0e/5xMAUQSEb565YGp2Fi/P8wOGKZs7tJ
         G4dsHpzLEhF+f13F+fWuPMP8t/dTWP64qlN0bCMLArwnjYpKHuez//CGLInNjMmM8zVj
         mlpEXTVR2/Ouay3qmTfnsskoIs26kyHFbMetKEe/a4/B/XqSCJOnM/A+AJPU79+o6QOI
         yEidU8Y6CQfvO2/VEHjdBT2Q9VmmW4uA6ZWKhv0ksX5dfTDpzd4irH5Chs1HRYbbB6O4
         vurQ==
X-Gm-Message-State: AJIora8PQSnlE5OOGSGb2MuiqNdjxTiuRDoatUFG6Z5VPc4BuGR9Ws2V
        l1fiMhRhGweSt8Am+alt7W6OYw==
X-Google-Smtp-Source: AA6agR62HyYSvC+LgEWXptx8UvHMaf3t1Teq0GYaR98724D7kJpvXdUM92sSva+zoy1yTiI605wHtw==
X-Received: by 2002:ac2:4e0d:0:b0:48a:bc83:7fb8 with SMTP id e13-20020ac24e0d000000b0048abc837fb8mr6560745lfr.623.1659427520594;
        Tue, 02 Aug 2022 01:05:20 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id c14-20020a2e9d8e000000b0025e5b5474a4sm190805ljj.85.2022.08.02.01.05.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 01:05:20 -0700 (PDT)
Message-ID: <9ef21f8e-163e-fc31-636d-c0d6d004f27f@linaro.org>
Date:   Tue, 2 Aug 2022 10:05:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 3/4] arm64: dts: meson: Add DDR PMU node
Content-Language: en-US
To:     Jiucheng Xu <jiucheng.xu@amlogic.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chris Healy <cphealy@gmail.com>
References: <20220801060049.1655177-1-jiucheng.xu@amlogic.com>
 <20220801060049.1655177-3-jiucheng.xu@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220801060049.1655177-3-jiucheng.xu@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2022 08:00, Jiucheng Xu wrote:
> Add DDR PMU device node for G12 series SoC
> 
> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
> ---
> Changes v2 -> v3:
>   - No change
> 
> Changes v1 -> v2:
>   - Remove model, dmc_nr, chann_nr properties
>   - Add g12a-ddr-pmu, g12b-ddr-pmu, sm1-ddr-pmu compatibles as
>     identifier
> ---
>  arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 7 +++++++
>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi       | 4 ++++
>  arch/arm64/boot/dts/amlogic/meson-g12b.dtsi       | 4 ++++
>  arch/arm64/boot/dts/amlogic/meson-sm1.dtsi        | 4 ++++
>  4 files changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> index 45947c1031c4..7e556fe575be 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
> @@ -2146,6 +2146,13 @@ hdmi_tx_out: endpoint {
>  			};
>  		};
>  
> +		ddr_pmu: ddr_pmu@ff638000 {
> +			compatible = "amlogic,g12-ddr-pmu";

No. Test your DTS against bindings first.

Best regards,
Krzysztof
