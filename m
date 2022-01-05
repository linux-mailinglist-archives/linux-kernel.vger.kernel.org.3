Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72CF4859E1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 21:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243933AbiAEUQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 15:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243922AbiAEUQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 15:16:00 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C14C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 12:15:59 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id s21-20020a05683004d500b0058f585672efso659808otd.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 12:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=HSbkNTNm9VCnUs8Ipu7XS+VBlyVvdkfAbBwxdrdNJmM=;
        b=h/Fp33d5JH0AQMkMH6HxzJbLti3BpYDnuXCFfvct3fO1Yk4F5W0CqXtafTBD37+7vZ
         nUYFUA6CQo/ae4VBbHp8lZ/yUbErrZA5tvfeh5Ilc5/j/zNju3CPymXucd8vojblVn1o
         nipOfF2Z5m4uXbr6K3q4DvXzk3RN+qVzkXoVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=HSbkNTNm9VCnUs8Ipu7XS+VBlyVvdkfAbBwxdrdNJmM=;
        b=1YDISEoEiTzj1tAheiB3KTO63S5tYnHBhvKdHx57xYuv6wJb7s4PuZ2IO4rOmMBonf
         hyX4/CbxwQeMZZ9PNbZervvQTx/fOf51YyIVnfNL+Ku5VY6EGw9F/KBQrSLehST2URLW
         OwveIt48jzrwF+xnkpN0D5WdqlmtBYczZ6EalKMaB0S4EPTpQxmPkmMJpJe9HYgwCWQX
         tU+V+a1MTOwcqQp3Lw/DE2yWrmobwbYHbHrMV3YCrV5wY4+EiVJ1GkNRl1R7rmHpPCD1
         j+8K0RLMYc/idyOCRRoF/iSGx3fCIVBMsWnhStR/KazGARzqB32+FkatOdQrsz6QWxZT
         AcgQ==
X-Gm-Message-State: AOAM532CSIGum7+vG6LSfAiqJlLlGffYFR9t60daJ6nLS99Bwi8NXeSA
        sQrsJrRUS1zeiCln3nxVK7xj0vnc/uJRhn8K6DoZiA==
X-Google-Smtp-Source: ABdhPJwLd+XEqPrdAZ7Ph0SB/lz1qb6vj3bA1AIY3TzFcRJvcOAaqL9i2JzAC8gw7biNic9knarJuMLiuf7T7HG3El0=
X-Received: by 2002:a9d:1a6:: with SMTP id e35mr44967ote.77.1641413759265;
 Wed, 05 Jan 2022 12:15:59 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Jan 2022 12:15:58 -0800
MIME-Version: 1.0
In-Reply-To: <1641208380-15510-2-git-send-email-quic_srivasam@quicinc.com>
References: <1641208380-15510-1-git-send-email-quic_srivasam@quicinc.com> <1641208380-15510-2-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 5 Jan 2022 12:15:58 -0800
Message-ID: <CAE-0n523iE-rkSKNvZaF8+qOezEQLo-hAhhMcRoHs9kVa0iLZg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: sc7280: Add nodes for va tx and
 rx macros and external codecs
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, dianders@chromium.org,
        judyhsiao@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        rohitkr@codeaurora.org, srinivas.kandagatla@linaro.org
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2022-01-03 03:12:58)
> SC7280 has VA, TX and RX macros with SoundWire Controllers to attach with
> codecs like WCD938x, max98360a using soundwire masters and i2s bus.
> Add these nodes for sc7280 based platforms audio use case.
> Add tlmm gpio property in wcd938x node for switching CTIA/OMTP Headset.
>
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-crd.dts  |   4 ++
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi |  52 ++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi     | 113 +++++++++++++++++++++++++++++++
>  3 files changed, 169 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> index cd2755c..035cca9 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> @@ -72,6 +72,10 @@ ap_ts_pen_1v8: &i2c13 {
>         pins = "gpio51";
>  };
>
> +&wcd938x {
> +       qcom,us-euro-gpios = <&tlmm 81 0>;

Why is this a qcom prefix vs. a standard foo-gpios property?

> +};
> +
>  &tlmm {
>         tp_int_odl: tp-int-odl {
>                 pins = "gpio7";
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index ddeb508..94614c9 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -636,3 +636,55 @@
>                 bias-pull-up;
>         };
>  };
> +
> +&swr0 {
> +       wcd_rx: wcd938x-rx{

space before { please

Also, are these speakers or amps or something like that? I'd expect the
node name to be more generic.

> +               compatible = "sdw20217010d00";
> +               reg = <0 4>;
> +               #sound-dai-cells = <1>;
> +               qcom,rx-port-mapping = <1 2 3 4 5>;
> +       };
> +};
> +
> +&swr1 {
> +       wcd_tx: wcd938x-tx{
> +               compatible = "sdw20217010d00";
> +               reg = <0 3>;
> +               #sound-dai-cells = <1>;
> +               qcom,tx-port-mapping = <1 2 3 4>;
> +       };
> +};
> +
> +&soc {
> +       max98360a: audio-codec-0 {

This shouldn't be a child of the soc node.

> +               compatible = "maxim,max98360a";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&amp_en>;
> +               sdmode-gpios = <&tlmm 63 GPIO_ACTIVE_HIGH>;
> +               #sound-dai-cells = <0>;
> +       };
> +
> +       wcd938x: codec {

Same comment.

> +               compatible = "qcom,wcd9380-codec";
> +               #sound-dai-cells = <1>;
> +
> +               reset-gpios = <&tlmm 83 0>;
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
> +               qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
> +               qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
> +               qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
> +       };
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 6233f2c..c0d9de3 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -1744,6 +1744,119 @@
>                         #clock-cells = <1>;
>                 };
>
> +               rxmacro: rxmacro@3200000 {

What is rxmacro? Maybe 'soundwire'?

> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&rx_swr_active>;
> +                       compatible = "qcom,sc7280-lpass-rx-macro";
> +                       reg = <0 0x3200000 0 0x1000>;
> +
> +                       clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>,
> +                                       <&lpass_aon LPASS_AON_CC_TX_MCLK_2X_CLK>,
> +                                       <&vamacro>;
> +                       clock-names = "mclk", "npl", "fsgen";
> +                       #clock-cells = <0>;
> +                       clock-frequency = <9600000>;
> +                       clock-output-names = "mclk";
> +                       #sound-dai-cells = <1>;
> +               };
> +
> +               /* rx macro */
> +               swr0: soundwire-controller@3210000 {

Is 'controller' redundant? i.e. soundwire is always a controller? Maybe
'soundwire' is better

> +                       reg = <0 0x3210000 0 0x2000>;
> +                       compatible = "qcom,soundwire-v1.6.0";
> +                       interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&rxmacro>;
> +                       clock-names = "iface";
> +                       label = "RX";
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

Why is this bit stuff in DT vs. in the device driver?

> +
> +                       #sound-dai-cells = <1>;
> +                       #address-cells = <2>;
> +                       #size-cells = <0>;
> +               };
> +
> +               txmacro: txmacro@3220000 {
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&tx_swr_active>;
> +                       compatible = "qcom,sc7280-lpass-tx-macro";
> +                       reg = <0 0x3220000 0 0x1000>;
> +
> +                       clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>,
> +                                        <&lpass_aon LPASS_AON_CC_TX_MCLK_2X_CLK>,
> +                                        <&vamacro>;

Please align the clocks here so the < starts on the same column.

> +                       clock-names = "mclk", "npl", "fsgen";
> +
> +                       #clock-cells = <0>;
> +                       clock-frequency = <9600000>;
> +                       clock-output-names = "mclk";
> +                       #address-cells = <2>;
> +                       #size-cells = <2>;
> +                       #sound-dai-cells = <1>;
> +               };
> +
> +               /* tx macro */

Do we need these comments? Please remove them as they're practically
useless.

> +               swr1: soundwire-controller@3230000 {
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

This looks like some common register location for soundwire oops bits.
Is it another device? Or maybe it's a common register base that needs to
be a syscon?

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
> +                       vdd-micb-supply = <&vreg_bob>;

The supplies need to be set in the board file, no the soc file as they
can be different depending on what the hardware engineer wires to the
pins on the SoC.

> +                       reg = <0 0x3370000 0 0x1000>;
> +                       clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>,
> +                                       <&lpass_audiocc LPASS_AUDIO_CC_RX_MCLK_CLK>;
> +                       clock-names = "mclk", "macro";
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
> --
> 2.7.4
>
