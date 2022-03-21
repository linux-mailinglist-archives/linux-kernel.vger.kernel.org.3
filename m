Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39394E310A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352894AbiCUUHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241950AbiCUUHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:07:18 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A650F36302
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:05:52 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id j7-20020a4ad6c7000000b0031c690e4123so20632104oot.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=lk0AKdp8jds7p631EcsWbrWAhTRrpqSIDlrdiHaTQ4Q=;
        b=DpgI02fRkehOJeypUXWjq22hIcV0KKYua1AN7LJq/HJVmY+fk6tteQGMxX3xar8eJY
         9j+mrKo73yRDKRRvkXHTXA9Rynm0y7hmbp6VYvfeTTrQKKbNlOpjc6E3gdPzFbb5toGo
         GxBb1rvKO0vFKG1c0EZsb2jPIl5t2eXPlpKA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=lk0AKdp8jds7p631EcsWbrWAhTRrpqSIDlrdiHaTQ4Q=;
        b=jfqUdGvXR5Qnl7wAk+U0aoIJS5+PwmS548SNYjeedXHb90Ne8aBwwDuVgWjIJ7Be3A
         /yXVuoETQTMJeEJTnUBLDYQSYPJ+sj0gXAWglAxXwNa1KV6snEIWb+3badQMflzbItSi
         n6lbfu+F0EI812HV7nHD6VITcnFkzkyEeYgB8moECSfPtYyzcko9fNR01hUcS8Xfv3Fz
         8ag2LOrHX0YOJoDbXp0RHNpVRzzI3qAbcGtSZ8VhtKqX6JuEfdFMOLjIwpUMpLCwW70x
         CKmeOxkHfvABy7ksMW3gHPab7P6e+m6eKpWhqsTsmCVeZaFI4q965R71ZLtgkMoPOFL8
         CaBQ==
X-Gm-Message-State: AOAM532nyXHF9PNr+q6wdVMZzbIk0dHZPud3MDJYQCvaHUedqNVyHnxz
        9ZdlCbzwPc88NcRQvqsK3bs0GRa3sEK+EaPWcz0qOg==
X-Google-Smtp-Source: ABdhPJz/UP6gaqrk/M7SfwM5+j4LnvvwReXIlUQLwO489z6XVpbUh1iETDqepTff503Mgd43MwdPy0fsY6xMii7BCoM=
X-Received: by 2002:a05:6870:b69c:b0:dd:b74b:4099 with SMTP id
 cy28-20020a056870b69c00b000ddb74b4099mr299550oab.193.1647893151809; Mon, 21
 Mar 2022 13:05:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Mar 2022 21:05:51 +0100
MIME-Version: 1.0
In-Reply-To: <1647865696-19192-2-git-send-email-quic_srivasam@quicinc.com>
References: <1647865696-19192-1-git-send-email-quic_srivasam@quicinc.com> <1647865696-19192-2-git-send-email-quic_srivasam@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 21 Mar 2022 21:05:51 +0100
Message-ID: <CAE-0n52E+_BUr33=DCt_rBi-KtdtG01PeRFJ-G98ME4Ka-6q8A@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] arm64: dts: qcom: sc7280: Add nodes for va tx and
 rx macros and external codecs
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, dianders@chromium.org,
        judyhsiao@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        rohitkr@codeaurora.org, srinivas.kandagatla@linaro.org
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2022-03-21 05:28:14)
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> index e2efbdd..224a82d 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> @@ -84,6 +84,12 @@ ap_ts_pen_1v8: &i2c13 {
>         pins = "gpio51";
>  };
>
> +&wcd938x {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&us_euro_select>;
> +       us-euro-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
> +};
> +
>  &tlmm {
>         tp_int_odl: tp-int-odl {
>                 pins = "gpio7";
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> index de646d9..c6a04c3 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> @@ -20,6 +20,14 @@
>  #include "sc7280-chrome-common.dtsi"
>
>  / {
> +       max98360a: audio-codec-0 {
> +               compatible = "maxim,max98360a";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&amp_en>;
> +               sdmode-gpios = <&tlmm 63 GPIO_ACTIVE_HIGH>;
> +               #sound-dai-cells = <0>;
> +       };
> +
>         chosen {
>                 stdout-path = "serial0:115200n8";
>         };
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 4a7b18a..5f75c9a 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -20,6 +20,41 @@
>                 serial1 = &uart7;
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
> +       wcd938x: audio-codec-1 {
> +               compatible = "qcom,wcd9380-codec";
> +               #sound-dai-cells = <1>;
> +
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&wcd938x_reset_active>, <&wcd938x_reset_sleep>;
> +               reset-gpios = <&tlmm 83 GPIO_ACTIVE_HIGH>;
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
> +
>         gpio-keys {
>                 compatible = "gpio-keys";
>                 label = "gpio-keys";
> @@ -476,6 +511,143 @@
>         drive-strength = <6>;
>  };
>
> +&soc {

Why is the soc node being modified in the board file? I expect these
nodes to always be present in the SoC (sc7280) so they should be largely
defined in the sc7280.dtsi file, except for any voltage supplies that
are described in the board file because the board design dictates what
power supplies are connected to the SoC pads.

> +       rxmacro: codec@3200000 {
> +               compatible = "qcom,sc7280-lpass-rx-macro";
> +               reg = <0 0x03200000 0 0x1000>;
> +
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&rx_swr_active>;
> +
> +               clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>,
> +                        <&lpass_aon LPASS_AON_CC_TX_MCLK_2X_CLK>,
> +                        <&vamacro>;
> +               clock-names = "mclk", "npl", "fsgen";
> +
> +               power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
> +                               <&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
> +               power-domain-names ="macro", "dcodec";
> +
> +               #clock-cells = <0>;
> +               #sound-dai-cells = <1>;
> +       };

This whole node can be moved to sc7280.dtsi and then we can have a
simple

	&rxmacro {
		status = "okay";
	};

here.

> +
> +       txmacro: codec@3220000 {
> +               compatible = "qcom,sc7280-lpass-tx-macro";
> +               reg = <0 0x03220000 0 0x1000>;
> +
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&tx_swr_active>;
> +
> +               clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>,
> +                        <&lpass_aon LPASS_AON_CC_TX_MCLK_2X_CLK>,
> +                        <&vamacro>;
> +               clock-names = "mclk", "npl", "fsgen";
> +
> +               power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
> +                               <&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
> +               power-domain-names ="macro", "dcodec";
> +
> +               #clock-cells = <0>;
> +               #sound-dai-cells = <1>;

Same, but txmacro.

> +       };
> +
> +       vamacro: codec@3370000 {
> +               compatible = "qcom,sc7280-lpass-va-macro";
> +               reg = <0 0x03370000 0 0x1000>;
> +
> +               pinctrl-0 = <&dmic01_active>;
> +               pinctrl-names = "default";
> +
> +               clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>;
> +               clock-names = "mclk";
> +
> +               power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
> +                               <&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
> +               power-domain-names ="macro", "dcodec";
> +
> +               vdd-micb-supply = <&vreg_bob>;
> +
> +               #clock-cells = <0>;
> +               #sound-dai-cells = <1>;

This one can move as well, except for vdd-micb-supply which needs to
stay here.

	&vamacro {
		status = "okay";
		vdd-micb-supply = <&vreg_bob>;
	};

> +       };
> +
> +       swr0: soundwire@3210000 {
> +               compatible = "qcom,soundwire-v1.6.0";
> +               reg = <0 0x03210000 0 0x2000>;

This node should largely go into the sc7280.dtsi file.

> +
> +               interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks = <&rxmacro>;
> +               clock-names = "iface";
> +
> +               qcom,din-ports = <0>;
> +               qcom,dout-ports = <5>;
> +
> +               resets = <&lpass_audiocc LPASS_AUDIO_SWR_RX_CGCR>;
> +               reset-names = "swr_audio_cgcr";
> +
> +               qcom,ports-word-length =        /bits/ 8 <0x01 0x07 0x04 0xff 0xff>;
> +               qcom,ports-sinterval-low =      /bits/ 8 <0x03 0x3f 0x1f 0x03 0x03>;
> +               qcom,ports-offset1 =            /bits/ 8 <0x00 0x00 0x0b 0x01 0x01>;
> +               qcom,ports-offset2 =            /bits/ 8 <0x00 0x00 0x0b 0x00 0x00>;
> +               qcom,ports-lane-control =       /bits/ 8 <0x01 0x00 0x00 0x00 0x00>;
> +               qcom,ports-block-pack-mode =    /bits/ 8 <0xff 0x00 0x01 0xff 0xff>;
> +               qcom,ports-hstart =             /bits/ 8 <0xff 0x03 0xff 0xff 0xff>;
> +               qcom,ports-hstop =              /bits/ 8 <0xff 0x06 0xff 0xff 0xff>;
> +               qcom,ports-block-group-count =  /bits/ 8 <0xff 0xff 0xff 0xff 0x00>;

Are these properties board specific? The sm8250.dtsi file has them so I
guess not.

> +
> +               #sound-dai-cells = <1>;
> +               #address-cells = <2>;
> +               #size-cells = <0>;
> +
> +               wcd_rx: codec@0,4 {
> +                       compatible = "sdw20217010d00";

Is this some component on the board? If so then it should stay here in
this file.

> +                       reg = <0 4>;
> +                       #sound-dai-cells = <1>;
> +                       qcom,rx-port-mapping = <1 2 3 4 5>;
> +               };
> +       };
> +
> +       swr1: soundwire@3230000 {
> +               compatible = "qcom,soundwire-v1.6.0";
> +               reg = <0 0x03230000 0 0x2000>;
> +
> +               interrupts-extended = <&intc GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
> +                                     <&pdc 130 IRQ_TYPE_LEVEL_HIGH>;
> +               interrupt-names = "swr_master_irq", "swr_wake_irq";
> +               clocks = <&txmacro>;
> +               clock-names = "iface";
> +
> +               qcom,din-ports = <3>;
> +               qcom,dout-ports = <0>;
> +
> +               resets = <&lpass_audiocc LPASS_AUDIO_SWR_TX_CGCR>;
> +               reset-names = "swr_audio_cgcr";
> +
> +               qcom,ports-sinterval-low =      /bits/ 8 <0x01 0x03 0x03>;
> +               qcom,ports-offset1 =            /bits/ 8 <0x01 0x00 0x02>;
> +               qcom,ports-offset2 =            /bits/ 8 <0x00 0x00 0x00>;
> +               qcom,ports-hstart =             /bits/ 8 <0xff 0xff 0xff>;
> +               qcom,ports-hstop =              /bits/ 8 <0xff 0xff 0xff>;
> +               qcom,ports-word-length =        /bits/ 8 <0xff 0x0 0xff>;
> +               qcom,ports-block-pack-mode =    /bits/ 8 <0xff 0xff 0xff>;
> +               qcom,ports-block-group-count =  /bits/ 8 <0xff 0xff 0xff>;
> +               qcom,ports-lane-control =       /bits/ 8 <0x00 0x01 0x00>;
> +               qcom,port-offset = <1>;
> +
> +               #sound-dai-cells = <1>;
> +               #address-cells = <2>;
> +               #size-cells = <0>;
> +
> +               wcd_tx: codec@0,3 {
> +                       compatible = "sdw20217010d00";
> +                       reg = <0 3>;
> +                       #sound-dai-cells = <1>;
> +                       qcom,tx-port-mapping = <1 2 3 4>;
> +               };

Same question about being a board component. Probably yes?

> +       };
> +};
> +
>  &tlmm {
>         amp_en: amp-en {
