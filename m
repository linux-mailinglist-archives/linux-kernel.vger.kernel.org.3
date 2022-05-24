Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91245320E8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiEXCXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbiEXCXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:23:03 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D9D9CC9D;
        Mon, 23 May 2022 19:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653358982; x=1684894982;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=0de7OZdEDnotdHJVDJmUKMnd7Q0VBtn1A0ZCxSDuzPQ=;
  b=bCK74XKGe2HxcgEttobw7Us0WHqYzzAv/NopWsCV7T7ZD63ml77meuP8
   yQxojCCEh3ilnFU3p5I7uWjA+24KjZboEAkxeyujxybx2C05pOEZwu/cS
   KIFdc3rrl379m2O852yAcTv5f8J6p/o0/6beoZ6oE6WDAou9ltmXZj35J
   Q=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 23 May 2022 19:23:02 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 19:23:01 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 23 May 2022 19:23:00 -0700
Received: from [10.79.43.230] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 23 May
 2022 19:22:57 -0700
Subject: Re: [PATCH v4 2/3] dt-bindings: remoteproc: qcom: Convert SC7280 MSS
 bindings to YAML
To:     Stephen Boyd <swboyd@chromium.org>, <bjorn.andersson@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>
CC:     <ohad@wizery.com>, <agross@kernel.org>,
        <mathieu.poirier@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mka@chromium.org>
References: <1652978825-5304-1-git-send-email-quic_sibis@quicinc.com>
 <1652978825-5304-3-git-send-email-quic_sibis@quicinc.com>
 <CAE-0n50iYAUmj6GEdCuOJ1d_SgeeFWtoxqWf7qN=jZ_js4wBcQ@mail.gmail.com>
 <1289c2e4-5607-b515-88b1-f44585e62cd3@quicinc.com>
 <CAE-0n52tbS2zvOWb4+2cbL7uth0Z3AJ-O6e0WH_xtQsMyu4A7A@mail.gmail.com>
From:   Sibi Sankar <quic_sibis@quicinc.com>
Message-ID: <c3a3f28b-06a4-0039-eb7b-833debd3f95d@quicinc.com>
Date:   Tue, 24 May 2022 07:52:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n52tbS2zvOWb4+2cbL7uth0Z3AJ-O6e0WH_xtQsMyu4A7A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/21/22 1:40 AM, Stephen Boyd wrote:
> Quoting Sibi Sankar (2022-05-20 11:46:58)
>> On 5/20/22 4:05 AM, Stephen Boyd wrote:
>>> Quoting Sibi Sankar (2022-05-19 09:47:04)
>>>> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml
>>>> new file mode 100644
>>>> index 000000000000..a936d84eefa6
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml
>>>> +        resets = <&aoss_reset AOSS_CC_MSS_RESTART>,
>>>> +                 <&pdc_reset PDC_MODEM_SYNC_RESET>;
>>>> +        reset-names = "mss_restart", "pdc_reset";
>>>> +
>>>> +        qcom,halt-regs = <&tcsr_mutex 0x23000 0x25000 0x28000 0x33000>;
>>>> +        qcom,ext-regs = <&tcsr 0x10000 0x10004 &tcsr_mutex 0x26004 0x26008>;
>>>
>>> Because it's two items I'd expect:
>>>
>>>        <&tcsr 0x10000 0x10004>, <&tcsr_mutex 0x26004 0x26008>;
>>
>> I guess both the ways work since the driver uses
>> of_parse_phandle_with_fixed_args.
> 
> See commit 39bd2b6a3783 ("dt-bindings: Improve phandle-array schemas")
> for why the way you have it is not preferred.

Sure, I'll fix the dt up and update the example.

-Sibi

> 
