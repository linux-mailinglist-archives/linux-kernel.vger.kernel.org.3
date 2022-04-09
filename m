Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDB84FA8AF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242120AbiDINqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbiDINqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:46:40 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A21986F7
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 06:44:33 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id b15so13006133edn.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 06:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9jXEm/llamwKFEyofVyK+nTUMIMtJh/N9Opoetbwiso=;
        b=H/Q1QSzzjh6u32GG8HINBQjg9TwglokvXK0o8iMSUEZ5LKCU4UGlvegrdfW19pX9Kw
         Jx+aCFxf4PgpI/i4Z7/SuesbDzwtYXu0IvwUXN7/x0Tv9d8YZkbdANXMLNK176OQ3U2v
         fESng/tSQPFwnXxO0JCD4Q1qGIrLJn58me1Zik5VgDzb+R2ISWMCDblWLUehEez3sfxN
         IViC67puHG0D/Afit76kZiOu6IBi1X4TvAwcA2tZlyHIyubhKx1x7vtHc8Qo5/d6weMl
         9BPKxxjcv/pn0HXqhtmFhBkX+hrC3nvlLUYQ3HWBS/O4Bnb0ZQ+elH2rLCUs/8d2qG0W
         Vu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9jXEm/llamwKFEyofVyK+nTUMIMtJh/N9Opoetbwiso=;
        b=WsrKoUwDpyP1c9YZMt/8rYsFD2VExezoKfmaEKxRBroIsPTl+VTIGp31o8s88phtev
         8OWzNd9K/wZhlhmnytCqqo7dLyh3CLfa9LW6WeVgCnAMffIi+fraYlIF8KCMbxSaPZ5+
         Nr/Eg41efW5ME/1X7X3s7pvmcjgZKH4s7hkjch7kbV+qfudrG32EfX6gpvIfFtDu0sYx
         aOqasiSzNY2FxkqQ/8vL/WHe8TkKGID0NoUgu0JW1b39DxUdHpXP0FJfyUtHAsWZqVlR
         sPBqUoA2hpbT9DJ5kKc2Jowa/pE9V+a8I+bDfvZyN8J6kaQ6ZsV9nOGaZb1mYxzXL8PI
         6uLA==
X-Gm-Message-State: AOAM530ijTyu/hoenXvwTj0bSvPqO9GjPdpIZO/Sn/SByal1xqh4CFHE
        Pmm+ovVLxkaulGzATh8Q8Z1/2g==
X-Google-Smtp-Source: ABdhPJyBs5U8dR/fCs4H56/RwXNw6AtMq+4fIEZsHq+kAAZocRW7OIaEKiTQ3Rp7aeugGdG7Yb1n4A==
X-Received: by 2002:a05:6402:3496:b0:419:82d5:f1d9 with SMTP id v22-20020a056402349600b0041982d5f1d9mr24186351edc.36.1649511871819;
        Sat, 09 Apr 2022 06:44:31 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id b17-20020aa7dc11000000b00412ae7fda95sm11514582edu.44.2022.04.09.06.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 06:44:31 -0700 (PDT)
Message-ID: <3e95f567-03f5-bf9c-1856-9fe602e9b025@linaro.org>
Date:   Sat, 9 Apr 2022 15:44:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 07/18] MIPS: DTS: jz4780: fix otg node as reported by
 dtbscheck
Content-Language: en-US
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org
References: <cover.1649443080.git.hns@goldelico.com>
 <298162bfa2e7225ccc753865e1ffa39ce2722b2a.1649443080.git.hns@goldelico.com>
 <bd19b6eb-d53a-b665-749d-46c275c85ccc@linaro.org>
 <822182F3-5429-4731-9FA1-8F18C5D95DEC@goldelico.com>
 <535e3eab-a28e-46f3-2a7e-f1ffd1913470@linaro.org>
 <7B66AC66-EF73-4F75-A775-589A4F98BEFC@goldelico.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7B66AC66-EF73-4F75-A775-589A4F98BEFC@goldelico.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2022 15:32, H. Nikolaus Schaller wrote:
> 
> 
>> Am 09.04.2022 um 15:15 schrieb Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>:
>>
>> On 09/04/2022 15:05, H. Nikolaus Schaller wrote:
>>>>
>>>> This looks wrong, the block usually should have a specific compatible.
>>>> Please mention why it does not.
>>>
>>> Well, I did not even have that idea that it could need an explanation.
>>>
>>> There is no "ingenic,jz4780-otg" and none is needed here to make it work.
>>
>> Make it work in what terms? We talk about hardware description, right?
> 
> Yes.
> 
>>
>>>
>>> Therefore the generic "snps,dwc2" is sufficient.
>>
>> No, you are mixing now driver behavior (is sufficient) with hardware
>> description.
> 
> No. "snps,dwc2" is a hardware description for a licensed block.
> Not a driver behavior.

snps,dwc2 matches the original block, not necessarily this
implementation. Unless you are sure?

> 
>> Most of licensed blocks require the specific compatible to
>> differentiate it.
> 
> If there is a need to differentiate.

No, regardless whether there is a need currently, most of them have
specific compatibles, because there are some minor differences. Even if
difference is not visible from programming model or wiring, it might
justify it's own specific compatible. For example because maybe once
that tiny difference will require some changes.

Someone added the ingenic compatible, so why do you assume that one tool
(bindings) is correct but other piece of code (using specific
compatible) is not? You use the argument "bindings warning" which is not
enough. Argument that blocks are 100% same, is good enough, if you are
sure. Just use it in commit msg. But are you sure that these are the
same? Same pins, same programming model (entire model, not used by Linux)?

Best regards,
Krzysztof
