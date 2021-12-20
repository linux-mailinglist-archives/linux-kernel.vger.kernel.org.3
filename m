Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889EC47A9D6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 13:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhLTMoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 07:44:11 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:11068 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbhLTMoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 07:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640004250; x=1671540250;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=UY5QOK4WexkpB6nxRP6uRky4rhzRwrcfHaEgqbYJz9w=;
  b=LYB3t3qZU6s3FO/I+f2mNfT2pZyUiYIXjGf/RO6LfkAkHLHIaGfbjfjA
   0DZus/eG0uuYW/KhxkubIWO1w1xUgXU61+ZuS2B8KzScImXbJGMj2Rjc9
   VLGiITo4RfARmnuUFS8JGysOLarGMNXWfH2+myfvqmy9MXTj1UPlmJ79E
   g=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 20 Dec 2021 04:44:10 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 04:44:09 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 20 Dec 2021 04:44:09 -0800
Received: from [10.216.48.77] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 20 Dec
 2021 04:44:04 -0800
Subject: Re: [PATCH V4 2/6] dt-bindings: regulator: Add pm8008 regulator
 bindings
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
 <1637314953-4215-3-git-send-email-quic_c_skakit@quicinc.com>
 <YZ+qn2hA4MzNEqM+@sirena.org.uk>
 <30b21a08-f7f7-f3a6-a3ac-156c7f8964b1@quicinc.com>
 <Ya4UcxxEq9t+isxS@sirena.org.uk>
From:   "Satya Priya Kakitapalli (Temp)" <quic_c_skakit@quicinc.com>
Message-ID: <30ec6b4c-f2a8-d80e-a542-1c2b3f30c049@quicinc.com>
Date:   Mon, 20 Dec 2021 18:14:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ya4UcxxEq9t+isxS@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/6/2021 7:17 PM, Mark Brown wrote:
> On Mon, Dec 06, 2021 at 07:13:02PM +0530, Satya Priya Kakitapalli (Temp) wrote:
>> On 11/25/2021 8:54 PM, Mark Brown wrote:
>>> On Fri, Nov 19, 2021 at 03:12:29PM +0530, Satya Priya wrote:
>>>> +properties:
>>>> +  compatible:
>>>> +    const: qcom,pm8008-regulators
>>> Why are we adding a separate compatible for this when we already know
>>> that this is a pm8008 based on the parent?
>> For the regulator driver to be probed we do need a separate compatible
>> right? may be I didn't get your question..
>> My understanding is we should have a separate compatible for each peripheral
>> under the parent mfd node.. like gpios, temp alarm, regulators etc..
> No, the MFD can register whatever children it likes without needing any
> help from the DT.

I think this is possible by using of_platform_bus_probe() API. But, the 
mfd driver uses of_platform_populate() API, this needs all device nodes 
to have a 'compatible' property unlike the of_platform_bus_probe() API.

All other MFD upstream drivers are also using the same API and 
registering the child regulators by using separate compatible strings.


>>>> +  vdd_l1_l2-supply:
>>>> +    description: Input supply phandle of ldo1 and ldo2 regulators.
>>> These supply nodes should be chip level, they're going into the chip and
>>> in general the expectation is that you should be able to describe the
>>> supplies going into a device without worrying about how or if any
>>> particular OS splits things up.
>> So, if i understand correctly, we don't have to mention these in the
>> documentation as these are handled at framework level?
> No.  I'm saying you should document these at the chip level, they do
> need to be documented though.

By chip level do you mean "pm8008.yaml" documentation? If so, yes, I can 
move these to pm8008.yaml and change DT accordingly.

