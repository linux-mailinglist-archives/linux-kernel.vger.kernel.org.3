Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5092E5471A1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 05:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350107AbiFKD0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 23:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347238AbiFKD0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 23:26:16 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A75EA0D32;
        Fri, 10 Jun 2022 20:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654917975; x=1686453975;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=HVSSV8LGOw92Phwdzd7AfIW3E8dYU6iGxh+I+4+CoQc=;
  b=xB1Tp52CkFVKJifT8LI8lxzYJdPPUPXhQm5Me0xEnfnKLrrSUTlsuXPO
   geK/AfePyyRFZhoO2joTjshrFJwR99mYE+7OBjZ7/ZkdWpgvMapciu2Cc
   oAOiwPh6J07dQ3Vd5LF6o2zM05N85fLMHlGFLrLu77Y67qh+XJ/M9m6Na
   s=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Jun 2022 20:26:14 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 20:26:14 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 10 Jun 2022 20:26:13 -0700
Received: from [10.216.8.205] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 10 Jun
 2022 20:26:06 -0700
Message-ID: <ae46345f-cb39-bfc2-16d9-70b5729eee6c@quicinc.com>
Date:   Sat, 11 Jun 2022 08:56:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 1/2] dt-bindings: pinctrl: qcom: sc7280: Add boolean
 param for ADSP bypass platforms
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>, <agross@kernel.org>,
        <alsa-devel@alsa-project.org>, <bgoswami@quicinc.com>,
        <bjorn.andersson@linaro.org>, <broonie@kernel.org>,
        <devicetree@vger.kernel.org>, <judyhsiao@chromium.org>,
        <lgirdwood@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <perex@perex.cz>, <quic_plai@quicinc.com>,
        <quic_rohkumar@quicinc.com>, <robh+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <tiwai@suse.com>
References: <1654872335-4993-1-git-send-email-quic_srivasam@quicinc.com>
 <1654872335-4993-2-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n53NdTwAO4DY0x7Fy9h4eRVR-3iKnGfqfZ-ggyghfsC9UA@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAE-0n53NdTwAO4DY0x7Fy9h4eRVR-3iKnGfqfZ-ggyghfsC9UA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/11/2022 1:34 AM, Stephen Boyd wrote:
Thanks for Your time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2022-06-10 07:45:34)
>> Add boolean param qcom,adsp-bypass-mode to support adsp bypassed sc7280
>> platforms. Which is required to make clock voting as optional for ADSP
>> bypass platforms.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> ---
>>   .../bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml          | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
>> index d32ee32..ea9920c 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
>> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml
>> @@ -17,7 +17,14 @@ description: |
>>
>>   properties:
>>     compatible:
>> -    const: qcom,sc7280-lpass-lpi-pinctrl
>> +    enum:
>> +      - qcom,sc7280-lpass-lpi-pinctrl
> Drop this part.
Okay. Will revert this change.
>
>> +
>> +  qcom,adsp-bypass-mode:
>> +    description:
>> +      Tells pin controllers want to make clocks optional for ADSP bypass
>> +      targets.
> How about "ADSP is in bypass mode"?

You mean, description like below?

qcom,adsp-bypass-mode:
     description:
	ADSP is in bypass mode.

