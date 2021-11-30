Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0C44628DB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 01:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhK3AKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 19:10:04 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:2926 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbhK3AKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 19:10:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638230804; x=1669766804;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Bw03o32uUdu6ZhNX68gM0vPW2K0EquUybwNztSvmq5s=;
  b=dQvXMlir8U58gCgt0xRZFm5ca+idxTtP75atC7pFlAXW64dad/ce07M0
   8VFZ25BV611uHhBq2/JoWYrn7ekmtwf++IxLc/nYpH9/l2AS1eCZXTAs7
   tPvYls+lg9JWp0XWb1cnOldqEOHUKv3Yy4L+yKt+kq4E+MH8sikK4Mb4K
   I=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 29 Nov 2021 16:06:44 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 16:06:43 -0800
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 29 Nov 2021 16:06:43 -0800
Received: from [10.231.205.174] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 29 Nov
 2021 16:06:40 -0800
Message-ID: <2a735bf2-8f7a-b09f-1c9b-85d850b3a8c4@quicinc.com>
Date:   Tue, 30 Nov 2021 08:06:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 10/10] dt-bindings: convert qcom,spmi-pmic-arb binding
 to YAML format
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <sboyd@kernel.org>,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Andy Gross <agross@kernel.org>, <collinsd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, <subbaram@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-kernel@vger.kernel.org>
References: <1638174137-23290-1-git-send-email-quic_fenglinw@quicinc.com>
 <1638174137-23290-11-git-send-email-quic_fenglinw@quicinc.com>
 <1638199831.114024.123611.nullmailer@robh.at.kernel.org>
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <1638199831.114024.123611.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/11/29 23:30, Rob Herring wrote:
> On Mon, 29 Nov 2021 16:22:17 +0800, Fenglin Wu wrote:
>> Convert the SPMI PMIC arbiter documentation to JSON/yaml. While at it,
>> update SPMI bus "reg" items constraint for SPMI PMIC arbiter to carry
>> it and update it with a smaller range.
>>
>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
>> ---
>>   .../bindings/spmi/qcom,spmi-pmic-arb.txt           |  67 -----------
>>   .../bindings/spmi/qcom,spmi-pmic-arb.yaml          | 128 +++++++++++++++++++++
>>   Documentation/devicetree/bindings/spmi/spmi.yaml   |   3 +-
>>   3 files changed, 130 insertions(+), 68 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
>>   create mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
>>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml:37:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> ./Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml:41:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
I will fix the indentation warning in next patch. I double checked this
at my side but it's curious that it didn't show up at my side even I have
installed yamllint and also upgraded dtschema to the latest.
> dtschema/dtc warnings/errors:
>
> doc reference errors (make refcheckdocs):
> Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt: Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
>
> See https://patchwork.ozlabs.org/patch/1561055
>
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.
>
