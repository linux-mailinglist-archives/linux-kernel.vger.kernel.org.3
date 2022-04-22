Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704A150B8FD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448165AbiDVNtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448028AbiDVNtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:49:50 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8382758E7D;
        Fri, 22 Apr 2022 06:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650635217; x=1682171217;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JEyD9nCRvwcRvJNC9ZuBb/MYlx4VMmcNp3H4Wj24ako=;
  b=OJW2thpAmVxYsC4JpJz8B0NVBAj3JtigvaPZuOBXnekmLvZv+yywb+BA
   RsLshvVHHnLp1FLgLXjkresOmbEh5ojBiG3jYs/tkn9iWJMbzmrX1E1QO
   pTge/PW46Ouo/Mdc4QqJ+3XsvygIBjOOBu9KupcCU7FMYTsfDC86al6hm
   U=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Apr 2022 06:46:56 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 06:46:56 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 22 Apr 2022 06:46:55 -0700
Received: from [10.216.36.2] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 22 Apr
 2022 06:46:50 -0700
Message-ID: <098cf844-c38b-3bbc-9e18-df6124d2c8d4@quicinc.com>
Date:   Fri, 22 Apr 2022 19:16:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v9 05/12] arm64: dts: qcom: sc7280: Add wcd9385 codec node
 for CRD 3.0/3.1
Content-Language: en-US
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_rohkumar@quicinc.com>, <srinivas.kandagatla@linaro.org>,
        <dianders@chromium.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1650552459-21077-1-git-send-email-quic_srivasam@quicinc.com>
 <1650552459-21077-6-git-send-email-quic_srivasam@quicinc.com>
 <YmGM35IjoEhNSdRD@google.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <YmGM35IjoEhNSdRD@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/21/2022 10:27 PM, Matthias Kaehlcke wrote:
Thanks for your time Matthias!!!
> On Thu, Apr 21, 2022 at 08:17:32PM +0530, Srinivasa Rao Mandadapu wrote:
>> Add wcd9385 codec node for audio use case on CRD rev5 (aka CRD 3.0/3.1)
> nit: rev5+
Okay.
>> boards. Add tlmm gpio property for switching CTIA/OMTP Headset.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts | 52 +++++++++++++++++++++++
>>   1 file changed, 52 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
>> index d0794f2..d6a3086 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
>> @@ -12,6 +12,36 @@
>>   / {
>>   	model = "Qualcomm Technologies, Inc. sc7280 CRD platform (rev5+)";
>>   	compatible = "google,hoglin", "qcom,sc7280";
>> +
>> +	wcd938x: audio-codec-1 {
> wcd9385 (same for the CRD <= 2.0, I missed it there).
Okay.
>
>> +		compatible = "qcom,wcd9385-codec";
>
>
>> +		pinctrl-names = "default", "sleep", "us_euro_hs_sel";
>> +		pinctrl-0 = <&wcd_reset_n>;
>> +		pinctrl-1 = <&wcd_reset_n_sleep>;
>> +		pinctrl-2 = <&us_euro_hs_sel>;
> This looks wrong, see my comment on the CRD <= 2.0 patch
> (https://patchwork.kernel.org/project/linux-arm-msm/patch/1650552459-21077-5-git-send-email-quic_srivasam@quicinc.com/)
Okay. Will modify accordingly.
>
>> +
>> +		reset-gpios = <&tlmm 83 GPIO_ACTIVE_HIGH>;
>> +		us-euro-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
>> +
>> +		qcom,rx-device = <&wcd_rx>;
>> +		qcom,tx-device = <&wcd_tx>;
>> +
>> +		vdd-rxtx-supply = <&vreg_l18b_1p8>;
>> +		vdd-io-supply = <&vreg_l18b_1p8>;
>> +		vdd-buck-supply = <&vreg_l17b_1p8>;
>> +		vdd-mic-bias-supply = <&vreg_bob>;
>> +
>> +		qcom,micbias1-microvolt = <1800000>;
>> +		qcom,micbias2-microvolt = <1800000>;
>> +		qcom,micbias3-microvolt = <1800000>;
>> +		qcom,micbias4-microvolt = <1800000>;
>> +
>> +		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000
>> +							  500000 500000 500000>;
>> +		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
>> +		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
>> +		#sound-dai-cells = <1>;
>> +	};
> The wcd9385 is on the qcard, so I think this node should be added to
> sc7280-qcard.dtsi and be marked as "disabled". This file can then just
> set the status to "okay". Future boards that use the wcd could do the
> same, rather than adding a copy of this node to their .dts file.
Okay. Will move to qcard dtsi file.
>
>>   };
>>   
>>   /* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
>> @@ -345,4 +375,26 @@ ap_ts_pen_1v8: &i2c13 {
>>   			  "",
>>   			  "",
>>   			  "";
>> +
>> +	us_euro_hs_sel: us-euro-hs-sel {
>> +		pins = "gpio81";
>> +		function = "gpio";
>> +		bias-pull-down;
>> +		drive-strength = <2>;
>> +	};
>> +
>> +	wcd_reset_n: wcd-reset-n {
>> +		pins = "gpio83";
>> +		function = "gpio";
>> +		drive-strength = <8>;
>> +		output-high;
>> +	};
>> +
>> +	wcd_reset_n_sleep: wcd-reset-n-sleep {
>> +		pins = "gpio83";
>> +		function = "gpio";
>> +		drive-strength = <8>;
>> +		bias-disable;
>> +		output-low;
>> +	};
> These are also on the qcard, please move the nodes to sc7280-qcard.dtsi
Okay.
