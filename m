Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225B7574B34
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbiGNKwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237798AbiGNKw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:52:28 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAE6550B6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:52:26 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id a10so1711594ljj.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=p5GjG0eV0vYuLSZs2y/SOdrMlopF9d7dRJclgcPc3hE=;
        b=jK77VM9nUux8iXmWo7aCYe1N7UMe5+s/CNo0Rzhmar2T+6xM4PESwtVLqmr2Qml5M2
         sF/XArXpCnWwpbqbntARJALcDpV65adze8UFvBAcZNMQ/qG4p80CD+HmiwgJv2HJOTFX
         krn1S8WhtghCJqR4M7xvAgQaPrHj/LDpNKrT7aUzuyz/L2EEYMki6EwJNoXgjTF/T9YK
         zV+69A8efs+AJJOWLDDXwHHq9a5A7Ai7Xoz+IJa5qBXnazG0uGrlwSNkgSJSpsl4xDOv
         4t97dR1DSRlZDOUlpFDy8LGXgMC//cGmrCwlQtan1Z2o+xuwb4Tx1h016UWr4BCXU1/l
         pwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=p5GjG0eV0vYuLSZs2y/SOdrMlopF9d7dRJclgcPc3hE=;
        b=Y3YQq6YD9mVI/m4M2eSRiJ6O0HYOGBRCJYC/39H2rnNrtCt0RzBY3Ym/TT0giCU2ck
         NO+oogDAQ4K7lltEufB/hHLWfzMy7AT+8AzuE7MKVCrhNZZ+rQe1L0gNzvi7awP1cj9I
         uCI+JgO3Uk5pEE0r/hvYMXpLOBkgH1WgBp2hEd3fTw1eSxBgH+wx8HOC0CInIJXZlT/q
         3VpuBBrs0lc9LdX/u2ec2Ad/gZUdXQb/CuSLBC5RV+OuARkmHBzzu8dkdMpI9N0CQ1Zr
         LoR3fY3loANQ7oGaHbVoJI6c+gvEdi+0UGqus33okFZ4yC9B57tvbwSWz9xf2T2vKfP2
         i33Q==
X-Gm-Message-State: AJIora9Du4XQDsNNYepbd/g0bCLHvv4M1cn6p1cOWNmNj6+qvL0D0LHJ
        63KEolQYE0O0vsYeM1bitOMLlA==
X-Google-Smtp-Source: AGRyM1tRighpv3FSsPDbwHBARKoXOLbSJ+Y71+kNTw8wIs8dcy0FYq3u3jdkzvj4OTsNcWhwLWcZbg==
X-Received: by 2002:a2e:83c6:0:b0:25a:d2c4:76c8 with SMTP id s6-20020a2e83c6000000b0025ad2c476c8mr4152410ljh.336.1657795945212;
        Thu, 14 Jul 2022 03:52:25 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id be6-20020a056512250600b00489da53b38esm296097lfb.224.2022.07.14.03.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 03:52:24 -0700 (PDT)
Message-ID: <093d85b9-6da2-2358-118e-7b5a2d1fa86e@linaro.org>
Date:   Thu, 14 Jul 2022 12:52:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/7] arm64: dts: qcom: sc8280xp: fix USB clock order
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220713131340.29401-1-johan+linaro@kernel.org>
 <20220713131340.29401-5-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220713131340.29401-5-johan+linaro@kernel.org>
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

On 13/07/2022 15:13, Johan Hovold wrote:
> Fix the USB controller clock order and naming so that they match the
> devicetree binding.
> 
> Note that the driver currently simply enables all clocks in the order
> that they are specified in the devicetree. Reordering the clocks as per
> the binding means that the only explicit ordering constraint found in
> the vendor driver, that cfg_noc should be enabled before the core_clk,
> is now honoured.
> 
> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 285a9828c250..45cc7d714fd2 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -1855,16 +1855,16 @@ usb_0: usb@a6f8800 {
>  			#size-cells = <2>;
>  			ranges;
>  
> -			clocks = <&gcc GCC_USB30_PRIM_MASTER_CLK>,
> -				 <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
> +			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
> +				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
>  				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
> -				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
>  				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
> +				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
>  				 <&gcc GCC_AGGRE_USB_NOC_AXI_CLK>,
>  				 <&gcc GCC_AGGRE_USB_NOC_NORTH_AXI_CLK>,
>  				 <&gcc GCC_AGGRE_USB_NOC_SOUTH_AXI_CLK>,
>  				 <&gcc GCC_SYS_NOC_USB_AXI_CLK>;
> -			clock-names = "core", "iface", "bus_aggr", "utmi", "sleep",
> +			clock-names = "cfg_noc", "core", "iface", "sleep", "mock_utmi",
>  				      "noc_aggr", "noc_aggr_north", "noc_aggr_south", "noc_sys";

Your commit title should also include change of naming.

Best regards,
Krzysztof
