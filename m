Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CCE566C9B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 14:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbiGEMQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 08:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbiGEMI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:08:58 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE5D3897
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 05:08:57 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y16so20147924lfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 05:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ihhr+go3H6HNgFbSksIx63Cidh++W2IwUum3O7T/3gk=;
        b=It5uTRFw2c8H1LR8TfaJKFKMA1hKtnruFe2SdrSsC7xUf8XjoruTXCJRNB5KxAm9+4
         NzwTDfmPtbsDAdaji7gkFBjYYIqr+ylikcW6DqWjuAJWQQ64rXQ/aDymH4AQjE95w93A
         edQjCBwR1LZwqfekoQ1N6cZzPcjs4j5LWOeaGfB71BdmcFZ0Cix+lMlIxlO6wzgm/fGA
         Uek3CaYmRIHb+PYdESrgnFB3vZV5nMkB+E84xsOvEFD4YlyjWmuGswMcxYjxdtjWwxZu
         3U6UIpQRd9sgdzyb4bPW3SWi3adHjSYjfpcWwONpKuKe7JblrGM/Y3Ommt6t5dYEeEck
         zXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ihhr+go3H6HNgFbSksIx63Cidh++W2IwUum3O7T/3gk=;
        b=noYQa3j5x3gFZAdZO+ZGXFl/52cVoIvV4tLHnVUmIwhqf6wzGkULrZRe++QZ8gDmAr
         jPFx+H2ppxxaXAIcB764y58aFQHqYjgwjJQWEsmuVK+gH8/5ygp9ZAILf/PT2iX+rVj7
         7WNgoO4VX+Me0gK+6O21NJdIHEjXOlbV/EXaCv0UvUGkxl8N/kq0+Qc99uc1dCHxJIAs
         kdb89miNMfhG1I1a1ji5zOpAkD9HaIvJxwEWXvkWuL+/axqLVhgJWiZAlvcob8q0mS1f
         KXxHxI7iMT8QzlDr2+JThskt6mhxGARXzyvrKJ+Mhpob0v92JB9zvEdp2fixpxVfVuYQ
         9Ahg==
X-Gm-Message-State: AJIora8mLboDI61ekYHHPULmfsY3RyaokIySksJTq4mQcOS492+3mD0A
        0x+JA44urOImfAW7sBY2MwaJFg==
X-Google-Smtp-Source: AGRyM1tFWsgMJ/MlaFpyOPsBIAszroay69w97JtxjVrtk8RsY2Y9SlOtd9egItDMdymBkfNWyLdwsg==
X-Received: by 2002:a05:6512:2393:b0:47f:8f12:3a93 with SMTP id c19-20020a056512239300b0047f8f123a93mr21458936lfv.209.1657022935496;
        Tue, 05 Jul 2022 05:08:55 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id s21-20020a056512315500b0047f6e91d4fesm3275915lfi.141.2022.07.05.05.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 05:08:54 -0700 (PDT)
Message-ID: <97d9ccf9-71f8-c97d-ce56-8aeb1a3db194@linaro.org>
Date:   Tue, 5 Jul 2022 14:08:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 02/20] dt-bindings: media: s5p-mfc: Convert s5p-mfc.txt to
 new DT schema
Content-Language: en-US
To:     Smitha T Murthy <smitha.t@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, stanimir.varbanov@linaro.org,
        dillon.minfei@gmail.com, david.plowman@raspberrypi.com,
        mark.rutland@arm.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        andi@etezian.org, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com
References: <20220517125548.14746-1-smitha.t@samsung.com>
 <CGME20220517125554epcas5p4e87a71471525056281f1578f4f80f760@epcas5p4.samsung.com>
 <20220517125548.14746-3-smitha.t@samsung.com>
 <6c2ea5f7-3cc0-d43c-c667-18c25b64ff72@linaro.org>
 <01e601d89064$a212a590$e637f0b0$@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <01e601d89064$a212a590$e637f0b0$@samsung.com>
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

On 05/07/2022 13:44, Smitha T Murthy wrote:
> 
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
>> Sent: Tuesday, May 17, 2022 7:26 PM
>> To: Smitha T Murthy <smitha.t@samsung.com>; linux-arm-
>> kernel@lists.infradead.org; linux-media@vger.kernel.org; linux-
>> kernel@vger.kernel.org; devicetree@vger.kernel.org
>> Cc: m.szyprowski@samsung.com; andrzej.hajda@intel.com;
>> mchehab@kernel.org; hverkuil-cisco@xs4all.nl;
>> ezequiel@vanguardiasur.com.ar; jernej.skrabec@gmail.com;
>> benjamin.gaignard@collabora.com; stanimir.varbanov@linaro.org;
>> dillon.minfei@gmail.com; david.plowman@raspberrypi.com;
>> mark.rutland@arm.com; robh+dt@kernel.org; krzk+dt@kernel.org;
>> andi@etezian.org; alim.akhtar@samsung.com; aswani.reddy@samsung.com;
>> pankaj.dubey@samsung.com; linux-fsd@tesla.com
>> Subject: Re: [PATCH 02/20] dt-bindings: media: s5p-mfc: Convert s5p-mfc.txt
>> to new DT schema
>>
>> On 17/05/2022 14:55, Smitha T Murthy wrote:
>>> Adds DT schema for s5p-mfc in yaml format.
>>>
>>
>> Thank you for your patch. There is something to discuss/improve.
>>
> 
> Thank you for the review. 
> 

You responded after two months, I don't remember what I reviewed... Two
months periods between resends do not really help to usptream.

> 
>>> +                compatible = "samsung,mfc-v12";
>>
>> Does not look like you tested the bindings. Please run `make
>> dt_binding_check` (see Documentation/devicetree/bindings/writing-
>> schema.rst for instructions).
>> Be sure to test your bindings before sending them.
>>
> 
> I did do make dtbs and dt_binding_check using v2022.3, I will recheck post these changes.
> 
>>> +                reg = <0x12880000 0x10000>;
>>> +                clock-names = "mfc";
>>> +                interrupts = <0 137 4>;
>>
>> Use interrupt defines.
>>
> 
> When I use interrupt defines I get errors as "1.	Syntax error: This was due to interrupts field has some macro reference and needed to give absolute value.", hence I gave absolute values.

Look at other DT schema files...

Best regards,
Krzysztof
