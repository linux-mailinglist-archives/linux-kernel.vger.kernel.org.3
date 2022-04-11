Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE3E4FBD43
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346570AbiDKNiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbiDKNiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:38:24 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4A81D32C;
        Mon, 11 Apr 2022 06:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649684170; x=1681220170;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vf9KvKCIrwXoSxZz+cBXcuhdAg4uSjtRtBgWIQcM4RM=;
  b=TPEX5Hd7IzMOZS9jHyJRDlLzd48qgpHw95fnt2bw+zOuYxB87AhVdw+M
   UHdK+rNcbsf7bmbffppYRbFgeaMWeqrPLg7tLHMlhPx0pBXWQi8t5+Ku2
   7YTqrEvsc1KEE87cAEi1w/IyEjcy0Bq4xAoznvgFNU1NxV0SDp/oh7rWo
   s=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 11 Apr 2022 06:36:09 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 06:36:08 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 11 Apr 2022 06:36:08 -0700
Received: from [10.216.15.65] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 11 Apr
 2022 06:36:04 -0700
Message-ID: <c3a6c56b-0206-27ea-e972-9ce1c17d2ca6@quicinc.com>
Date:   Mon, 11 Apr 2022 19:06:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v6 2/2] arm64: dts: qcom: sc7280: add lpass lpi pin
 controller node
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohitkr@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1649157167-29106-1-git-send-email-quic_srivasam@quicinc.com>
 <1649157167-29106-3-git-send-email-quic_srivasam@quicinc.com>
 <Ykx47AlGYa8s5FTa@google.com> <Ykz32cMNG8PhN2c+@google.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <Ykz32cMNG8PhN2c+@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/6/2022 7:45 AM, Matthias Kaehlcke wrote:
Thanks Matthias for your time and Valuable inputs!!!
> On Tue, Apr 05, 2022 at 10:14:20AM -0700, Matthias Kaehlcke wrote:
>> On Tue, Apr 05, 2022 at 04:42:47PM +0530, Srinivasa Rao Mandadapu wrote:
>>> Add LPASS LPI pinctrl node required for Audio functionality on sc7280
>>> based platforms.
>>>
>>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi |  98 ++++++++++++++++++++++++++++
>>>   arch/arm64/boot/dts/qcom/sc7280.dtsi     | 107 +++++++++++++++++++++++++++++++
>>>   2 files changed, 205 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>>> index 2afbbe3..f912a89 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>>> @@ -238,6 +238,104 @@
>>>   	modem-init;
>>>   };
>>>   
>>> +&lpass_tlmm {
>>> +	dmic01_active: dmic01-active {
>>> +		clk {
>>> +			drive-strength = <8>;
>>> +		};
>>> +
>>> +		data {
>>> +			drive-strength = <8>;
>> The DMIC data pins are input pins, right? Why does an input pin need a drive
>> strength? Same for other input pins.
Okay. Will remove this.
>>
>>> +		};
>>> +	};
>> There's no need to reference 'lpass_tlmm' nor to repeat $label: $node.
>> Instead just use phandles:
Okay. Will change accordingly.
>>
>> &dmic01_active {
>> 	clk {
>> 		drive-strength = <8>;
>> 	};
>>
>> 	data {
>> 		drive-strength = <8>;
>> 	};
>> };
>>
>> Rather than replicating the node hierarchy you could also just give each pin a
>> label, and then:
>>
>> &dmic01_clk_active {
>> 	drive-strength = <8>;
>> };
>>
>> &dmic01_data_active {
>> 	drive-strength = <8>;
>> };
>>
>> I don't have a strong preference, but wonder if the grouping adds any value.
> One more thing: please also drop the '_active' suffix, it is not needed. With
> that I think it's clearer to get rid of the grouping.
For now will continue as it's.  Anyway we are removing dmic01_data_active.
>
>>> +
>>> +	dmic01_sleep: dmic01-sleep {
>>> +		clk {
>>> +			drive-strength = <2>;
>>> +			bias-disable;
>>> +		};
>>> +
>>> +		data {
>>> +			drive-strength = <2>;
>>> +			pull-down;
>>> +		};
>>> +	};
>>> +
>>> +	dmic23_active: dmic02-active {
>>> +		clk {
>>> +			drive-strength = <8>;
>>> +		};
>>> +
>>> +		data {
>>> +			drive-strength = <8>;
>>> +		};
>>> +	};
>>> +
>>> +	dmic23_sleep: dmic02-sleep {
>>> +		clk {
>>> +			drive-strength = <2>;
>>> +			bias-disable;
>>> +		};
>>> +
>>> +		data {
>>> +			drive-strength = <2>;
>>> +			pull-down;
>>> +		};
>>> +	};
>>> +
>>> +	rx_swr_active: rx-swr-active {
>>> +		clk {
>>> +			drive-strength = <2>;
>>> +			slew-rate = <1>;
>>> +			bias-disable;
>>> +		};
>>> +
>>> +		data {
>>> +			drive-strength = <2>;
>>> +			slew-rate = <1>;
>>> +			bias-bus-hold;
>>> +		};
>>> +	};
>>> +
>>> +	rx_swr_sleep: rx-swr-sleep {
>>> +		clk {
>>> +			drive-strength = <2>;
>>> +			bias-pull-down;
>>> +		};
>>> +
>>> +		data {
>>> +			drive-strength = <2>;
>>> +			bias-pull-down;
>>> +		};
>>> +	};
>>> +
>>> +	tx_swr_active: tx-swr-active {
>>> +		clk {
>>> +			drive-strength = <2>;
>>> +			slew-rate = <1>;
>>> +			bias-disable;
>>> +		};
>>> +
>>> +		data {
>>> +			drive-strength = <2>;
>>> +			slew-rate = <1>;
>>> +			bias-bus-hold;
>>> +		};
>>> +	};
>>> +
>>> +	tx_swr_sleep: tx-swr-sleep {
>>> +		clk {
>>> +			drive-strength = <2>;
>>> +			bias-pull-down;
>>> +		};
>>> +
>>> +		data {
>>> +			drive-strength = <2>;
>>> +			bias-bus-hold;
>>> +		};
>>> +	};
>>> +};
>>> +
>>>   &pcie1 {
>>>   	status = "okay";
>>>   	perst-gpio = <&tlmm 2 GPIO_ACTIVE_LOW>;
>>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>>> index 8d8cec5..db74fc3 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>>> @@ -1987,6 +1987,113 @@
>>>   			qcom,bcm-voters = <&apps_bcm_voter>;
>>>   		};
>>>   
>>> +		lpass_tlmm: pinctrl@33c0000 {
>>> +			compatible = "qcom,sc7280-lpass-lpi-pinctrl";
>>> +			reg = <0 0x33c0000 0x0 0x20000>,
>>> +				<0 0x3550000 0x0 0x10000>;
>> Pad addresses to 8 digits.
Okay.
>>
>>> +			gpio-controller;
>>> +			#gpio-cells = <2>;
>>> +			gpio-ranges = <&lpass_tlmm 0 0 15>;
>>> +
>>> +			#clock-cells = <1>;
>>> +
>>> +			dmic01_active: dmic01-active {
>>> +				clk {
>>> +					pins = "gpio6";
>>> +					function = "dmic1_clk";
>>> +				};
>>> +
>>> +				data {
>>> +					pins = "gpio7";
>>> +					function = "dmic1_data";
>>> +				};
>>> +			};
>>> +
>>> +			dmic01_sleep: dmic01-sleep {
>>> +				clk {
>>> +					pins = "gpio6";
>>> +					function = "dmic1_clk";
>>> +				};
>>> +
>>> +				data {
>>> +					pins = "gpio7";
>>> +					function = "dmic1_data";
>>> +				};
>>> +			};
>>> +
>>> +			dmic23_active: dmic02-active {
>> is it intentional that the node name is 'dmic02*', but the label 'dmic23*'?
typo error. will fix it.
>>
>>> +				clk {
>>> +					pins = "gpio8";
>>> +					function = "dmic2_clk";
>>> +				};
>>> +
>>> +				data {
>>> +					pins = "gpio9";
>>> +					function = "dmic2_data";
>>> +				};
>>> +			};
>>> +
>>> +			dmic23_sleep: dmic02-sleep {
>> ditto
Okay.
>>
>>> +				clk {
>>> +					pins = "gpio8";
>>> +					function = "dmic2_clk";
>>> +				};
>>> +
>>> +				data {
>>> +					pins = "gpio9";
>>> +					function = "dmic2_data";
>>> +				};
>>> +			};
>>> +
>>> +			rx_swr_active: rx-swr-active {
>>> +				clk {
>>> +					pins = "gpio3";
>>> +					function = "swr_rx_clk";
>>> +				};
>>> +
>>> +				data {
>>> +					pins = "gpio4", "gpio5";
>>> +					function = "swr_rx_data";
>>> +				};
>>> +			};
>>> +
>>> +			rx_swr_sleep: rx-swr-sleep {
>>> +				clk {
>>> +					pins = "gpio3";
>>> +					function = "swr_rx_clk";
>>> +				};
>>> +
>>> +				data {
>>> +					pins = "gpio4", "gpio5";
>>> +					function = "swr_rx_data";
>>> +				};
>>> +			};
>>> +
>>> +			tx_swr_active: tx-swr-active {
>>> +				clk {
>>> +					pins = "gpio0";
>>> +					function = "swr_tx_clk";
>>> +				};
>>> +
>>> +				data {
>>> +					pins = "gpio1", "gpio2", "gpio14";
>>> +					function = "swr_tx_data";
>>> +				};
>>> +			};
>>> +
>>> +			tx_swr_sleep: tx-swr-sleep {
>>> +				clk {
>>> +					pins = "gpio0";
>>> +					function = "swr_tx_clk";
>>> +				};
>>> +
>>> +				data {
>>> +					pins = "gpio1", "gpio2", "gpio14";
>>> +					function = "swr_tx_data";
>>> +				};
>>> +			};
>>> +		};
>>> +
>>>   		gpu: gpu@3d00000 {
>>>   			compatible = "qcom,adreno-635.0", "qcom,adreno";
>>>   			reg = <0 0x03d00000 0 0x40000>,
