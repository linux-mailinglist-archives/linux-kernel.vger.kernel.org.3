Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF494651C5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351032AbhLAPg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:36:56 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:27270 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234031AbhLAPgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:36:52 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638372811; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=Q6HUfZt5oXc1duwzRmR4q+p0TcjKzuDlkMig1w3ztew=; b=h8Z66wQKT0C7N7uedH+hbkkXyuRHwxXYQSElshDKdPb4B+mXEiMl1hMMKjxiIBkntGgESIeD
 89ZDNdytmKIwYeB7D3m6ep7m1temDqyaGQAOrE7axBjaWIMFT9uLSXHqUCG9l1HpKHOMxBJ7
 s7vM2THR+39nh2jB3y5/LsJx5Zs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 61a795cbe7d68470afbdae2b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 01 Dec 2021 15:33:31
 GMT
Sender: srivasam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E26A2C4361A; Wed,  1 Dec 2021 15:33:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.0
Received: from [10.242.143.72] (unknown [202.46.23.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9A681C4338F;
        Wed,  1 Dec 2021 15:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 9A681C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH v6 10/10] ASoC: qcom: SC7280: Update config for building
 codec dma drivers
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org
Cc:     Venkata Prasad Potturu <potturu@codeaurora.org>
References: <1637928282-2819-1-git-send-email-srivasam@codeaurora.org>
 <1637928282-2819-11-git-send-email-srivasam@codeaurora.org>
 <0d51b0fd-61a9-e68f-6ab8-27708667d787@linaro.org>
From:   Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Organization: Qualcomm India Private Limited.
Message-ID: <a3663a8d-5a05-3bbe-4d5d-2b5b4a55d0d4@codeaurora.org>
Date:   Wed, 1 Dec 2021 21:03:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <0d51b0fd-61a9-e68f-6ab8-27708667d787@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/1/2021 4:20 PM, Srinivas Kandagatla wrote:
Thanks for Your time Srini!!!
>
> On 26/11/2021 12:04, Srinivasa Rao Mandadapu wrote:
>> Add configuration for building SC7280 audio codec dma drivers.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
>> Co-developed-by: Venkata Prasad Potturu <potturu@codeaurora.org>
>> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
>> ---
>> This patch set depends on:
>>      -- 
>> https://patchwork.kernel.org/project/alsa-devel/list/?series=582321
>>
>>   sound/soc/qcom/Kconfig  | 13 +++++++++++++
>>   sound/soc/qcom/Makefile |  4 ++++
>>   2 files changed, 17 insertions(+)
>>
>> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
>> index 530d01f..b46a2e7 100644
>> --- a/sound/soc/qcom/Kconfig
>> +++ b/sound/soc/qcom/Kconfig
>> @@ -20,6 +20,10 @@ config SND_SOC_LPASS_PLATFORM
>>       tristate
>>       select REGMAP_MMIO
>>   +config SND_SOC_LPASS_CDC_DMA
>> +    tristate
>> +    select REGMAP_MMIO
>> +
>>   config SND_SOC_LPASS_IPQ806X
>>       tristate
>>       select SND_SOC_LPASS_CPU
>> @@ -36,6 +40,13 @@ config SND_SOC_LPASS_SC7180
>>       select SND_SOC_LPASS_PLATFORM
>>       select SND_SOC_LPASS_HDMI
>>   +config SND_SOC_LPASS_SC7280
>> +    tristate
>> +    select SND_SOC_LPASS_CPU
>> +    select SND_SOC_LPASS_PLATFORM
>> +    select SND_SOC_LPASS_HDMI
>> +    select SND_SOC_LPASS_CDC_DMA
>> +
>>   config SND_SOC_STORM
>>       tristate "ASoC I2S support for Storm boards"
>>       select SND_SOC_LPASS_IPQ806X
>> @@ -156,7 +167,9 @@ config SND_SOC_SC7280
>>       tristate "SoC Machine driver for SC7280 boards"
>>       depends on I2C && SOUNDWIRE || COMPILE_TEST
>>       select SND_SOC_QCOM_COMMON
>> +    select SND_SOC_LPASS_SC7280
>>       select SND_SOC_MAX98357A
>> +    select SND_SOC_WCD938X
>
> Why are we updating machine Kconfigs in this patch, should that be not 
> in your machine driver patch series?

Actually, SND_SOC_LPASS_SC7280 is of lpass-sc7280 platform driver.  
SND_SOC_WCD938X is for wcd codec driver.

Will add WCD Kconfig as separate patch.

>
> I think I did point this out in previous versions too.
>
>
> --srini
>
>
>>       select SND_SOC_LPASS_RX_MACRO
>>       select SND_SOC_LPASS_TX_MACRO
>>       help
>> diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
>> index 625aec6..8b7b876 100644
>> --- a/sound/soc/qcom/Makefile
>> +++ b/sound/soc/qcom/Makefile
>> @@ -1,18 +1,22 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   # Platform
>>   snd-soc-lpass-cpu-objs := lpass-cpu.o
>> +snd-soc-lpass-cdc-dma-objs := lpass-cdc-dma.o
>>   snd-soc-lpass-hdmi-objs := lpass-hdmi.o
>>   snd-soc-lpass-platform-objs := lpass-platform.o
>>   snd-soc-lpass-ipq806x-objs := lpass-ipq806x.o
>>   snd-soc-lpass-apq8016-objs := lpass-apq8016.o
>>   snd-soc-lpass-sc7180-objs := lpass-sc7180.o
>> +snd-soc-lpass-sc7280-objs := lpass-sc7280.o
>>     obj-$(CONFIG_SND_SOC_LPASS_CPU) += snd-soc-lpass-cpu.o
>> +obj-$(CONFIG_SND_SOC_LPASS_CDC_DMA) += snd-soc-lpass-cdc-dma.o
>>   obj-$(CONFIG_SND_SOC_LPASS_HDMI) += snd-soc-lpass-hdmi.o
>>   obj-$(CONFIG_SND_SOC_LPASS_PLATFORM) += snd-soc-lpass-platform.o
>>   obj-$(CONFIG_SND_SOC_LPASS_IPQ806X) += snd-soc-lpass-ipq806x.o
>>   obj-$(CONFIG_SND_SOC_LPASS_APQ8016) += snd-soc-lpass-apq8016.o
>>   obj-$(CONFIG_SND_SOC_LPASS_SC7180) += snd-soc-lpass-sc7180.o
>> +obj-$(CONFIG_SND_SOC_LPASS_SC7280) += snd-soc-lpass-sc7280.o
>>     # Machine
>>   snd-soc-storm-objs := storm.o
>>
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

