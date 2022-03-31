Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AF34ED3FA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 08:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiCaGf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 02:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiCaGfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 02:35:53 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB74F1EA0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 23:34:06 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id c10so27554315ejs.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 23:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=c4SmVHsDkudYEyg9IrI8RgsuOT8JSF8xcW5md7xT/Ok=;
        b=ENXGltYC898VuIdpCOFU4AS0J3uxxgmclSA09v8DooceuwBa8oCfEbvMLy+Sh5cObS
         6mZZ0FsD2Ykf/PC/hUbJTVAL/QuojkKWcx+d2g5AGJCto6JjGVhNi3IoIwJiYCCGspUN
         w9+CJ9Imc5wP71XoTIy1XObq2B9J+XAS+bCprS0NWJscD8WKVLX013o/tyqYuG7cIrkd
         TTc/QhT/paqCaA2pu1AMxuOfTW3vfxwheMl3bYEU4HF1F2cUKPU20cPNrc9D/+tEjisS
         jabT3Yf+HXwrjQoFNCNn28Fi1ID8iUN1zRC0A7QmWmLJYB1HBtuy9VBlll2+Kf2bgGzH
         p7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=c4SmVHsDkudYEyg9IrI8RgsuOT8JSF8xcW5md7xT/Ok=;
        b=IAhO2prdF1J+yJqtFHLHK2CJvAhfA9VtG2ZAcXA1JWVxdoi+FBOWbXxVmVHUgZsacP
         Zob3JT92hBEcOxJ0tlMoUb5E5DliYLWOWSEDxmnMgznPL5K0CVUGPX4sMYgy5RqCvAQv
         ZU7jZ2lO0eLz//st7Nvc3G2hQ13yoVtm74Mt862tCJZ+fyly9zBMX1wEn+UWA4MXVLJl
         HLD17kOGT25CRODfH5VWhtW8ZZYdIjvPS7Mi6E/QopKwb7btw6fSoFCbYgDQfKPrWaeu
         OjKddb05F1iDqipGHSSmwRJl+pBoMfEwJXk7KhrdvuI8otER9BdFbKrAzUxbTP6Xb2z1
         dHZA==
X-Gm-Message-State: AOAM533U5sAf94ZjFxndcQATXRs9ICwq0oK1a/CsXLBq69qCe75WiPp8
        yYW4pap0KJTR1hhlmEZ6i1QSjA==
X-Google-Smtp-Source: ABdhPJw1hxcxfGo1o86WWmnvS53cQHn9OtNW7zDdd6anzYYBfUrPR2Ackm2vrlixW2tE2YBXYCgXdg==
X-Received: by 2002:a17:907:6d8f:b0:6e0:1512:913b with SMTP id sb15-20020a1709076d8f00b006e01512913bmr3744666ejc.491.1648708445076;
        Wed, 30 Mar 2022 23:34:05 -0700 (PDT)
Received: from [192.168.0.165] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id r3-20020aa7cb83000000b0041b573e2654sm2622587edt.94.2022.03.30.23.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 23:34:04 -0700 (PDT)
Message-ID: <cbe5c963-c727-0fe6-6e03-039c4334f7a9@linaro.org>
Date:   Thu, 31 Mar 2022 08:34:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/3] dt-bindings: clock: add binding for MA35D1 clock
 controller
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jacky Huang <ychuang3@nuvoton.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, sboyd@kernel.org, krzk+dt@kernel.org,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org, cfli0@nuvoton.com
References: <20220331024256.14762-1-ychuang3@nuvoton.com>
 <20220331024256.14762-2-ychuang3@nuvoton.com>
 <866c6b42-434d-e7db-5319-2256cd7003d7@linaro.org>
In-Reply-To: <866c6b42-434d-e7db-5319-2256cd7003d7@linaro.org>
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

On 31/03/2022 08:29, Krzysztof Kozlowski wrote:
> On 31/03/2022 04:42, Jacky Huang wrote:
>> Add the dt-bindings header for Nuvoton MA35D1, that gets shared
>> between the clock controller and clock references in the dts.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>>  .../dt-bindings/clock/nuvoton,ma35d1-clk.h    | 262 ++++++++++++++++++
>>  1 file changed, 262 insertions(+)
>>  create mode 100644 include/dt-bindings/clock/nuvoton,ma35d1-clk.h
>>
>> diff --git a/include/dt-bindings/clock/nuvoton,ma35d1-clk.h b/include/dt-bindings/clock/nuvoton,ma35d1-clk.h
>> new file mode 100644
>> index 000000000000..3634e5edcac5
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/nuvoton,ma35d1-clk.h
>> @@ -0,0 +1,262 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
> 
> Can you make it the same license as bindings?
> 
>> +/*
>> + * Copyright (c) 2022 Nuvoton Technology Corporation.
>> + */
>> +
>> +#ifndef __DT_BINDINGS_MA35D1_CLK_H
>> +#define __DT_BINDINGS_MA35D1_CLK_H
>> +
>> +/* Clock Sources */
>> +/* External and Internal oscillator clocks */
>> +#define	HXT		0
> 
> One space after '#define'. Please do not introduce some non-Linux coding
> style.

You also ignored my comments from your v1 (because this is not v1...).
Do not resend without discussion or implementation.

Best regards,
Krzysztof
