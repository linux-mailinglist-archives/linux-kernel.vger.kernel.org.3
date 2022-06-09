Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC895450E0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344044AbiFIPcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343936AbiFIPb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:31:58 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106FD4CD71
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 08:31:56 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 25so31427746edw.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 08:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PeAB4WdUupDaLbzIqQrrnRA29amPQ8PYJd3E0QmEGsE=;
        b=EakJTslO6FLE81sHxNC1bk/UhJdyWwE3LaolAbYnM/XwG1uFz5Ko+NX7UNNu3tbcoN
         K4rcFigA5wVJgxMnlO7NLPQdS3C/ggA1Vn8OzBb8vvyKZFT1e8iQCHxDYA2eB8gQtft+
         7HzbxwQvQgZY6ae+bwehfzc7RnStB3PIBUZf7baw2dZU6u3EZKK9c5vh03InUK7PI/Xs
         PjArKEXUAAVAQfrkTYYW6QeCkqxbR+gH5Pemmw+ozW5iwl6YhpAMgD9p9LlKl6lrcgHH
         VT+W3GXIoaXr5Nc/REr/+pECZOjR0CqcLiiXkWlDSxBfAIMKAiL7Nj6L+FzleyxE5OcS
         rrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PeAB4WdUupDaLbzIqQrrnRA29amPQ8PYJd3E0QmEGsE=;
        b=vqJAi7OB9S6nfuL9d4vx3ieQLnFBYcdiY3unKlQ9y9SFax81w0v5m+RPkncHo4aU6c
         PnkIngvIJmdc1lr/nUbXntJEdWJPlqK0x0ARPaYWWN7Ww0GOdH00ZfM4H8luZHcN8vr6
         8WD67Ocez/cxev+J/JlF8yB/iQm7rLh0JeY+IORX1pYbKnZ/35bnFSwMIjWQq+Un82an
         Iwb/w0kda4N21Z8ekIAM0tVl3yBif8XurGaFsDKFxu8bDY78JS1gMe0XTLfEoxO2VTN/
         O0t9+VWMLfsNTAixgc4RYFqbeHHdDziTE4ulibri0QYy3JKz8sIqPFDo0TxgnWKaNpj/
         NQZQ==
X-Gm-Message-State: AOAM531olzagXi3DJAOfNENJ/0nYrT+OuOQeTiIOnE6atTONBEH68S/r
        X3+ekKZpsEMwwbfINf02tsdZIw==
X-Google-Smtp-Source: ABdhPJwOIiJjZlxWJ8Qllh5BIHfUY6pWFLHsCbCBYUYtWh67b6d6/Fy01aSRrec+f5WJFGHljJB2KQ==
X-Received: by 2002:a05:6402:2788:b0:431:3f86:1d4e with SMTP id b8-20020a056402278800b004313f861d4emr29911904ede.238.1654788714499;
        Thu, 09 Jun 2022 08:31:54 -0700 (PDT)
Received: from [192.168.0.199] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id f27-20020a17090624db00b006f3ef214dcdsm10940096ejb.51.2022.06.09.08.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 08:31:53 -0700 (PDT)
Message-ID: <6d460a14-5da3-19f8-c614-307c2e737c17@linaro.org>
Date:   Thu, 9 Jun 2022 17:31:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 04/48] dt-bindings: pinctrl: nuvoton,wpcm450-pinctrl:
 align key node name
Content-Language: en-US
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
 <20220609113911.380368-3-krzysztof.kozlowski@linaro.org>
 <YqIP1vYuLztSQR+n@latitude>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YqIP1vYuLztSQR+n@latitude>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2022 17:20, Jonathan Neuschäfer wrote:
> On Thu, Jun 09, 2022 at 01:39:06PM +0200, Krzysztof Kozlowski wrote:
>> gpio-keys schema requires keys to have more generic name.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../devicetree/bindings/pinctrl/nuvoton,wpcm450-pinctrl.yaml    | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/nuvoton,wpcm450-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/nuvoton,wpcm450-pinctrl.yaml
>> index 47a56b83a610..4c7691c38b10 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/nuvoton,wpcm450-pinctrl.yaml
>> +++ b/Documentation/devicetree/bindings/pinctrl/nuvoton,wpcm450-pinctrl.yaml
>> @@ -152,7 +152,7 @@ examples:
>>        pinctrl-names = "default";
>>        pinctrl-0 = <&pinctrl_uid>, <&pinmux_uid>;
>>  
>> -      uid {
>> +      switch-uid {
> 
> In this example, and more importantly the original copy in
> nuvoton-wpcm450-supermicro-x9sci-ln4f.dts, I think button-uid fits
> slightly better, because it's a momentary push button. (Still arguably a
> switch, but not one that would stay in both the on and off position.)

Sure, I'll change it to button-uid.

Thanks!


Best regards,
Krzysztof
