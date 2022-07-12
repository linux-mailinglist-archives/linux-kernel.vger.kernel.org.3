Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41166571E07
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbiGLPE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbiGLPEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:04:08 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD14C174F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:00:12 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id t25so14391966lfg.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5rwKBeIAZBL/2EbnwIvloMXojmJae+HG+bwLQ3UvKZU=;
        b=BbqDqVYooYKIj1K6apNQYxI5UjKiAsnraSpIq+Gxz0bTDVuntACzh0E+3jiLg/k3aK
         d83//NilU35J6/a6+8ApONO/62eR5hR7JqotATL2RfHiawCOJOwfoGw1YGiafdoDwnfm
         rOD7HwKkH/n8jYHCG/exNMQ1AgZwyUBlvZt0JUR9VwiYXV1RR9yczW8BKn0kIpToBR6j
         Y9Gl4vzK5t0jzYrQtgabsfnZug43LGWh7DUtsBKT9GqX8PXIZq81V2Jw7pGS5hP7N91U
         OmmTYBrdiDoyPc9dQ7X4g3r8ZEmlS6/0SN1CdaxS2TT8RwWpJvjjh2GAvXHuEoLy+wu4
         chZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5rwKBeIAZBL/2EbnwIvloMXojmJae+HG+bwLQ3UvKZU=;
        b=Qt9ZdOlY0Uczh4AbpmNU8E8vd3lmBWCw1SHxx5d7c57xVrIdAyoKQy3lHKyAJ7BLo6
         LiQd9zO3M9dI6tzrC5vYBx13r1HWJnxs++tg8lB8L4skD7DIBS4DNt8kISHlS3My/jgi
         ZmlXsovp+bGkVx2tqfTUdCxZHAOQmPyJfK6lJFMasBz5cTF8CMuPRGjZSxTtiDUssiZ3
         ElpCOLBMKgROc73+Sjd0H7XybDQ8+Kqf0OeIxK6lGcLt1UatinBoeqs1KoF2+Su2HdIF
         0EA4Ho5VM6XZUKNbb3CQhqn05IF0fRwnYyYE7HvC1sZrJPAvqiIpsbJ5q8gflu7WvsMU
         E1yQ==
X-Gm-Message-State: AJIora8mtGRuU945vvFWf6xviDjTAhYeLlEHleYLiyqpFD4+2NdPj9Zx
        RY3PzdsW9FJzAxjnVXX6EsD2DQ==
X-Google-Smtp-Source: AGRyM1tZfgJtj9Pi+7AZnjOK058CzPog+YlI+5JjlBYCIAmKzqbCcAsF+0E+Hb47hZNPuTxqlmc4uQ==
X-Received: by 2002:a05:6512:2511:b0:47f:a15b:c3ad with SMTP id be17-20020a056512251100b0047fa15bc3admr14872192lfb.441.1657638009971;
        Tue, 12 Jul 2022 08:00:09 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id o20-20020ac25e34000000b00489cc0dd59esm2209550lfg.90.2022.07.12.08.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 08:00:09 -0700 (PDT)
Message-ID: <b46f49e4-355d-7a59-4a4a-f5c77b6835df@linaro.org>
Date:   Tue, 12 Jul 2022 17:00:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH net-next 1/9] dt-bindings: net: Add lynx PCS
Content-Language: en-US
To:     Sean Anderson <sean.anderson@seco.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
References: <20220711160519.741990-1-sean.anderson@seco.com>
 <20220711160519.741990-2-sean.anderson@seco.com>
 <4584120c-8e6f-6943-1bd3-aa6942525eda@linaro.org>
 <a6b2d031-8356-492b-8eef-a7cdfacaba51@seco.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a6b2d031-8356-492b-8eef-a7cdfacaba51@seco.com>
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

On 12/07/2022 16:57, Sean Anderson wrote:
> Hi Krzysztof,
> 
> On 7/12/22 4:47 AM, Krzysztof Kozlowski wrote:
>> On 11/07/2022 18:05, Sean Anderson wrote:
>>> This adds bindings for the PCS half of the Lynx 10g/28g SerDes drivers.
>>>
>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>>> ---
>>>
>>>  .../devicetree/bindings/net/fsl,lynx-pcs.yaml | 47 +++++++++++++++++++
>>>  1 file changed, 47 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/net/fsl,lynx-pcs.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/fsl,lynx-pcs.yaml b/Documentation/devicetree/bindings/net/fsl,lynx-pcs.yaml
>>> new file mode 100644
>>> index 000000000000..49dee66ab679
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/net/fsl,lynx-pcs.yaml
>>
>> Shouldn't this be under net/pcs?
> 
> There's no net/pcs, since this is the first of its kind. 

There is, coming via Renesas tree.

> There's no net/phy
> either, so I didn't bother creating one.


Best regards,
Krzysztof
