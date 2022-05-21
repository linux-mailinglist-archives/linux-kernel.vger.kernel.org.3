Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A6752F83D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 06:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239821AbiEUEGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 00:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbiEUEG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 00:06:29 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D8F814A7;
        Fri, 20 May 2022 21:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653105988; x=1684641988;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bY1CIUKqGJCO/khWDalEZ0ZkWi/2j8BFDc2NSAfiS9o=;
  b=YgncMWC25qQa84/WabU1zKcVWMi1VE0ZD6YftubjD5ubs3oC/kM6FJ2i
   haBgDIQ4XGz+us1/YPHvxgZGpNY+sqC8bCrnoqcB0yUoownL6R5Haai8C
   WZi8iXOdO37CIB/9LSQ8SgO8tYUjUq6oQ5j4tyufJ1ZTQWPRO+dM/sDCo
   c=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 May 2022 21:06:27 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 21:06:27 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 20 May 2022 21:06:25 -0700
Received: from [10.50.38.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 20 May
 2022 21:06:23 -0700
Message-ID: <1c51c9c6-e0d5-8616-8ba1-ef870bfb96ec@quicinc.com>
Date:   Sat, 21 May 2022 09:36:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] soc: qcom: socinfo: Add an ID for sc7180P
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Stephen Boyd <swboyd@chromium.org>, <matvore@chromium.org>,
        Andy Gross <agross@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220520155305.v2.1.I26eca1856f99e6160d30de6d50ecab60e6226354@changeid>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <20220520155305.v2.1.I26eca1856f99e6160d30de6d50ecab60e6226354@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/2022 4:23 AM, Douglas Anderson wrote:
> Some sc7180 Chromebooks actually have sc7180P (known by many names,
> apparently, including possibly sc7180 Pro and sc7185). This is a
> sc7180 part that has slightly higher clock speeds.
>
> The official ID numbrer allocated to these devices by Qualcomm is 495
> so we'll add an entry to the table for them. Note that currently
> shipping BIOS for these devices will actually end up reporting an ID
> of 407 due to a bug but eventually a new BIOS will be released which
> corrects it to 495.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v2:
> - Switch from 407 to 495.
>
>   drivers/soc/qcom/socinfo.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> index cee579a267a6..c2c879ccc6c0 100644
> --- a/drivers/soc/qcom/socinfo.c
> +++ b/drivers/soc/qcom/socinfo.c
> @@ -332,6 +332,7 @@ static const struct soc_id soc_id[] = {
>   	{ 480, "SM8450" },
>   	{ 482, "SM8450" },
>   	{ 487, "SC7280" },
> +	{ 495, "SC7180P" },
>   };
>   
>   static const char *socinfo_machine(struct device *dev, unsigned int id)

Reviewed-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>

-Sai
