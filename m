Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2D158F8C3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 10:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbiHKIFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 04:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbiHKIFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:05:05 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0193389CC0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:05:04 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f20so24486072lfc.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=AWObm1t2SGsfX+EOzuUn4SeYctPOHns23Pie8FOr12w=;
        b=blQsdmvcfi8aabm0W+4Bgxbof6mNYs6NonqMhJPZ1aVJaqcsFhXMdZFZDyiII01Fhf
         x9SHadRxyjNFE6LHkQukeYi/PX+T/LeY29ukbibda1AWyUU0JolhqKes7iKm6crF8upp
         PjVSelSX7gWdWVdY0E/fsOGQZv12TmTl0F0n04rlQS7j160OcGljnSOY0O6hsfmWLYNU
         erUQklKIcGEFmbm9uSYCv7VuYJBAX7vbCUJzTehyFcxuXxX4lfsmNtLHHZwkqSDtoRU4
         bFh+tOND5apR5OsJm2vyhaqZz8bRcXZMncjdCXcWwNp59SYUWZFKcpRUCvltmUjvXpVx
         jqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=AWObm1t2SGsfX+EOzuUn4SeYctPOHns23Pie8FOr12w=;
        b=WuFXIh4liwUqcvNQ+U9K9l6O3uE/HmV0GMJo0fUFEOuDac05zyzfojXbJ14nQo/oGk
         VN8wQPAs4HHRPVkSCtT/Ht/+JUAbvZ5GnZRqrE0HminVMBxmr66H9iiteIGSLxCGb9sf
         RksFxf7kIpUvsz/N935tjaLS8/Ws3nSYPQi+VuUNKBuYeIgU8iC4ilzur88KGfRfzP1e
         QnukzLvUteXGo1Z6lcQXaMwz+WxYxTmZn6JfvkxLrg+2JLIgHKu0WOQg74aRMByFUDu7
         QZW890yDoQ8zNc1qDdvfjtycD0wCfXtrxnhpuf8G6H1XQCoL9SmTHp/VdgTx1TFOftDW
         0VHw==
X-Gm-Message-State: ACgBeo1qpa2RlSXds6HAyuj8SCTbfDmXoMayL8cgCgXLt0kqd/jWdH9m
        +Ydczgk6CIx0hQWxeeH2aVcegw==
X-Google-Smtp-Source: AA6agR7A6T7SL1WDl9JlKh+6jE8mNB65VeBjyl40+g28JZzZxZZVG575FetC+Nlr08Mgmdi51/8NDQ==
X-Received: by 2002:a05:6512:c13:b0:48b:3b30:637d with SMTP id z19-20020a0565120c1300b0048b3b30637dmr9499019lfu.447.1660205100855;
        Thu, 11 Aug 2022 01:05:00 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id y8-20020a2e95c8000000b0025d47a29734sm721935ljh.47.2022.08.11.01.04.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 01:05:00 -0700 (PDT)
Message-ID: <74afb676-4a85-7a8e-f7ea-20d8a0967d7d@linaro.org>
Date:   Thu, 11 Aug 2022 11:04:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/3] dt-bindings: display/msm: Add binding for SC8280XP
 MDSS
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220811040121.3775613-1-bjorn.andersson@linaro.org>
 <20220811040121.3775613-2-bjorn.andersson@linaro.org>
 <db9b74f9-1f65-5b88-1c81-0a3fd6dcf9a6@linaro.org>
In-Reply-To: <db9b74f9-1f65-5b88-1c81-0a3fd6dcf9a6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2022 10:56, Krzysztof Kozlowski wrote:
> On 11/08/2022 07:01, Bjorn Andersson wrote:
>> Add binding for the display subsystem and display processing unit in the
>> Qualcomm SC8280XP platform.
>>
>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> ---
>>  .../bindings/display/msm/dpu-sc8280xp.yaml    | 284 ++++++++++++++++++
>>  1 file changed, 284 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/display/msm/dpu-sc8280xp.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/display/msm/dpu-sc8280xp.yaml b/Documentation/devicetree/bindings/display/msm/dpu-sc8280xp.yaml
>> new file mode 100644
>> index 000000000000..6c25943e639c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/msm/dpu-sc8280xp.yaml
> 
> qcom prefix is needed (also when file is in msm subdir)
> 
> The file name should be based on compatible, so "qcom,sc8280xp-mdss.yaml"
> 
>> @@ -0,0 +1,284 @@
>> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/msm/dpu-sc8280xp.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Display Processing Unit for SC8280XP
>> +
>> +maintainers:
>> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
>> +
>> +description:
>> +  Device tree bindings for MSM Mobile Display Subsystem (MDSS) that encapsulates
>> +  sub-blocks like DPU display controller, DSI and DP interfaces etc. Device tree
>> +  bindings of MDSS and DPU are mentioned for SC8280XP.
> 
> s/Device tree bindings//
> so just:
> 
> SC8280XP MSM Mobile Display Subsystem (MDSS) that encapsulates
> sub-blocks like DPU display controller, DSI and DP interfaces etc.
> 
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,sc8280xp-mdss
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  reg-names:
>> +    const: mdss
> 
> You do not need reg names for one item, especially if the name is kind
> of obvious... unless you re-use existing driver which needs it? Then
> maybe let's change the driver to take first element?

OK, I see the driver expects this. It seems it is legacy from
87729e2a7871 ("drm/msm: unify MDSS drivers") times. So it could be
changed to grab first element always (older MDSS with three reg items
still has mdss_phys at first item).

> 
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: Display AHB clock from gcc
>> +      - description: Display AHB clock from dispcc
>> +      - description: Display core clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: iface
>> +      - const: ahb
>> +      - const: core
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  interrupt-controller: true
>> +
>> +  "#address-cells": true
>> +
>> +  "#size-cells": true
> 
> I see other DPU bindings also specify both as "true". Why not a fixed
> number (const)?
> 
>> +
>> +  "#interrupt-cells":
>> +    const: 1
>> +
>> +  iommus:
>> +    items:
>> +      - description: Phandle to apps_smmu node with SID mask for Hard-Fail port0
>> +
>> +  ranges: true
>> +
>> +  interconnects:
>> +    minItems: 2
> 
> No need for minItems in such case.
> 
>> +    maxItems: 2
>> +
>> +  interconnect-names:
>> +    items:
>> +      - const: mdp0-mem
>> +      - const: mdp1-mem
>> +
>> +  resets:
>> +    items:
>> +      - description: MDSS_CORE reset
>> +
>> +patternProperties:
>> +  "^display-controller@[0-9a-f]+$":
>> +    type: object
>> +    description: Node containing the properties of DPU.
> 
> additionalProperties:false on this level
> 
> which will point to missing properties (e.g. opp-table)

I'll fix existing bindings which have similar issue.


Best regards,
Krzysztof
