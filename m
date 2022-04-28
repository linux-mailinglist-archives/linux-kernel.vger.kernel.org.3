Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B495C513169
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242453AbiD1KnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241899AbiD1KnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:43:04 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506BE6A07C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:39:49 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id g6so8718253ejw.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XreYXHdj5GUywvUvOHNYSnATh/KLGPy94j+XuPVD3j0=;
        b=m1zjC7wTi82Snz5yieUbOWn6q7W6bAD55dY92ttNzYSN71T9BY+yUKEX0pc3yB0FDQ
         fSjLscTFq0VVNtOFPL4vXbdEL62VAhMd5RaWa9I0/+ryolv8NZxUavHpEg+qTeNReFVZ
         GSJDzTlj+fdyuftuiAcA1vE8XzwYYBsYGOQ5+SS4BgsUF9ki4Vo2g2a9x6lyxboHHilr
         FQzEviln03feIbHXx0HnThw1vO8x7VC5zYZQ0oqJwTrUXPXMHY1SuMGx/3mdC4stkYUy
         CH/G55wSttWL2i0tLAc090LKt1WD9mUdVYufZf4hZrdT+VD7qlQ/IeBZqdRYCg9m0mep
         TrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XreYXHdj5GUywvUvOHNYSnATh/KLGPy94j+XuPVD3j0=;
        b=QqIpnYMnEGt5h8H1HQLqr20SUAblOwWfBFO9LHD+ZJTYnBxlyIaPuAzPPZpOm6334T
         d8AcLzr5jsXO/zGIM5ADkS+Rcyv9HMu6oxlqBffpurS9VzqHSoKEcYSu8Itw3WGgTOQ1
         HhLQ7hPKTUUwMKaYfYcoL/6FnQiWMb3U3BpH0p82cvbfwkB6TRcP5aw63wz4Z5XJGHe0
         TwgbAU3TtpqS9HzYnF2upOniXlOrjTPZtfEiopTXR5lTbhQlklomvLu3hPeLHgeOvKpg
         KwNo7wIJebk8/XHm28QkJPhVTfbcnxmevzBhA3092suZ2MJ73kcR00g6xDtOfQlRzAhu
         XKIw==
X-Gm-Message-State: AOAM533okpOnW3q7/PtfDdqQ3XLIFFGfWUygS3bD3/pg1/tM+IsPQ8SZ
        cTo0gnnU8wG2x+HWty3LTprIUw==
X-Google-Smtp-Source: ABdhPJzEDwDg3E7Df6+q43rZTTLIdab+VvuqKnSKT5KDytDtKNiUEFPn2HwJWhSfCB6p3tbQ+j71Zg==
X-Received: by 2002:a17:907:d20:b0:6f3:be6a:ece8 with SMTP id gn32-20020a1709070d2000b006f3be6aece8mr9819968ejc.503.1651142387803;
        Thu, 28 Apr 2022 03:39:47 -0700 (PDT)
Received: from [192.168.0.33] (cpc78119-cwma10-2-0-cust590.7-3.cable.virginm.net. [81.96.50.79])
        by smtp.gmail.com with ESMTPSA id y13-20020aa7cccd000000b0042617ba639asm1341057edt.36.2022.04.28.03.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Apr 2022 03:39:46 -0700 (PDT)
Message-ID: <4e25e146-d57a-7df7-1b97-e63eb7431a1b@linaro.org>
Date:   Thu, 28 Apr 2022 11:39:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 6/6] dt-bindings: power: supply: qcom,pmi8998-charger: add
 bindings for smb2 driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
References: <20220427184031.2569442-1-caleb.connolly@linaro.org>
 <20220427184031.2569442-7-caleb.connolly@linaro.org>
 <192d76cd-1d4c-c11a-874e-543e86cd7b64@linaro.org>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <192d76cd-1d4c-c11a-874e-543e86cd7b64@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/04/2022 07:49, Krzysztof Kozlowski wrote:
> On 27/04/2022 20:40, Caleb Connolly wrote:
>> Add devicetree bindings for the Qualcomm PMI8998/PM660 SMB2 charger
>> driver.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> 
> This should be a v2, because you already sent a patchset. You make it
> for example with:
Argh, thanks, I'll resend.
> 
> `git format-patch -6 -v2`
> 
> and add changelog to cover-letter (which actually you did...).
> 
>> ---
>>   .../power/supply/qcom,pmi8998-charger.yaml    | 83 +++++++++++++++++++
>>   1 file changed, 83 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
>> new file mode 100644
>> index 000000000000..41b471713364
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
>> @@ -0,0 +1,83 @@
>> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/power/supply/qcom,pmi8998-charger.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm PMI8998/PM660 Switch-Mode Battery Charger "2"
>> +
>> +maintainers:
>> +  - Caleb Connolly <caleb.connolly@linaro.org>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - qcom,pmi8998-charger
>> +      - qcom,pm660-charger
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    minItems: 4
>> +    maxItems: 4
> 
> No need for minItems if it is equal to max. Skip the minItems, please.
> 
> Best regards,
> Krzysztof

-- 
Kind Regards,
Caleb (they/he)
