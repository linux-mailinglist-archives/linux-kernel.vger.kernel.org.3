Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035335ABFEA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 18:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiICQyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 12:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiICQyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 12:54:07 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD594D824;
        Sat,  3 Sep 2022 09:54:06 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id r4so6409748edi.8;
        Sat, 03 Sep 2022 09:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=enTjVccMI7zVJxhuIsvJAc9Bul3yVB/Yhn5bDIsujys=;
        b=CnyAR1K3WpZCSKDo4YMU/6iOxzD60cGy31+T68uwOkBjrGcaYVjwR6J9N/Sm2KOC6t
         PwFO+GwLrmQgxeLbtsonmsAo7aOO7GBz9NZUoZAHfLD1l6YO/CRhc4Phtf58rUvUjTZA
         ycN/W3QSWrk/vMhnBVFEQCinutN5eOK9Eb/zLUuKfQGCWU2rRpPEodCVr1Up4gWRGKVi
         r680azqk/n+LUbWxM4sha+RM4Z1iSj2T1lKo4nKHjc6yquhaxxAdu0r+JG8jhe7clqCn
         ENfAhU2WK2JWB3bd+v5itA+bmxjnpdQ/wifcuOZ5Snx0sfQ4c9StPE6SgFo0LOkhleEN
         cEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=enTjVccMI7zVJxhuIsvJAc9Bul3yVB/Yhn5bDIsujys=;
        b=0murk8D+4+1ziqvOSTDYeCrb1ZijWOkqZ50DRltsILpaoTsB7VpiEhSm0TUcwmK/IH
         AnsCcyhOQRYBLO8mPuwqZ9WFCGwikYEOu5dkj7QPS4zYny+i+c63Olv+Bqv/N7bhz5xR
         P00gfYA/WkUJ4ekuOd3OH57hnPXIjG1RwWpA+PbhP3vJQbvduAPzactSF5URgAQCzest
         C08mO9GvW14hAGWIWQykDd++kHVF7w+zJP14jjiEwABk2So0A/SHaxKyseAhxkev9rTX
         bCahVlw48/lg+x3NSH9X61bObwTs+57uTuXZngvaLbP81QnM4zkgxZmkwOmt5+kOe34m
         I8hg==
X-Gm-Message-State: ACgBeo0Tjzq9dC4qeDjaZFhr+QbSc0iqJC7dkGVIxoR5n7GaIv1CvMyi
        QiQI4s57cxZEcXpZKw4khY8=
X-Google-Smtp-Source: AA6agR4NVA71S/KhP2L4AL9mo6BsrulPaXeUD+9t3G89qnrWRa0H4cubVN/ks9rKnz95GQp8iHvmFQ==
X-Received: by 2002:a05:6402:2802:b0:43a:9098:55a0 with SMTP id h2-20020a056402280200b0043a909855a0mr37113428ede.179.1662224045019;
        Sat, 03 Sep 2022 09:54:05 -0700 (PDT)
Received: from [192.168.74.101] ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id y6-20020a170906070600b0073d70df6e56sm2684678ejb.138.2022.09.03.09.54.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Sep 2022 09:54:04 -0700 (PDT)
Message-ID: <89e6a200-d9af-7263-5e09-d7d824277a30@gmail.com>
Date:   Sat, 3 Sep 2022 19:54:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 08/14] dt-bindings: ufs: qcom: Add sm6115 binding
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220901072414.1923075-1-iskren.chernev@gmail.com>
 <20220901072414.1923075-9-iskren.chernev@gmail.com>
 <7804ffbe-4e27-d8bd-dbe2-75d1323da064@linaro.org>
From:   Iskren Chernev <iskren.chernev@gmail.com>
In-Reply-To: <7804ffbe-4e27-d8bd-dbe2-75d1323da064@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/1/22 19:11, Krzysztof Kozlowski wrote:
> On 01/09/2022 10:24, Iskren Chernev wrote:
>> Add SM6115 UFS to DT schema.
>>
>> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
>> ---
>>  .../devicetree/bindings/ufs/qcom,ufs.yaml     | 26 +++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>> index f2d6298d926c..7c5f6e2e6d4c 100644
>> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>> @@ -28,6 +28,7 @@ properties:
>>            - qcom,msm8998-ufshc
>>            - qcom,sc8280xp-ufshc
>>            - qcom,sdm845-ufshc
>> +          - qcom,sm6115-ufshc
>>            - qcom,sm6350-ufshc
>>            - qcom,sm8150-ufshc
>>            - qcom,sm8250-ufshc
>> @@ -178,6 +179,31 @@ allOf:
>>            minItems: 1
>>            maxItems: 1
>>
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,sm6115-ufshc
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 8
>> +          maxItems: 8
>> +        clock-names:
>> +          items:
>> +            - const: core_clk
>> +            - const: bus_aggr_clk
>> +            - const: iface_clk
>> +            - const: core_clk_unipro
>> +            - const: core_clk_ice
>
> Use existing name and put it in the same place as existing variant - sdm845:
> ice_core_clk

The only problem with sdm845 bindings is the presence of rx_lane1_sync_clk
clock. I'm guessing I could pass zeros there, because it shouldn't be used. Or
it could be moved to last property and then min/maxItems to guard, but that is
a change to something more-or-less immutable.

> Best regards,
> Krzysztof

Regards,
Iskren
