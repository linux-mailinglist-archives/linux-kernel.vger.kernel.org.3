Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD800525E29
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378730AbiEMJB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 05:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378735AbiEMJBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 05:01:04 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2406C2F39E
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 02:01:00 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so4385086wmn.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 02:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=lRU0KcNE0a23vfPKTZTRFidSipfZvgZA2AvdCHUsUCQ=;
        b=UHUEMu6m/YYgTvqVnCaYzdnC9PFsK3950Ebdu8MmueWFBUVmxSTKxYWedRVF4YUGnV
         QQ+lzbsdYh8TDyYLXS2cldnW9jKCxeIfd6VFmAVz0pkqg59pZDbavwQOj8r9WhrPbelf
         9OopO3EdBKu8ZawPVeLrhLOsbxvEdXY/8DyIsVMlzsu9bkLOXDbqlHcbxKtwivVfKaDA
         1miew9iVHh7BehvoScGH4zzTYaXtv2CG+PnQiBMy6/LjXVojrA58e0OSFssRo+Vsn4RG
         YAPd5tc3tM3D648CTGvBPzDbbo64w/ZM0wE4ZTdyKsYuzlxc++5DonMqw+kMktEFwJYj
         Dm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=lRU0KcNE0a23vfPKTZTRFidSipfZvgZA2AvdCHUsUCQ=;
        b=E3Y5ezYPr+tOYoiBYgVNMI0sSBRkSHoZrXy9q6yRSo7ZiSxySGmnU+DtrF1DwhT1DP
         BLMW5VWq2KNM45KI/UvgtW/JYTaNtFzI7wqgei7llocYTCZdln0c+GWj2QGnn8uyrY+i
         bxFWOm38Aai+TF0b4y2/FGIEkR+1CA+O9MzFHb0QkIh3SiGTNJMS2vGUkdm7GkYk/1IN
         VtQl90ipFErVHdDSumtZhMDDaePe8o7OOkSkH1CIUZ8ip8kvs+MkxPmjEAN8qOu+v6vm
         FKSaDYJAfCKt/hkqgCIE6c8j609+GsPuHvTk9jRHRKSQ5gIPNKEeQLhgptPj7dEUa6Vg
         G8XA==
X-Gm-Message-State: AOAM532tPy7CKgrnBmkxNkH62IMwQFX2nvXQ64gA+3NCRyH6kEJUvUpI
        r5/V2eJGQcrA4OQvKSETpyisTA==
X-Google-Smtp-Source: ABdhPJziNEAcPdLbmvFdxJ3jD2a2GdpSTyBsHkbyz2V3JF3SiM9UZWNoRNY6y9zaDL35ZJRJt41LDA==
X-Received: by 2002:a05:600c:ad2:b0:394:22e1:ebcf with SMTP id c18-20020a05600c0ad200b0039422e1ebcfmr13991066wmr.181.1652432458722;
        Fri, 13 May 2022 02:00:58 -0700 (PDT)
Received: from [192.168.0.169] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id m18-20020adfa3d2000000b0020c5253d8ffsm1560932wrb.75.2022.05.13.02.00.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 02:00:58 -0700 (PDT)
Message-ID: <48d96a4e-ce1b-03a1-1831-36555efd7080@linaro.org>
Date:   Fri, 13 May 2022 11:00:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/3] dt-bindings: arm: qcom: Add sc7180 Chromebook board
 bindings
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220512090429.1.I9804fcd5d6c8552ab25f598dd7a3ea71b15b55f0@changeid>
 <828bc65f-e585-0fe7-c038-c750861c9446@linaro.org>
In-Reply-To: <828bc65f-e585-0fe7-c038-c750861c9446@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/05/2022 09:57, Krzysztof Kozlowski wrote:
> On 12/05/2022 18:04, Douglas Anderson wrote:
>> This copy-pastes compatibles from sc7180-based boards from the device
>> trees to the yaml file so that `make dtbs_check` will be happy.
>>
>> NOTES:
>> - I make no attempt to try to share an "item" for all sc7180 based
>>   Chromebooks. Because of the revision matching scheme used by the
>>   Chromebook bootloader, at times we need a different number of
>>   revisions listed.
>> - Some of the odd entries in here (like google,homestar-rev23 or the
>>   fact that "Google Lazor Limozeen without Touchscreen" changed from
>>   sku5 to sku6) are not typos but simply reflect reality.
>> - Many revisions of boards here never actually went to consumers, but
>>   they are still in use within various companies that were involved in
>>   Chromebook development. Since Chromebooks are developed with an
>>   "upstream first" methodology, having these revisions supported with
>>   upstream Linux is important. Making it easy for Chromebooks to be
>>   developed with an "upstream first" methodology is valuable to the
>>   upstream community because it improves the quality of upstream and
>>   gets Chromebooks supported with vanilla upstream faster.
>>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> ---
>>
>>  .../devicetree/bindings/arm/qcom.yaml         | 180 ++++++++++++++++++
>>  1 file changed, 180 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
>> index 5c06d1bfc046..399be67eb5d2 100644
>> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
>> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
>> @@ -214,11 +214,191 @@ properties:
>>                - qcom,ipq8074-hk10-c2
>>            - const: qcom,ipq8074
>>  
>> +      # Qualcomm Technologies, Inc. SC7180 IDP
>>        - items:
>>            - enum:
>>                - qcom,sc7180-idp
>>            - const: qcom,sc7180
>>  
>> +      # Google CoachZ (rev1 - 2)
>> +      - items:
>> +          - const: google,coachz-rev1
>> +          - const: google,coachz-rev2
> 
> The inverted pattern of old revision being compatible with the new one,
> is done on purpose? You claim here every rev1 is always compatible with
> rev2 ...
> 
> I don't think we discussed such patterns in previous talk. I quickly
> went through it and there were only skuX moving around, not rev1 being
> newer then rev2.

BTW, your other Chromebooks use logical order:

https://lore.kernel.org/all/20220512205602.158273-2-nfraprado@collabora.com/




Best regards,
Krzysztof
