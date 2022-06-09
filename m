Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8876544B80
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245230AbiFIMO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237898AbiFIMOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:14:52 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA97A15AB1B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 05:14:49 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w27so30879683edl.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 05:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UzOEe2X6Pcp5CwSwzOY2ybmrXssFZ5RmjZdx4tT+M50=;
        b=G/WxesYGBG8H3t/Zi6No32EukuRuEvudUPMMa+c7U9VFoVDPbMbL8Y2lsrAuwDziIY
         I2NgS4zkfLl1TdG5I4Xh53kQv56f3EVw7gWAmcKA19s86ApyHcAebK42vYEETip87382
         5dAoJ/dh7Gnjr9pXIfbgJynGn2hzi7vAVmgkvIh638E7pyGy6c/6t3d4Aogsf1R1MuuZ
         XZ6eOAXQdjXBjF9gyk8Ggi8fvtWyni6uFwiohsvNjOShK2a/Yh+RqkRz43pjBC3WSVkm
         b9tJVs00exkAScc1g4B3wy9bMSGPMVZa9737bLWsJjbbtWwxmZLWEapE5Z5QAauGD6vv
         olnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UzOEe2X6Pcp5CwSwzOY2ybmrXssFZ5RmjZdx4tT+M50=;
        b=C67QFtysckNilu2xUQmMuhUhJc4eivEEiY5yVbgK9d2halcp24TAZJhMrQnV4JoYie
         jQmS7DdBkpvfBouBjgR2PEVa+8ZIK96Ox7NoMMSTAxCkOgIBPfPFpD/p8T2oKoC74W5Q
         5PHSbAkcJf4/zfH27pwouXFMJ6u5sLMK+uVc9kiYon8dV2pYfsJtfk2PPQFPdMSPt85R
         MvlpwEs2lvNHifrjINEuDlPXXOht6T2vx5RY4Ha74FxTKZh7CirZQZarBVkgAMRscb53
         FID8v8nR9+thJraexBN0AtfnI+CXQDEIYXDPvig0kfY5in9KNSoMUznsFEGTpPWUxwS4
         CsIA==
X-Gm-Message-State: AOAM530yx03e+PqZh2qyHdD4Bu9Iav8KNP8nq6ZvSoXeZK13iB6eilGe
        JEAmifgYSzwGLBpFink/BBH+iQ==
X-Google-Smtp-Source: ABdhPJxm+YhFVbWSiAI0yxYJExwM3A6gaCeP9DrDlyEGnXB/LOPPvq6V3/x2Q0jrhgeqqaicyeV4wg==
X-Received: by 2002:a05:6402:378b:b0:42a:ad8c:628f with SMTP id et11-20020a056402378b00b0042aad8c628fmr44794604edb.90.1654776888389;
        Thu, 09 Jun 2022 05:14:48 -0700 (PDT)
Received: from [192.168.0.197] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i2-20020a056402054200b004315050d7dfsm8255608edx.81.2022.06.09.05.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 05:14:47 -0700 (PDT)
Message-ID: <89afe584-58d6-537a-b30e-84153c228225@linaro.org>
Date:   Thu, 9 Jun 2022 14:14:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] arm64: dts: qcom/sdm845-shift-axolotl: Add audio
 support
Content-Language: en-US
To:     Alexander Martinz <amartinz@shiftphones.com>,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
References: <20220609095412.211060-1-amartinz@shiftphones.com>
 <20220609095412.211060-2-amartinz@shiftphones.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220609095412.211060-2-amartinz@shiftphones.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2022 11:54, Alexander Martinz wrote:
> This patch adds audio support for the SHIFT6mq phone.
> 
> The primary microphone and headphone jack are handled by the
> SDM845 sound card and WCD9340 codec.
> 
> The primary speaker needs to go through the TFA9890 speaker
> amplifier.

Thank you for your patch. There is something to discuss/improve.

> 
> Signed-off-by: Alexander Martinz <amartinz@shiftphones.com>
> Tested-by: Dylan Van Assche <me@dylanvanassche.be>

Same problem.

> ---
>  .../boot/dts/qcom/sdm845-shift-axolotl.dts    | 141 ++++++++++++++++++
>  1 file changed, 141 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> index fa72f23ef0c2..8c4967d6d0e3 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
> @@ -8,6 +8,8 @@
>  
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include <dt-bindings/sound/qcom,q6afe.h>
> +#include <dt-bindings/sound/qcom,q6asm.h>
>  #include "sdm845.dtsi"
>  #include "pm8998.dtsi"
>  #include "pmi8998.dtsi"
> @@ -492,6 +494,19 @@ touchscreen@38 {
>  	};
>  };
>  
> +&i2c11 {
> +	status = "okay";
> +	clock-frequency = <400000>;
> +
> +	tfa9890_codec: tfa9890@34 {

Generic node names please, so I guess it is: codec or audio-codec

> +		compatible = "nxp,tfa9890";
> +		reg = <0x34>;
> +		vddd-supply = <&vreg_s4a_1p8>;
> +		reset-gpio = <&tlmm 7 0>;
> +		#sound-dai-cells = <1>;
> +	};
> +};
> +
>  &ipa {
>  	status = "okay";
>  
> @@ -530,6 +545,27 @@ volume_down_resin: resin {
>  	};
>  };
>  
> +&q6afedai {
> +	qi2s@22 {
> +		reg = <22>;
> +		qcom,sd-lines = <0>;
> +	};
> +};
> +
> +&q6asmdai {
> +	dai@0 {
> +		reg = <0>;
> +	};
> +
> +	dai@1 {
> +		reg = <1>;
> +	};
> +
> +	dai@2 {
> +		reg = <2>;
> +	};
> +};
> +
>  /*
>   * Prevent garbage data on bluetooth UART lines
>   */
> @@ -578,6 +614,84 @@ &qupv3_id_1 {
>  	status = "okay";
>  };
>  
> +&sound {
> +	model = "SHIFT6mq";
> +	compatible = "qcom,sdm845-sndcard";
> +	pinctrl-0 = <&quat_mi2s_active &quat_mi2s_sd0_active>;
> +	pinctrl-names = "default";
> +
> +	audio-routing = "RX_BIAS", "MCLK",
> +			"AMIC1", "MIC BIAS1",
> +			"AMIC2", "MIC BIAS2",
> +			"AMIC3", "MIC BIAS3";
> +
> +	mm1-dai-link {
> +		link-name = "MultiMedia1";
> +		cpu {
> +			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
> +		};
> +	};
> +
> +	mm2-dai-link {
> +		link-name = "MultiMedia2";
> +		cpu {
> +			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA2>;
> +		};
> +	};
> +
> +	mm3-dai-link {
> +		link-name = "MultiMedia3";
> +		cpu {
> +			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA3>;
> +		};
> +	};
> +
> +	speaker-dai-link {
> +		link-name = "Speaker Playback";
> +		codec {
> +			sound-dai = <&tfa9890_codec 0>;
> +		};
> +
> +		cpu {
> +			sound-dai = <&q6afedai QUATERNARY_MI2S_RX>;
> +		};
> +
> +		platform {
> +			sound-dai = <&q6routing>;
> +		};
> +	};
> +
> +	slim-dai-link {
> +		link-name = "SLIM Playback";
> +		codec {
> +			sound-dai = <&wcd9340 0>;
> +		};
> +
> +		cpu {
> +			sound-dai = <&q6afedai SLIMBUS_0_RX>;
> +		};
> +
> +		platform {
> +			sound-dai = <&q6routing>;
> +		};
> +	};
> +
> +	slimcap-dai-link {
> +		link-name = "SLIM Capture";
> +		codec {
> +			sound-dai = <&wcd9340 1>;
> +		};
> +
> +		cpu {
> +			sound-dai = <&q6afedai SLIMBUS_0_TX>;
> +		};
> +
> +		platform {
> +			sound-dai = <&q6routing>;
> +		};
> +	};
> +};
> +
>  &tlmm {
>  	gpio-reserved-ranges = <0 4>, <81 4>;
>  
> @@ -686,6 +800,15 @@ config {
>  			bias-pull-down;
>  		};
>  	};
> +
> +	wcd_intr_default: wcd_intr_default {

No underscores in node names. Instead hyphens.

> +		pins = <54>;
> +		function = "gpio";
> +
> +		input-enable;
> +		bias-pull-down;
> +		drive-strength = <2>;
> +	};
>  };


Best regards,
Krzysztof
