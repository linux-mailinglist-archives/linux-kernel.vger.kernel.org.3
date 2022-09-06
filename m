Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677D05AE34B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 10:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239494AbiIFInD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 04:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbiIFImc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:42:32 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC8578216;
        Tue,  6 Sep 2022 01:38:52 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id s11so14129824edd.13;
        Tue, 06 Sep 2022 01:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=7aKcWrHN0iy5lXqS6WWR60dmN/jKxbkqMcVmWFyZOLI=;
        b=cDuUtI7zVTHj675gi9AY7ykpUUvRcTJd8av+hapb1tW/ieoFruFNFltdwC2epnpHi9
         Dx2eQg86oLemuVU+I+p2fRyXfTZsQTbV2uSTrBLdNVRdLNA/dMw1C1SCeGpKqI2iop9v
         vnoHhLsgptMUa6WYb0A7O8tS6DQvYw3KK+opl4x9ABOSQrSFrtTdDkVSs/yNpXawo0M9
         wefnuU7QAI9bkBGsDXl4yJW/moWdUezMOBIbHX7UBcC4KuUhT6K1VPZpnjvWNk1IAQXv
         SRFrvNKztVPJQmyElsZ3p5SRsjiolqN7jf6CcyJaUFLzIBggKs6kok9a0ZP3r4LAaWkg
         A8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=7aKcWrHN0iy5lXqS6WWR60dmN/jKxbkqMcVmWFyZOLI=;
        b=saG59GXTFexjfvYoyjxyH4sJZg8nPSxAO3l4DEcFAWlwezafd7uQfdYYcDjqIwacpY
         oKlIKlvDPhK3wc0LVgDE8Tzku9fJVFxXJDymAR1QzI8aFRXUPaFP7O1HfVMV0fXwXh+D
         d7GBosVQWXJSJ//XgDTwQr2HR7PCoEf+HPHunmUCZWAHdnhI/5FDMxm/Sx76eUonDjov
         7XV4LL517BZJYvT02MBXzyOfRlIWq70+vLj7KbqtOq7LTybCyVjJZ3GkOp5uIOru/3Fl
         IaJ/ZnG1Rto10cAxNowvCkPkjgZZpoO5AqZdLWGvOhA+UQSqGjgFT9mxqIKhdNI7vpCZ
         ubKQ==
X-Gm-Message-State: ACgBeo3WrkaSc/puzYZRwwJtmL/6kUEHME2FZJVpTmfW98NLHGiOMc8O
        9LQYPqb15Jucc59hfyDKbH8=
X-Google-Smtp-Source: AA6agR59/EsDw+4IIUjpBCdyYu05A7w7PVNvttbU27dBMXxkQJLsZm9LX/0Y0hoNNKfHdXaLMRsXVg==
X-Received: by 2002:aa7:c506:0:b0:44e:6abd:1fb8 with SMTP id o6-20020aa7c506000000b0044e6abd1fb8mr8841675edq.308.1662453530666;
        Tue, 06 Sep 2022 01:38:50 -0700 (PDT)
Received: from [192.168.74.101] ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id b23-20020a170906039700b00715a02874acsm6228600eja.35.2022.09.06.01.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 01:38:50 -0700 (PDT)
Message-ID: <4fe6c7ea-38e6-2a6e-fa78-29664f819aca@gmail.com>
Date:   Tue, 6 Sep 2022 11:38:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/9] dt-bindings: ufs: qcom: Add sm6115 binding
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
References: <20220903174150.3566935-1-iskren.chernev@gmail.com>
 <20220903174150.3566935-2-iskren.chernev@gmail.com>
 <14abb0cd-4f65-030e-5479-bf1487979624@linaro.org>
From:   Iskren Chernev <iskren.chernev@gmail.com>
In-Reply-To: <14abb0cd-4f65-030e-5479-bf1487979624@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/6/22 11:29, Krzysztof Kozlowski wrote:
> On 03/09/2022 19:41, Iskren Chernev wrote:
>> Add SM6115 UFS to DT schema.
>>
>> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
>> ---
>>  .../devicetree/bindings/ufs/qcom,ufs.yaml     | 26 +++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
>> index f2d6298d926c..be55a5dfc68f 100644
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
> This still is not naming and order of sdm845.

Yes, this will come in v3. v2 was released before we finished discussing this issue.

>> +            - const: ref_clk
>> +            - const: tx_lane0_sync_clk
>> +            - const: rx_lane0_sync_clk
> 
> Best regards,
> Krzysztof
