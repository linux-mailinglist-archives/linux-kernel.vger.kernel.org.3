Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A29158EECB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 16:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbiHJOv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 10:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbiHJOvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 10:51:21 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25B766A77
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 07:51:17 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id l21so4878237ljj.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 07:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=DtUCGMChLqmvdjMLfi90xiJ0nBqpPpWGiSNCuCWE+Yo=;
        b=gtpZL/WRnblKgLiaoK7ZSZg9v/iM6jRgDkCMiBpWSLxI5nWnpjGGag8G80tVh8JDxX
         45Wefz8i3Is2ewLBX6X2bQtyVtktt6gOUNKUdll6rjoNl53cvytNYg0a2I1FbJimlSXC
         4pGAaCBV0mGYkGk/qbuKbWC9Bt42Zh+ZQAe8MIa3pdqLC6eBPU4wOL6AzjnikGb6j6WS
         pEpuSFMYHFwAwjJY5e/ZVu1MYJNGJ+0fF0R4+HOmxx+7+7BoLBlOmVvfDY35Bxy7urln
         UbD7APoyL/2/sx+GcP26TEeLqQYriKnA0xunIPTpEKKXg15oryeon9vAGTirHd0tqCZu
         YHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=DtUCGMChLqmvdjMLfi90xiJ0nBqpPpWGiSNCuCWE+Yo=;
        b=VLswV5HF20DtNPhlCjLx0v30UF7mzAr5fSut1ZyZVW2brUkenktDVz/R1hasrIh+BI
         uhq5m5UWdmDieu3YLw2d5i0qtvCYCpsfvp3+rfPO+G23gRDWfdTIP4GYyruiopybXjtd
         YFQJFKjZVboaPPJ2PrVKtT1plBOj19UdFbZO7ZeFUvz7zNExlH1vc8hqZubiHV72W4vS
         bjghCzMtUY7YssZ6V9d3WhQv/igr4xx2MNaHWkDlqytw2/DlPl8ejZNqel7lQM0V1ADy
         yBZGRLARnu2gf6IyJKqODgLs54ueSxDRvoR4BwH8/XhE4nzGehSe2LkOZOg72F0VrouN
         wMIQ==
X-Gm-Message-State: ACgBeo3oMXAjLJKlDKBVaKmFADzejMMavkd/PH+QsbNfKH6e2Oi/wP3d
        /MdDS0lROj5UkauTAhmaIbozIQ==
X-Google-Smtp-Source: AA6agR6BUj46IC9KhSfaa/BLM4gLct73I2FdwhqcZrf/okZeq/LcOrf+2lot6WC6KGlFP27wO/cE6Q==
X-Received: by 2002:a2e:5351:0:b0:25e:bba1:ae87 with SMTP id t17-20020a2e5351000000b0025ebba1ae87mr7164456ljd.353.1660143076235;
        Wed, 10 Aug 2022 07:51:16 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id z16-20020a19f710000000b00485caa0f5dfsm372763lfe.44.2022.08.10.07.51.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 07:51:15 -0700 (PDT)
Message-ID: <bd0fb511-043f-55fc-5f9d-1cbeeca066e6@linaro.org>
Date:   Wed, 10 Aug 2022 17:51:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sdm845: add displayport node
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220810035424.2796777-1-bjorn.andersson@linaro.org>
 <20220810035424.2796777-3-bjorn.andersson@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220810035424.2796777-3-bjorn.andersson@linaro.org>
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

On 10/08/2022 06:54, Bjorn Andersson wrote:
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Add displayport controller device node, describing DisplayPort hardware
> block on SDM845.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

If the patchset does not go with your dt-bindings change, it won't be
tested by Rob's bot for that binding. Responsibility to run dtbs_check
is then on you. :)

>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 82 +++++++++++++++++++++++++++-
>  1 file changed, 80 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index eae307a4babf..a8ba6ebc714f 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -4457,13 +4457,20 @@ ports {
>  
>  					port@0 {
>  						reg = <0>;
> -						dpu_intf1_out: endpoint {
> -							remote-endpoint = <&dsi0_in>;
> +						dpu_intf0_out: endpoint {
> +							remote-endpoint = <&dp_in>;
>  						};
>  					};
>  
>  					port@1 {
>  						reg = <1>;
> +						dpu_intf1_out: endpoint {
> +							remote-endpoint = <&dsi0_in>;
> +						};
> +					};
> +
> +					port@2 {
> +						reg = <2>;
>  						dpu_intf2_out: endpoint {
>  							remote-endpoint = <&dsi1_in>;
>  						};
> @@ -4495,6 +4502,77 @@ opp-430000000 {
>  				};
>  			};
>  
> +			mdss_dp: displayport-controller@ae90000 {
> +				status = "disabled";

status at the end.

> +				compatible = "qcom,sdm845-dp";
> +
> +				reg = <0 0xae90000 0 0x200>,
> +				      <0 0xae90200 0 0x200>,
> +				      <0 0xae90400 0 0x600>,
> +				      <0 0xae90a00 0 0x600>,
> +				      <0 0xae91000 0 0x600>;
> +
> +				interrupt-parent = <&mdss>;
> +				interrupts = <12>;
> +
> +				clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DP_AUX_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DP_LINK_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DP_LINK_INTF_CLK>,
> +					 <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>;
> +				clock-names = "core_iface", "core_aux", "ctrl_link",
> +					      "ctrl_link_iface", "stream_pixel";
> +				#clock-cells = <1>;
> +				assigned-clocks = <&dispcc DISP_CC_MDSS_DP_LINK_CLK_SRC>,
> +						  <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>;
> +				assigned-clock-parents = <&dp_phy 0>, <&dp_phy 1>;
> +				phys = <&dp_phy>;
> +				phy-names = "dp";
> +
> +				operating-points-v2 = <&dp_opp_table>;
> +				power-domains = <&rpmhpd SDM845_CX>;
> +
> +				ports {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					port@0 {
> +						reg = <0>;
> +						dp_in: endpoint {
> +							remote-endpoint = <&dpu_intf0_out>;
> +						};
> +					};
> +
> +					port@1 {
> +						reg = <1>;
> +						dp_out: endpoint { };
> +					};
> +				};
> +
> +				dp_opp_table: dp-opp-table {

Node name just "opp-table"

> +					compatible = "operating-points-v2";
> +

Best regards,
Krzysztof
