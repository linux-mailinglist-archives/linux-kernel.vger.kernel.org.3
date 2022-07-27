Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97E4582466
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 12:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiG0Kcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 06:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiG0Kcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:32:50 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE6743E4C;
        Wed, 27 Jul 2022 03:32:49 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ss3so30605017ejc.11;
        Wed, 27 Jul 2022 03:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=E/qzjVJN5WWKHgFz90joUQZKX1gH8+X44tnHcaaleRE=;
        b=RptdFzJcpvUIKx1+aWtXT+nUxk3D/CeadIyslqlrStwbzgnpeDhIIYo7kMn5RW1RNZ
         Lss8dmOMV4KPF91dyaHV3FABhVmNY/oSojPyziOhOIIV+qYZv6kV6rXGmJRDxO/VrSTz
         ripzNTie/9B5pCCfV+LUrnZw3gzCqtVEdd76OuvRZVSMv2Dzv73mabDYzqjNly4c+j99
         rE1l37B8bbsgScMCwIEWMvxBS5xPkjf0Sv0XOuxs+4nG7OTgCoD5Y3OR30vsQ36Zima3
         rfztm9WnWz5zp54eu7cfO2DaXCJoy4oZiENv7NwESpIfpUpUg4Hj3nJ5FeJ67BDO1vis
         SNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=E/qzjVJN5WWKHgFz90joUQZKX1gH8+X44tnHcaaleRE=;
        b=mYMM9+t18zg6Uw78jRYeT9G6dUYPPWdgAUl/cxRTZIwttpGHvqrgf26o+BY19EdRKO
         3O0HrfvqBB8QLaRIJPWnN06Rn9366hrGUFrigg/ipEzN+zTR7LHXGLBqvbkg2v8NtxOt
         ohdNg9toX+LRD2OI4Oxa0rmg4Nvzd/imSLi2UkeSzE/4y+MLzkmq4d24zazLlUnqW0yp
         DOh+Ns5bbqHCPVcqQuZwd/hCpPT/sdl133O1EvBRhTyhekDxCfWh9EMhN1vgifwLK5OY
         dh8OGkSX3iW00c2WA7uwOY0YLrvF0yiG0XqGmV0LkPg5TTnh18bklsQonGgJ99BkkuAe
         CXbA==
X-Gm-Message-State: AJIora/Nsy0sQdLXdbx1Dbzq+vyiCK4C2HUWrVzRDNlHXlf92P6AyZ7Y
        02wmSfQMrJ9Y7Yf0IUVJAIkHSCYDfG1cI8Go
X-Google-Smtp-Source: AGRyM1vR9quAcWCfkXjA/aLvO1r/ui2cWaTwBIhM8Iv3YIvvoVrH88WzTJ14z7buMJJoNybKZqjb5Q==
X-Received: by 2002:a17:906:29d:b0:6f0:18d8:7be0 with SMTP id 29-20020a170906029d00b006f018d87be0mr16330478ejf.561.1658917967712;
        Wed, 27 Jul 2022 03:32:47 -0700 (PDT)
Received: from [192.168.74.101] ([77.78.38.236])
        by smtp.gmail.com with ESMTPSA id d12-20020a50fe8c000000b0043a554818afsm9996918edt.42.2022.07.27.03.32.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 03:32:46 -0700 (PDT)
Message-ID: <73a82790-52c4-b777-b4ff-f8d361f0bd29@gmail.com>
Date:   Wed, 27 Jul 2022 13:32:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/5] dt-bindings: regulator: Document the PM6125 RPM
 regulators
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20220726181133.3262695-1-iskren.chernev@gmail.com>
 <20220726181133.3262695-3-iskren.chernev@gmail.com>
 <7e742415-d93f-83d9-bf01-6f023a4d1a34@linaro.org>
From:   Iskren Chernev <iskren.chernev@gmail.com>
In-Reply-To: <7e742415-d93f-83d9-bf01-6f023a4d1a34@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/27/22 10:26, Krzysztof Kozlowski wrote:
> On 26/07/2022 20:11, Iskren Chernev wrote:
>> Document the pm6125 compatible string and available regulators in the QCom SMD
>> RPM regulator documentation.
>>
>> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
>> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
>
> Unusual SoB chain here as well.

Will fix.

>> ---
>>  .../devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
>> index c233461cc980..1122a3a17f56 100644
>> --- a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
>> +++ b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
>> @@ -57,6 +57,9 @@ description:
>>
>>    For pm660l s1, s2, s3, s5, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, bob
>>
>> +  For pm6125 s1, s2, s3, s4, s5, s6, s7, s8, l1, l2, l3, l5, l6, l7, l8, l9,
>> +  l10, l22, l12, l13, l14, l15, l16, l17, l18, l19, l20, l21, l22, l23, l24
>> +
>>    For pma8084, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, l1, l2, l3,
>>    l4, l5, l6, l7, l8, l9, l10, l11, l12, l13, l14, l15, l16, l17, l18, l19,
>>    l20, l21, l22, l23, l24, l25, l26, l27, lvs1, lvs2, lvs3, lvs4, 5vs1
>> @@ -90,6 +93,7 @@ properties:
>>        - qcom,rpm-pm8998-regulators
>>        - qcom,rpm-pm660-regulators
>>        - qcom,rpm-pm660l-regulators
>> +      - qcom,rpm-pm6125-regulators
>
> Put new entry in alphabetical order.

Will sort first (they are currently not sorted), then add pm6125. Should I also
sort the driver code?

> Best regards,
> Krzysztof
