Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6558D4B7FF4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 06:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344573AbiBPFO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 00:14:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344556AbiBPFOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 00:14:53 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E77F9570;
        Tue, 15 Feb 2022 21:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644988481; x=1676524481;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ylavwFYQD6KGHhXFsIL//yJI76kYPD2M2lrrfVfYUGw=;
  b=CFY+xCOmeY3nuwQpj8kWQ311B21R4Rtb6KjM2BEdcoie80TD0w6A7pxT
   FbBP5aqYCdgO6OGCTNS2GfmPanYH3bt1wCVmsOArwbMEYvIicowVYwvDG
   7MqysXt2TUkjl55TKoWel1FRpFVKyF190aGLtijbVOwBlnAFQn3EMkxkD
   Q=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Feb 2022 21:14:40 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 21:14:33 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Feb 2022 21:14:32 -0800
Received: from [10.216.55.237] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 15 Feb
 2022 21:14:27 -0800
Subject: Re: [RESEND v13 05/10] ASoC: qcom: Add register definition for codec
 rddma and wrdma
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <alsa-devel@alsa-project.org>, <bgoswami@codeaurora.org>,
        <bjorn.andersson@linaro.org>, <broonie@kernel.org>,
        <devicetree@vger.kernel.org>, <judyhsiao@chromium.org>,
        <lgirdwood@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <perex@perex.cz>,
        <quic_plai@quicinc.com>, <robh+dt@kernel.org>,
        <rohitkr@codeaurora.org>, <srinivas.kandagatla@linaro.org>,
        <tiwai@suse.com>
CC:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1644850708-11099-1-git-send-email-quic_srivasam@quicinc.com>
 <1644850708-11099-6-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n53iKwT8u=d2KG5KX8fJgFs1JhTnaGCfG=OLarhvLdmf3Q@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
Message-ID: <13d0bb5c-4f63-12a0-3c2c-c2d0e0211026@quicinc.com>
Date:   Wed, 16 Feb 2022 10:44:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n53iKwT8u=d2KG5KX8fJgFs1JhTnaGCfG=OLarhvLdmf3Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
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


On 2/15/2022 6:42 AM, Stephen Boyd wrote:
Thanks for your time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2022-02-14 06:58:23)
>> This patch adds register definitions for codec read dma and write dma
>   git grep "This patch" -- Documentation/process/
Okay. Will remove and reword the commit message.
>
>> lpass interface.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
>> index 7cc3763..e059c4a 100644
>> --- a/sound/soc/qcom/lpass.h
>> +++ b/sound/soc/qcom/lpass.h
>> @@ -39,6 +39,29 @@
>>                          return -EINVAL;         \
>>          } while (0)
>>
>> +static inline bool is_cdc_dma_port(int dai_id)
>> +{
>> +       switch (dai_id) {
>> +       case LPASS_CDC_DMA_RX0 ... LPASS_CDC_DMA_RX9:
>> +       case LPASS_CDC_DMA_TX0 ... LPASS_CDC_DMA_TX8:
>> +       case LPASS_CDC_DMA_VA_TX0 ... LPASS_CDC_DMA_VA_TX8:
>> +               return true;
>> +       default:
> Drop case
Okay. will remove it.
>
>> +               return false;
>> +       }
> return false;
>
> would be shorter.
Okay. will change it.
>
>> +}
>> +
>> +static inline bool is_rxtx_cdc_dma_port(int dai_id)
>> +{
>> +       switch (dai_id) {
>> +       case LPASS_CDC_DMA_RX0 ... LPASS_CDC_DMA_RX9:
>> +       case LPASS_CDC_DMA_TX0 ... LPASS_CDC_DMA_TX8:
>> +               return true;
>> +       default:
>> +               return false;
>> +       }
> Same.
Okay.
>
>> +}
>> +
>>   struct lpaif_i2sctl {
>>          struct regmap_field *loopback;
>>          struct regmap_field *spken;
