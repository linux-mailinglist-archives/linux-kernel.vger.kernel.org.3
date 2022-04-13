Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D0D4FF7EB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbiDMNnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235986AbiDMNmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:42:50 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBB927CFA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:40:29 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id d10so2484411edj.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=nGZGKuJ7npiWwchQ6VEl9yeXgIZmCPQcRILQ40zJi1E=;
        b=rtnhy0qGkF/8MKR17T/kwvDp7b0exdqVR4XHbVfyXXL2lYObXtS5PaRcfmWRYGJTi0
         DPWaEqlsJPztV0aq28H27Z/L/eUxF4pB7uDZZPgox1Mu+5fbiF/1NSGWoC6hgcRvRKRZ
         UjdyDio2C/eF4Kg1qBm1saFNUD/uhk3FYp0kIIsq1we4aIAc5wUrqX5PDTQ8TJ+uE16d
         L0GcTvKYe9j1JeKl8bxb0TQf/eIiiMz5t7Vnkix2YTgu/RdTno+NNRsSWW6u33n/Rl5X
         BgkBqoDGvUoKuRpAXd9AXoLuCNDKkboqLcPnXePe6zwgWLt7DtTI/bg8P7Z0+8B9TmIv
         VG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=nGZGKuJ7npiWwchQ6VEl9yeXgIZmCPQcRILQ40zJi1E=;
        b=sijcSwKgd9JYviPcH7DpgxS+JW+XuFSmE6Z0h0pVMqmoGKAUoQaElX9uJQqbXS6/SX
         LssmvdSZt2WKOAgBeGxxBJ8djvkqB4H3b7+TlONDBYPA/LRmj7oHUEG2WARtzVx6uk5s
         4oIwcYjW2vL0N1ByUIT9P6vd7KiZBU/fOxb2uUayZNWYuYRyVsaQzg261KY2RTRAv6pr
         /RiolYOm9ujwJYtbxLPU7aiom1uxZ9WLYQDPZ0dqbhqQkoiVJvh4UALMXuWmmUioQx36
         cajHT8xx8eJtNjM5/c42Xb5wUsGn20CK9dUg4/rK+Lv8UsukabcDmawUNnix40mdalWb
         plmA==
X-Gm-Message-State: AOAM530XI/kS1XtidliQ78lmyIgjQTubGmgR7BhXRLkdd/vRFBNZRK57
        ZCiQj2dGv9Rma+LPc32aoDxT2w==
X-Google-Smtp-Source: ABdhPJx91WPpN6s0yKD0uT2Y+d/THhsDcg5FC0n8Lsz7WKOq9WL2ds/4w5NlHIJRk2Km+6oiOtYsnA==
X-Received: by 2002:a50:a408:0:b0:41c:cdc7:88bd with SMTP id u8-20020a50a408000000b0041ccdc788bdmr43812906edb.399.1649857227491;
        Wed, 13 Apr 2022 06:40:27 -0700 (PDT)
Received: from [192.168.0.205] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id j12-20020a50e0cc000000b0041cd813ac01sm1238406edl.28.2022.04.13.06.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 06:40:26 -0700 (PDT)
Message-ID: <d900bb23-e58e-3586-86a7-11cbae084066@linaro.org>
Date:   Wed, 13 Apr 2022 15:40:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v8 4/6] dt-bindings: mfd: sensehat: Add Raspberry Pi Sense
 HAT schema
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Charles Mirabile <cmirabil@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Miguel Ojeda <ojeda@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
References: <20220412201343.8074-1-cmirabil@redhat.com>
 <20220412201343.8074-5-cmirabil@redhat.com>
 <79281f23-1eb8-6659-d126-eaa608c7abe5@linaro.org>
In-Reply-To: <79281f23-1eb8-6659-d126-eaa608c7abe5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2022 15:38, Krzysztof Kozlowski wrote:
> On 12/04/2022 22:13, Charles Mirabile wrote:
>> This patch adds the device tree bindings for the Sense HAT
>> and each of its children devices in yaml form.
>>
> 
> Thank you for your patch. There is something to discuss/improve.
> 
>> +description:
>> +  This device is part of the sensehat multi function device.
>> +  For more information see ../mfd/raspberrypi,sensehat.yaml.
>> +
>> +  This device features a programmable 8x8 RGB LED matrix.
>> +
>> +properties:
>> +  compatible:
>> +    const: raspberrypi,sensehat-display
> 
> This binding is practically empty, so I wonder what's is purpose? Do you
> plan to grow it? If this was already explained, sorry for bringing it up
> again... :)
> 

BTW, I see now you got review from Rob. What changed here that you did
not include it? It is expected to document such case in patch changelog,
so the reviewer will know he wasn't ignored. :)

Best regards,
Krzysztof
