Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFC949038A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237979AbiAQIPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:15:37 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:38125 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230028AbiAQIPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:15:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642407335; x=1673943335;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pE15V9cC2hu9MEnNgmYkLQQoTLc+mdGCHkVp2gX0xDE=;
  b=CLVi9hju/2oTjkw4QtNG1CK7ZYrf+7ZDYJJyVbQcE/KlC/7RzesIf2Xb
   bXSfLigWmZaumnZMC+qn9/e37YBUmTbAz7NLEG3wOhQCny9i3ReJKV+YF
   JZgUvZ1uA5T6FXeWbji7t1q7kls56risDXooYSFEi8kqPbcGsQ1uhv2Nb
   o=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 17 Jan 2022 00:15:35 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 00:12:59 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 17 Jan 2022 00:12:58 -0800
Received: from [10.216.37.171] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 17 Jan
 2022 00:12:53 -0800
Message-ID: <7745d562-17bd-0a51-7f7e-8f5468e6d373@quicinc.com>
Date:   Mon, 17 Jan 2022 13:42:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 04/10] arm64: dts: qcom: sm8450: Update cpuidle states
 parameters
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     <bjorn.andersson@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <quic_lsrao@quicinc.com>, <quic_rjendra@quicinc.com>,
        <devicetree@vger.kernel.org>
References: <1641749107-31979-1-git-send-email-quic_mkshah@quicinc.com>
 <1641749107-31979-5-git-send-email-quic_mkshah@quicinc.com>
 <CAPDyKFrrajGPsH5=iqtB6PAuO6Y9C8_QfbF8yF2PKqrVuCmZ9g@mail.gmail.com>
From:   Maulik Shah <quic_mkshah@quicinc.com>
In-Reply-To: <CAPDyKFrrajGPsH5=iqtB6PAuO6Y9C8_QfbF8yF2PKqrVuCmZ9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/14/2022 6:00 PM, Ulf Hansson wrote:
>
>> @@ -315,7 +315,7 @@
>>
>>                  CLUSTER_PD: cpu-cluster0 {
>>                          #power-domain-cells = <0>;
>> -                       domain-idle-states = <&CLUSTER_SLEEP_0>;
>> +                       domain-idle-states = <&CLUSTER_SLEEP_0 &CLUSTER_SLEEP_1>;
> Should this be like the below instead?
>
> <&CLUSTER_SLEEP_0>,  <&CLUSTER_SLEEP_1>;

Thanks for catching this. Will correct in v2.

Thanks,
Maulik
