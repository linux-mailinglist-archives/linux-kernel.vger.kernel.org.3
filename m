Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAC74AF23D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiBINBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiBINBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:01:17 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D506FC0613CA;
        Wed,  9 Feb 2022 05:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644411681; x=1675947681;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KD6Lp4BkKlFVB0RGHgLuv8EhmfR4x5XxZN5wW9sPRTg=;
  b=tQGYiPY/ggziLCvmO9LMADUZqOXI3GWtUvD1M3R5ZOUyZaGXfCrX9vx6
   rDJwefnvyUWl8JayQsFGWZ/hUMO9X7/IL9rbbXU+B5fOCDnG46hXflKaO
   nDEPhv8z20sMJTm0ncSPhDcs/GkjOD8C6TiYwl1G68PI09hz1eAB4CJxA
   g=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 09 Feb 2022 05:01:19 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 05:01:19 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 05:01:18 -0800
Received: from [10.50.24.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 9 Feb 2022
 05:01:15 -0800
Message-ID: <c898d9e6-c63a-d79c-f0c6-f33112e70b33@quicinc.com>
Date:   Wed, 9 Feb 2022 18:31:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCHv2 0/9] soc: qcom: llcc: Add LLCC support for SM8450 SoC
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Prasad <quic_psodagud@quicinc.com>
References: <cover.1643355594.git.quic_saipraka@quicinc.com>
 <Yf/XgGSHE9PwYrz0@matsya>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <Yf/XgGSHE9PwYrz0@matsya>
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

On 2/6/2022 7:43 PM, Vinod Koul wrote:
> On 28-01-22, 13:17, Sai Prakash Ranjan wrote:
>> This patch series adds support for LLCC on SM8450 SoC. It mainly
>> consists of LLCC driver changes to incorporate newer LLCC HW found
>> on SM8450 SoC and the corresponding DT bits to enable LLCC.
>> Based on qcom/for-next branch.
> I have tested this on SM8450 QRD and MTP
>
> Tested-by: Vinod Koul <vkoul@kernel.org>
>

Thanks Vinod.

-Sai
