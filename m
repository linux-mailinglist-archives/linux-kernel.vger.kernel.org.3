Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5304B7FCA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 05:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344543AbiBPE6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 23:58:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbiBPE6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 23:58:30 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15D06158;
        Tue, 15 Feb 2022 20:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644987498; x=1676523498;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=9hWDVImhK1Iwotogv2R90DiFeUKHg484m5QG3YbFP7A=;
  b=UH0LscZR+gCShY206mAWAZ0Fb0d6HlXTaLrbriE9x+iJHGBO/TzXb8Wc
   BujTyAuJWJqtS0OZ3qNnGGNLxMx6QPZQtthIZRmNiQ8iIpCR8QeooOpZT
   O9h4Rby1gq7KoF4As99QsvbeRM4cDXBwRRwQXqQ4J/hH8KALNChZuLIQ0
   g=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Feb 2022 20:58:18 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 20:58:16 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Feb 2022 20:58:16 -0800
Received: from [10.216.55.237] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 15 Feb
 2022 20:58:11 -0800
Subject: Re: [RESEND v13 03/10] ASoC: qcom: lpass: Add dma fields for codec
 dma lpass interface
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
 <1644850708-11099-4-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n53dXfwsJ=mh7cNH6Lq0Um+h+oTJDvqsXALh8L=wfONLjw@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
Message-ID: <0311446c-d7da-a701-b63d-08ca02d9c5d5@quicinc.com>
Date:   Wed, 16 Feb 2022 10:28:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAE-0n53dXfwsJ=mh7cNH6Lq0Um+h+oTJDvqsXALh8L=wfONLjw@mail.gmail.com>
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


On 2/15/2022 6:35 AM, Stephen Boyd wrote:
Thanks for your time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2022-02-14 06:58:21)
>> Add lpass interface memebers to support audio path over codec dma.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   sound/soc/qcom/lpass.h | 116 +++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 116 insertions(+)
>>
>> diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
>> index f0d21cd..7cc3763 100644
>> --- a/sound/soc/qcom/lpass.h
>> +++ b/sound/soc/qcom/lpass.h
>> @@ -234,12 +294,66 @@ struct lpass_variant {
>>          struct reg_field wrdma_enable;
>>          struct reg_field wrdma_dyncclk;
>>
>> +       /*CDC RXTX RD_DMA */
> Please add space after /*
Okay. Will change it.
>
>> +       struct reg_field rxtx_rdma_intf;
>> +       struct reg_field rxtx_rdma_bursten;
>> +       struct reg_field rxtx_rdma_wpscnt;
>> +       struct reg_field rxtx_rdma_fifowm;
>> +       struct reg_field rxtx_rdma_enable;
>> +       struct reg_field rxtx_rdma_dyncclk;
>> +       struct reg_field rxtx_rdma_burst8;
>> +       struct reg_field rxtx_rdma_burst16;
>> +       struct reg_field rxtx_rdma_dynburst;
>> +       struct reg_field rxtx_rdma_codec_enable;
>> +       struct reg_field rxtx_rdma_codec_pack;
>> +       struct reg_field rxtx_rdma_codec_intf;
>> +       struct reg_field rxtx_rdma_codec_fs_sel;
>> +       struct reg_field rxtx_rdma_codec_ch;
>> +       struct reg_field rxtx_rdma_codec_fs_delay;
>> +
>> +       /*CDC RXTX WR_DMA */
> Same
Okay.
>
>> +       struct reg_field rxtx_wrdma_intf;
>> +       struct reg_field rxtx_wrdma_bursten;
>> +       struct reg_field rxtx_wrdma_wpscnt;
>> +       struct reg_field rxtx_wrdma_fifowm;
>> +       struct reg_field rxtx_wrdma_enable;
>> +       struct reg_field rxtx_wrdma_dyncclk;
>> +       struct reg_field rxtx_wrdma_burst8;
>> +       struct reg_field rxtx_wrdma_burst16;
>> +       struct reg_field rxtx_wrdma_dynburst;
>> +       struct reg_field rxtx_wrdma_codec_enable;
>> +       struct reg_field rxtx_wrdma_codec_pack;
>> +       struct reg_field rxtx_wrdma_codec_intf;
>> +       struct reg_field rxtx_wrdma_codec_fs_sel;
>> +       struct reg_field rxtx_wrdma_codec_ch;
>> +       struct reg_field rxtx_wrdma_codec_fs_delay;
>> +
>> +       /*CDC VA WR_DMA */
>> +       struct reg_field va_wrdma_intf;
>> +       struct reg_field va_wrdma_bursten;
>> +       struct reg_field va_wrdma_wpscnt;
>> +       struct reg_field va_wrdma_fifowm;
>> +       struct reg_field va_wrdma_enable;
>> +       struct reg_field va_wrdma_dyncclk;
>> +       struct reg_field va_wrdma_burst8;
>> +       struct reg_field va_wrdma_burst16;
>> +       struct reg_field va_wrdma_dynburst;
>> +       struct reg_field va_wrdma_codec_enable;
>> +       struct reg_field va_wrdma_codec_pack;
>> +       struct reg_field va_wrdma_codec_intf;
>> +       struct reg_field va_wrdma_codec_fs_sel;
>> +       struct reg_field va_wrdma_codec_ch;
>> +       struct reg_field va_wrdma_codec_fs_delay;
>> +
>>          /**
> This shouldn't have two stars as it isn't kerneldoc
Actually this not part of this patch.
>
>>           * on SOCs like APQ8016 the channel control bits start
>>           * at different offset to ipq806x
>>           **/
>>          u32     dmactl_audif_start;
>>          u32     wrdma_channel_start;
>> +       u32     rxtx_wrdma_channel_start;
>> +       u32     va_wrdma_channel_start;
>> +
>>          /* SOC specific initialization like clocks */
>>          int (*init)(struct platform_device *pdev);
>>          int (*exit)(struct platform_device *pdev);
>> @@ -251,10 +365,12 @@ struct lpass_variant {
>>          int num_dai;
>>          const char * const *dai_osr_clk_names;
>>          const char * const *dai_bit_clk_names;
>> +       const char * const *cdc_dma_clk_names;
>>
>>          /* SOC specific clocks configuration */
>>          const char **clk_name;
>>          int num_clks;
>> +       int cdc_dma_num_clks;
> Why not size_t? Negative numbers are useful here?
Okay. As negative numbers are not useful here, will change to size_t.
