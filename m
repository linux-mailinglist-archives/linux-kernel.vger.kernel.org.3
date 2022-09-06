Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC4D5AF495
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiIFTl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiIFTlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:41:24 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4177580B73
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:41:23 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id g5so18342065ybg.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 12:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=snU6sHLVFuhFuegCz2LY5uuGVktWfNxhucOSPu7x3aQ=;
        b=wHBp6mR5w+Xd1tEiqooTyS8Ep4Ay3sazBcUaioh7iqJpCe5zfFGywdqLdgknSZqsJK
         4s75HteCxyyHfSMbOnQtS2qWDl6/VXfV9T+suuhOYo+rtZf5Wm3TdB68SYCL4vR09YYC
         4P0Z7IF7/ix94DimDR/5HV3HdferHNb+UzA/Ck+GNktplONrOf8twaoDpN/bpetp+fLF
         0vnJhLCUEgIV+0JeZMnAIKc1GORmmk41xHK76om87gsTep9prhSozgYbQSpe1/hPsW/4
         Soav00fk8802IepJ1tQy7myIPs1YAkw+jbFzpT3HUbofcQHFaS/28N1kGKNLVfAkkkfo
         5+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=snU6sHLVFuhFuegCz2LY5uuGVktWfNxhucOSPu7x3aQ=;
        b=mbh4E+f1sCsHcM3EFYEqrWxYS8RE60Saomdu7myB9BMTu9fdYmQ3EoOYEBN5xaLA0G
         rmj4xGF6+eOmGcm/iz46F1B10Q5H3gFZf1xmrIXm2eKmPPhdoaqqy3Y1QoSwyTbuYFZ6
         OYhaj7yB65jnnizI+dj25zYEW3VOPd0KYjPAy/MgO45DTEJk+vnTiRRKJfwL8g+osMN0
         V5vosGkiwLidJaJ5k34gxFB3LX3fhTpWSQvT8EBpn5XTtpFNwt4GQGduFh31AIEAzi6K
         /s7SrrBDIoIyo40CNSoNqyNShh0Ex1JjFE7AhI3M6pK+x4yHXOcuCPKR7T8SyctrG9Qm
         tXEQ==
X-Gm-Message-State: ACgBeo2XwyeytLNCco1MjrZSofSAxoLUfLjKQuJu7XyS/URwljB1APfZ
        G3b0z0g0rpfpe5tu17jlbKMFEbbqVL5683BAEVmf2g==
X-Google-Smtp-Source: AA6agR5G8yckKVkmwDJ1JIT5INXPH+zDHdVVnaWJpfc1vFTYPqRYDNyyh/s08b/ty20JzitIYp4q6FTMdHOZDoDl/vU=
X-Received: by 2002:a25:5c3:0:b0:6a9:90fb:c9e6 with SMTP id
 186-20020a2505c3000000b006a990fbc9e6mr203601ybf.152.1662493282333; Tue, 06
 Sep 2022 12:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220906183334.203787-1-luca@z3ntu.xyz> <20220906183334.203787-4-luca@z3ntu.xyz>
In-Reply-To: <20220906183334.203787-4-luca@z3ntu.xyz>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 6 Sep 2022 22:41:11 +0300
Message-ID: <CAA8EJpqjnafKyUrd1ntYFeGTDtRxgEUSu0Mg9wNGxObJ3wF0Kw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: msm8953: add MDSS
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sept 2022 at 21:36, Luca Weiss <luca@z3ntu.xyz> wrote:
>
> From: Vladimir Lypak <vladimir.lypak@gmail.com>
>
> Add the MDSS, MDP and DSI nodes that are found on msm8953 SoC.
>
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Changes since v2:
> - add "core" clock for mdss as suggested by Dmitry Baryshkov
>
>  arch/arm64/boot/dts/qcom/msm8953.dtsi | 210 ++++++++++++++++++++++++++
>  1 file changed, 210 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> index 3d11331e78d2..580333141a66 100644
> --- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
> @@ -726,6 +726,216 @@ tcsr_phy_clk_scheme_sel: syscon@193f044 {
>                         reg = <0x193f044 0x4>;
>                 };
>
> +               mdss: mdss@1a00000 {
> +                       compatible = "qcom,mdss";
> +
> +                       reg = <0x1a00000 0x1000>,
> +                             <0x1ab0000 0x1040>;
> +                       reg-names = "mdss_phys",
> +                                   "vbif_phys";
> +
> +                       power-domains = <&gcc MDSS_GDSC>;
> +                       interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> +
> +                       interrupt-controller;
> +                       #interrupt-cells = <1>;
> +
> +                       clocks = <&gcc GCC_MDSS_AHB_CLK>,
> +                                <&gcc GCC_MDSS_AXI_CLK>,
> +                                <&gcc GCC_MDSS_VSYNC_CLK>,
> +                                <&gcc GCC_MDSS_MDP_CLK>;
> +                       clock-names = "iface",
> +                                     "bus",
> +                                     "vsync",
> +                                     "core";
> +
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       ranges;
> +
> +                       status = "disabled";
> +
> +                       mdp: mdp@1a01000 {
> +                               compatible = "qcom,mdp5";

Could you please change this to "qcom,msm8953-mdp5", "qcom,mdp5".

> +                               reg = <0x1a01000 0x89000>;
> +                               reg-names = "mdp_phys";
> +

[skipped]

> +
> +                       dsi0_phy: dsi-phy@1a94400 {

Let's probably use a generic name 'phy' here and for dsi1_phy.

The rest looks good to me.

> +                               compatible = "qcom,dsi-phy-14nm-8953";
> +                               reg = <0x1a94400 0x100>,
> +                                     <0x1a94500 0x300>,
> +                                     <0x1a94800 0x188>;
> +                               reg-names = "dsi_phy",
> +                                           "dsi_phy_lane",
> +                                           "dsi_pll";
> +
> +                               #clock-cells = <1>;
> +                               #phy-cells = <0>;
> +
> +                               clocks = <&gcc GCC_MDSS_AHB_CLK>, <&xo_board>;
> +                               clock-names = "iface", "ref";
> +
> +                               status = "disabled";
> +                       };


-- 
With best wishes
Dmitry
