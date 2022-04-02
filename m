Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9FD4EFFFD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 11:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354024AbiDBJLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 05:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244053AbiDBJLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 05:11:32 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC5A532DA
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 02:09:40 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id c10so10311719ejs.13
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 02:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=kd0NXB1Zpr99nwzhwykwjlZXPnel4cWxpQfKUpkCMHk=;
        b=IPrXv9vJtuIqqczOLMSmbtbpxKLQMRqoHRQqRTjVRFt4XO+cn+jGv3A0ddYp/tq7gY
         Zg7teYhVeEfjJ8csVKtGys1Y6/lrBvrxsdVaGEio7GpsGA26NvKIok57F6Ww8nbIHQye
         rXmxl63yx1oW+DKpT22urlehfD/nbAMpo9LvOn1G6icNPf2NIzuPi1KPPEaHk5bXYQ2L
         yfj9ZgvUPumDQ7S7kDptsISup59+tDCEC99Hw/VHbN6fEhZp+NoZ6CIxy1fjYa9XekPR
         serYvl4TidGxyJu9quyVUhjNX3aQyNJjetX9Z2KkDWVzjwvoeVb0n+VdPnbOPkm+mK4A
         0aQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kd0NXB1Zpr99nwzhwykwjlZXPnel4cWxpQfKUpkCMHk=;
        b=4TgWSM3QLbwtTOzakR1MrQmQFg9E83PJYmPvi04WgjMWS20lkDwVCEjhENqgoXAUgn
         nzaef2OnbrkaaYU5bmDP6ICxsxRn1LAQ2if9LAbbRF3NCr7pORu9dIS9gH5v2LEMmz6F
         6cdlJQi2MZ6EP9tpLglD40PfdyquXU8DZhc4gTCAsXAg8Pt/CGK68TcG/7Zpa0sQZ6fK
         YcEJ2q4FyqNdhLWdUekL/fsPh/S3iui5S4eSiIJvk6jqnYvX8X8fB0L1ValMVdiaMKon
         TFrgn32cl8PfFBlrzrkMoLOsVOZS612jDwZmeEiZHHqQ6etoRoBwd/cxz6Gbt5IlxQUR
         H0NQ==
X-Gm-Message-State: AOAM531IjaJz4b3l8UXlaG9shWV80RPQIQft9mwN/o0kJGtv7n0jAO0t
        nAEMFg05rvD0YRi9iBkG6ORDzg==
X-Google-Smtp-Source: ABdhPJwqleeVWzZcqz6QlP7/awNnzIZNAP/RE/+/3JTo9Oc/kx/lPCi9SIvYHyQ5AoA0h5pDpTMV4w==
X-Received: by 2002:a17:907:3e16:b0:6df:b4f0:5cc2 with SMTP id hp22-20020a1709073e1600b006dfb4f05cc2mr3180696ejc.285.1648890579004;
        Sat, 02 Apr 2022 02:09:39 -0700 (PDT)
Received: from [192.168.0.170] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id o12-20020a50c90c000000b0041907e62024sm2192677edh.85.2022.04.02.02.09.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 02:09:38 -0700 (PDT)
Message-ID: <c93bdf12-bf53-9277-0394-5eaeea081183@linaro.org>
Date:   Sat, 2 Apr 2022 11:09:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 1/4] dt-bindings: clock: qcom,gcc-sdm845: add parent
 power domain
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Bean Huo <beanhuo@micron.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Taniya Das <tdas@codeaurora.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20220401145820.1003826-1-krzysztof.kozlowski@linaro.org>
 <20220401145820.1003826-2-krzysztof.kozlowski@linaro.org>
 <20220401232451.1B7A9C340F3@smtp.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220401232451.1B7A9C340F3@smtp.kernel.org>
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

On 02/04/2022 01:24, Stephen Boyd wrote:
> Quoting Krzysztof Kozlowski (2022-04-01 07:58:17)
>> Allow Qualcomm GCC to register its parent power domain (e.g. RPMHPD) to
>> properly pass performance state from children.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml
>> index d902f137ab17..5fe1b2c42d5a 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml
>> @@ -43,6 +43,9 @@ properties:
>>    '#reset-cells':
>>      const: 1
>>  
>> +  powert-domains:
> 
> s/powert/power/

Thanks. This actually points to the fact I did not test this bindings
change :(

Best regards,
Krzysztof
