Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8690497232
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 15:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236800AbiAWOnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 09:43:37 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:13424 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbiAWOne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 09:43:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642949014; x=1674485014;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ISKKszcB4BU8ddnDILGYHFW7vinX67qvZKaFwOdiGbc=;
  b=ODlHXZtTiq3Cw4g1pmyAQnQ/m0ufPTSmUAbTOCUh6joNFa0hC+7u29ci
   Zr/jeH1EpWBR+BldU+C3lAzH1uZFlkGpNX9AOUomwK8/TnJR49iFGHR70
   VYCKhyvLT7szJVypJLTabIqAg2pTMccROkHUGTkaLJH8w8HS3ovNDb6Y8
   w=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 23 Jan 2022 06:43:34 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 06:43:32 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 23 Jan 2022 06:43:32 -0800
Received: from [10.216.26.9] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Sun, 23 Jan
 2022 06:43:21 -0800
Message-ID: <d241d160-fb27-2103-3c5c-237b88baa91f@quicinc.com>
Date:   Sun, 23 Jan 2022 20:13:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V3 0/4] thermal: qcom: Add support for PMIC5 Gen2 ADC_TM
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>, <mka@chromium.org>,
        <dmitry.baryshkov@linaro.org>, <robh+dt@kernel.org>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <manivannan.sadhasivam@linaro.org>, <linus.walleij@linaro.org>,
        <quic_kgunda@quicinc.com>, <quic_aghayal@quicinc.com>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <quic_subbaram@quicinc.com>, <jic23@kernel.org>,
        <amitk@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
References: <1637647025-20409-1-git-send-email-quic_jprakash@quicinc.com>
 <20211126182911.00005110@Huawei.com>
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <20211126182911.00005110@Huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 11/26/2021 11:59 PM, Jonathan Cameron wrote:
> On Tue, 23 Nov 2021 11:27:00 +0530
> Jishnu Prakash <quic_jprakash@quicinc.com> wrote:
>
>> Made following changes in this post:
>> Addressed comments given by Jonathan for qcom-spmi-adc-tm5.yaml.
>> Addressed comments given by Dmitry and Jonathan for qcom-spmi-adc-tm5.c.
>> Split patch for qcom-spmi-adc-tm5.c into two parts, one to refactor
>> code to support multiple device generations and the second to add
>> actual Gen2 ADC_TM changes.
> Series is missing a change log.  Either in cover letter, or in
> individual patches after the --
>
> Jonathan


I'll add the change log in the cover letter in the next post.


>
>> Jishnu Prakash (4):
>>    dt-bindings: thermal: qcom: add PMIC5 Gen2 ADC_TM bindings
>>    iio: adc: qcom-vadc-common: add reverse scaling for PMIC5 Gen2 ADC_TM
>>    thermal: qcom: Add support for multiple generations of devices
>>    thermal: qcom: add support for PMIC5 Gen2 ADCTM
>>
>>   .../bindings/thermal/qcom-spmi-adc-tm5.yaml        | 110 ++++-
>>   drivers/iio/adc/qcom-vadc-common.c                 |  11 +
>>   drivers/thermal/qcom/qcom-spmi-adc-tm5.c           | 451 +++++++++++++++++++--
>>   include/linux/iio/adc/qcom-vadc-common.h           |   2 +
>>   4 files changed, 541 insertions(+), 33 deletions(-)
>>
Thanks,

Jishnu

