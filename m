Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DAB55CCB8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237317AbiF0O0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237312AbiF0O0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:26:32 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A351013F25
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:26:30 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n1so13295872wrg.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ErDQFXWdYs2zULfkFMONKNeCe/Dj1t+LSS/N2wVv994=;
        b=w0dvdBO/UupcFBr03m7tcptBHVgqV2TEN0CQY1a6OGskByAIoXaRhP13MhIaPE30YA
         E5LZ0INJyUKJyz4Sd+TUyuv1TrLhbX5NrgvRa+wnde/7JDnBLei8PeDXe1kPa1MMvW4f
         oSZk7L8ftqsfsUsEDCFou6UEv+uJN78lLeeyOlWzK87sFjCNCSG/QR16koVGo85joDyD
         bbEjYulHyedUDdmcSC+5JkQYYiLB/wqkl4mlGRg0T3IPeYUeIRi7aWDjEIN+p42lBRcB
         WoCzbxruL3iszTMBFbNLlKu31d/6d7tGTrWKjlJpdodJEaKOllYoz5xy9a6blKJfHjOk
         Dmlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ErDQFXWdYs2zULfkFMONKNeCe/Dj1t+LSS/N2wVv994=;
        b=CaFLwwBU6kHHr1QtSWgaUbjS1Pg2M1StF3OSUdsHaPJkX3crfSg6ZrddylPmZyjXjF
         OB4LY93wPBMHKIXSY0LKbjeoDpbi7p6HMuJDi8RHtyyh8aswFxptmidfM7ZISDvnL7c7
         7JNTTs1bvZqwZZpRYWCXNfxxhA/BIm7ic9b3NRsv2XHjTYEkbRbTlz9Y9TyUcJVWPb/a
         ZZYmujB5HBwkVKx43nxtGcjgP3liThEY2YZ30BnNDsidYK7LqW8iD0iInxwkLPxgFrs5
         gCadBtQDzPFrACmFrwRs76VyHG2Uoa1X0cdna7bH5V7p56eacQJByyncc2PcRlOUCcMZ
         +/Ug==
X-Gm-Message-State: AJIora9Cb2EVWWLI7UH++pCY20jCbvAqRXHdME22ogLA6nw3ZakI6wkG
        jyYxjQFOrg89eGNWsXJreRG9/g==
X-Google-Smtp-Source: AGRyM1sMb750QwH5Pp1X9ererXrUAT1rhhISnkjarGTROXCA7GWXOOkLoYMhrHh5S6yLFHJfSwQZqA==
X-Received: by 2002:a5d:598c:0:b0:218:3fe6:40bd with SMTP id n12-20020a5d598c000000b002183fe640bdmr13514630wri.373.1656339989229;
        Mon, 27 Jun 2022 07:26:29 -0700 (PDT)
Received: from [192.168.0.251] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id t18-20020a1c7712000000b0039749b01ea7sm16226662wmi.32.2022.06.27.07.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 07:26:28 -0700 (PDT)
Message-ID: <53066f1e-0a0f-de98-571d-759c7be5c835@linaro.org>
Date:   Mon, 27 Jun 2022 16:26:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 04/12] dt-bindings: arm: qcom: add missing QCS404 board
 compatibles
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220521164550.91115-1-krzysztof.kozlowski@linaro.org>
 <20220521164550.91115-4-krzysztof.kozlowski@linaro.org>
 <CAL_JsqKXDs=QHKob2Xy6vAFZfnkM9ggfmqf9TNA1hv8TScTmgQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAL_JsqKXDs=QHKob2Xy6vAFZfnkM9ggfmqf9TNA1hv8TScTmgQ@mail.gmail.com>
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

On 27/06/2022 15:41, Rob Herring wrote:
> On Sat, May 21, 2022 at 10:46 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> Document board compatibles already present in Linux kernel.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/arm/qcom.yaml | 8 ++++++++
>>  1 file changed, 8 insertions(+)
> 
> This is now failing in linux-next:
> 
> /builds/robherring/linux-dt/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.example.dtb:
> /: compatible: 'oneOf' conditional failed, one must be fixed:
>  ['qcom,qcs404'] is too short
>  'qcom,qcs404' is not one of ['qcom,apq8016-sbc']
> ...
>  'qcom,qcs404' is not one of ['qcom,sm8450-hdk', 'qcom,sm8450-qrd']
>  From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/arm/qcom.yaml

I'll fix it.

Best regards,
Krzysztof
