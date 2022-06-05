Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FF053DC86
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 17:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350937AbiFEPPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 11:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351090AbiFEPPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 11:15:06 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4ED4D600
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 08:15:03 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id er5so15756154edb.12
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 08:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uUTCHtLrKiDbQl/tZcD1cs2OUjqwDsiGmSTmuLA8eFg=;
        b=OyHF3rulfwpQ+H4kM0gYuavsh+7RQuG/F/zHr0QsihBHUiUBlpMVnkgcz75akfkD+x
         7lybdMqw3PIgKS64wtbHQhSEkL/LDHN3FIxPkabYVKZnXMMKjbcb/RHRqeBd35+KcKzw
         8irsXRbo+ZQyZpOlng6sHNgF1hBOc4CRDzEWROwcV3/L/XNvbqZFpMm4Sbp7iqvEIKok
         b9AVzZjUM4HNrWRUhPLjzxIDveoiJA/VYz21urpzxMZOIOmCFd643zqnqeOuYgwZYFvg
         uapATNYf2N7VBrXO7cvo7P1i1qutovtxDA2Mrn5g2BhpLSvSh8i4OyqAMZJD7BX/4Vij
         1Azg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uUTCHtLrKiDbQl/tZcD1cs2OUjqwDsiGmSTmuLA8eFg=;
        b=oiF0WYwbVeVnKsBsAUCJ+VvNxzTh2Bkg5oPMWQvWEThYvMsFWZR8QwuXSryiMZQdXu
         5YGSA1mbhB8BDlK/jdRU14l25RnCcaMCSwVA3ZAoh92Wu0eX+OhRRpjRfwcIww52krc1
         Y2de2RJchbmhY7Yr/hpfRotUKb+wjWOEPnZfvIQDdNN40V05+q59WZfur8eVYQ7Sa6Jz
         nzPAg7YnHj4hzl0048sJzMHoz0srPCJ84teCKSDV8gXvL0HHxHOwwivpnE1XwdP9UhRB
         4vvlmlFeDKp50jwjmCWDKNuK8Yuh6/fVeTeB3myRqFtbZjL4VND3r671kA6dy2gq9Ar/
         58kA==
X-Gm-Message-State: AOAM532Rqkyy3LcoaLqmqLI2WC2WViw1kADYJxYmDvQTS9HRjUqj6D9m
        ymjVE4x4WsnSXQ/LQGb+MENwwA==
X-Google-Smtp-Source: ABdhPJwRAfAIDWYX/hPmYOR71w9t0egsDQWp6p9WhbNqD1JeS7dZwZgdrj+Xnm4r3xmk8BEScZaxHQ==
X-Received: by 2002:a05:6402:4255:b0:431:34c3:6018 with SMTP id g21-20020a056402425500b0043134c36018mr7082764edb.146.1654442102273;
        Sun, 05 Jun 2022 08:15:02 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id cz20-20020a0564021cb400b0042dd85bd23bsm6933493edb.55.2022.06.05.08.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jun 2022 08:15:01 -0700 (PDT)
Message-ID: <ca93699e-f905-c0ee-8ddb-1be2491fc8cc@linaro.org>
Date:   Sun, 5 Jun 2022 17:15:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH 2/2] dt-bindings: input: gpio-keys: document label and
 autorepeat properties
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Hansson <newbie13xd@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>
References: <20220603101601.542054-1-krzysztof.kozlowski@linaro.org>
 <20220603101601.542054-3-krzysztof.kozlowski@linaro.org>
 <Ypo6Q8/SuPGxp/ac@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Ypo6Q8/SuPGxp/ac@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2022 18:43, Dmitry Torokhov wrote:
> On Fri, Jun 03, 2022 at 12:16:01PM +0200, Krzysztof Kozlowski wrote:
>> The original text bindings documented "autorepeat" and "label"
>> properties (in the device node, beside the nodes with keys).
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/input/gpio-keys.yaml | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
>> index 49d388dc8d78..b1c910a5e233 100644
>> --- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
>> +++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
>> @@ -15,6 +15,14 @@ properties:
>>        - gpio-keys
>>        - gpio-keys-polled
>>  
>> +  autorepeat:
>> +    type: boolean
>> +    description:
>> +      Enable operating system (not hardware) key auto repeat feature.
> 
> Should we refer to the generic input device property here instead (one
> on described in input.yaml)?

You mean copy the description from input.yaml or say something like:
"see input.yaml"?


Best regards,
Krzysztof
