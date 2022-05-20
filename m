Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2151B52F215
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352412AbiETSJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbiETSJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:09:02 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70A018C059;
        Fri, 20 May 2022 11:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653070139; x=1684606139;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=knFYaVRPtMVRb8qpLq9fJgECyjoHfreaopnzSRfpyUM=;
  b=yuDshxUd0lESpZVtck8DrZAy2NG/+U1xaQNGbtEAtOFJWaNTWXg2G1Ew
   4GtOKgpv/QfcAj97SGwYLLV4GKDlcsJjM9dxyJ4evRbudkYLpvOoEeX3s
   v26hRIIY311nPwixVyQPgrXNZFfgETiXz4Q2thidcX5VQ+R2z9hjBsFWg
   E=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 May 2022 11:08:59 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 11:08:59 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 20 May 2022 11:08:58 -0700
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 20 May
 2022 11:08:55 -0700
Subject: Re: [PATCH v4 1/3] arm64: dts: qcom: sc7280: Add proxy interconnect
 requirements for modem
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <ohad@wizery.com>, <agross@kernel.org>,
        <mathieu.poirier@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <mka@chromium.org>
References: <1652978825-5304-1-git-send-email-quic_sibis@quicinc.com>
 <1652978825-5304-2-git-send-email-quic_sibis@quicinc.com>
 <YoaqDcB6wkd4zOWR@ripper>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <031ebead-4b0d-8493-d8f8-96f2ff9d938a@quicinc.com>
Date:   Fri, 20 May 2022 23:38:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YoaqDcB6wkd4zOWR@ripper>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Bjorn,
Thanks for taking time to review the series.

On 5/20/22 2:05 AM, Bjorn Andersson wrote:
> On Thu 19 May 09:47 PDT 2022, Sibi Sankar wrote:
> 
>> Add interconnects that are required to be proxy voted upon during modem
>> bootup on SC7280 SoCs.
> 
> This looks reasonable, but how come the vote is only for DDR frequency?
> What about the buses between modem and ddr?

The proxy votes that are put in aren't for perf related reasons, the
modem was getting llcc timeouts while trying to read contents from 
memory. The hw team recommended the proxy votes as the fix.

-Sibi

> 
> Regards,
> Bjorn
> 
>>
>> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
>> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
>> index 9f4a9c263c35..91aad86cc708 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
>> @@ -88,6 +88,7 @@
>>   	status = "okay";
>>   	compatible = "qcom,sc7280-mss-pil";
>>   	iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
>> +	interconnects = <&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>;
>>   	memory-region = <&mba_mem>, <&mpss_mem>;
>>   };
>>   
>> -- 
>> 2.7.4
>>
