Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FA652EE11
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 16:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350253AbiETOYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 10:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350231AbiETOYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 10:24:38 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680F8169E0B
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:24:35 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y32so14600777lfa.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 07:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8qK1C/fXcj1Bx31GwrbgIHQcHFBncp+gQ5Gc0QhkCVs=;
        b=XX0K4MWrxSFsvmT0HwgfuHMG+PL/FDHT2earFmJZKpu92EmvkETnV90r/whOD+/lL/
         nGVWqi/eYsZYX2P8CBT16ewGnaf+AMkQk/1oQm2tdWIH3Fe4KXAWxkkSUCiTSqomOoCK
         WmDEeN67QmThoa9r3L66RSklPVtI/Ja/zILbnI/URnPDcTYIEPEVpyxBW48RUS+xTHnr
         C1ZCvj2Mr3gvzekOMt6lDvaxKe3SgWMSMxhcqKjm3V7jipK6Ktbo5JKqe60kmm3Vhs6E
         SMCGwv7oQ92A5Q2QjLfxfBwIeIvz6D0LWbSY26f2rZmldPZ31ChLWmA+T2EJGcDpyekH
         z5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8qK1C/fXcj1Bx31GwrbgIHQcHFBncp+gQ5Gc0QhkCVs=;
        b=KqceOeP5S1qmPB914+M2rrFXNT8OFA/d1ggqLbfYg8ai97tMm3xYNcfzQGQv0p0yDr
         vPVQ/0j80l4IA+Rp72R6FzErGSECAvO7nW7ZM0PsiK/mE5/It0DnpKsfmVYVMKrFBOqB
         1o5ShLLJCd1PMPMTYAXVQErw1S+yG8WvpdEBa3Keki0KXs98bE6O0lGQKXPyq+N68rEk
         0SH5ERSXt2DGpaGhbYhAIWosgahHIYqqsFGMJxsT3tV1rrFylJztXpAG9YBUbQwnugJt
         J2lb4340Sm+OH2p8VhIWTLRLG3W0wmIB4X2PGmG5/BKhW6c959AGq7aVE7DR9Pf9xYyj
         xWpw==
X-Gm-Message-State: AOAM5326m/W2DcI3f3VlPve/j6qUJupMtSIh8ibLu/Br+RblIeLGoKVF
        vqIA9aWargc+ZrrKY1Zq5b/E7kSazUz3C/W0
X-Google-Smtp-Source: ABdhPJwwrJPm4H3reVCsciJsAq6hR9ACJ31onH+YD27Kg88MIvoXnWyGyYu+ftDUc43IRAua/VsZiA==
X-Received: by 2002:a05:6512:110d:b0:473:d519:5764 with SMTP id l13-20020a056512110d00b00473d5195764mr7385296lfg.128.1653056673730;
        Fri, 20 May 2022 07:24:33 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o25-20020a056512051900b0047255d2117asm678537lfb.169.2022.05.20.07.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 07:24:33 -0700 (PDT)
Message-ID: <b9487ffe-7ed5-077c-3c2c-886746457365@linaro.org>
Date:   Fri, 20 May 2022 16:24:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/5] dt-bindings: interconnect: Add Qualcomm SM6350 NoC
 support
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220520070318.48521-1-luca.weiss@fairphone.com>
 <20220520070318.48521-3-luca.weiss@fairphone.com>
 <7b451dfb-8353-4a4e-1834-a01feaa267d2@linaro.org>
 <CK4KPEWM9165.2LR9ZUG2GGK6Q@otso>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CK4KPEWM9165.2LR9ZUG2GGK6Q@otso>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2022 14:04, Luca Weiss wrote:
> Hi Krzysztof,
> 
> Thanks for the review!
> 
> On Fri May 20, 2022 at 12:31 PM CEST, Krzysztof Kozlowski wrote:
>> On 20/05/2022 09:03, Luca Weiss wrote:
>>> Add bindings for Qualcomm SM6350 Network-On-Chip interconnect devices.
>>>
>>> As SM6350 has two pairs of NoCs sharing the same reg, allow this in the
>>> binding documentation, as was done for qcm2290.
>>>
>>> Because the main qcom,rpmh.yaml file is getting too complicated for our
>>> use cases, create a new qcom,rpmh-common.yaml and a separate
>>> qcom,sm6350-rpmh.yaml that defines our new bindings.
>>>
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>> ---
>>> Changes since v1:
>>> * Split sm6350 into separate yaml with new rpmh-common.yaml
>>>
>>>  .../interconnect/qcom,rpmh-common.yaml        |  41 +++++
>>>  .../interconnect/qcom,sm6350-rpmh.yaml        |  82 ++++++++++
>>>  .../dt-bindings/interconnect/qcom,sm6350.h    | 148 ++++++++++++++++++
>>>  3 files changed, 271 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,rpmh-common.yaml
>>>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm6350-rpmh.yaml
>>>  create mode 100644 include/dt-bindings/interconnect/qcom,sm6350.h
>>>
>>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh-common.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh-common.yaml
>>> new file mode 100644
>>> index 000000000000..6121eea3e87d
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh-common.yaml
>>> @@ -0,0 +1,41 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/interconnect/qcom,rpmh-common.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Qualcomm RPMh Network-On-Chip Interconnect
>>> +
>>> +maintainers:
>>> +  - Georgi Djakov <georgi.djakov@linaro.org>
>>> +  - Odelu Kukatla <okukatla@codeaurora.org>
>>
>> Is this valid email address?
> 
> Will put Georgi and Bjorn as maintainers, as per your other email.
> 
>>
>>> +
>>> +description: |
>>> +   RPMh interconnect providers support system bandwidth requirements through
>>> +   RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
>>> +   able to communicate with the BCM through the Resource State Coordinator (RSC)
>>> +   associated with each execution environment. Provider nodes must point to at
>>> +   least one RPMh device child node pertaining to their RSC and each provider
>>> +   can map to multiple RPMh resources.
>>> +
>>> +properties:
>>> +  '#interconnect-cells':
>>> +    enum: [ 1, 2 ]
>>
>> Why this is an enum?
> 
> As a start, just adding that the definitions are copied from
> qcom,rpmh.yaml so it's not my invention :) Of course that doesn't mean
> that it should be improved where possible!
> 
> Either value is supported by the driver (and used upstream). But perhaps
> it can use a description to define what the 'parameters' mean.
> 
> The second (optional) parameters "is to support different bandwidth
> configurations that are toggled by RPMh, depending on the power state of
> the CPU."[0]
> 
> A commit message for sc7180 calls it the "tag information" and "The
> consumers can specify the path tag as an additional argument to the
> endpoints."[1]
> 
> Not sure how to properly describe the first property, I guess the
> interconnect endpoint? Maybe Georgi can help here.
> 
> 
> [0] https://lore.kernel.org/linux-arm-msm/b079a211-d387-7958-bbe2-c41cac00d269@kernel.org/
> [1] https://git.kernel.org/torvalds/c/e23b122

Hm, indeed driver supports variable values. It's fine then.

> 
>>
>>> +
>>> +  qcom,bcm-voters:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>> +    items:
>>
>> Please implement my previous comments.
> 
> Sorry, I looked over the comment in v1.
> 
> As far as I can tell in current code only 1 item is used.
> 
> If the second parameter of_bcm_voter_get would be used as non-NULL then
> qcom,bcm-voter-names gets looked up and the N-th value in qcom,bcm-voters
> used. But currently qcom,bcm-voter-names is not actively used so only
> one gets used.
> 
> Do you have a recommendation what to put here? A synthetic limit like
> 32 just to have a number there?

Let's go with maxItems:1, for both fields.

> 
>>
>>> +      maxItems: 1
>>> +    description: |
>>
>> No need for |
> 
> ack
> 
>>
>>> +      List of phandles to qcom,bcm-voter nodes that are required by
>>> +      this interconnect to send RPMh commands.
>>> +
>>> +  qcom,bcm-voter-names:
>>
>> What names do you expect here?
> 
> Currently unused in mainline but newer downstream kernels[2] use "hlos"
> as first parameter, and e.g. "disp" as second one that goes to a
> qcom,bcm-voter that's a child of disp_rsc. Not sure exactly what that
> does.
> 
> [2] https://github.com/atomsand/android_kernel_qcom_devicetree/blob/a6d50810116e8314d64eb63b8862c207b974e0c7/qcom/waipio.dtsi#L1701-L1793

The bindings example uses apps and disp, so here would be only "apps".

>>> +
>>> +  '#interconnect-cells': true
>>
>> Since you defined it as enum in rpmh-common, you really expect here
>> different values?
> 
> Doesn't ": true" here just mean we want the value from the allOf: -
> $ref?
> But we could in theory make interconnect-cells only accept <2> for
> sm6350.

Yes, and the $ref defines it as [1, 2], so initially I thought this
should be narrowed. However it seems 1 or 2 are still valid for all of
Qcom interconnects, so your "true" is correct.


Best regards,
Krzysztof
