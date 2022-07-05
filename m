Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F277C56765F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiGESZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiGESZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:25:17 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0DE18E2D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 11:25:16 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id z21so21912292lfb.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 11:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WC7DHh08NOM7Xz+nZkjbiyv/DEw8liELUQbZaa8HLjE=;
        b=vjU+We/YTlDF63Nrshk2+b5uc+KMGxK0LoEiIoz0UYfxzYbQPdkc2I1KNm1DW+9UpO
         LwJmagFXBi8HAXdWxklSqAUSB8s3sg2wW4gecyywKeoBSvVwN6xZb0wD/AgRgZ//RjPS
         fveApMmPsQ6BlNdOgjCNCEV58CpilE0sxIUAcIyWVzPbyKbeheZvsAYfJjsCB10m9jNI
         7GBAC+dQu2e6ZP7SbCulrsX73hNUwzHgj7LQIWibFKnnBPkExKMN49XOhDogyUfOVaJE
         e/lWrKejlyENdivxOFqNBjtOoFAxg5ZKX8eJlKhfoLVtX8O64ns7UZXdkWsF0KO8YyR1
         fvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WC7DHh08NOM7Xz+nZkjbiyv/DEw8liELUQbZaa8HLjE=;
        b=jYa1Mr2VoDJ6WxatfEQzab/Z7V7z4ITLPmEtWL6oP9pW6eYgfGhblX+/LudIZuT5PP
         eMw7bNxt5PDcAHT9XKK4gE/cR9qhXEUSxqHIBfZit4op0+LQQE9uQ3laAHJifjVAgV3k
         qK8V+PXY7hlC9eMjBtlgAllEFYKFe97aByAMFQaHIvRKP0tiURoiPZC5ZHYp62dKt07Y
         BF2IBh5uf40IBEhspFvx/Fe79VTKs203khfNI/ws9t7dtiUOoUrDomAmm8oKUGX9kSkH
         Tiz2qiwZsWf92EEvPnGhPo/C+YmQJ+e6BJ/ESWlc1wY/efl5dk68xJeW9g1ttKAS++f2
         +Rpw==
X-Gm-Message-State: AJIora/2JclX+/RM3IJpAeE1SthvjIsSclEEYpy3kSEfAQe2+u995Kkz
        sJQfVP0gkaYcL/76EYnqTzhoIw==
X-Google-Smtp-Source: AGRyM1vP9s82lHwnRo9zWX+lPinh7vzvThh+FhjFI99M+KzoTKgmZKLFd6MsDpjAkMTUuX2rGTD8xA==
X-Received: by 2002:ac2:4e03:0:b0:485:74c4:97ce with SMTP id e3-20020ac24e03000000b0048574c497cemr310361lfr.13.1657045515094;
        Tue, 05 Jul 2022 11:25:15 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id z3-20020a056512308300b0047255d210d6sm5814972lfd.5.2022.07.05.11.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 11:25:14 -0700 (PDT)
Message-ID: <f856824a-111c-6cb2-19e5-683f419322ac@linaro.org>
Date:   Tue, 5 Jul 2022 20:25:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] ASoC: dt-bindings: qcom,sm8250: add SDM845 sound
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220705174702.763247-1-krzysztof.kozlowski@linaro.org>
 <YsSBFjW6riKOZZcz@gerhold.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YsSBFjW6riKOZZcz@gerhold.net>
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

On 05/07/2022 20:21, Stephan Gerhold wrote:

> [...]
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>> index 4ecd4080bb96..7cdf9e9f4dd3 100644
>> --- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>> +++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
>> @@ -18,6 +18,7 @@ properties:
>>      enum:
>>        - qcom,apq8016-sbc-sndcard
>>        - qcom,msm8916-qdsp6-sndcard
>> +      - qcom,sdm845-sndcard
>>        - qcom,sm8250-sndcard
>>        - qcom,qrb5165-rb5-sndcard
>>  
> 
> Looks like you forgot the db845c and lenovo compatible? :)
> 
> If you add them feel free to add my:
> Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

Argh, of course. Thanks.


Best regards,
Krzysztof
