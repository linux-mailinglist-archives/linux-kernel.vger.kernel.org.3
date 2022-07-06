Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C915681AD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbiGFIds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiGFIdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:33:46 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD0224080
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 01:33:45 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id a11so17524780ljb.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 01:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wlxhLk8GtvHfTNPQQ5/qoeWMnw4GPuSjJ34XtezDHvY=;
        b=jlBx29CN1/dVhocZ4vJTvqAJIqrC7FjoEO2STEXPPnm66PDYmdU/gQ3OabZsG2K0Ow
         3diOXQ1IcuWmQEmetNfI9CB6CxOVkJsLZ91pPLq1RSflFwfNZongZ/lbjEvaecoJdHrk
         dOm/l8IvC3+NFahcYfWxLsxD8BBUY8SM57c/w5+R6zwXj2q3SterPeTms3YhsG/3qCtd
         FjSNTCREixR6MARnNX2ZF0kS+vLqY1ng1oVe+aeZSo2qgtb/TQvt2ei3vwQn1mLibnus
         syf0K9+v6LZTf90uUeIHr4/RO94WhuaxnPTvXROQMeeA88DYzbCIxv8VvdFic9TH66DF
         7DcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wlxhLk8GtvHfTNPQQ5/qoeWMnw4GPuSjJ34XtezDHvY=;
        b=ikAjKneuTV+azlDcHEg0nZat9Z6kTGCsbwaGdmG0RkVVWl/log3bleN37AHhP2xixy
         BnBFFkrR0hw2KOErT0kUdrlELGrDeNc68qpKVh7ITu99sAfukBnFWtuAnPqNxIs3BKBc
         mMM1B6XEZJy3NhlGEnX2GdzukAE5+VHcD9v0Z1BhCNmwS9Sh4JN42mDRW3BBhvEG1NuL
         LNItibPksLgUt3oDObuDUZejrXv9+9qV9CY/ijvDYkpwMd7Ns0mxcV6KHcmedT43gfxN
         WvlIA5q12TH5yLM5tmHXomeN0wWG40n2/24NpN+HmtEk7+NOdBUS65cRff/V9gtCmcSD
         GkYQ==
X-Gm-Message-State: AJIora9sdqZMBLddlGJfMplBpjWBy1RmwKYI+PgGwvcSUektCmp5wDWo
        oSJRci5XT66GK9crJ1Bn9J0l6g==
X-Google-Smtp-Source: AGRyM1t//aaCjXRXeweYVmhJLewHT+cZlSTWtWad/EL7MKBDFOq/Gkvw22AuaZSuvnSRhbSpg+LGBA==
X-Received: by 2002:a2e:a22a:0:b0:25d:3caf:4c2f with SMTP id i10-20020a2ea22a000000b0025d3caf4c2fmr2639216ljm.241.1657096423871;
        Wed, 06 Jul 2022 01:33:43 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id j20-20020a056512345400b0047255d21157sm6149234lfr.134.2022.07.06.01.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 01:33:43 -0700 (PDT)
Message-ID: <13e21cef-7667-db8e-7a71-00d9f19eea56@linaro.org>
Date:   Wed, 6 Jul 2022 10:33:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 02/13] ARM: dts: qcom: add gsbi6 missing definition for
 ipq8064
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan McDowell <noodles@earth.li>
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
 <20220705133917.8405-3-ansuelsmth@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705133917.8405-3-ansuelsmth@gmail.com>
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

On 05/07/2022 15:39, Christian Marangi wrote:
> Add gsbi6 missing definition for ipq8064.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Tested-by: Jonathan McDowell <noodles@earth.li>
> ---
>  arch/arm/boot/dts/qcom-ipq8064.dtsi | 40 +++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> index f06a17bd915a..1b4b72723ead 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> @@ -665,6 +665,46 @@ spi@1a280000 {
>  			};
>  		};
>  
> +		gsbi6: gsbi@16500000 {
> +			status = "disabled";

status goes to the end of properties.

> +			compatible = "qcom,gsbi-v1.0.0";

Compatible is first.

> +			cell-index = <6>;
> +			reg = <0x16500000 0x100>;

reg is second.

> +			clocks = <&gcc GSBI6_H_CLK>;
> +			clock-names = "iface";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			syscon-tcsr = <&tcsr>;
> +
> +			gsbi6_i2c: i2c@16580000 {
> +				compatible = "qcom,i2c-qup-v1.1.1";
> +				reg = <0x16580000 0x1000>;
> +				interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
> +
> +				clocks = <&gcc GSBI6_QUP_CLK>, <&gcc GSBI6_H_CLK>;
> +				clock-names = "core", "iface";
> +				status = "disabled";

Ditto.

> +
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +
> +			gsbi6_spi: spi@16580000 {
> +				compatible = "qcom,spi-qup-v1.1.1";
> +				reg = <0x16580000 0x1000>;
> +				interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
> +
> +				clocks = <&gcc GSBI6_QUP_CLK>, <&gcc GSBI6_H_CLK>;
> +				clock-names = "core", "iface";
> +				status = "disabled";

Ditto

> +
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +		};
> +
>  		gsbi7: gsbi@16600000 {
>  			status = "disabled";
>  			compatible = "qcom,gsbi-v1.0.0";


Best regards,
Krzysztof
