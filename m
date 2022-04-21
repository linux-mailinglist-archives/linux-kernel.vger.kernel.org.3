Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8E250A65C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388724AbiDUQ77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiDUQ7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:59:55 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB1349C9D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:57:05 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id bx5so5487214pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q2IAgvex9X3dkujovRgUSvoi3VREyFVH2u2OtN6n7C4=;
        b=fMWH3qkFo6p1eQi3YpmP2ZMZp5lPiLxdtO4T1c9f48A1aMlUziVN0mMRXiRMzHK9x4
         Q0VCxsYmd2PhUihaVke0MQnUfl8XnnjNLzU9zK1MO+aD39mfbk0i7CNVo2/heAKmIhsS
         Fs2c9kpiwShaZW1QysMiXHWvB9/jmMfVFSq6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q2IAgvex9X3dkujovRgUSvoi3VREyFVH2u2OtN6n7C4=;
        b=kJq6SfeYR0wwAT2nbv5xbLPhEdsCTr4ycgwqSmAuVRDVWBM1axfL1H9bt56H385Z2M
         zhjGYvWlY0x67ElyGxzfL+F88CJWoeLVVsoCjsWVOsdNTWZQVEFQMxS5kGw47L7g6kaX
         OD+T1gzmj20KZufGKsTfOvLVgOWhZsuMEkhnBM+WzmS1QAYJnM9YMHhowAfNqWVskS7x
         i6FhbfvWtNUJZVeVNm758G3MQuhI9aIyY18nnQx2P9OYyh6WYs/y5sRV78FloEAQKCKk
         e6ygiS7GJNt4KbpS5gYe87bfsm9ZWDrUSxWTa0mFV4d78QS/HFYk5cg1wMYauTFuN6S8
         Q+jA==
X-Gm-Message-State: AOAM530rEd1nr/R8BkkSUw/fmRw/Hk0tdoGcxQQPP2ASTn1ePk8KTDr1
        LtcFL6KbRTumofFjOBZw4knYhw==
X-Google-Smtp-Source: ABdhPJzFhlybj2za5Cf0sYeFVh1imb8tBXDYiBI9X7QE2CeAiWCSE2WnwcwMFR4FAviXIBLsEU4ORQ==
X-Received: by 2002:a17:90b:3508:b0:1d2:ef2f:9f8c with SMTP id ls8-20020a17090b350800b001d2ef2f9f8cmr11447953pjb.42.1650560225331;
        Thu, 21 Apr 2022 09:57:05 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:d426:5807:a72:7b27])
        by smtp.gmail.com with UTF8SMTPSA id p11-20020a65490b000000b003aa7791f3afsm4862691pgs.84.2022.04.21.09.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 09:57:05 -0700 (PDT)
Date:   Thu, 21 Apr 2022 09:57:03 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohkumar@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v9 05/12] arm64: dts: qcom: sc7280: Add wcd9385 codec
 node for CRD 3.0/3.1
Message-ID: <YmGM35IjoEhNSdRD@google.com>
References: <1650552459-21077-1-git-send-email-quic_srivasam@quicinc.com>
 <1650552459-21077-6-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1650552459-21077-6-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 08:17:32PM +0530, Srinivasa Rao Mandadapu wrote:
> Add wcd9385 codec node for audio use case on CRD rev5 (aka CRD 3.0/3.1)

nit: rev5+

> boards. Add tlmm gpio property for switching CTIA/OMTP Headset.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts | 52 +++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> index d0794f2..d6a3086 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> @@ -12,6 +12,36 @@
>  / {
>  	model = "Qualcomm Technologies, Inc. sc7280 CRD platform (rev5+)";
>  	compatible = "google,hoglin", "qcom,sc7280";
> +
> +	wcd938x: audio-codec-1 {

wcd9385 (same for the CRD <= 2.0, I missed it there).

> +		compatible = "qcom,wcd9385-codec";



> +		pinctrl-names = "default", "sleep", "us_euro_hs_sel";
> +		pinctrl-0 = <&wcd_reset_n>;
> +		pinctrl-1 = <&wcd_reset_n_sleep>;
> +		pinctrl-2 = <&us_euro_hs_sel>;

This looks wrong, see my comment on the CRD <= 2.0 patch
(https://patchwork.kernel.org/project/linux-arm-msm/patch/1650552459-21077-5-git-send-email-quic_srivasam@quicinc.com/)

> +
> +		reset-gpios = <&tlmm 83 GPIO_ACTIVE_HIGH>;
> +		us-euro-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
> +
> +		qcom,rx-device = <&wcd_rx>;
> +		qcom,tx-device = <&wcd_tx>;
> +
> +		vdd-rxtx-supply = <&vreg_l18b_1p8>;
> +		vdd-io-supply = <&vreg_l18b_1p8>;
> +		vdd-buck-supply = <&vreg_l17b_1p8>;
> +		vdd-mic-bias-supply = <&vreg_bob>;
> +
> +		qcom,micbias1-microvolt = <1800000>;
> +		qcom,micbias2-microvolt = <1800000>;
> +		qcom,micbias3-microvolt = <1800000>;
> +		qcom,micbias4-microvolt = <1800000>;
> +
> +		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000
> +							  500000 500000 500000>;
> +		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
> +		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
> +		#sound-dai-cells = <1>;
> +	};

The wcd9385 is on the qcard, so I think this node should be added to
sc7280-qcard.dtsi and be marked as "disabled". This file can then just
set the status to "okay". Future boards that use the wcd could do the
same, rather than adding a copy of this node to their .dts file.

>  };
>  
>  /* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
> @@ -345,4 +375,26 @@ ap_ts_pen_1v8: &i2c13 {
>  			  "",
>  			  "",
>  			  "";
> +
> +	us_euro_hs_sel: us-euro-hs-sel {
> +		pins = "gpio81";
> +		function = "gpio";
> +		bias-pull-down;
> +		drive-strength = <2>;
> +	};
> +
> +	wcd_reset_n: wcd-reset-n {
> +		pins = "gpio83";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		output-high;
> +	};
> +
> +	wcd_reset_n_sleep: wcd-reset-n-sleep {
> +		pins = "gpio83";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-disable;
> +		output-low;
> +	};

These are also on the qcard, please move the nodes to sc7280-qcard.dtsi
