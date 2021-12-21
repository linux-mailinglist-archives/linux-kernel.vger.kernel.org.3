Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8050B47C9D2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 00:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238095AbhLUXl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 18:41:57 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:49322 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237103AbhLUXl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 18:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640130116; x=1671666116;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YrEk2U8/c5RaE74NICYhYBvJowu6EP7iBBBHKsBbex8=;
  b=rR6gL87TPHYK0C46KFn4y99T5FDxYbsM0f3zAir7xGabUxxeBQex6cz1
   dOUDvf0hnpeA6kFgL/xnulVau0lboTunLTGymyTIELiVrPt/dNl6b0/Or
   5jJR5XJEkyPHg5mXyrod3IBiozTsT+/L2pV1nOUmar7tVf54q0UwwEKPv
   8=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 21 Dec 2021 15:41:55 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 15:41:40 -0800
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 21 Dec 2021 15:41:40 -0800
Received: from [10.231.205.174] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 21 Dec
 2021 15:41:37 -0800
Message-ID: <517655ce-e4b2-809d-3244-25ab25128b65@quicinc.com>
Date:   Wed, 22 Dec 2021 07:41:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 11/11] dt-bindings: convert qcom,spmi-pmic-arb binding
 to YAML format
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <devicetree@vger.kernel.org>, <collinsd@codeaurora.org>,
        <linux-kernel@vger.kernel.org>, Andy Gross <agross@kernel.org>,
        "Subbaraman Narayanamurthy" <quic_subbaram@quicinc.com>,
        <subbaram@codeaurora.org>, <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <maz@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <tglx@linutronix.de>
References: <1640071211-31462-1-git-send-email-quic_fenglinw@quicinc.com>
 <1640071211-31462-12-git-send-email-quic_fenglinw@quicinc.com>
 <1640085064.276534.1014103.nullmailer@robh.at.kernel.org>
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <1640085064.276534.1014103.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/12/21 19:11, Rob Herring wrote:
> On Tue, 21 Dec 2021 15:20:09 +0800, Fenglin Wu wrote:
>> Convert the SPMI PMIC arbiter documentation to JSON/yaml.
>>
>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
>> ---
>>   .../bindings/spmi/qcom,spmi-pmic-arb.txt           |  67 ----------
>>   .../bindings/spmi/qcom,spmi-pmic-arb.yaml          | 146 +++++++++++++++++++++
>>   2 files changed, 146 insertions(+), 67 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
>>   create mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
>>
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.example.dt.yaml: spmi@fc4cf000: reg: [[4232900608, 4096], [4232884224, 4096], [4232880128, 4096]] is too long
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spmi/spmi.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.example.dt.yaml: spmi@fc4cf000: reg: [[4232900608, 4096], [4232884224, 4096], [4232880128, 4096]] is too long
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
I re-based the change on the tip of spmi-next project which has this 
change included:
https://lore.kernel.org/all/20211119034613.32489-2-james.lo@mediatek.com/
With it, the constraint should be removed and this warning/error won't 
be seen.
> doc reference errors (make refcheckdocs):
> Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt: Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
>
> See https://patchwork.ozlabs.org/patch/1571409
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
