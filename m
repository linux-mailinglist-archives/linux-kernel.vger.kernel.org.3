Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4005ABFF7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 19:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiICREa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 13:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiICRE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 13:04:27 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F176EB0;
        Sat,  3 Sep 2022 10:04:25 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bj12so9348414ejb.13;
        Sat, 03 Sep 2022 10:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=yxIgBn6wmYWPsRLdC51HzjmvMPKahEKhVb6/Ezsf8mA=;
        b=ijUqM1sW6mBfkE8312xgrAE9ovi6QTzYF9G5bRdlJopYfEEo8RczFkLnWsPzA+hCPu
         DgtA9/7hQa1L2Ml01WIt5kue58GqgQL0NpEFJva2/+wTK8Ycv+nRh9DKIRINXFPHSMWC
         qMAMVIobLM68kXcjbNITPradRcbZ8HX3rkzC84vZ7+j9zb9/N/N8BjhXnhHE5vPQVvxc
         DGZEvXWEbp3mAriGUJLvgSvO36crwcPhWrT/JdORFhmGWdy/+/TmOrBztEZRL0NBIoxk
         2dkfem6hMT6NYE/rObRHBRMknb1LxEAlvZNnH9Az3jNu/Sq7bdY4IrHuheF8KiQ5mUHo
         cNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yxIgBn6wmYWPsRLdC51HzjmvMPKahEKhVb6/Ezsf8mA=;
        b=zCuNg6unDJUfD0bGw2Oa1XM8fX7Ij76m4hN2ptlBnB9ZhTgy2UIrB4IqYD+N04fOwv
         LJC7yQZ1huxphA43up2Rm4KSYuqvhEVoJg9Xn/Dq2YU2+amndVxyWiuOl6IjhXmQlXTg
         sm8gq8dt3JyfWg0GGlEFWYUGzS5ZP/jkQ7VPGmLocEfNx1ARhzB2oNI8QdsgDFwZETVY
         c7TmX5a9XOw++n3T3SV65twfXtK4NasbD1MGCRUYeSQc6CMyoAiC0YX75VmTlX83h1zd
         l5q0FI6jlFSd0KyLA9YWjDg+S95MSthpBHSXOqayHvoiak0iffS20HTk6ddrL5BKykI4
         urGg==
X-Gm-Message-State: ACgBeo0pJeJwf/XlZSLStYawVGft0hPyNZbErAoy1YS04b6YStPtU6iV
        3Nc6dzwQnc5rWAlPkZ65j3Q=
X-Google-Smtp-Source: AA6agR6LpCThAlRPo/ggANiOJBQT8ScLgVqJIejA+pV0Wm8SSnWY7ZA/pyHOPnOS4TlJmbpeUnE+Zg==
X-Received: by 2002:a17:907:2bc7:b0:73d:d239:110b with SMTP id gv7-20020a1709072bc700b0073dd239110bmr30616553ejc.752.1662224663681;
        Sat, 03 Sep 2022 10:04:23 -0700 (PDT)
Received: from [192.168.74.101] ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id e23-20020a50a697000000b004481ee9b4besm3464223edc.63.2022.09.03.10.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Sep 2022 10:04:23 -0700 (PDT)
Message-ID: <488be3d3-d4c4-6200-be99-b85e6ac72c34@gmail.com>
Date:   Sat, 3 Sep 2022 20:04:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 09/14] arm64: dts: qcom: sm6115: Add UFS nodes
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20220901072414.1923075-1-iskren.chernev@gmail.com>
 <20220901072414.1923075-10-iskren.chernev@gmail.com>
 <a0204dc3-af13-6b0b-d779-0f207d1aff7e@linaro.org>
From:   Iskren Chernev <iskren.chernev@gmail.com>
In-Reply-To: <a0204dc3-af13-6b0b-d779-0f207d1aff7e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/1/22 19:13, Krzysztof Kozlowski wrote:
> On 01/09/2022 10:24, Iskren Chernev wrote:
>> The SM6115 comes with UFS support, so add the related UFS and UFS PHY
>> nodes.
>>
>> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
>> ---
>>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 70 ++++++++++++++++++++++++++++
>>  1 file changed, 70 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>> index cde963c56ac9..491fffff8aa1 100644
>> --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
>> @@ -620,6 +620,76 @@ opp-202000000 {
>>  			};
>>  		};
>>
>> +		ufs_mem_hc: ufshc@4804000 {
>> +			compatible = "qcom,sm6115-ufshc", "qcom,ufshc",
>> +				     "jedec,ufs-2.0";
>> +			reg = <0x4804000 0x3000>, <0x4810000 0x8000>;
>> +			reg-names = "std", "ice";
>
> I could imagine that testing DTS against existing bindings might miss a
> lot, because we have still a lot of errors. But at least I would expect
> you test your DTS against your own bindings, which you submit here (and
> previously).
>
> You just wrote that ice is not allowed.

OK, I'm an idiot. I didn't run the bindings checks, not against existing
bindings or my bindings or whatever. It's my fault.

Ice should be allowed, I fixed the bindings in v2.

For the record, running dtbs_checks is a PITA, not only because of the
thousands of warnings in unrelated code, but because it takes forever.

Maybe the docs should be updated with instructions on how to run it on a single
(or a small subset) of DTBs. I had to comment out a lot of Makefile lines to
focus it on mine. It would really help if the binding check works more like
a compiler, not some magic spell hidden in a bunch of Makefiles.

I'll list all remaining issues with description/explanation in v2. The fact
that some bindings break on all DTBs present doesn't help either.

>> +			interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
>> +			phys = <&ufs_mem_phy_lanes>;
>> +			phy-names = "ufsphy";
>> +			lanes-per-direction = <1>;
>> +			#reset-cells = <1>;
>> +			resets = <&gcc GCC_UFS_PHY_BCR>;
>> +			reset-names = "rst";
>> +
>> +			power-domains = <&gcc GCC_UFS_PHY_GDSC>;
>> +			iommus = <&apps_smmu 0x100 0>;
>> +
>> +			clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
>> +				 <&gcc GCC_SYS_NOC_UFS_PHY_AXI_CLK>,
>> +				 <&gcc GCC_UFS_PHY_AHB_CLK>,
>> +				 <&gcc GCC_UFS_PHY_UNIPRO_CORE_CLK>,
>> +				 <&gcc GCC_UFS_PHY_ICE_CORE_CLK>,
>> +				 <&rpmcc RPM_SMD_XO_CLK_SRC>,
>> +				 <&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
>> +				 <&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>;
>> +			clock-names = "core_clk",
>> +				      "bus_aggr_clk",
>> +				      "iface_clk",
>> +				      "core_clk_unipro",
>> +				      "core_clk_ice",
>> +				      "ref_clk",
>> +				      "tx_lane0_sync_clk",
>> +				      "rx_lane0_sync_clk";
>> +
>> +			freq-table-hz = <50000000 200000000>,
>> +					<0 0>,
>> +					<0 0>,
>> +					<37500000 150000000>,
>> +					<75000000 300000000>,
>> +					<0 0>,
>> +					<0 0>,
>> +					<0 0>;
>> +
>> +			non-removable;
>
> Is it allowed property?

I dropped it.

>> +			status = "disabled";
>> +		};
>> +
>> +		ufs_mem_phy: phy@4807000 {
>> +			compatible = "qcom,sm6115-qmp-ufs-phy";
>> +			reg = <0x4807000 0x1c4>;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges;
>> +
>> +			clocks = <&gcc GCC_UFS_CLKREF_CLK>,
>> +				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
>> +			clock-names = "ref", "ref_aux";
>> +
>> +			resets = <&ufs_mem_hc 0>;
>> +			reset-names = "ufsphy";
>> +			status = "disabled";
>> +
>> +			ufs_mem_phy_lanes: lanes@4807400 {
>> +				reg = <0x4807400 0x098>,
>> +				      <0x4807600 0x130>,
>> +				      <0x4807c00 0x16c>;
>> +				#phy-cells = <0>;
>> +			};
>> +		};
>> +
>> +
>
> Just one blank line.
>
> Best regards,
> Krzysztof
