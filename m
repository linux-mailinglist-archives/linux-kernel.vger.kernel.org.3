Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E819468344
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 08:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354946AbhLDICr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 03:02:47 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:35793 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354886AbhLDICq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 03:02:46 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638604761; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=RPYFRq2tetZ3XfrNaT2ZW8JmIgt6VIgZNLFs/5bLiyw=; b=uOmXhMS2/u6h7f0PR4bXf77c8QZi6dHIr9V2XHU3A7o6XWV35u/TXVKhWs+RYx8SXdw1DyWD
 Z1SOYhUU45iKQ2NFzqYKKC+bnlOZVzOcO8PfaWg2vOLfYhB7Oqf5ggvTrc020XRlnoGy8TB/
 t7IpnPSOFaKBdPHgPiGWMi6RrWw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 61ab1fd8903341b2e49c70f6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 04 Dec 2021 07:59:20
 GMT
Sender: srivasam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 62BF0C43619; Sat,  4 Dec 2021 07:59:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.29.24] (unknown [49.37.168.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B7A07C4338F;
        Sat,  4 Dec 2021 07:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org B7A07C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH v8 09/10] ASoC: dt-bindings: Add SC7280 lpass cpu bindings
To:     Rob Herring <robh+dt@kernel.org>,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.com>
Cc:     alsa-devel@alsa-project.org, bjorn.andersson@linaro.org,
        judyhsiao@chromium.org, tiwai@suse.com,
        linux-kernel@vger.kernel.org, bgoswami@codeaurora.org,
        agross@kernel.org, plai@codeaurora.org,
        Venkata Prasad Potturu <potturu@codeaurora.org>,
        perex@perex.cz, devicetree@vger.kernel.org, lgirdwood@gmail.com,
        linux-arm-msm@vger.kernel.org, swboyd@chromium.org,
        rohitkr@codeaurora.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org
References: <1638547658-22032-1-git-send-email-srivasam@codeaurora.com>
 <1638547658-22032-10-git-send-email-srivasam@codeaurora.com>
 <1638574455.248037.1043006.nullmailer@robh.at.kernel.org>
 <CAL_JsqKf4Y84+_PQqhwMEEiJNrR92urMUYSqYTEU0_c7fYnyhQ@mail.gmail.com>
From:   Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Organization: Qualcomm India Private Limited.
Message-ID: <07f5a5f2-cdf5-75de-9635-0edcd5e5c905@codeaurora.org>
Date:   Sat, 4 Dec 2021 13:29:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKf4Y84+_PQqhwMEEiJNrR92urMUYSqYTEU0_c7fYnyhQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/4/2021 5:08 AM, Rob Herring wrote:
Thanks for your time and notifying the issue!!!
> On Fri, Dec 3, 2021 at 5:34 PM Rob Herring <robh@kernel.org> wrote:
>> On Fri, 03 Dec 2021 21:37:37 +0530, Srinivasa Rao Mandadapu wrote:
>>> From: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
>>>
>>> Add bindings for sc7280 lpass cpu driver which supports
>>> audio over i2s based speaker, soundwire based headset, msm dmics
>>> and HDMI Port.
>>>
>>> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
>>> Co-developed-by: Venkata Prasad Potturu <potturu@codeaurora.org>
>>> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
>>> ---
>>>   .../devicetree/bindings/sound/qcom,lpass-cpu.yaml  | 70 +++++++++++++++++++---
>>>   1 file changed, 62 insertions(+), 8 deletions(-)
>>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.example.dt.yaml: lpass@62d80000: reg: [[0, 1658351616, 0, 425984], [0, 1659895808, 0, 167936]] is too short
>>          From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
> Are you running the checks before you send out your patches. Because
> it seems like you keep sending things with the same errors.
>
> If there's errors, I'm not going to review this. If you need help
> getting it to work, then ask.
Actually, the too short name errors are coming for the existing names 
also. could you please suggest on how to go ahead?
>
> And what's with your email setup? codeaurora.com bounces.

 From December 3 Qualcomm mail domain got changed to quicinc.com from 
codeaurora.org.

May be that's the reason for bouncing.

>
> Rob

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

