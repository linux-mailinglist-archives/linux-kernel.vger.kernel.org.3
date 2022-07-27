Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B228581FA2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 07:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiG0FvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 01:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiG0FvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 01:51:17 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77437E09F;
        Tue, 26 Jul 2022 22:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658901075; x=1690437075;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VEjkzbDXO/nzCBnskeBQ348RYw6djOjzDmFL3vRyQ/g=;
  b=j7uRRWF0CAKlANmW837i1FptpBZX00h30azdaIzrFSKlK1huM5Zkmr3N
   RF96dVd3FlSdK2yQJ5d82qEgzNPJ9pZdBp3FmcGgpaCE4EF81ZWhlRTGg
   xEKYc4vyWbjy5b1/47Y+O/ADtGnbOwNINfLMpWKVeAvRjyormxDfqIrnU
   c=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Jul 2022 22:51:15 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 22:51:15 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Jul 2022 22:51:14 -0700
Received: from [10.50.42.78] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 26 Jul
 2022 22:51:11 -0700
Message-ID: <e28ef7e2-c23a-f87b-09b2-958f2212c30e@quicinc.com>
Date:   Wed, 27 Jul 2022 11:21:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH V3 2/2] arm64: dts: qcom: sc7280: Update lpassaudio clock
 controller for resets
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_tdas@quicinc.com>
References: <1658316144-16520-1-git-send-email-quic_c_skakit@quicinc.com>
 <1658316144-16520-3-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n53wdhH2P729KDDbghScCcU=4-sFmxVugyJgxmGeFs4mgw@mail.gmail.com>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
In-Reply-To: <CAE-0n53wdhH2P729KDDbghScCcU=4-sFmxVugyJgxmGeFs4mgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/27/2022 6:52 AM, Stephen Boyd wrote:
> Quoting Satya Priya (2022-07-20 04:22:24)
>> From: Taniya Das <quic_tdas@quicinc.com>
>>
>> The lpass audio supports TX/RX/WSA block resets. Also to keep
>> consistency update lpasscore to lpass_core.
> Consistency with what?


Hi Stephen,


We got a comment to change this on previous posts, to keep consistency 
with the other nodes like lpass_aon etc


https://patchwork.kernel.org/project/linux-arm-msm/patch/20220503113246.13857-1-quic_tdas@quicinc.com/#24842497

>> Fixes: 9499240d15f2 ("arm64: dts: qcom: sc7280: Add lpasscore & lpassaudio clock controllers")
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
>> ---
>> Changes since v3:
>>   - Remove the status="disabled" from lpasscc node.
>>
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index 71735bb..c641f0b 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -2184,6 +2184,7 @@
>>                          power-domains = <&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
>>                          #clock-cells = <1>;
>>                          #power-domain-cells = <1>;
>> +                       #reset-cells = <1>;
> Is there a binding update for qcom,sc7280-lpassaudiocc?
>
>>                  };
>>
>>                  lpass_aon: clock-controller@3380000 {
>> @@ -2191,13 +2192,13 @@
>>                          reg = <0 0x03380000 0 0x30000>;
>>                          clocks = <&rpmhcc RPMH_CXO_CLK>,
>>                                 <&rpmhcc RPMH_CXO_CLK_A>,
>> -                              <&lpasscore LPASS_CORE_CC_CORE_CLK>;
>> +                              <&lpass_core LPASS_CORE_CC_CORE_CLK>;
> Is this really necessary?
>
>>                          clock-names = "bi_tcxo", "bi_tcxo_ao", "iface";
>>                          #clock-cells = <1>;
>>                          #power-domain-cells = <1>;
>>                  };
>>
>> -               lpasscore: clock-controller@3900000 {
>> +               lpass_core: clock-controller@3900000 {
> Is this really necessary?
>
>>                          compatible = "qcom,sc7280-lpasscorecc";
>>                          reg = <0 0x03900000 0 0x50000>;
>>                          clocks = <&rpmhcc RPMH_CXO_CLK>;
