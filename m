Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFE551D20E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 09:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389472AbiEFHTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389458AbiEFHT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:19:27 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C6D2E080
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:15:43 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bv19so12759052ejb.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 May 2022 00:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7g9JO/Ybw9irKMb1RLnb7HIkga3Dv3dwhtzTDOGzIqI=;
        b=eunXz/jJ22emEnm9j1ZKkdizjud+RpDosbQw03+WYs/zT4ezzVjJmgyCbF8K9QaChP
         q8/4A2wtC96OPJuvFDq0ersh77V8L5R7gM8k9azwtSHn9JPcjCrjzAk2LCGO31OT0Z4y
         PDXCBm/w/BVDih3HHieKmt5so84yoEw1kx2v8SPLu5VEcOlN24qhcFTBh8yKXbVyLbEU
         PHxv4bAg77gVeDU1RA7bToXYfmRdd5RulyxGNCBTn6FmIVG5hiGX33DHA+Zs3JWDzR/L
         T6u9XL4pozWRZXW264WrXSVsdHqjp2f7kku5ow7B1eQTp3JJB7TbIIAVpJMtfbnKFXcJ
         LIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7g9JO/Ybw9irKMb1RLnb7HIkga3Dv3dwhtzTDOGzIqI=;
        b=Zxzmg/ey9paUceCCTnR7Z5DnDz3spb06Xb6Ty51f3Ipldy3kBokSmObGYQAid48S+i
         WbwTFS85nGeFfpCk4LRDfQ5lK0OEsxfgFJotHoiVBJbMPdBCb3MGowdGOcsLE2sF+W+k
         jrEQZ0qqtHwcH5a4Uc5djeyPMd0HQ8H5WnocybiE6hZiLxIN4WIGdkOifdUUQzlCoJq3
         46aZRItUbhTCe/Y54GN2wM2ocLWHtMm6i+k4Ad0Q6QVr2p+ZxEyDRoOpEsxtkAIW9/MX
         UP58OUldJIwNxaiY8QCY24Jp4SfsGRVjz5mSsY+wvAtr1xPRid8ms2uT03gEsjK3AwBN
         ap2g==
X-Gm-Message-State: AOAM531fmV/FyA5fjq+7J9z6iN3acf3Of10SQFl2CFntWcVYee074ouN
        TYsXfmcW/GTfzq9+QjSlDpinqA==
X-Google-Smtp-Source: ABdhPJxgd3hK/qt9qIuLszkmZtLv2HjclvaSrS1ez9rOxs8wZ1arV9Hioosh6sfq5Fg2Oc7d0T6qxA==
X-Received: by 2002:a17:907:6e8b:b0:6f4:7147:a6ac with SMTP id sh11-20020a1709076e8b00b006f47147a6acmr1782778ejc.187.1651821342232;
        Fri, 06 May 2022 00:15:42 -0700 (PDT)
Received: from [192.168.0.223] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id qz24-20020a170907681800b006f3ef214de6sm1605225ejc.76.2022.05.06.00.15.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 May 2022 00:15:41 -0700 (PDT)
Message-ID: <7c4b51a9-6340-ef27-708d-2ad96830edcb@linaro.org>
Date:   Fri, 6 May 2022 09:15:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v14 6/9] dt-bindings: interrupt-controller: Add bindings
 for SP7021 interrupt controller
Content-Language: en-US
To:     =?UTF-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "maz@kernel.org" <maz@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
References: <cover.1651805790.git.qinjian@cqplus1.com>
 <56fb5e9a35a901f15d8e9721385c7e916c181377.1651805790.git.qinjian@cqplus1.com>
 <550cd907-be2a-4e90-350c-fbc3bdc03728@linaro.org>
 <d4ec03ed722349dda9fa3357449ac612@cqplus1.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d4ec03ed722349dda9fa3357449ac612@cqplus1.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2022 09:01, qinjian[覃健] wrote:
>>> +title: Sunplus SP7021 SoC Interrupt Controller Device Tree Bindings
>>
>> Remove "Device Tree Bindings". This applies to all bindings patches, not
>> only to one.
>>
> 
> Did you means change
> "title: Sunplus SP7021 SoC Interrupt Controller Device Tree Bindings"
> to 
> "title: Sunplus SP7021 SoC Interrupt Controller"?

Yes, thank you.


Best regards,
Krzysztof
