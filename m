Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B084F64E8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237579AbiDFQ1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237734AbiDFQ06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:26:58 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8F91AF7CB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 19:15:56 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s72so986221pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 19:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p+/JljknQMw8XcaBWsgixj9umqk5+DiaogKeytdkVos=;
        b=Gfr4nEj+95ViBM7QBzuL4YUTuNGg3zJNjfqKZQcjWytKE3qpaNx2nTyIYl8cLOUpAn
         ztA05KhFvw8oL7Iqe/XzFOIQSTO6GNaAtzIcGrg0dhj5WswJ56DpP/aOpuexPZByH17Y
         4a0AneA0chnYOxFNjE++clig/VN4lo//nuQ7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p+/JljknQMw8XcaBWsgixj9umqk5+DiaogKeytdkVos=;
        b=sUuxMk5SMl6MNFzcLkfgdmg54QjpDToT6dqbYKbb4NggwJRiFsATUfETAVQeirPpar
         DigoYGNJvzIzf0Wqs2rgfoqQIihHcoICXDa0vi1TRIEkGruZF+gfR0noGboKKYAFc/Bh
         YneviTdx+AbDug/R3rzkY64R7TNLS2TPQTnxyt4kO2FBgyC66zfcAtIVnfR2F9/i3Twu
         Y8CKTPGEjBMz8+IGyHmsCyv5VgNRBMYR9uGHkVhMAgtXudldzOwcctBxKbBv3gQvYC7c
         Hj5GruH+l0npTUQZWcdVHDjHwOozJ0oLyGGmRBMbuk/JK8THJ6cFBAGHMAUbMpHlvcz0
         O4/A==
X-Gm-Message-State: AOAM532VR4xLeUvLLZlRJMgdPf/Ahzkehquy39NXDN0nf6XVTfD8IdBu
        9YzfKxZcgEGqnGOrnvwdSuPUbA==
X-Google-Smtp-Source: ABdhPJwbRb3OJuCGiMt66+NRuG+xEgZDPyRbFkqYOfW6pu+kNIq7dYqMaCrpJnztt3UbP5q827JN3A==
X-Received: by 2002:aa7:9e0f:0:b0:4fd:fb27:a42 with SMTP id y15-20020aa79e0f000000b004fdfb270a42mr6736930pfq.13.1649211355504;
        Tue, 05 Apr 2022 19:15:55 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:6b63:d403:e31b:da39])
        by smtp.gmail.com with UTF8SMTPSA id d21-20020a056a0024d500b004fb0e7c7c3bsm18115245pfv.161.2022.04.05.19.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 19:15:54 -0700 (PDT)
Date:   Tue, 5 Apr 2022 19:15:53 -0700
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
Message-ID: <Ykz32cMNG8PhN2c+@google.com>
References: <1649157167-29106-1-git-send-email-quic_srivasam@quicinc.com>
 <1649157167-29106-3-git-send-email-quic_srivasam@quicinc.com>
 <Ykx47AlGYa8s5FTa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ykx47AlGYa8s5FTa@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 10:14:20AM -0700, Matthias Kaehlcke wrote:
> On Tue, Apr 05, 2022 at 04:42:47PM +0530, Srinivasa Rao Mandadapu wrote:
> > Add LPASS LPI pinctrl node required for Audio functionality on sc7280
> > based platforms.
> > 
> > Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> > Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> > Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> > ---
> >  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi |  98 ++++++++++++++++++++++++++++
> >  arch/arm64/boot/dts/qcom/sc7280.dtsi     | 107 +++++++++++++++++++++++++++++++
> >  2 files changed, 205 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> > index 2afbbe3..f912a89 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> > @@ -238,6 +238,104 @@
> >  	modem-init;
> >  };
> >  
> > +&lpass_tlmm {
> > +	dmic01_active: dmic01-active {
> > +		clk {
> > +			drive-strength = <8>;
> > +		};
> > +
> > +		data {
> > +			drive-strength = <8>;
> 
> The DMIC data pins are input pins, right? Why does an input pin need a drive
> strength? Same for other input pins.
> 
> > +		};
> > +	};
> 
> There's no need to reference 'lpass_tlmm' nor to repeat $label: $node.
> Instead just use phandles:
> 
> &dmic01_active {
> 	clk {
> 		drive-strength = <8>;
> 	};
> 
> 	data {
> 		drive-strength = <8>;
> 	};
> };
> 
> Rather than replicating the node hierarchy you could also just give each pin a
> label, and then:
> 
> &dmic01_clk_active {
> 	drive-strength = <8>;
> };
> 
> &dmic01_data_active {
> 	drive-strength = <8>;
> };
> 
> I don't have a strong preference, but wonder if the grouping adds any value.

One more thing: please also drop the '_active' suffix, it is not needed. With
that I think it's clearer to get rid of the grouping.

> > +
> > +	dmic01_sleep: dmic01-sleep {
> > +		clk {
> > +			drive-strength = <2>;
> > +			bias-disable;
> > +		};
> > +
> > +		data {
> > +			drive-strength = <2>;
> > +			pull-down;
> > +		};
> > +	};
> > +
> > +	dmic23_active: dmic02-active {
> > +		clk {
> > +			drive-strength = <8>;
> > +		};
> > +
> > +		data {
> > +			drive-strength = <8>;
> > +		};
> > +	};
> > +
> > +	dmic23_sleep: dmic02-sleep {
> > +		clk {
> > +			drive-strength = <2>;
> > +			bias-disable;
> > +		};
> > +
> > +		data {
> > +			drive-strength = <2>;
> > +			pull-down;
> > +		};
> > +	};
> > +
> > +	rx_swr_active: rx-swr-active {
> > +		clk {
> > +			drive-strength = <2>;
> > +			slew-rate = <1>;
> > +			bias-disable;
> > +		};
> > +
> > +		data {
> > +			drive-strength = <2>;
> > +			slew-rate = <1>;
> > +			bias-bus-hold;
> > +		};
> > +	};
> > +
> > +	rx_swr_sleep: rx-swr-sleep {
> > +		clk {
> > +			drive-strength = <2>;
> > +			bias-pull-down;
> > +		};
> > +
> > +		data {
> > +			drive-strength = <2>;
> > +			bias-pull-down;
> > +		};
> > +	};
> > +
> > +	tx_swr_active: tx-swr-active {
> > +		clk {
> > +			drive-strength = <2>;
> > +			slew-rate = <1>;
> > +			bias-disable;
> > +		};
> > +
> > +		data {
> > +			drive-strength = <2>;
> > +			slew-rate = <1>;
> > +			bias-bus-hold;
> > +		};
> > +	};
> > +
> > +	tx_swr_sleep: tx-swr-sleep {
> > +		clk {
> > +			drive-strength = <2>;
> > +			bias-pull-down;
> > +		};
> > +
> > +		data {
> > +			drive-strength = <2>;
> > +			bias-bus-hold;
> > +		};
> > +	};
> > +};
> > +
> >  &pcie1 {
> >  	status = "okay";
> >  	perst-gpio = <&tlmm 2 GPIO_ACTIVE_LOW>;
> > diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > index 8d8cec5..db74fc3 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > @@ -1987,6 +1987,113 @@
> >  			qcom,bcm-voters = <&apps_bcm_voter>;
> >  		};
> >  
> > +		lpass_tlmm: pinctrl@33c0000 {
> > +			compatible = "qcom,sc7280-lpass-lpi-pinctrl";
> > +			reg = <0 0x33c0000 0x0 0x20000>,
> > +				<0 0x3550000 0x0 0x10000>;
> 
> Pad addresses to 8 digits.
> 
> > +			gpio-controller;
> > +			#gpio-cells = <2>;
> > +			gpio-ranges = <&lpass_tlmm 0 0 15>;
> > +
> > +			#clock-cells = <1>;
> > +
> > +			dmic01_active: dmic01-active {
> > +				clk {
> > +					pins = "gpio6";
> > +					function = "dmic1_clk";
> > +				};
> > +
> > +				data {
> > +					pins = "gpio7";
> > +					function = "dmic1_data";
> > +				};
> > +			};
> > +
> > +			dmic01_sleep: dmic01-sleep {
> > +				clk {
> > +					pins = "gpio6";
> > +					function = "dmic1_clk";
> > +				};
> > +
> > +				data {
> > +					pins = "gpio7";
> > +					function = "dmic1_data";
> > +				};
> > +			};
> > +
> > +			dmic23_active: dmic02-active {
> 
> is it intentional that the node name is 'dmic02*', but the label 'dmic23*'?
> 
> > +				clk {
> > +					pins = "gpio8";
> > +					function = "dmic2_clk";
> > +				};
> > +
> > +				data {
> > +					pins = "gpio9";
> > +					function = "dmic2_data";
> > +				};
> > +			};
> > +
> > +			dmic23_sleep: dmic02-sleep {
> 
> ditto
> 
> > +				clk {
> > +					pins = "gpio8";
> > +					function = "dmic2_clk";
> > +				};
> > +
> > +				data {
> > +					pins = "gpio9";
> > +					function = "dmic2_data";
> > +				};
> > +			};
> > +
> > +			rx_swr_active: rx-swr-active {
> > +				clk {
> > +					pins = "gpio3";
> > +					function = "swr_rx_clk";
> > +				};
> > +
> > +				data {
> > +					pins = "gpio4", "gpio5";
> > +					function = "swr_rx_data";
> > +				};
> > +			};
> > +
> > +			rx_swr_sleep: rx-swr-sleep {
> > +				clk {
> > +					pins = "gpio3";
> > +					function = "swr_rx_clk";
> > +				};
> > +
> > +				data {
> > +					pins = "gpio4", "gpio5";
> > +					function = "swr_rx_data";
> > +				};
> > +			};
> > +
> > +			tx_swr_active: tx-swr-active {
> > +				clk {
> > +					pins = "gpio0";
> > +					function = "swr_tx_clk";
> > +				};
> > +
> > +				data {
> > +					pins = "gpio1", "gpio2", "gpio14";
> > +					function = "swr_tx_data";
> > +				};
> > +			};
> > +
> > +			tx_swr_sleep: tx-swr-sleep {
> > +				clk {
> > +					pins = "gpio0";
> > +					function = "swr_tx_clk";
> > +				};
> > +
> > +				data {
> > +					pins = "gpio1", "gpio2", "gpio14";
> > +					function = "swr_tx_data";
> > +				};
> > +			};
> > +		};
> > +
> >  		gpu: gpu@3d00000 {
> >  			compatible = "qcom,adreno-635.0", "qcom,adreno";
> >  			reg = <0 0x03d00000 0 0x40000>,
