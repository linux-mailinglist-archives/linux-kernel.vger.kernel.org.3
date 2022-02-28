Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6514C7BEE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiB1V1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 16:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiB1V1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:27:09 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5090D1216BA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:26:30 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id i6-20020a4ac506000000b0031c5ac6c078so20247286ooq.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=Nxilu7+HAI0U7HYYSI4kRsmb5+6xQphIHHkvWlOdQGE=;
        b=iK9ibw+VJcXWMiYghwx3jLFBLikCr4KMj7UALwrLJLRycc2kTZd7VUv0d/POruPdjB
         nFjhjjNq7Ps/f6IkLTPcylsPsKFJepVkSePPMsKy0gF9c2ct4o2j/IjSwj7R38JND1NE
         jvBs9fOPFZjaHoGwwHQQbmeqbhbqjZOxzKrYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=Nxilu7+HAI0U7HYYSI4kRsmb5+6xQphIHHkvWlOdQGE=;
        b=OE5U972zJ/LVDZu7Jjih0F67fTjWdc92RlXReFRdA+d61SjYPK2o63vRk7vR6N+Oyr
         iBcbw5Y615KcVRXxhICO4e5rp1OZ1ofSkIpQqlcbKVtYl94Y1olizKpAXJoFKmOS4EE5
         4sK9JnWn6WRCN3l4OwXalNyzLu4ov/YTiv+/zXZ0bbTN4oqG+WrF8E24Yor1JcHgYA8s
         5UvIIK23MwKykPZK12X6GAZRbyXu6399+GCPkN/sbdTjkrLwOJs5kzT9OXdue1G5ymii
         J0OdJQa9vBUp8O+pdIMhcrabIEbNib9QrBX13wkTe8Cfs0xcUsp5O6yTHh0YcBgPSGo7
         cyjA==
X-Gm-Message-State: AOAM531kFJy49MbstELrImjduqORK+/+f9qTII/yCyTDjuJLyiuWiMNp
        DL9AxmMtfIJHtZMj3eCLk+EeMAWD57UO+Mrggbln6Q==
X-Google-Smtp-Source: ABdhPJw21T+a7f+8cAYvaWe6XiSPwhiATh+b0qQU0SwFvOdpOcVzAZk59pJkyTB3Va+jwd2JOqQUcvkl+t7LLQPwKZM=
X-Received: by 2002:a05:6870:3c18:b0:d7:22ed:20b0 with SMTP id
 gk24-20020a0568703c1800b000d722ed20b0mr3906699oab.32.1646083589169; Mon, 28
 Feb 2022 13:26:29 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 28 Feb 2022 13:26:28 -0800
MIME-Version: 1.0
In-Reply-To: <1643887981-31011-2-git-send-email-quic_srivasam@quicinc.com>
References: <1643887981-31011-1-git-send-email-quic_srivasam@quicinc.com> <1643887981-31011-2-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 28 Feb 2022 13:26:28 -0800
Message-ID: <CAE-0n53CJ=FWT8yKSEzA9XvV6Ld8h-HNGJgzJn8EPjLir63wzw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] arm64: dts: qcom: sc7280: Add nodes for va tx and
 rx macros and external codecs
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, dianders@chromium.org,
        judyhsiao@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        rohitkr@codeaurora.org, srinivas.kandagatla@linaro.org
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2022-02-03 03:32:59)
> SC7280 has VA, TX and RX macros with SoundWire Controllers to attach with
> codecs like WCD938x, max98360a using soundwire masters and i2s bus.
> Add these nodes for sc7280 based platforms audio use case.
> Add tlmm gpio property in wcd938x node for switching CTIA/OMTP Headset.
>
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-crd.dts  |   4 +
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi |  55 ++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi     | 122 +++++++++++++++++++++++++++++++
>  3 files changed, 181 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> index cd2755c..e6fbfc2 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> @@ -72,6 +72,10 @@ ap_ts_pen_1v8: &i2c13 {
>         pins = "gpio51";
>  };
>
> +&wcd938x {
> +       us-euro-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
> +};
> +
>  &tlmm {
>         tp_int_odl: tp-int-odl {
>                 pins = "gpio7";
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index ddeb508..2806888 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -32,6 +32,14 @@
>                 };
>         };
>
> +       max98360a: audio-codec-0 {
> +               compatible = "maxim,max98360a";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&amp_en>;
> +               sdmode-gpios = <&tlmm 63 GPIO_ACTIVE_HIGH>;
> +               #sound-dai-cells = <0>;
> +       };
> +
>         nvme_3v3_regulator: nvme-3v3-regulator {
>                 compatible = "regulator-fixed";
>                 regulator-name = "VLDO_3V3";
> @@ -43,6 +51,31 @@
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&nvme_pwren>;
>         };
> +
> +       wcd938x: codec {

This is 'codec' and above it is 'audio-codec-0'. Maybe this should be
'audio-codec-1'? Also, can this be sorted alphabetically on node name?
Adding nodes to the end of a section leads to more conflicts.

> +               compatible = "qcom,wcd9380-codec";
> +               #sound-dai-cells = <1>;
> +
> +               reset-gpios = <&tlmm 83 GPIO_ACTIVE_HIGH>;

I'd expect a pinctrl to at least set or remove biasing on gpio83. Where
is that?

> +
> +               qcom,rx-device = <&wcd_rx>;
> +               qcom,tx-device = <&wcd_tx>;
> +
> +               vdd-rxtx-supply = <&vreg_l18b_1p8>;
> +               vdd-io-supply = <&vreg_l18b_1p8>;
> +               vdd-buck-supply = <&vreg_l17b_1p8>;
> +               vdd-mic-bias-supply = <&vreg_bob>;
> +
> +               qcom,micbias1-microvolt = <1800000>;
> +               qcom,micbias2-microvolt = <1800000>;
> +               qcom,micbias3-microvolt = <1800000>;
> +               qcom,micbias4-microvolt = <1800000>;
> +
> +               qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000
> +                                                         500000 500000 500000>;
> +               qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
> +               qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
> +       };
>  };
>
>  /*
> @@ -636,3 +669,25 @@
>                 bias-pull-up;
>         };
>  };
> +
> +&swr0 {
> +       wcd_rx: wcd938x-hph-playback {

wcd_rx: playback@0,4 {

> +               compatible = "sdw20217010d00";
> +               reg = <0 4>;
> +               #sound-dai-cells = <1>;
> +               qcom,rx-port-mapping = <1 2 3 4 5>;
> +       };
> +};
> +
> +&swr1 {
> +       wcd_tx: wcd938x-hph-capture {

wcd_tx: capture@0,3 {

> +               compatible = "sdw20217010d00";
> +               reg = <0 3>;
> +               #sound-dai-cells = <1>;
> +               qcom,tx-port-mapping = <1 2 3 4>;
> +       };
> +};
> +
> +&vamacro {
> +       vdd-micb-supply = <&vreg_bob>;
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 6233f2c..946eb01 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -1744,6 +1744,128 @@
>                         #clock-cells = <1>;
>                 };
>
> +               rxmacro: rxmacro@3200000 {

rxmacro is not a generic node name.

> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&rx_swr_active>;

Please put compatible first always. Followed by reg property.

> +                       compatible = "qcom,sc7280-lpass-rx-macro";
> +                       reg = <0 0x3200000 0 0x1000>;
> +
> +                       clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>,
> +                                <&lpass_aon LPASS_AON_CC_TX_MCLK_2X_CLK>,
> +                                <&vamacro>;
> +                       clock-names = "mclk", "npl", "fsgen";
> +
> +                       power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
> +                                       <&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
> +                       power-domain-names ="macro", "dcodec";
> +
> +                       #clock-cells = <0>;
> +                       clock-frequency = <9600000>;

What is clock-frequency? Is this like assigned-clock-rates? Why can't
that be used?

> +                       clock-output-names = "mclk";

Please don't use clock-output-names.

> +                       #sound-dai-cells = <1>;
> +               };
> +
> +               swr0: soundwire@3210000 {
> +                       reg = <0 0x3210000 0 0x2000>;
> +                       compatible = "qcom,soundwire-v1.6.0";
> +                       interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&rxmacro>;
> +                       clock-names = "iface";
> +                       label = "RX";

What is label used for? Can we drop it?

> +
> +                       qcom,din-ports = <0>;
> +                       qcom,dout-ports = <5>;
> +                       qcom,swrm-hctl-reg = <0x032a90a0>;
> +
> +                       qcom,ports-word-length =        /bits/ 8 <0x01 0x07 0x04 0xFF 0xFF>;
> +                       qcom,ports-sinterval-low =      /bits/ 8 <0x03 0x3F 0x1F 0x03 0x03>;
> +                       qcom,ports-offset1 =            /bits/ 8 <0x00 0x00 0x0B 0x01 0x01>;
> +                       qcom,ports-offset2 =            /bits/ 8 <0x00 0x00 0x0B 0x00 0x00>;
> +                       qcom,ports-lane-control =       /bits/ 8 <0x01 0x00 0x00 0x00 0x00>;
> +                       qcom,ports-block-pack-mode =    /bits/ 8 <0xFF 0x00 0x01 0xFF 0xFF>;
> +                       qcom,ports-hstart =             /bits/ 8 <0xFF 0x03 0xFF 0xFF 0xFF>;
> +                       qcom,ports-hstop =              /bits/ 8 <0xFF 0x06 0xFF 0xFF 0xFF>;
> +                       qcom,ports-block-group-count =  /bits/ 8 <0xFF 0xFF 0xFF 0xFF 0x00>;

I have no idea what these are. Why aren't they part of the driver? At
the least, lowercase hex please.

> +
> +                       #sound-dai-cells = <1>;
> +                       #address-cells = <2>;
> +                       #size-cells = <0>;
> +               };
> +
> +               txmacro: txmacro@3220000 {
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&tx_swr_active>;

Move pinctrl lower.

> +                       compatible = "qcom,sc7280-lpass-tx-macro";
> +                       reg = <0 0x3220000 0 0x1000>;

Pad out register addresses to 8 digits please. 0x03220000

> +
> +                       clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>,
> +                                <&lpass_aon LPASS_AON_CC_TX_MCLK_2X_CLK>,
> +                                <&vamacro>;
> +                       clock-names = "mclk", "npl", "fsgen";
> +
> +                       power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
> +                                       <&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
> +                       power-domain-names ="macro", "dcodec";
> +
> +                       #clock-cells = <0>;
> +                       clock-frequency = <9600000>;
> +                       clock-output-names = "mclk";
> +                       #address-cells = <2>;
> +                       #size-cells = <2>;
> +                       #sound-dai-cells = <1>;
> +               };
> +
> +               swr1: soundwire@3230000 {
> +                       reg = <0 0x3230000 0 0x2000>;
> +                       compatible = "qcom,soundwire-v1.6.0";
> +
> +                       interrupts-extended =
> +                                       <&intc GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
> +                                       <&pdc 130 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "swr_master_irq", "swr_wake_irq";
> +                       clocks = <&txmacro>;
> +                       clock-names = "iface";
> +                       label = "TX";
> +
> +                       qcom,din-ports = <3>;
> +                       qcom,dout-ports = <0>;
> +                       qcom,swrm-hctl-reg = <0x032a90a8>;

What is this? A reset control?

> +
> +                       qcom,ports-sinterval-low =      /bits/ 8 <0x01 0x03 0x03>;
> +                       qcom,ports-offset1 =            /bits/ 8 <0x01 0x00 0x02>;
> +                       qcom,ports-offset2 =            /bits/ 8 <0x00 0x00 0x00>;
> +                       qcom,ports-hstart =             /bits/ 8 <0xFF 0xFF 0xFF>;
> +                       qcom,ports-hstop =              /bits/ 8 <0xFF 0xFF 0xFF>;
> +                       qcom,ports-word-length =        /bits/ 8 <0xFF 0x0 0xFF>;
> +                       qcom,ports-block-pack-mode =    /bits/ 8 <0xFF 0xFF 0xFF>;
> +                       qcom,ports-block-group-count =  /bits/ 8 <0xFF 0xFF 0xFF>;
> +                       qcom,ports-lane-control =       /bits/ 8 <0x00 0x01 0x00>;
> +                       qcom,port-offset = <1>;
> +
> +                       #sound-dai-cells = <1>;
> +                       #address-cells = <2>;
> +                       #size-cells = <0>;
> +               };
> +
> +               vamacro: codec@3370000 {
> +                       compatible = "qcom,sc7280-lpass-va-macro";
> +                       pinctrl-0 = <&dmic01_active>;
> +                       pinctrl-names = "default";
> +
> +                       reg = <0 0x3370000 0 0x1000>;
> +                       clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>;
> +                       clock-names = "mclk";
> +
> +                       power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
> +                                       <&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
> +                       power-domain-names ="macro", "dcodec";
> +
> +                       #clock-cells = <0>;
> +                       clock-frequency = <9600000>;
> +                       clock-output-names = "fsgen";
> +                       #sound-dai-cells = <1>;
> +               };
> +
>                 lpass_tlmm: pinctrl@33c0000 {
>                         compatible = "qcom,sc7280-lpass-lpi-pinctrl";
>                         reg = <0 0x33c0000 0x0 0x20000>,
