Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A1050D8BC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 07:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241212AbiDYFUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 01:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237644AbiDYFUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 01:20:35 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C412DD9;
        Sun, 24 Apr 2022 22:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650863847; x=1682399847;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qAAiyq//qlwD5o1Z65odfkrvAYtitgtFY9JA6EBbbfw=;
  b=ErYFwXzDZTCmxoonqlf7hsUEW/UPyr7FwrloY73xuJnMQksrweF+VgCA
   hcgxDiNXmOkbQTBC9UPVURaQIGdTZbXeCc4/shhcwy6bNE2BzPtrrg0oI
   blwg3wvvz56b9W+q6n2jswqqZOK8fsTEvM77veRSAfvmCgiHnOSIYp7gN
   Y=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Apr 2022 22:17:26 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 22:17:25 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 24 Apr 2022 22:17:25 -0700
Received: from [10.216.15.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 24 Apr
 2022 22:17:21 -0700
Message-ID: <d678588b-e38e-c9f8-c7e6-1786f8398ffc@quicinc.com>
Date:   Mon, 25 Apr 2022 10:47:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Add ldo_l17b regulator node
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <agross@kernel.org>, <robh+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rohkumar@quicinc.com>,
        <srinivas.kandagatla@linaro.org>, <dianders@chromium.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <quic_rjendra@quicinc.com>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1650550779-8133-1-git-send-email-quic_srivasam@quicinc.com>
 <YmQiIJatomyUVahR@builder.lan>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <YmQiIJatomyUVahR@builder.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/23/2022 9:28 PM, Bjorn Andersson wrote:
Thanks for your time Bjorn!!
> On Thu 21 Apr 09:19 CDT 2022, Srinivasa Rao Mandadapu wrote:
>
>> Add ldo_l17b in pm7325 regulator, which is required for
>> wcd codec vdd buck supply.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
>> index b833ba1..17d0c05 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
>> @@ -113,6 +113,11 @@
>>   			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
>>   		};
>>   
>> +		vreg_l17b_1p8: ldo17 {
>> +			regulator-min-microvolt = <1700000>;
>> +			regulator-max-microvolt = <1900000>;
> Can you confirm that this doesn't need to be in HPM mode?
HPM mode included and sent V2 patch.
>
> Thanks,
> Bjorn
>
>> +		};
>> +
>>   		vdd_px_wcd9385:
>>   		vdd_txrx:
>>   		vddpx_0:
>> -- 
>> 2.7.4
>>
