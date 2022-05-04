Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E047651956B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 04:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344014AbiEDCSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 22:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343984AbiEDCS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 22:18:29 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DF32A72F;
        Tue,  3 May 2022 19:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651630495; x=1683166495;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rMNGehIgiXmPL/7MJwr9CxJwJzaRTJNO1ROWw9C2U2I=;
  b=j+SuCXxwHeHbm1a4T4cgY9AIH09Okp28ye4afXU7iIemtIbkXtOKfJsE
   mHKGkCIIV03etbEgdIyFGnlBezYEu0+ox2wyqeedGOj3Cs9Kcmn5lq2o8
   /EY1SGFE0S3WwsNi+a/j7Gzf9PfxhQRxPPaP94aN8+ljXoUvaPGdnHeNe
   g=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 03 May 2022 19:14:55 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 19:14:55 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 3 May 2022 19:14:54 -0700
Received: from [10.50.60.188] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 3 May 2022
 19:14:51 -0700
Message-ID: <13819b2d-26f0-14f4-9cb9-affb6b18f13d@quicinc.com>
Date:   Wed, 4 May 2022 07:44:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] soc: qcom: socinfo: Add another ID for sc7180
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <matvore@chromium.org>,
        "Reviewed-by : Stephen Boyd" <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220502173338.1.I26eca1856f99e6160d30de6d50ecab60e6226354@changeid>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <20220502173338.1.I26eca1856f99e6160d30de6d50ecab60e6226354@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/3/2022 6:03 AM, Douglas Anderson wrote:
> It appears the some sc7180 devices, like the one in my
> sc7180-trogdor-homestar, report an ID of 407 instead of 425. Add
> another ID into the list.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>   drivers/soc/qcom/socinfo.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
> index cee579a267a6..2ef1dc2a1dd3 100644
> --- a/drivers/soc/qcom/socinfo.c
> +++ b/drivers/soc/qcom/socinfo.c
> @@ -318,6 +318,7 @@ static const struct soc_id soc_id[] = {
>   	{ 396, "IPQ8071A" },
>   	{ 402, "IPQ6018" },
>   	{ 403, "IPQ6028" },
> +	{ 407, "SC7180" },
>   	{ 421, "IPQ6000" },
>   	{ 422, "IPQ6010" },
>   	{ 425, "SC7180" },

Hmm, this ID maps to SM6250 which is a mobile variant. Not sure we should
use it for SC7180 which already has 425 ID assigned, perks of marketing :)

Thanks,
Sai
