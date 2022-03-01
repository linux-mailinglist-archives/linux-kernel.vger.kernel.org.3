Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7BD4C8CE3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 14:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbiCANpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 08:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiCANpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:45:36 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4085C9EBBE;
        Tue,  1 Mar 2022 05:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646142296; x=1677678296;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LjBrJhVMjX29DVpiyyWhBn/Si+cXwkHRPIhgP2fekLc=;
  b=wUNJKAG3wsOB21hYnFO18WxJRf24OPybHApcOctMqQgsmK+QaieonLYi
   k62t+tLSmyr75TQx5vlhU3fWUFu/UGmSmG4/6YMnxuhT4trsoH8mwKUXe
   idmIAfFm94AN26cf9njsMjfsEX29aky8l2vdhxWUmgI/SIrWdllrt+Vri
   0=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 01 Mar 2022 05:44:56 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 05:44:55 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 1 Mar 2022 05:44:54 -0800
Received: from [10.216.30.210] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Tue, 1 Mar 2022
 05:44:48 -0800
Message-ID: <8145926a-17d7-17c6-4a4a-a92aa83e5ad0@quicinc.com>
Date:   Tue, 1 Mar 2022 19:14:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5 2/2] dt-bindings: soundwire: qcom: Add bindings for
 audio CSR reset control property
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <alsa-devel@alsa-project.org>, <bgoswami@codeaurora.org>,
        <bjorn.andersson@linaro.org>, <broonie@kernel.org>,
        <devicetree@vger.kernel.org>, <judyhsiao@chromium.org>,
        <lgirdwood@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <perex@perex.cz>,
        <pierre-louis.bossart@linux.intel.com>, <quic_plai@quicinc.com>,
        <robh+dt@kernel.org>, <rohitkr@codeaurora.org>,
        <sanyog.r.kale@intel.com>, <srinivas.kandagatla@linaro.org>,
        <tiwai@suse.com>, <yung-chuan.liao@linux.intel.com>
CC:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1646030377-12092-1-git-send-email-quic_srivasam@quicinc.com>
 <1646030377-12092-3-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n51Toe+R+GzWZ5=QGz8oQ-g2W0=AL=RvYMZviwzR8cMfwQ@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAE-0n51Toe+R+GzWZ5=QGz8oQ-g2W0=AL=RvYMZviwzR8cMfwQ@mail.gmail.com>
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


On 3/1/2022 2:33 AM, Stephen Boyd wrote:
Thanks for your time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2022-02-27 22:39:37)
>> Update description for audio CSR reset control property, which is
>> required for latest chipsets to allow software enabling in CGCR HCLK register.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/soundwire/qcom,sdw.txt | 12 ++++++++++++
> Any reason this can't be yamlified?

As such nothing is blocking to yamlify. We Shall do after all Herobrine 
audio patches upstream completed.

Will add in my To Do list and pick this activity ASAP.

>
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt b/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
>> index b93a2b3..84c8f54 100644
>> --- a/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
>> +++ b/Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
>> @@ -150,6 +150,18 @@ board specific bus parameters.
>>                      or applicable for the respective data port.
>>                      More info in MIPI Alliance SoundWire 1.0 Specifications.
>>
>> +- reset:
>> +       Usage: optional
>> +       Value type: <prop-encoded-array>
>> +       Definition: Should specify the SoundWire audio CSR reset controller interface,
>> +                   which is required for SoundWire version 1.6.0 and above.
>> +
>> +- reset-names:
>> +       Usage: optional
>> +       Value type: <stringlist>
>> +       Definition: should be "swr_audio_cgcr" for SoundWire audio CSR reset
>> +                   controller interface.
>> +
>>   Note:
>>          More Information on detail of encoding of these fields can be
>>   found in MIPI Alliance SoundWire 1.0 Specifications.
>> --
>> 2.7.4
>>
