Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F13258C307
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 07:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbiHHFsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 01:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiHHFsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 01:48:35 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A62E021
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 22:48:34 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id y23so8672287ljh.12
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 22:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TIrX4wWXL580Px5dbJvNkxZzeOiOFCFrMMchxJeQOuc=;
        b=mcCGdEJw9FZO09QjyXA3m+8wD3T/6Y89yKVLedeKOubWMRU/LPtKJd6fJ77dbRN+QR
         KHjjOAhWzkCbcK+GlhZw6dL7tBML5AF7lyxVO7+0HWrgI6j6nNZV+Nd2a8x3xoiY44nN
         JsdxiOXzGdvdmUCrA/hMeXqHADt5KWN1YKRFnCsPh0C4CId0lVa7+X986G1Cd4RU2I2k
         8D5GVvX92MomUdGIW+FGEH8WEXuPamwDXA81Hhr4kGWorLP0HxNZY99sEr2HAzpqLvNG
         OI1USvtYrmb9+anJ2GkQ3jsFNjbMs2jg5SYdVQj0lzLnn5EEkNTKmZF3TaoSerYrNPq8
         Tsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TIrX4wWXL580Px5dbJvNkxZzeOiOFCFrMMchxJeQOuc=;
        b=JPjfuohe8/DbSN7KsA0PBOWj5hNqRr8qNUz5qX03jtFHe8l92GfEEKXFdz7RhOU7Yc
         wi8zWOw7wKboYoI9c1MYuZ4noN24ED7a54OP8yw3bcLLFhzYb1tZZPH0ixxnaQXuoCK5
         RAAhuAa81isRtHS5zdvEJ5yAlNRSl2+EDmxp7lmNZ+419KvRwhuFMRGAFROxYpzF956U
         GwcZM91gb8/tRV85/Ndi/DjQFWn1SeYT5QZiCVqxi8UCMf/2b+t8Pa/HXFpzSX3Ole1a
         OyahGgS21TPuBhYH5+XB8iaVjmlI8L5uOYwP68idRtwUuDJWGiroosSg87sK8Gb0vRAI
         Rn8Q==
X-Gm-Message-State: ACgBeo3IfWt7IhXTimlej5FgjqSiapbJdZwKChnyPh+EiNyzKCelFn28
        hOOMXqTq4x7G4gnImIj4xVnbww==
X-Google-Smtp-Source: AA6agR4D73BAD0Z2IFCuLGIV7lIs9avpDSjJShxV5xwzLtAZ/p5aGAKVpEuPbZH4/3qaaedUJJFyIA==
X-Received: by 2002:a2e:9609:0:b0:25e:5937:300b with SMTP id v9-20020a2e9609000000b0025e5937300bmr5100502ljh.494.1659937713238;
        Sun, 07 Aug 2022 22:48:33 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id k11-20020ac24f0b000000b0048b969ab510sm807825lfr.27.2022.08.07.22.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 22:48:32 -0700 (PDT)
Message-ID: <1ab7b38d-e356-6cb8-f101-9499eb34e026@linaro.org>
Date:   Mon, 8 Aug 2022 07:48:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] dt-bindings: iio: gyroscope: bosch,bmg160: correct
 number of pins
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220805075503.16983-1-krzysztof.kozlowski@linaro.org>
 <20220806153221.1a90bd28@jic23-huawei>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220806153221.1a90bd28@jic23-huawei>
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

On 06/08/2022 16:32, Jonathan Cameron wrote:
> On Fri,  5 Aug 2022 09:55:03 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> BMG160 has two interrupt pins to which interrupts can be freely mapped.
>> Correct the schema to express such case and fix warnings like:
>>
>>   qcom/msm8916-alcatel-idol347.dtb: gyroscope@68: interrupts: [[97, 1], [98, 1]] is too long
>>
>> However the basic issue still persists - the interrupts should come in a
>> defined order.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> ---
>>
>> Changes since v1:
>> 1. Accept also INT2 as one interrupt (Jonathan).
> 
> This doesn't work. If we are going to support either interrupt, at the very least
> we need to require interrupt-names if the first one isn't INT1.  So your fix
> is right but not enough.
> 
> Driver may ignore interrupt-names for now (would be good to have a sanity check in driver
> though so the driver explicitly checks for INT2 and doesn't use the interrupt if
> it is INT2 - support for that being for a future 'feature' addition).
> 
> A hacky solution would be to require the first one to always be INT1 but that
> gives us no (backwards compatible) path forwards if someone does have a board
> where only INT2 is wired.
> 
> So minimum change I think will be to provide interrupt-names allowing any of
> INT1 (default if not specified)
> INT1, INT2
> INT2

This is exactly what my fix is doing. What else do you need?
interrupt-names is just a helper which anyway driver does not use, so
enforcing it now does not change much.


Best regards,
Krzysztof
