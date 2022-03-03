Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7574CB48F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 02:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiCCB5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 20:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiCCB5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 20:57:03 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BCE33E13;
        Wed,  2 Mar 2022 17:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646272578; x=1677808578;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3bzSRY1al0oYlmM52NOwKtS+br8ieRk+tPabImmuEUM=;
  b=IUllmM4Q7zHnq/KDRBRxxnlRhUBz/KKesZNU8NjsBLJbto3qbJBAAwcw
   rF7cFm/fhx8XDHFyCkNr3azs4EYeImGZYGbHohHo8BHhJ21XNKj9X4UH/
   0XO/ZeF5b+IwgU8tcQ/d0I7625cCr30l4+zfAm5KIC9Cgc2YHlnkVAkZ5
   w=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 02 Mar 2022 17:56:18 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 17:56:17 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 2 Mar 2022 17:56:16 -0800
Received: from [10.216.42.174] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Wed, 2 Mar 2022
 17:56:09 -0800
Message-ID: <7e9fceed-6b29-d6a6-2035-fdf3fc70a773@quicinc.com>
Date:   Thu, 3 Mar 2022 07:26:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v6 3/3] dt-bindings: soundwire: qcom: Add bindings for
 audio CSR reset control property
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@codeaurora.org>,
        <perex@perex.cz>, <tiwai@suse.com>,
        <srinivas.kandagatla@linaro.org>, <rohitkr@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1646224982-3361-1-git-send-email-quic_srivasam@quicinc.com>
 <1646224982-3361-4-git-send-email-quic_srivasam@quicinc.com>
 <Yh+RwQS1Cyeuq4Jf@matsya>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <Yh+RwQS1Cyeuq4Jf@matsya>
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


On 3/2/2022 9:18 PM, Vinod Koul wrote:
Thanks for your time Vinod!!!
> On 02-03-22, 18:13, Srinivasa Rao Mandadapu wrote:
>> Update description for audio CSR reset control property, which is
>> required for latest chipsets to allow software enabling in CGCR HCLK register.
> too many acronyms pls explain!
Okay. Will expand and re post the patch.
>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/soundwire/qcom,sdw.txt | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt b/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
>> index b93a2b3..84c8f54 100644
>> --- a/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
>> +++ b/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
>> @@ -150,6 +150,18 @@ board specific bus parameters.
>>   		    or applicable for the respective data port.
>>   		    More info in MIPI Alliance SoundWire 1.0 Specifications.
>>   
>> +- reset:
>> +	Usage: optional
>> +	Value type: <prop-encoded-array>
>> +	Definition: Should specify the SoundWire audio CSR reset controller interface,
>> +		    which is required for SoundWire version 1.6.0 and above.
>> +
>> +- reset-names:
>> +	Usage: optional
>> +	Value type: <stringlist>
>> +	Definition: should be "swr_audio_cgcr" for SoundWire audio CSR reset
>> +		    controller interface.
>> +
> We should add these in example as well...
Okay. Will add in Example.
>
>>   Note:
>>   	More Information on detail of encoding of these fields can be
>>   found in MIPI Alliance SoundWire 1.0 Specifications.
>> -- 
>> 2.7.4
