Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A37658D3CD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 08:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237631AbiHIGcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 02:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235179AbiHIGcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 02:32:07 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFCB1FCFC;
        Mon,  8 Aug 2022 23:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1660026727; x=1691562727;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=VyIoMcZ7RkY7NN4Q1ADLKqmIVyptu2nK6LJES8ahh8w=;
  b=gyYGtKFuQXWlQt4YO5sx/5YX82H++6ksKq3LJ8lmL6YpWT0O0r/TEo1y
   HAA/6DwaBNkD891ltmhugbnrsedYk1iHLReF4Yo8Qr6woBIcf8UTyr0AN
   M2yq35rldyVzSwah4zRnKwuLJ/SCJQLuy2VV0u3nYmBYtfgU2dFNcikDg
   Q=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 08 Aug 2022 23:32:06 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 23:32:05 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 8 Aug 2022 23:32:05 -0700
Received: from [10.216.39.97] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 8 Aug 2022
 23:31:59 -0700
Message-ID: <dd446961-c455-d721-cc0a-2aec506b2189@quicinc.com>
Date:   Tue, 9 Aug 2022 12:01:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5/8] remoteproc: qcom: Add efuse evb selection control
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>
References: <1659536480-5176-1-git-send-email-quic_srivasam@quicinc.com>
 <1659536480-5176-6-git-send-email-quic_srivasam@quicinc.com>
 <0ed40651-1638-3701-f310-cd50102ae763@linaro.org>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <0ed40651-1638-3701-f310-cd50102ae763@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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


On 8/7/2022 1:56 AM, Dmitry Baryshkov wrote:
Thanks for Your Time Dmitry!!!
> On 03/08/2022 17:21, Srinivasa Rao Mandadapu wrote:
>> Add efuse evb selection control and enable it for starting ADSP.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>
> Is the lpass_efuse region used solely by the ADSP or is it shared with 
> anybody else (e.g. other sound-related devices)? If the latter is 
> true, then please use syscon for the lpass_efuse region.
This region is being used by ADS PIL driver only.
>
>> ---
>>   drivers/remoteproc/qcom_q6v5_adsp.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c 
>> b/drivers/remoteproc/qcom_q6v5_adsp.c
>> index a9fcb5c..201cc21 100644
>> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
>> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
>> @@ -56,6 +56,7 @@
>>     #define LPASS_BOOT_CORE_START    BIT(0)
>>   #define LPASS_BOOT_CMD_START    BIT(0)
>> +#define LPASS_EFUSE_Q6SS_EVB_SEL 0x0
>>     struct adsp_pil_data {
>>       int crash_reason_smem;
>> @@ -85,6 +86,7 @@ struct qcom_adsp {
>>       struct clk_bulk_data *clks;
>>         void __iomem *qdsp6ss_base;
>> +    void __iomem *lpass_efuse;
>>         struct reset_control *pdc_sync_reset;
>>       struct reset_control *restart;
>> @@ -366,6 +368,9 @@ static int adsp_start(struct rproc *rproc)
>>       /* Program boot address */
>>       writel(adsp->mem_phys >> 4, adsp->qdsp6ss_base + RST_EVB_REG);
>>   +    if (adsp->lpass_efuse)
>> +        writel(LPASS_EFUSE_Q6SS_EVB_SEL, adsp->lpass_efuse);
>> +
>>       /* De-assert QDSP6 stop core. QDSP6 will execute after out of 
>> reset */
>>       writel(LPASS_BOOT_CORE_START, adsp->qdsp6ss_base + 
>> CORE_START_REG);
>>   @@ -520,6 +525,11 @@ static int adsp_init_mmio(struct qcom_adsp *adsp,
>>           return PTR_ERR(adsp->qdsp6ss_base);
>>       }
>>   +    adsp->lpass_efuse = 
>> devm_platform_ioremap_resource_byname(pdev, "lpass_efuse");
>> +    if (IS_ERR(adsp->lpass_efuse)) {
>> +        adsp->lpass_efuse = NULL;
>> +        dev_dbg(adsp->dev, "failed to map LPASS efuse registers\n");
>> +    }
>>       syscon = of_parse_phandle(pdev->dev.of_node, "qcom,halt-regs", 0);
>>       if (!syscon) {
>>           dev_err(&pdev->dev, "failed to parse qcom,halt-regs\n");
>
>
