Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4FB5067DC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 11:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350399AbiDSJmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 05:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239650AbiDSJmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 05:42:14 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8411F639;
        Tue, 19 Apr 2022 02:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650361172; x=1681897172;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wVJ9UhjrH0Z/VNjIO0QK3Ri+9clE9QiJj3Vxp/R+xgg=;
  b=Mqv6cJsRPjHxIPjFGkcvLdgJFeJDeqnMKtdYhXf8KGIPG7w8H0cAUKOI
   IxegYVFJnjiJfFxH2pZ3O4gEqhlSuTL8xhfVDWi1fKpcLaiIPbjGSmXIX
   5fJ/CbbcqrN/AGADupCW8xzTmpJMtvRrCXmVPgLYbrcPnPmONAyhtuC/L
   o=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 19 Apr 2022 02:39:32 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 02:39:21 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 19 Apr 2022 02:39:19 -0700
Received: from [10.216.20.240] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 19 Apr
 2022 02:39:13 -0700
Message-ID: <de6581e4-f894-6833-bb39-f5830013f7b6@quicinc.com>
Date:   Tue, 19 Apr 2022 15:09:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] ASoC: qcom: SC7280: Update machine driver startup,
 shutdown callbacks
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <quic_rohkumar@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>
CC:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1650352619-17370-1-git-send-email-quic_srivasam@quicinc.com>
 <102ad140-dc26-d266-a716-4e22003ec601@linaro.org>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <102ad140-dc26-d266-a716-4e22003ec601@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/19/2022 2:49 PM, Srinivas Kandagatla wrote:
Thanks for your time Srini!!
>
>
> On 19/04/2022 08:16, Srinivasa Rao Mandadapu wrote:
>> Update machine driver startup, shutdown callback functions to support
>> codec DMA paths. Without this change, platforms with WCD codec is 
>> failing
>> to register sound card.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   sound/soc/qcom/sc7280.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/sound/soc/qcom/sc7280.c b/sound/soc/qcom/sc7280.c
>> index 4ef4034..d64df11 100644
>> --- a/sound/soc/qcom/sc7280.c
>> +++ b/sound/soc/qcom/sc7280.c
>> @@ -295,6 +295,10 @@ static void sc7280_snd_shutdown(struct 
>> snd_pcm_substream *substream)
>>           break;
>>       case LPASS_DP_RX:
>>           break;
>> +    case LPASS_CDC_DMA_RX0 ... LPASS_CDC_DMA_RX9:
>> +    case LPASS_CDC_DMA_TX0 ... LPASS_CDC_DMA_TX8:
>> +    case LPASS_CDC_DMA_VA_TX0 ... LPASS_CDC_DMA_VA_TX8:
>> +        break;
>>       default:
>>           dev_err(rtd->dev, "%s: invalid dai id 0x%x\n", __func__,
>>               cpu_dai->id);
>
> Why not just make sc7280_snd_startup code like this:
>
> static int sc7280_snd_startup(struct snd_pcm_substream *substream)
> {
>     struct snd_soc_pcm_runtime *rtd = substream->private_data;
>     struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
>     int ret = 0;
>
>     switch (cpu_dai->id) {
>     case MI2S_PRIMARY:
>         ret = sc7280_rt5682_init(rtd);
>         break;
>     default:
>         break;
>     }
>     return ret;
> }
>
> and sc7280_snd_shutdown with something similar

Yes. we can do as you suggested. Then Shall I do it as fix to a commit?

i.e. c5198db ASoC: qcom: Add driver support for ALC5682I-VS

>
> --srini
>> @@ -316,6 +320,10 @@ static int sc7280_snd_startup(struct 
>> snd_pcm_substream *substream)
>>           break;
>>       case LPASS_DP_RX:
>>           break;
>> +    case LPASS_CDC_DMA_RX0 ... LPASS_CDC_DMA_RX9:
>> +    case LPASS_CDC_DMA_TX0 ... LPASS_CDC_DMA_TX8:
>> +    case LPASS_CDC_DMA_VA_TX0 ... LPASS_CDC_DMA_VA_TX8:
>> +        break;
>>       default:
>>           dev_err(rtd->dev, "%s: invalid dai id 0x%x\n", __func__,
>>               cpu_dai->id);
