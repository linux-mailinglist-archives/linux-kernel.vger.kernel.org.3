Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBB04FA8DF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 16:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242314AbiDIOCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 10:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiDIOCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 10:02:39 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D13275D2
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 07:00:29 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id l26so22454652ejx.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 07:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ylCilMt17wf2kzWsA22YBnijUFnndNZS+pdpGkiKb/8=;
        b=Ocarr7bDUjv+Fnea3KsIyy3/Q/bTFEV00z690cWKRRsORm7Q9E369bFqG4Y/Z/3wph
         sxqOP+RucyqSOrWLZeamxQjlJfiFUsAPe090AM8qabsP4l0vuBRHJpp44t8HytYz80xq
         sfZsh41QQRfykhEzeAHNnJIx9KGEZXlQ5hD+zoYXr1hGNuY/tbtpuKLwsjz2792X7FW1
         B9SkElntg3pZYFxBu9KXoakvkYuG4Pj42LmWiMIurG45f4KZEN+sKBAlvTlNo7D3t4jQ
         nk2Z8pB8VOvxSW6Lw+C2ZnWPls/cfZ4A0Hb1Th/Vi6oUEqnqMnjZjLbQ98GjdDtrUs9C
         CI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ylCilMt17wf2kzWsA22YBnijUFnndNZS+pdpGkiKb/8=;
        b=rwV7b6Kg1fUJm/r5RixQV08P5heJ0EWJCPS93QoWGG8k+vMCYZBESemA6g4eHqSvav
         b7hPn7/zfiGprSbG1vfJeYPgRgMPLV/8yJ38ECes5oiGDTH55z0OM2oGXKg8wEpLwkK9
         jy0QaG4l9JbbaI2+iDm4AmbuwJxkhAx/npHSW90C9+ZesWtsIyzweWvOFS0CHsvepbBl
         OdUwSaFnsPbzKd1iVnvGEk+8LFOt2FajkLBxVUiFlcRMrwl/QQ0epWLSX9dl9hxLWllS
         wIp90Njqnqp14VjvKPK3RcnGqjSSVZXZZpF5OzgHtSdBrorihokhiee3g0vE4xjPgpEf
         QyrQ==
X-Gm-Message-State: AOAM531WRSUfHzPZYlI0x3g9PSQk0JrK06ADC7/3iryI7b8NMRaexOwO
        WjFpaRdJhnM9cGyTxcmaZ6HYVQ==
X-Google-Smtp-Source: ABdhPJzjG6KIONIUnoFW1+NNwFB0QZzYAijDLGqQFcrpAGMZDTG0bRSADaNinMAGvRLghxGSR6degA==
X-Received: by 2002:a17:907:62a2:b0:6e0:e201:b94e with SMTP id nd34-20020a17090762a200b006e0e201b94emr22792832ejc.730.1649512828032;
        Sat, 09 Apr 2022 07:00:28 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id jv20-20020a170907769400b006e7f859e683sm6213304ejc.19.2022.04.09.07.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 07:00:27 -0700 (PDT)
Message-ID: <7a2e986f-708b-ae4f-e877-6cdc1607626a@linaro.org>
Date:   Sat, 9 Apr 2022 16:00:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 05/18] MIPS: DTS: jz4780: fix pinctrl as reported by
 dtbscheck
Content-Language: en-US
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
References: <cover.1649443080.git.hns@goldelico.com>
 <1941bc4ed553b27f399ad00ea61ff2b0237d14e3.1649443080.git.hns@goldelico.com>
 <e905896e-335d-a88a-1961-d17b92e46585@linaro.org>
 <530E0F7F-FC03-45DD-BF87-D049D3108AD3@goldelico.com>
 <c84b5ec0-0193-ab62-1985-25bc2baa9f05@linaro.org>
 <B5EB5983-DA9F-4631-B737-2B1417CF9054@goldelico.com>
 <f40e1a00-be4d-11c7-6a7c-6b50635a2960@linaro.org>
 <499848FD-3F64-4B5D-9259-5C9E1ED4E8AB@goldelico.com>
 <fb521d87-2d52-c15c-83c0-1b62bf1b1cc4@linaro.org>
 <F0C0E942-BA61-4C74-860B-93D57C3D0F9A@goldelico.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <F0C0E942-BA61-4C74-860B-93D57C3D0F9A@goldelico.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2022 15:57, H. Nikolaus Schaller wrote:
> 
> 
>> Am 09.04.2022 um 15:46 schrieb Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>:
>>
>> On 09/04/2022 15:41, H. Nikolaus Schaller wrote:
>>>>
>>>> No. I ask you to fix all pin-controller cases, for entire MIPS, not just
>>>> one.
>>>
>>> Oops. Nope. I am a volunteer and neither your employee nor slave.
>>
>> No one thinks differently and I am sorry that you felt it. Please accept
>> my apologies, if you get different impression. You understand though the
>> meaning of word "ask for something" and "order something" (the latter
>> which I did not use).
>>
>> I just asked.
> 
> Ok. Maybe english is not our mother language and we sometimes don't
> get the nuances right. Sorry if I understood that wrongly.
> 
> At least I now understand what you did suggest.

Yeah, probably I did not express my thoughts correctly.

I would like to state that I appreciate your work and I think it is
important, even if I do not express it correctly. Please accept my
apologies if I am bit harsh or impolite. That's not my intention.

> 
> Doing the same change for treewide MIPS is beyond my capabilities since
> I can't easily test any compile setup. So far I only compile for CI20 and
> as far as I know every machine still needs its own config for MIPS 
> (haven't checked recently). So I am not even sure if dtbscheck tells me
> all locations.


OK, fair enough.


Best regards,
Krzysztof
