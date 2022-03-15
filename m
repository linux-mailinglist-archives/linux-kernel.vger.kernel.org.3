Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351C54D9FB9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 17:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349944AbiCOQQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 12:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240489AbiCOQQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 12:16:46 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F27449921;
        Tue, 15 Mar 2022 09:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647360934; x=1678896934;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GV0TCfK4F7z4NNGahHA1Aii1fPduEtBUYoCf8fA5z8M=;
  b=xvcpf/v/v8MHF5vJHbrzXq/Hq4PTzSBaN7b9+JytjQuCInXc2f61AaPF
   pmBhyi/q0vH2jkeRVF9MCC6oGc71RkQoofrNMkbh/OsSUJ0FzvH3UlN61
   43SQalJfwLXEffyHXYUqNarpek3QCWHSxn84ubDuqkb0deIBhUHf8yMXL
   A=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 15 Mar 2022 09:15:34 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 09:15:33 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Mar 2022 09:15:33 -0700
Received: from [10.216.59.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 15 Mar
 2022 09:15:29 -0700
Message-ID: <0f75ebf7-b893-a1a0-1581-6ec29e0be8c6@quicinc.com>
Date:   Tue, 15 Mar 2022 21:45:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sc7280: Add lpass cpu node
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <devicetree@vger.kernel.org>,
        <dianders@chromium.org>, <judyhsiao@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <rohitkr@codeaurora.org>,
        <srinivas.kandagatla@linaro.org>
CC:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1643887981-31011-1-git-send-email-quic_srivasam@quicinc.com>
 <1643887981-31011-3-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n53X-+gaspxgdVtnr8FW6S5VhXPJaAxLd+vikCnYf9aF6w@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAE-0n53X-+gaspxgdVtnr8FW6S5VhXPJaAxLd+vikCnYf9aF6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/1/2022 3:01 AM, Stephen Boyd wrote:
Thanks for your time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2022-02-03 03:33:00)
>> Add lpass cpu node for audio on sc7280 based platforms.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 28 +++++++++++++++
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi     | 59 ++++++++++++++++++++++++++++++++
>>   2 files changed, 87 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> index 2806888..a76b2d1 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> @@ -691,3 +691,31 @@
>>   &vamacro {
>>          vdd-micb-supply = <&vreg_bob>;
>>   };
>> +
>> +&lpass_cpu {
>> +       status = "okay";
>> +
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&sec_mi2s_active>;
> Is it a reset gpio? If so, make it a reset-gpios property. I couldn't
> find the definition.

It's not reset gpio. it's for I2S clk, data and ws. It is there in 
previous patch set, which is not applied yet.

We did splitting this node as per functionality. will change here 
accordingly.

>
>> +
>> +       mi2s-secondary@1 {
>> +               reg = <MI2S_SECONDARY>;
>> +               qcom,playback-sd-lines = <0>;
>> +       };
>> +
>> +       hdmi-primary@5 {
>> +               reg = <LPASS_DP_RX>;
>> +       };
>> +
>> +       wcd-rx@6 {
>> +               reg = <LPASS_CDC_DMA_RX0>;
>> +       };
>> +
>> +       wcd-tx@19 {
>> +               reg = <LPASS_CDC_DMA_TX3>;
>> +       };
>> +
>> +       va-tx@25 {
>> +               reg = <LPASS_CDC_DMA_VA_TX0>;
>> +       };
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index 946eb01..c2da5ce 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -17,6 +17,7 @@
>>   #include <dt-bindings/reset/qcom,sdm845-aoss.h>
>>   #include <dt-bindings/reset/qcom,sdm845-pdc.h>
>>   #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>> +#include <dt-bindings/sound/qcom,lpass.h>
>>   #include <dt-bindings/thermal/thermal.h>
>>
>>   / {
>> @@ -1847,6 +1848,64 @@
>>                          #size-cells = <0>;
>>                  };
>>
>> +               lpass_cpu: audio-subsystem@3260000 {
>> +                       compatible = "qcom,sc7280-lpass-cpu";
>> +                       reg = <0 0x3260000 0 0xC000>,
>> +                             <0 0x3280000 0 0x29000>,
>> +                             <0 0x3340000 0 0x29000>,
>> +                             <0 0x336C000 0 0x3000>,
>> +                             <0 0x3987000 0 0x68000>,
>> +                             <0 0x3B00000 0 0x29000>;
> Lowercase hex. Pad out reg to 8 digits.
Okay.
>
>> +                       reg-names = "lpass-rxtx-cdc-dma-lpm",
>> +                                   "lpass-rxtx-lpaif",
>> +                                   "lpass-va-lpaif",
>> +                                   "lpass-va-cdc-dma-lpm",
>> +                                   "lpass-hdmiif",
>> +                                   "lpass-lpaif";
> That 'lpass' prefix looks very redundant.
Okay. Currently driver and documentation has mentioned similarly. Will 
take care from next time.
>
>> +
>> +                       iommus = <&apps_smmu 0x1820 0>,
>> +                                <&apps_smmu 0x1821 0>,
>> +                                <&apps_smmu 0x1832 0>;
