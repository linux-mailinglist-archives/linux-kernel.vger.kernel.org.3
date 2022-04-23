Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE58850CD21
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 21:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbiDWTDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 15:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235009AbiDWTDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 15:03:01 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721411C6C83
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 12:00:03 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id i27so22229499ejd.9
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 12:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+uwEn9PtiETP9hgJxDCM35viHAdrK5gZduRTsOTAbfA=;
        b=t3ztxLhsW2gnmub5Y4m4fXss2kLlqV08GB4ts6ipTgAnlJNPgGHmDA4kzeoP+j/YdL
         0l8gQlmc3o2ZQRIb12Yaq1jFUF9TPYv3O9Tnn6xaK/elxbjflNJIrMIjohy/9p1zz05o
         pqaShbNZEnRtF3OjJUGmS8usqgpjyqBXwS3y/60ZwqH4lD0dhe63Nk/jjJT8eqTDZA28
         4K4/1tlT6OCpBRGPg3iUVKb9TPN2/QSn7R5gnkZba4IHo8L7PiAJdWOCVRseWOwuP5Sg
         MIpZ5YAdvu96ZoeDPzYHptBdkd5OgP1beY0xoZlqJIM0myu4ZKalJx7CDnKNKJ0hR3YB
         O1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+uwEn9PtiETP9hgJxDCM35viHAdrK5gZduRTsOTAbfA=;
        b=IKt8Jewet6tZlxbiaRm9dvC+tuLtO1LZFabq9RixpddroQ251/5yX/1aHIiS3pUr08
         n9nj8MR/ww8EDufqUYSS7xJIxf3jve9JyxcM5XnTRlZ1T+93/+Zid76NbUkrFJQgtAI9
         ZmVb6i0KTeMU1os/fgdpYqfxSx1P+f8zYqSq/yyNPmO/QNEmuevaRe7J3YrPH0P7rNv9
         TUeDnWb3AsU36S2TwAOFLKr72Ut9vTGQpBmp+V8z/rjYbKhviCjPcSYi/J3xe62fNqHl
         VDLebphtRU0AHHO0vCRhCGUAu5dbkKwOY4WsN/Mx5kWb0t1N/9IVjgYvlxp3hgI4kfOE
         jP6g==
X-Gm-Message-State: AOAM5309GKUfEF1bBOYKymSj9tkV7QXzZhDIwKC0FYlLOjmSJv9P2w6r
        atEu8k1cS+UuY92s4rgPWyfpdA==
X-Google-Smtp-Source: ABdhPJzgajugMKK45hYI0FNGUcmQU06VbSYanQu9uAbA9fu3U6zoOBMMbv9JDVvo58GRODX9a0Uqag==
X-Received: by 2002:a17:907:970b:b0:6f0:103c:f7fa with SMTP id jg11-20020a170907970b00b006f0103cf7famr9283163ejc.171.1650740402064;
        Sat, 23 Apr 2022 12:00:02 -0700 (PDT)
Received: from [192.168.0.234] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bf11-20020a0564021a4b00b00423e997a3ccsm2472862edb.19.2022.04.23.12.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Apr 2022 12:00:01 -0700 (PDT)
Message-ID: <1d2c5505-f412-5993-ca60-51e65242aa1e@linaro.org>
Date:   Sat, 23 Apr 2022 21:00:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: fsl: convert fsl,layerscape-scfg to YAML
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220421153115.3496834-1-michael@walle.cc>
 <fb8c2c57-38bf-065f-a781-beb2fb89353e@linaro.org>
 <9c8c910e62b6b8a674ee0f2c752b6479@walle.cc>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9c8c910e62b6b8a674ee0f2c752b6479@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/2022 16:05, Michael Walle wrote:
> Am 2022-04-23 12:17, schrieb Krzysztof Kozlowski:
> 
>>> +patternProperties:
>>> +  "^interrupt-controller@[a-z0-9]+$":
>>> +    $ref: /schemas/interrupt-controller.yaml#
>>
>> Do you have a specific FSL schema (bindings) for the child?
> 
> Mh, indeed there is the following binding which I didn't notice
> earlier
> Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
> 
> So I guess it has to be converted before this schema?

That would be awesome! :) Skipping the conversion is not a blocker, but
it is easy later to forget to update the reference.


Best regards,
Krzysztof
