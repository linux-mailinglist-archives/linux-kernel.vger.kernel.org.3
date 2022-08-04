Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AA8589A55
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 12:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbiHDKPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 06:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiHDKPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 06:15:07 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FDF37F8C;
        Thu,  4 Aug 2022 03:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659608105; x=1691144105;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XCvsOpbFvXVB0iV70v8x3JyHx/fBHTkYQUv4zcAVYmw=;
  b=KbSXlB9uN0qyL3eRgQ+gC1QDWbH3mAlarB78V43heP/Oqlj4evLCm0xw
   jrYv/v91+dkwB4UlcvOvcPmz2DRxlZQCArglp2cGu0SzIeTKyNyc2SA93
   /yMtbqsTDGFvJqMzOvS4uOr6yiz/keZY59kIo3qH63ezigU2iRMD6ffeB
   k=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 04 Aug 2022 03:15:05 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 03:15:05 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 4 Aug 2022 03:15:04 -0700
Received: from [10.216.12.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 4 Aug 2022
 03:14:58 -0700
Message-ID: <5507af1a-3548-8e08-be3f-42f59bcc2096@quicinc.com>
Date:   Thu, 4 Aug 2022 15:44:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/8] dt-bindings: remoteproc: qcom: adsp: Add compatible
 name for SC7280
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <quic_plai@quicinc.com>,
        <bgoswami@quicinc.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <srinivas.kandagatla@linaro.org>, <quic_rohkumar@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <devicetree@vger.kernel.org>
References: <1659536480-5176-1-git-send-email-quic_srivasam@quicinc.com>
 <1659536480-5176-3-git-send-email-quic_srivasam@quicinc.com>
 <20220803204359.GA2586715-robh@kernel.org>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <20220803204359.GA2586715-robh@kernel.org>
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


On 8/4/2022 2:13 AM, Rob Herring wrote:
Thanks for your time and valuable inputs Rob!!!
> On Wed, Aug 03, 2022 at 07:51:14PM +0530, Srinivasa Rao Mandadapu wrote:
>> Add compatible name and update max reg items for SC7280 base platforms.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> ---
>>   .../devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml          | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml
>> index 9f11332..147996f 100644
>> --- a/Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml
>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,lpass-adsp-pil.yaml
>> @@ -17,11 +17,12 @@ properties:
>>     compatible:
>>       enum:
>>         - qcom,sdm845-adsp-pil
>> +      - qcom,sc7280-adsp-pil
>>   
>>     reg:
>> -    maxItems: 1
>> +    maxItems: 2
> sdm845 has 2 entries too?
No. There max items not changed.
>
>>       description:
>> -      The base address and size of the qdsp6ss register
>> +      The base address and size of the qdsp6ss register and mcc register
> Better expressed as:
>
> minItems: 1
> items:
>    - description: qdsp6ss register
>    - description: mcc register
>
> Though the descriptions could expand on what those registers are.
>
> Rob
Okay. Will change accordingly and re spin the patches.
