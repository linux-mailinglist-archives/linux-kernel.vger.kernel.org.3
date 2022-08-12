Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE8C5915AE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 20:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239110AbiHLSxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 14:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238908AbiHLSxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 14:53:23 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A16625C56
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 11:53:21 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a9so2446908lfm.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 11:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=H2hFHauRZ+2L1/8Jn5Q0JcmOqrApxd8gqlCGFKCdAM4=;
        b=PBfBUmCCqcFOkJncUdtapjWauTPUiKTDxV8oZ1lYEW8xc3KN7Gru9WcRttJJrZKU1v
         puewIC/RAT4riMzrbYZNMmChbVUy0NVo4m3lT43eIzZTcMVjUMT0/X5alIayZosShy4a
         A2DBnUKi2Oa3ha/9X7/FiezFCFP3q9i/vcYoE/Mi3Y4AdJPYaYItnAvzdaooEn9rDIZN
         7pAj20HghfJsz2LY4CVKj1QhkKHqoUmLnisWbFU4dQIds7kZm8k1S6Yg29dGSpwT2wDf
         ivyfgtn7IX0vPdhw51VB0i1Mn8hENHdS9HJxKH7sP6kJG94PPgGibl4u+FRAAJc+Wg71
         YtFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=H2hFHauRZ+2L1/8Jn5Q0JcmOqrApxd8gqlCGFKCdAM4=;
        b=wj1jjYRUtgowDhGKvqgDY8xgmUvOvDEvZ1ObhWQVaKFYDdJUg87voFsdEPY+US4dSy
         Ko/rYOaZT7Ex0g3JRTMVfqrBtM2YYkpARLZZVj0B/sgLGAvZ4iP/11cfLWaObYsI/7Sx
         jBEB/2Q1DZdsVyRidINjhPFKJxCMVrzbSmq1cd6GFZfZCsjqV5sSIRuUzvt4MgG0MoAx
         cRvDw82eZ1zLdkEncTEb1LjMkUJLSmTpVl0PFBL145vYZrWruNLEbdePElpl9o7mJbLh
         tfPFIwmybGwhl9UfxjN0wa7oJ0M9ut/UHhjJky9eLKLxNlkBVANdNHc8GsUCyHgmhvXL
         i1uQ==
X-Gm-Message-State: ACgBeo2zonx+oCOxJuMCGEwhjeMVYV9pXZMYS9oatE+fBslqOGb03INl
        OAcvuYIL2QvubLzSwT+IAIxjyQ==
X-Google-Smtp-Source: AA6agR6ZIpyoLa852PCDDPN1ueyFqhPzbfJsN8zaQTOoB7GiCdBw7o8HRvVEUWrz3UjuDNBYcfEFlw==
X-Received: by 2002:ac2:4d18:0:b0:48b:4a2d:a378 with SMTP id r24-20020ac24d18000000b0048b4a2da378mr1611866lfi.304.1660330399661;
        Fri, 12 Aug 2022 11:53:19 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id u9-20020ac251c9000000b0048b003c4bf7sm298508lfm.169.2022.08.12.11.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 11:53:19 -0700 (PDT)
Message-ID: <f2a664be-71e9-7a26-2f0c-5f654d9cb3cb@linaro.org>
Date:   Fri, 12 Aug 2022 21:53:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: Add Richtek RT9471
 battery charger
Content-Language: en-US
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        =?UTF-8?B?5ri45a2Q6aao?= <alina_yu@richtek.com>,
        cy_huang <cy_huang@richtek.com>, alinayu829@gmail.com,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
References: <1660225318-4063-1-git-send-email-u0084500@gmail.com>
 <1660225318-4063-2-git-send-email-u0084500@gmail.com>
 <3cae9d60-4012-1dfd-abd9-4d0b9379e6bb@linaro.org>
 <CADiBU3_depGDZtiyizU3MB939A3oH1uTWzTMyruUy0z=u6BZkQ@mail.gmail.com>
 <40261b95-637a-1304-2e06-8c8ff7fc377b@linaro.org>
 <CADiBU38+9sR1r20=YWt-9s2+u7maHH+1VudCnV1-0+F4jYKdQQ@mail.gmail.com>
 <CADiBU3_Jt6n6tm=oVvjk5vsoEAneH7t-37S6skepA6v6bVVYUw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CADiBU3_Jt6n6tm=oVvjk5vsoEAneH7t-37S6skepA6v6bVVYUw@mail.gmail.com>
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

On 12/08/2022 19:05, ChiYuan Huang wrote:
>> It's the same usage like as TI charger.
>>>>
>>>> For charger driver, does it mean legacy IRQ handler is more preferred?
>>>
>>> Who is the consumer of these interrupts? Can you show the DTS with the
>>> interrupt consumer?
>>>
> Sorry, I forget to reply this question.
> Some battery driver may need to know the 'full', 'recharge' , 'ieoc' status.
> The usage will  be like as below
> 
> battery {
>   interrupts-extended = <&rt9471_chg 2 0>, <&rt9471_chg 3 0>, &(rt9471_chg 5 0>;
>   interrupt-names = "chg-done", "chg-recharge", "chg-ieoc";
> };
> 
> Some gauge HW needs this information to enhance the battery capacity accuracy.

Other supply stack pieces do it via supplies (supplied to/from in
include/linux/power_supply.h) and reporting power_supply_changed().

With such explanation, your device is an interrupt source, but it is not
an interrupt controller. If your device is interrupt controller, it
means someone routes the interrupt line to your device. Physical line.

Best regards,
Krzysztof
