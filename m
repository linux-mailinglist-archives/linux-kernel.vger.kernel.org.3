Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF714E7875
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 16:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376315AbiCYP5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 11:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242758AbiCYP5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 11:57:03 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB2299EFB;
        Fri, 25 Mar 2022 08:55:28 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id r13so16220984ejd.5;
        Fri, 25 Mar 2022 08:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nBp1rQ230IpvKYOLtxdPVmwxaC/K/6eYv/k0cIvzrGg=;
        b=ydhh9iorl5wHVKdsPWtYnTYfKWEWODecyKOsVEKQXAZtFKQq08d3HyBCxgqhb9I4Hs
         ewJ+5sHkOIh6nND8HIH5PY9TECauUcqniNVPYrOOxzWqFdeIFgScEBj2n67rTzZg4raI
         LnfGimKV9O/HTwxRGGRB3/tnyuN/g9XApfcV1O2/6y3iAWDH9WdyXG+che0KtuHX5QLr
         CgtZI3KY1hiazH3Gmo7pWWB3CKWOeLD7mjz7jxJk7ZMiBQ4ACk5Z//ih7ageUhoG47CO
         iR2+DkjZNwi0ro9cW3jEe0JR9lfwnkb9upCzGMZkNUg9pXj8s/tCD8seqtZVhKxymjeJ
         VPog==
X-Gm-Message-State: AOAM533+YjqQVnu+0YNLvxDfa6MAvaTzgVaF6mUtcBIj4zju3vpyUL6b
        Ih36Hxl0BkLdxO7dm3Q0bSk=
X-Google-Smtp-Source: ABdhPJwpK1Kmx/OKEINVZuqpBjuFjLxKskelwEoutmoGUI6L3rkaULEluc9/Vz6It99LqPXqv0mtIw==
X-Received: by 2002:a17:907:3f8c:b0:6e0:6970:dc87 with SMTP id hr12-20020a1709073f8c00b006e06970dc87mr12134491ejc.236.1648223726593;
        Fri, 25 Mar 2022 08:55:26 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id gb29-20020a170907961d00b006e00c7b0f5asm2539273ejc.0.2022.03.25.08.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 08:55:26 -0700 (PDT)
Message-ID: <cf67f944-47a7-f3b5-9d83-f0f51dc4e954@kernel.org>
Date:   Fri, 25 Mar 2022 16:55:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] regulator: rt5759: Add support for Richtek RT5759
 DCDC converter
Content-Language: en-US
To:     ChiYuan Huang <u0084500@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>, gene_chen@richtek.com,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <1648170401-6351-1-git-send-email-u0084500@gmail.com>
 <1648170401-6351-3-git-send-email-u0084500@gmail.com>
 <d2b431f8-9197-4a42-4ee2-4e771e20e0aa@kernel.org>
 <CADiBU39RGQj1-+yK18mZf3MR78KACKqb2kAxkCFKGXKpJ6Nqxw@mail.gmail.com>
 <e4a15ceb-c013-96be-48d1-e65267400463@kernel.org>
 <CADiBU3-gwsh5v1NLUYr_ovXwpUxQqgR61f-Jpc3G-zHs_yV4uw@mail.gmail.com>
 <03999953-77c5-0272-7477-ab8a069b3671@kernel.org>
 <CADiBU38zYM1Rw2inTJ_Pu2eWKKqp2Ybb-_+JUJfxfmLNu=kYvw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CADiBU38zYM1Rw2inTJ_Pu2eWKKqp2Ybb-_+JUJfxfmLNu=kYvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2022 16:50, ChiYuan Huang wrote:
> Krzysztof Kozlowski <krzk@kernel.org> 於 2022年3月25日 週五 下午11:37寫道：
>>
>> On 25/03/2022 15:59, ChiYuan Huang wrote:
>>> Krzysztof Kozlowski <krzk@kernel.org> 於 2022年3月25日 週五 下午10:47寫道：
>>>>
>>>>>>> +
>>>>>>> +static const struct of_device_id __maybe_unused rt5759_device_table[] = {
>>>>>>
>>>>>> I don't think this can be __maybe_unused. It is always referenced via
>>>>>> of_match_table, isn't it?
>>>>>>
>>>>> I think it can declared as '__maybe_unused'.
>>>>> If 'of_device_id' is unused, then in probe stage,
>>>>> 'of_device_get_match_data' will return NULL.
>>>>
>>>> But your of_device_id cannot be unused. It is always referenced.
>>>>
>>> I'm not sure, but your assumption is based on 'CONFIG_OF', right?
>>> Only if 'CONFIG_OF' is not defined, then it'll be really unused.
>>
>> Is it possible to build this driver without CONFIG_OF? Did you try it?
>>
> No, my development board always  use device tree that's defined CONFIG_OF.
> 
> But theoretically, you can also check of_device.h, if CONFIG_OF is not
> defined, 'of_device_get_match_data' always return NULL.
> If so, my usage is still right.

No, it does not look right and your arguments are not even related to
the topic. I don't think we talk about the same thing.

You mention board, some of_device_get_match_data() so you talk about
runtime. maybe_unused is not about runtime. It is about build time.

The code you sent cannot have this structure unused. If you think
otherwise, please provide argument, but not about runtime (again). You
can for example build it without OF and see...

Best regards,
Krzysztof
