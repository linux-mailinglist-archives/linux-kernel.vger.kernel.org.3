Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BACDA469636
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243722AbhLFNHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:07:06 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:63777 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243721AbhLFNHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:07:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638795817; x=1670331817;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=fN+AGjvGVQF3YmxSDAvtPepi7zeO3Ze+Kbg1rbOx7BU=;
  b=SMOqMD2E3SyU4PfIJOXUWH90Z056NT+0nzOOsdQroJ4RSdbupRL+tR+w
   lA924fERkvFBO/buSJ+SGFIZ4wjWm2NJKsQZtjI7/UyMIhv7/+5KRGDre
   RpEhUCXVibuNmFgmtToiEJaPanB3e7wPuGSfVQW0+tPTOEI3ACsjls9Dx
   8=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 06 Dec 2021 05:03:36 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 05:03:35 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 6 Dec 2021 05:03:35 -0800
Received: from [10.216.22.188] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 6 Dec 2021
 05:03:30 -0800
Subject: Re: [PATCH V4 1/6] dt-bindings: regulator: Add
 "regulator-min-dropout-voltage-microvolt"
To:     Mark Brown <broonie@kernel.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, <swboyd@chromium.org>,
        <collinsd@codeaurora.org>, <subbaram@codeaurora.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>,
        "Lee Jones" <lee.jones@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1637314953-4215-1-git-send-email-quic_c_skakit@quicinc.com>
 <1637314953-4215-2-git-send-email-quic_c_skakit@quicinc.com>
 <YZ+o9sQpECZSrieN@sirena.org.uk>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Message-ID: <d828f2a1-03e8-d6ee-4ab7-39bf677093b7@quicinc.com>
Date:   Mon, 6 Dec 2021 18:33:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YZ+o9sQpECZSrieN@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/25/2021 8:47 PM, Mark Brown wrote:
> On Fri, Nov 19, 2021 at 03:12:28PM +0530, Satya Priya wrote:
>
>> +  regulator-min-dropout-voltage-microvolt:
>> +    description: Specifies the minimum voltage in microvolts that the
>> +      parent supply regulator must output, above the output of this regulator.
> Usually this is a fixed property of the regulator rather than something
> that varies per board - why have a DT property?


The min-dropout value (headroom) varies with boards, that's why we have 
a DT property for it. We overwrite the default value in driver with 
actual value read from DT


