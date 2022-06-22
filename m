Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76014554939
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343603AbiFVKIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347121AbiFVKHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:07:55 -0400
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B67CCDA;
        Wed, 22 Jun 2022 03:07:52 -0700 (PDT)
Received: from [192.168.1.101] (abxi223.neoplus.adsl.tpnet.pl [83.9.2.223])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 1565820554;
        Wed, 22 Jun 2022 12:07:46 +0200 (CEST)
Message-ID: <bc646661-9be5-5256-5ec9-a27623003693@somainline.org>
Date:   Wed, 22 Jun 2022 12:07:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v6 1/6] arm64: dts: qcom: sm8350: Replace integers with
 rpmpd defines
Content-Language: en-US
To:     Robert Foss <robert.foss@linaro.org>, bjorn.andersson@linaro.org,
        agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, jonathan@marek.ca,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20220621233412.506768-1-robert.foss@linaro.org>
 <20220621233412.506768-2-robert.foss@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220621233412.506768-2-robert.foss@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.06.2022 01:34, Robert Foss wrote:
> Replace &rpmhpd power domain integers with their respective defines
> in order to improve legibility.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  arch/arm64/boot/dts/qcom/sm8350.dtsi | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> index c0137bdcf94b..52428b6df64e 100644
> --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> @@ -1656,8 +1656,8 @@ mpss: remoteproc@4080000 {
>  			clocks = <&rpmhcc RPMH_CXO_CLK>;
>  			clock-names = "xo";
>  
> -			power-domains = <&rpmhpd 0>,
> -					<&rpmhpd 12>;
> +			power-domains = <&rpmhpd SM8350_CX>,
> +					<&rpmhpd SM8350_MSS>;
>  			power-domain-names = "cx", "mss";
>  
>  			interconnects = <&mc_virt MASTER_LLCC &mc_virt SLAVE_EBI1>;
> @@ -2167,8 +2167,8 @@ slpi: remoteproc@5c00000 {
>  			clocks = <&rpmhcc RPMH_CXO_CLK>;
>  			clock-names = "xo";
>  
> -			power-domains = <&rpmhpd 4>,
> -					<&rpmhpd 5>;
> +			power-domains = <&rpmhpd SM8350_LCX>,
> +					<&rpmhpd SM8350_LMX>;
>  			power-domain-names = "lcx", "lmx";
>  
>  			memory-region = <&pil_slpi_mem>;
> @@ -2235,8 +2235,8 @@ cdsp: remoteproc@98900000 {
>  			clocks = <&rpmhcc RPMH_CXO_CLK>;
>  			clock-names = "xo";
>  
> -			power-domains = <&rpmhpd 0>,
> -					<&rpmhpd 10>;
> +			power-domains = <&rpmhpd SM8350_CX>,
> +					<&rpmhpd SM8350_MXC>;
>  			power-domain-names = "cx", "mxc";
>  
>  			interconnects = <&compute_noc MASTER_CDSP_PROC &mc_virt SLAVE_EBI1>;
> @@ -2540,8 +2540,8 @@ adsp: remoteproc@17300000 {
>  			clocks = <&rpmhcc RPMH_CXO_CLK>;
>  			clock-names = "xo";
>  
> -			power-domains = <&rpmhpd 4>,
> -					<&rpmhpd 5>;
> +			power-domains = <&rpmhpd SM8350_LCX>,
> +					<&rpmhpd SM8350_LMX>;
>  			power-domain-names = "lcx", "lmx";
>  
>  			memory-region = <&pil_adsp_mem>;
