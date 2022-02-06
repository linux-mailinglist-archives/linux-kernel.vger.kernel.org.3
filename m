Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FD04AAF15
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 12:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbiBFLxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 06:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234957AbiBFLtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 06:49:31 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7181C06173B;
        Sun,  6 Feb 2022 03:49:30 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id t7so15556792ljc.10;
        Sun, 06 Feb 2022 03:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=qpsYzbivkkdveiz3jrhzknfAz9utFIWn4A3/RXZRA8o=;
        b=Wz70FLvBmPiudg6xQ3qQ5TwSRbRrI2uPf3muo7NyUI1j3T5bCwGZ+ctGPPiho3Mxdy
         xx5H6DfkjucGPMXRybkLYFncO7MehbZmifndkNzAzTfzO82crSRG2VX3ssbYIQfDHKEq
         hLOaiVSl1saLS44xlt61IOvCxpgtis8G/GBvB4ZOp5IXsiF+sIy1wLWdzNimPiQ0xKH2
         xVnW/K/sVIynr3gfyAgEXNoIABi/nvwzApnyTOWUHgKx0gMMGZbgrjSJ5o/r8PbBw4YH
         nE7AOlPE+ZIc6Ls6qfFWgC5ei619VkAXA0Hrs7Fpm3yNmBa1N45cB9+T0DI/LBEgNP81
         2VSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qpsYzbivkkdveiz3jrhzknfAz9utFIWn4A3/RXZRA8o=;
        b=Agp3Q+wBNNJBTL5OMQ3rkOeXK96rDjo8kKBmbOxg15HrusDKqW4xh4OrryIci+jFXO
         VJVo76rS2couJ4cRsI0WOutch/pVefPWQoJ45mHRO2jsZonhZCqOKl4FeKhEYII88z3m
         qGSmF0h9sTAHZdU7Eh1YXZWcsBcVcwbaM1pcVVxImLx80rUulIwf8svpEoGYW+q8K6aK
         i2spw+V2igeNee64uSGjwTPshvsbQu7JPE1BahS7RtQxSicQJUGZn9ywjcK2Zs0e1dva
         tnY2CKXK0kZTNDmk/Q3eLAZjl5uu64YjCGv07W6Nd/F+r3XBkLlEPLV6luVvEXTUkvsN
         8rbg==
X-Gm-Message-State: AOAM533lu60N6O0lqHnm6VfUn825c+E6PfwhTGK/oX/DS0lxQKKBcuVp
        61pNjcfW1XI8LQnDg0PD1MASC6SZqX4=
X-Google-Smtp-Source: ABdhPJwr1tTWLq1co7NexfEvCSKv8xkLEqalEYHCyUO+KVi8LSZjgfEUwEldRF7bZPM0BYxjW+UM6A==
X-Received: by 2002:a05:651c:50f:: with SMTP id o15mr5229913ljp.119.1644148169167;
        Sun, 06 Feb 2022 03:49:29 -0800 (PST)
Received: from [192.168.2.145] (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.googlemail.com with ESMTPSA id n16sm1075561lfq.113.2022.02.06.03.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Feb 2022 03:49:28 -0800 (PST)
Message-ID: <57486a1b-8667-6f51-977f-16343572925e@gmail.com>
Date:   Sun, 6 Feb 2022 14:49:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 4/5] dt-bindings: memory: lpddr3-timings: convert to
 dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220205120043.8337-1-krzysztof.kozlowski@canonical.com>
 <20220205120043.8337-5-krzysztof.kozlowski@canonical.com>
 <a204a4eb-6615-26db-facf-ad284c1732d7@gmail.com>
 <a5bbf115-21a2-7d63-6744-72487b9e756a@canonical.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <a5bbf115-21a2-7d63-6744-72487b9e756a@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.02.2022 14:20, Krzysztof Kozlowski пишет:
> On 05/02/2022 19:50, Dmitry Osipenko wrote:
>> 05.02.2022 15:00, Krzysztof Kozlowski пишет:
>>> +  reg:
>>> +    maxItems: 1
>>> +    description: |
>>> +      Maximum DDR clock frequency for the speed-bin, in Hz.
>>
>> Why max-freq is specified as a register? At minimum this is inconsistent
>> with the lpddr2 binding.
> 
> First of all, this is a conversion, so the bindings already specified
> max-freq that way.

The conversion part looks okay to me.

> Second, I don't know. I think this was some Lukasz's workaround for
> device node without unit address, but I don't see the reason now why it
> was needed.

I see now that actually there is one exynos5422-odroid-core.dtsi that
uses the 'reg' property.

> We could unify it with DDR2 by deprecating 'reg' and introducing
> 'max-freq', in separate commit. But you know, existing bindings are
> already there...

Will be great if you could add another patch to deprecate the 'reg'.
This will prevent returning to this topic in the future if somebody will
be adding lpddr3 timings, it also will make bindings to look consistent.

Thank you!
