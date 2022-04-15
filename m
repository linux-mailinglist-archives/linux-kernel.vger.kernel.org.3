Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CDC502FC0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 22:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352862AbiDOU0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 16:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352818AbiDOU0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 16:26:07 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB382DCE1C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 13:23:37 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id b188so9229700oia.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 13:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=eRleA2ofzoX2IeccF8Nd0DI1ypt5SFTqVlhM+d2F6FM=;
        b=XnjjU3BEIFNFHO4V5/9HYSGf34YL0Ta6fBTy7JezgNXWtbJozrn2X+kKN3COKD/6Mw
         0g3S/LZNC18iO903GQVANxofB3P2gEIFPUCr2SkDRQv7jDmkOctENUSmNJHkL21OK4vn
         9KkZgrVxopxtNkwv/xa6n24eck21wdBeHGGoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=eRleA2ofzoX2IeccF8Nd0DI1ypt5SFTqVlhM+d2F6FM=;
        b=UFZpWD6N1XU6r2DR4vR11/PwkCz88PXn9XCZyCwLtEU+TbxLVND0QtmHxYJqmeEpK5
         vPYlynBhht0BH3UzqxLWwPeV1YJI81QDS/sMWAzdc6rHYSPjzfvfURXZqSm5YevvkLWY
         9vVNC7ouIJ52ODqkXPyS7Cb22Sw9e4/L8RoRw2fyJCzSQJFqHagVlOMnF2kmke12aBHq
         srLKAAWnPxBIOJy4CuuuyFsbeAgU9um0GJ/GC+WrGmr/ScBsprKeqSJKftaFnblGgThz
         4G+WEwnQTWkZNjmb3KwzeFpnNQiZE+Hek717E5z5sWBpW2RHVHOYCw/XLmhRlZmkfCOH
         CeuQ==
X-Gm-Message-State: AOAM53147kUfFx922iS7vSIo4UpdMWji3MMOeCaXgMuGRVX/AzGXS+ap
        HnyjjmeK32kUANZxpcqDV6BUE7ZrLtdfDa33sqg6TA==
X-Google-Smtp-Source: ABdhPJwl3Y2g621FA23XrMTwjotGB1KiG0Bug1QLCnjYGEe0Y+cwQI4zgqrP1VtkPaj+lMHht+J7CylHQEwxOjQVKCo=
X-Received: by 2002:aca:bd41:0:b0:2ec:ff42:814f with SMTP id
 n62-20020acabd41000000b002ecff42814fmr290395oif.63.1650054217338; Fri, 15 Apr
 2022 13:23:37 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 15 Apr 2022 13:23:36 -0700
MIME-Version: 1.0
In-Reply-To: <20220202053207.14256-1-tdas@codeaurora.org>
References: <20220202053207.14256-1-tdas@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 15 Apr 2022 13:23:36 -0700
Message-ID: <CAE-0n52T9Z+LS3KMVeSBsad=Em3e27J=rEzHTB0WS-b5M=owFQ@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: dts: qcom: sc7280: Add lpasscore & lpassaudio
 clock controllers
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2022-02-01 21:32:07)
> Add the low pass audio clock controller device nodes.
>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  * Fix unwanted extra spaces in reg property.
>  * Fix lpass_aon node clock phandle <&lpasscc> to <&lpasscore>
>
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 43 ++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 937c2e0e93eb..0d8a0d9d0f89 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -1744,6 +1746,47 @@
>                         #clock-cells = <1>;
>                 };
>
> +               lpass_audiocc: clock-controller@3300000 {
> +                       compatible = "qcom,sc7280-lpassaudiocc";
> +                       reg = <0 0x03300000 0 0x30000>;
> +                       clocks = <&rpmhcc RPMH_CXO_CLK>,
> +                              <&lpass_aon LPASS_AON_CC_MAIN_RCG_CLK_SRC>;
> +                       clock-names = "bi_tcxo", "lpass_aon_cc_main_rcg_clk_src";
> +                       power-domains = <&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
> +                       #clock-cells = <1>;
> +                       #power-domain-cells = <1>;
> +               };
> +
> +               lpass_aon: clock-controller@3380000 {
> +                       compatible = "qcom,sc7280-lpassaoncc";
> +                       reg = <0 0x03380000 0 0x30000>;

I see that this region overlaps with the third region of lpasscc@3000000
in this file. That means the driver for this clk controller doesn't
probe. I don't know what the correct fix is, but it's either remove this
node and move the driver contents to lpasscc or remove the region from
lpasscc and provide those clks from this node.

> +                       clocks = <&rpmhcc RPMH_CXO_CLK>,
> +                              <&rpmhcc RPMH_CXO_CLK_A>,
> +                              <&lpasscore LPASS_CORE_CC_CORE_CLK>;
> +                       clock-names = "bi_tcxo", "bi_tcxo_ao", "iface";
