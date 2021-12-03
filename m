Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4305C4680BA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 00:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354313AbhLCXoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 18:44:07 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:13343 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354148AbhLCXoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 18:44:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638574841; x=1670110841;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=PbgjBGtolt5B+GkMimGNb9ZTzL0SOFZVmFHPY6gsRmE=;
  b=Rp+lfz4q2acv4CjtxGFs6Q3uDaJJGdQOf49fWARoLTjDDl4lNvkqjWGB
   AOdVbFZ6wE0ivZkRRwFlCcxZC0brFjON6B0X5hpdB2pcqjJjtDFYSpIwo
   TVsChqfJN53ca8XFcAeIOPE3jAB0cXlGAKdB+HPI8Gq80A3J6BbPIJXFt
   s=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 03 Dec 2021 15:40:41 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 15:40:41 -0800
Received: from [10.110.102.90] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Fri, 3 Dec 2021
 15:40:39 -0800
Subject: Re: [PATCH v8 09/10] ASoC: dt-bindings: Add SC7280 lpass cpu bindings
To:     Rob Herring <robh+dt@kernel.org>,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.com>,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
CC:     <alsa-devel@alsa-project.org>, <bjorn.andersson@linaro.org>,
        <judyhsiao@chromium.org>, <tiwai@suse.com>,
        <linux-kernel@vger.kernel.org>, <bgoswami@codeaurora.org>,
        <agross@kernel.org>, <plai@codeaurora.org>,
        Venkata Prasad Potturu <potturu@codeaurora.org>,
        <perex@perex.cz>, <devicetree@vger.kernel.org>,
        <lgirdwood@gmail.com>, <linux-arm-msm@vger.kernel.org>,
        <swboyd@chromium.org>, <rohitkr@codeaurora.org>,
        <broonie@kernel.org>, <srinivas.kandagatla@linaro.org>
References: <1638547658-22032-1-git-send-email-srivasam@codeaurora.com>
 <1638547658-22032-10-git-send-email-srivasam@codeaurora.com>
 <1638574455.248037.1043006.nullmailer@robh.at.kernel.org>
 <CAL_JsqKf4Y84+_PQqhwMEEiJNrR92urMUYSqYTEU0_c7fYnyhQ@mail.gmail.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
Message-ID: <c817ec06-6423-7408-8064-dfc4a867a251@quicinc.com>
Date:   Fri, 3 Dec 2021 15:40:38 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKf4Y84+_PQqhwMEEiJNrR92urMUYSqYTEU0_c7fYnyhQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/2021 3:38 PM, Rob Herring wrote:
> On Fri, Dec 3, 2021 at 5:34 PM Rob Herring <robh@kernel.org> wrote:
>>
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
>>
>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>
>> yamllint warnings/errors:
>>
>> dtschema/dtc warnings/errors:
>> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.example.dt.yaml: lpass@62d80000: reg: [[0, 1658351616, 0, 425984], [0, 1659895808, 0, 167936]] is too short
>>          From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
> 
> Are you running the checks before you send out your patches. Because
> it seems like you keep sending things with the same errors.
> 
> If there's errors, I'm not going to review this. If you need help
> getting it to work, then ask.
> 
> And what's with your email setup? codeaurora.com bounces.

codeaurora.com is definitely a wrong domain. It should be codeaurora.org 
instead.

> 
> Rob
> 
