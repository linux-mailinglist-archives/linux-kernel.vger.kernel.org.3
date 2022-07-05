Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACE5566A58
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiGEL4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiGEL4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:56:36 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42241175B1
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 04:56:35 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id u14so14228573ljh.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 04:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Vsyz7Rlb53JTlbHvnnvdRFpkzvwYidG5knYyvTWU2J4=;
        b=J6Xn7PwhlmRL7Kr9Bf4WitjD0eaEp+S7R2w8kXZs6D9tSVlKBV8mGj12PFb/afjI7P
         JgcoIl3VgyhipdKeKvV1sIo5+Dks/B7z9qOLzwx7uFR0wEO04pZ53kK/hBAt4XGI6hME
         sMojGdcXlpLpIJ1OXj8XizfCfLxDv8ALSt4PfnGQOdCVRfoOcV1ThEpIx/Bs/7eTPbBY
         XpRIam2VUHXzNalRQvG3bOfx/+Im167jX2UDMIX1gFPSwtBIKB8IuZ4cG+KIA+jP6I4z
         BJ/M93qt1RiKaeG9C5vbSkTqiT/cguYMKFMl5q0AWvaWvhLpGOgEm1r24VnOzX9DNK1l
         3gdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Vsyz7Rlb53JTlbHvnnvdRFpkzvwYidG5knYyvTWU2J4=;
        b=fJuOLrSJHUHkC9zHlOZSRfhD39eWDuY6NmVNsa8T7tbv7/EbHfQ5URIyvhZzQ1iMvn
         fHjhgd4UPJLQ1e4dda9UMqiqVG6fZPBkOaziTD5oyuSEqpJ1uIkOupnYQUyTQ/KE7phZ
         tm2l8YdgpbSz1KHGhPTzm4ivwFsIABzdSK5G1KOyGhkVdZssI9/8elPNXpt2pUAyiG4F
         4toAzZjtISDERlEfY26kOyuP19W1AxrkyDkQVtfG7Q7f0hfmWBtLjDkl9p4HmqE5oNyV
         f96rjJfOPb+TH7ECPoAoXv6N38PZBP4ulzBaKiHci1jbiQ0GGR95Fo/OvnX4RQrGxzO8
         8NqQ==
X-Gm-Message-State: AJIora9UhSSFIN0HKSqyucv6keJDKVt704hwhj0WU3MSRjYGBb4+lErN
        rBFzu9r8g0bpVmRIetOHJ1yQQg==
X-Google-Smtp-Source: AGRyM1s8dtYMfQ0WmJojokE+mPEUDR+r4cp5dqxRDFw4fkhs4A6Iya7P4qMDZAfLM9Dp/WYdyBx2Ug==
X-Received: by 2002:a2e:90f:0:b0:25d:309e:422f with SMTP id 15-20020a2e090f000000b0025d309e422fmr2096329ljj.179.1657022193599;
        Tue, 05 Jul 2022 04:56:33 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id w16-20020a05651234d000b004815305854bsm2768554lfr.61.2022.07.05.04.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 04:56:33 -0700 (PDT)
Message-ID: <963917cf-0f9d-600f-564e-9e687270b1af@linaro.org>
Date:   Tue, 5 Jul 2022 13:56:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 17/43] dt-bindings: phy: qcom,qmp-pcie: add missing child
 node schema
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220705094239.17174-1-johan+linaro@kernel.org>
 <20220705094239.17174-18-johan+linaro@kernel.org>
 <4bc79a1c-66b1-225d-5026-ddf3e6f7d22c@linaro.org>
 <YsQlzr6nyvz761Kz@hovoldconsulting.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YsQlzr6nyvz761Kz@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2022 13:51, Johan Hovold wrote:
> On Tue, Jul 05, 2022 at 12:18:37PM +0200, Krzysztof Kozlowski wrote:
>> On 05/07/2022 11:42, Johan Hovold wrote:
>>> Add the missing the description of the PHY-provider child node which was
>>> ignored when converting to DT schema.
>>>
>>> Also fix up the incorrect description that claimed that one child node
>>> per lane was required.
>>>
>>> Fixes: ccf51c1cedfd ("dt-bindings: phy: qcom,qmp: Convert QMP PHY bindings to yaml")
>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>> ---
>>>  .../bindings/phy/qcom,qmp-pcie-phy.yaml       | 88 ++++++++++++++++++-
>>>  1 file changed, 85 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
>>> index ff1577f68a00..5a1ebf874559 100644
>>> --- a/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
>>> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-pcie-phy.yaml
>>> @@ -69,9 +69,37 @@ properties:
> 
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - qcom,sm8250-qmp-gen3x2-pcie-phy
>>> +              - qcom,sm8250-qmp-modem-pcie-phy
>>> +              - qcom,sm8450-qmp-gen4x2-pcie-phy
>>> +    then:
>>> +      patternProperties:
>>> +        "^phy@[0-9a-f]+$":
>>> +          properties:
>>> +            reg:
>>> +              items:
>>> +                - description: TX lane 1
>>> +                - description: RX lane 1
>>> +                - description: PCS
>>> +                - description: TX lane 2
>>> +                - description: RX lane 2
>>> +                - description: PCS_MISC
>>> +    else:
>>> +      patternProperties:
>>> +        "^phy@[0-9a-f]+$":
>>> +          properties:
>>> +            reg:
>>> +              minItems: 3
>>> +              maxItems: 4
>>> +              items:
>>> +                - description: TX
>>> +                - description: RX
>>> +                - description: PCS
>>> +                - description: PCS_MISC
>>> +      if:
>>
>> Do not include if within other if. Just split the entire section to its
>> own if:.
> 
> That sounds like it would just obfuscate the logic. The else clause
> specified 3-4 registers and the nested if determines which compatibles
> use which by further narrowing the range.
> 
> If you move it out to the else: this would be really hard understand and
> verify.

Every bindings are expected to do that way and most of them are doing
it: define broad constraints in properties:, then define strict
constraints per each variant. Easy to follow code. This binding is not
particularly special to make it different than other ones. Doing
semi-strict constraints in if: and then additional constrain in nested
if: is not easy to understand and verify.


Best regards,
Krzysztof
