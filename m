Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5276F4C2FF2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236438AbiBXPhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbiBXPhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:37:20 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D289D60DB5;
        Thu, 24 Feb 2022 07:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645717009; x=1677253009;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6iOO/xvEAZwa7uM8e2lemBPhR3SH5fevH9P0Xv6tYoc=;
  b=lrmOcWCSpYOIfhDm5ko0cestwdzQpWwWRQmvibM4sDEQF0FHVcj4TgUk
   hYuRv9QFGEuer6HF+ZEJtbNCPJQ/mv+adpanJSy87n+c6hUDP/8uHZDp9
   4m2I7pnYsbzAOAYPhXEQu76dFkQPGkA5fWLeZgJBy0O0zqx85qpm3pRSe
   w=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 24 Feb 2022 07:36:49 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 07:36:49 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 24 Feb 2022 07:36:49 -0800
Received: from [10.216.20.63] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Thu, 24 Feb
 2022 07:36:43 -0800
Message-ID: <1d433167-7768-9d10-7e92-74bca4bc8d39@quicinc.com>
Date:   Thu, 24 Feb 2022 21:06:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v15 6/10] ASoC: qcom: Add regmap config support for codec
 dma driver
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@codeaurora.org>,
        <perex@perex.cz>, <tiwai@suse.com>,
        <srinivas.kandagatla@linaro.org>, <rohitkr@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1645630745-25051-1-git-send-email-quic_srivasam@quicinc.com>
 <1645630745-25051-7-git-send-email-quic_srivasam@quicinc.com>
 <Yhd26Cbe6ecbiVYH@sirena.org.uk>
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <Yhd26Cbe6ecbiVYH@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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


On 2/24/2022 5:45 PM, Mark Brown wrote:
Thanks for Your time Brown!!!
> On Wed, Feb 23, 2022 at 09:09:01PM +0530, Srinivasa Rao Mandadapu wrote:
>> Update regmap configuration for supporting headset playback and
>> capture and DMIC capture using codec dma interface
> This breaks an x86 allmodconfig build:
>
> /mnt/kernel/sound/soc/qcom/lpass-cpu.c:976:29: error: 'lpass_va_regmap_config' defined but not used [-Werror=unused-variable]
>    976 | static struct regmap_config lpass_va_regmap_config = {
>        |                             ^~~~~~~~~~~~~~~~~~~~~~
> /mnt/kernel/sound/soc/qcom/lpass-cpu.c:966:29: error: 'lpass_rxtx_regmap_config' defined but not used [-Werror=unused-variable]
>    966 | static struct regmap_config lpass_rxtx_regmap_config = {
>        |                             ^~~~~~~~~~~~~~~~~~~~~~~~
Okay. Sent patch series with fix.
