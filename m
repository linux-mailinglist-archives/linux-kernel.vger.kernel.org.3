Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B315C4F4F8E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242499AbiDFAxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572898AbiDERQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:16:21 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B40725C2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 10:14:23 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so45829pjk.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 10:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0s66Tr5Fxz2b83SYU1mHaVJqlskQtPLz5vVq+NK22v0=;
        b=k997fVYIhUwrf3n7zR/PwUUEFagjhi1fLWsA3VodXXYnlAEu1dk8ROS3lIp6Q6HXTe
         mMbAKhE/sebpwCH8zuiwKNX6NfYo48PWIgZbg4chdCoxSN3Erg5VyxQUVCRRXNhU8/5F
         iEULqe4Xv8ZJEFyZ9KqeBh8CVw4GRN6c+3HIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0s66Tr5Fxz2b83SYU1mHaVJqlskQtPLz5vVq+NK22v0=;
        b=AS4OThH6SJn7owdccB6Uk/wl2OdQY/j8OKYGjigok/w5DC+Abfufkw5SoHXjf35QDJ
         dq9+KIYsQz9/w1P1T0C92vqyZS5wP9MFA8yAhHqWpTazVzzo0mEouv932MVtSKLAWQh3
         0AoaZMLNezt1acZ9XXR4jpFzj0Qjm3hmeCiZz7AfwTjgHqCVOWoTSRLinA0E3VPXkj9H
         S6NlS8948PhMShVC31PXc/thzt4QRkQ/05AiUg8MBG/BA7dBMu0vXk0XVEqt74VvjOe1
         eRtOlYQ8Z+49wxfsokQs3VO0VcyZRqi5x02lxQOVleD983yOLoFr76e8U+CmVAL/mfaP
         IWdg==
X-Gm-Message-State: AOAM532JSZ8CKuH5Nnf+aUO7kVQRiW+RgxRcc/VQ92qkyzcXZIbVXwcI
        lvlWJR+M5pSa8MdKxUFpSPa1xg==
X-Google-Smtp-Source: ABdhPJwj4vid1vbB9Yl2j9x5FaTZNaJiwiQ9QqyLaZybPMRgTyUPrEjgwkXJTHjdx8XUqV+zFKBXvQ==
X-Received: by 2002:a17:903:22cf:b0:154:837c:597 with SMTP id y15-20020a17090322cf00b00154837c0597mr4389570plg.135.1649178862778;
        Tue, 05 Apr 2022 10:14:22 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6b63:d403:e31b:da39])
        by smtp.gmail.com with UTF8SMTPSA id k62-20020a17090a4cc400b001c7ea7f487asm3094710pjh.39.2022.04.05.10.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 10:14:22 -0700 (PDT)
Date:   Tue, 5 Apr 2022 10:14:20 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_rohitkr@quicinc.com,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v6 2/2] arm64: dts: qcom: sc7280: add lpass lpi pin
 controller node
Message-ID: <Ykx47AlGYa8s5FTa@google.com>
References: <1649157167-29106-1-git-send-email-quic_srivasam@quicinc.com>
 <1649157167-29106-3-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1649157167-29106-3-git-send-email-quic_srivasam@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 04:42:47PM +0530, Srinivasa Rao Mandadapu wrote:
> Add LPASS LPI pinctrl node required for Audio functionality on sc7280
> based platforms.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi |  98 ++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi     | 107 +++++++++++++++++++++++++++++++
>  2 files changed, 205 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 2afbbe3..f912a89 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -238,6 +238,104 @@
>  	modem-init;
>  };
>  
> +&lpass_tlmm {
> +	dmic01_active: dmic01-active {
> +		clk {
> +			drive-strength = <8>;
> +		};
> +
> +		data {
> +			drive-strength = <8>;

The DMIC data pins are input pins, right? Why does an input pin need a drive
strength? Same for other input pins.

> +		};
> +	};

There's no need to reference 'lpass_tlmm' nor to repeat $label: $node.
Instead just use phandles:

&dmic01_active {
	clk {
		drive-strength = <8>;
	};

	data {
		drive-strength = <8>;
	};
};

Rather than replicating the node hierarchy you could also just give each pin a
label, and then:

&dmic01_clk_active {
	drive-strength = <8>;
};

&dmic01_data_active {
	drive-strength = <8>;
};

I don't have a strong preference, but wonder if the grouping adds any value.

> +
> +	dmic01_sleep: dmic01-sleep {
> +		clk {
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +
> +		data {
> +			drive-strength = <2>;
> +			pull-down;
> +		};
> +	};
> +
> +	dmic23_active: dmic02-active {
> +		clk {
> +			drive-strength = <8>;
> +		};
> +
> +		data {
> +			drive-strength = <8>;
> +		};
> +	};
> +
> +	dmic23_sleep: dmic02-sleep {
> +		clk {
> +			drive-strength = <2>;
> +			bias-disable;
> +		};
> +
> +		data {
> +			drive-strength = <2>;
> +			pull-down;
> +		};
> +	};
> +
> +	rx_swr_active: rx-swr-active {
> +		clk {
> +			drive-strength = <2>;
> +			slew-rate = <1>;
> +			bias-disable;
> +		};
> +
> +		data {
> +			drive-strength = <2>;
> +			slew-rate = <1>;
> +			bias-bus-hold;
> +		};
> +	};
> +
> +	rx_swr_sleep: rx-swr-sleep {
> +		clk {
> +			drive-strength = <2>;
> +			bias-pull-down;
> +		};
> +
> +		data {
> +			drive-strength = <2>;
> +			bias-pull-down;
> +		};
> +	};
> +
> +	tx_swr_active: tx-swr-active {
> +		clk {
> +			drive-strength = <2>;
> +			slew-rate = <1>;
> +			bias-disable;
> +		};
> +
> +		data {
> +			drive-strength = <2>;
> +			slew-rate = <1>;
> +			bias-bus-hold;
> +		};
> +	};
> +
> +	tx_swr_sleep: tx-swr-sleep {
> +		clk {
> +			drive-strength = <2>;
> +			bias-pull-down;
> +		};
> +
> +		data {
> +			drive-strength = <2>;
> +			bias-bus-hold;
> +		};
> +	};
> +};
> +
>  &pcie1 {
>  	status = "okay";
>  	perst-gpio = <&tlmm 2 GPIO_ACTIVE_LOW>;
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 8d8cec5..db74fc3 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -1987,6 +1987,113 @@
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
>  
> +		lpass_tlmm: pinctrl@33c0000 {
> +			compatible = "qcom,sc7280-lpass-lpi-pinctrl";
> +			reg = <0 0x33c0000 0x0 0x20000>,
> +				<0 0x3550000 0x0 0x10000>;

Pad addresses to 8 digits.

> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-ranges = <&lpass_tlmm 0 0 15>;
> +
> +			#clock-cells = <1>;
> +
> +			dmic01_active: dmic01-active {
> +				clk {
> +					pins = "gpio6";
> +					function = "dmic1_clk";
> +				};
> +
> +				data {
> +					pins = "gpio7";
> +					function = "dmic1_data";
> +				};
> +			};
> +
> +			dmic01_sleep: dmic01-sleep {
> +				clk {
> +					pins = "gpio6";
> +					function = "dmic1_clk";
> +				};
> +
> +				data {
> +					pins = "gpio7";
> +					function = "dmic1_data";
> +				};
> +			};
> +
> +			dmic23_active: dmic02-active {

is it intentional that the node name is 'dmic02*', but the label 'dmic23*'?

> +				clk {
> +					pins = "gpio8";
> +					function = "dmic2_clk";
> +				};
> +
> +				data {
> +					pins = "gpio9";
> +					function = "dmic2_data";
> +				};
> +			};
> +
> +			dmic23_sleep: dmic02-sleep {

ditto

> +				clk {
> +					pins = "gpio8";
> +					function = "dmic2_clk";
> +				};
> +
> +				data {
> +					pins = "gpio9";
> +					function = "dmic2_data";
> +				};
> +			};
> +
> +			rx_swr_active: rx-swr-active {
> +				clk {
> +					pins = "gpio3";
> +					function = "swr_rx_clk";
> +				};
> +
> +				data {
> +					pins = "gpio4", "gpio5";
> +					function = "swr_rx_data";
> +				};
> +			};
> +
> +			rx_swr_sleep: rx-swr-sleep {
> +				clk {
> +					pins = "gpio3";
> +					function = "swr_rx_clk";
> +				};
> +
> +				data {
> +					pins = "gpio4", "gpio5";
> +					function = "swr_rx_data";
> +				};
> +			};
> +
> +			tx_swr_active: tx-swr-active {
> +				clk {
> +					pins = "gpio0";
> +					function = "swr_tx_clk";
> +				};
> +
> +				data {
> +					pins = "gpio1", "gpio2", "gpio14";
> +					function = "swr_tx_data";
> +				};
> +			};
> +
> +			tx_swr_sleep: tx-swr-sleep {
> +				clk {
> +					pins = "gpio0";
> +					function = "swr_tx_clk";
> +				};
> +
> +				data {
> +					pins = "gpio1", "gpio2", "gpio14";
> +					function = "swr_tx_data";
> +				};
> +			};
> +		};
> +
>  		gpu: gpu@3d00000 {
>  			compatible = "qcom,adreno-635.0", "qcom,adreno";
>  			reg = <0 0x03d00000 0 0x40000>,
