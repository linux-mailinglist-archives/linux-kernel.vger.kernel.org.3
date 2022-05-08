Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312ED51ED97
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 15:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbiEHNEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 09:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiEHNEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 09:04:38 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0164617B;
        Sun,  8 May 2022 06:00:45 -0700 (PDT)
Received: from [192.168.1.101] (abxj12.neoplus.adsl.tpnet.pl [83.9.3.12])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id A344F3F36E;
        Sun,  8 May 2022 15:00:42 +0200 (CEST)
Message-ID: <7626562a-abbd-64f4-380e-a0b855f3aadb@somainline.org>
Date:   Sun, 8 May 2022 15:00:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] arm64: dts: qcom: sm6350: Replace literal rpmpd indices
 with constants
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220507224645.2238421-1-marijn.suijten@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220507224645.2238421-1-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8.05.2022 00:46, Marijn Suijten wrote:
> It seems the SM6350_CX definition was temporarily replaced with its
> literal value 0 in 1797e1c9a95c ("arm64: dts: qcom: sm6350: Add SDHCI1/2
> nodes") to prevent a dependency on the qcom-rpmpd.h header patch being
> available prior to this DT patch being applied, similar to c23f1b77358c
> ("arm64: dts: qcom: sm6125: Avoid using missing SM6125_VDDCX").
> However, unlike the revert of that in the sm6125 tree the next merge
> window around in a90b8adfa2dd ("Revert "arm64: dts: qcom: sm6125: Avoid
> using missing SM6125_VDDCX""), this has not yet happened for sm6350:
> replace them back now that the definitions are definitely available.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad

>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> index fb1a0f662575..b3160720edcb 100644
> --- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
> @@ -489,7 +489,7 @@ sdhc_1: sdhci@7c4000 {
>  			clock-names = "iface", "core", "xo";
>  			qcom,dll-config = <0x000f642c>;
>  			qcom,ddr-config = <0x80040868>;
> -			power-domains = <&rpmhpd 0>;
> +			power-domains = <&rpmhpd SM6350_CX>;
>  			operating-points-v2 = <&sdhc1_opp_table>;
>  			bus-width = <8>;
>  			non-removable;
> @@ -935,7 +935,7 @@ sdhc_2: sdhci@8804000 {
>  			clock-names = "iface", "core", "xo";
>  			qcom,dll-config = <0x0007642c>;
>  			qcom,ddr-config = <0x80040868>;
> -			power-domains = <&rpmhpd 0>;
> +			power-domains = <&rpmhpd SM6350_CX>;
>  			operating-points-v2 = <&sdhc2_opp_table>;
>  			bus-width = <4>;
>  
