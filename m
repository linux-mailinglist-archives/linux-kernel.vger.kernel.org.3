Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0396F512046
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243221AbiD0Qkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242225AbiD0Qkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:40:35 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735C666AE7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:37:23 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id l18so4515394ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=J/YKQZJJA+ogT3/a4U1yoxjCA4/ZVLkuY10wH+/url8=;
        b=Rq0vUpX2noDFfwzl1T7aznlztl4rUv32V26rOZSrnHEUew+gr/+RppDXrUXOCCTJaS
         zVFbC04LvMH39ZviDMvJJg9XReaz2bTDvX08S8SIuAvjIW+cHu/sCkhFAZEZtAcDt0G+
         anr07GVzgWFwT0gmCtzza4H03UsEsXAJsby/DLoGMLa5/eF8koOLMTJi4yeeeBF9aYeH
         Pa3YD0Yf+hOOOaxww2YVyry98d7ZMNLRuHiznjposx9RjhwoZGJBItA/hN+V6PE4WFeP
         8AEcOTjmoDT54/cgpB+Q8utWh4kR3el/kgl6vPw2HMkkvfHQYKsyY/NMnyPBs4rQzuug
         UDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=J/YKQZJJA+ogT3/a4U1yoxjCA4/ZVLkuY10wH+/url8=;
        b=4qYiMvpvESRZcyST9kDpM2tGbhnRFbnP1KUZOz3OVXzg2UMVn6Lwdp0Uq8udI8mvNv
         t7vVD6PyB+YMmZN77r0amxowTb+427wRP/UdWlXVfZMgRmGYpiRVG+6xtV5kRJzN0zuN
         7c7XqSHQRjqjzOaS1TK/y1kiJCh4BBn3jKMXwn4ZxAFVOEVAy4lQNh3srWA5ACRC4tCK
         6sxB9PiXHts/aw7WM/TfQ5cQHfLVbKmRsfczMSrAhRME2337II6/49Rg+JQhVPdY8P/W
         mkwmVoZ9jRlQqolICbW7pHXihmT9wKGNr6LE1YXucKkB+5ovY+90vcdhN7AI1rSOu4no
         mLTQ==
X-Gm-Message-State: AOAM531+t2dQoFGSR4MvPwU/pBD/8JRatgnulqiGs9k5oDG8ZGoLUJYf
        YQf2F1AD7mrmPG9TJldaXuoMgQ==
X-Google-Smtp-Source: ABdhPJxUeMGT05JDUbQztMtjK+f5XWgcQc6Wt5A/Zx5c82Lq7VCC+s6KhF9pR4qQSR0RhsvcS7E4ZA==
X-Received: by 2002:a17:906:559:b0:6f3:8ba6:39c8 with SMTP id k25-20020a170906055900b006f38ba639c8mr17537928eja.486.1651077442041;
        Wed, 27 Apr 2022 09:37:22 -0700 (PDT)
Received: from [192.168.0.156] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id rb48-20020a170907693000b006f3d4b12d41sm284727ejc.177.2022.04.27.09.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 09:37:21 -0700 (PDT)
Message-ID: <5139dc9f-96c3-9f20-4c62-feee902cb5e6@linaro.org>
Date:   Wed, 27 Apr 2022 18:37:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 1/7] dt-bindings: hwmon: Add nuvoton,nct6775
Content-Language: en-US
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Renze Nicolai <renze@rnplus.nl>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20220427010154.29749-1-zev@bewilderbeest.net>
 <20220427010154.29749-2-zev@bewilderbeest.net>
 <178b9310-a854-dfa6-a4f3-f971b608abe3@linaro.org>
 <YmjmWNUpCAFYesyk@hatter.bewilderbeest.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YmjmWNUpCAFYesyk@hatter.bewilderbeest.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2022 08:44, Zev Weiss wrote:
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  nuvoton,tsi-channel-mask:
>>> +    description:
>>> +      Bitmask indicating which TSI temperature sensor channels are
>>> +      active.  LSB is TSI0, bit 1 is TSI1, etc.
>>
>> Need a type/ref.
>>
> 
> Ack, thanks.

Did you test the bindings after the changes? Using reviewers time
instead of testing by yourself with an automated tool is quite a waste.

Best regards,
Krzysztof
