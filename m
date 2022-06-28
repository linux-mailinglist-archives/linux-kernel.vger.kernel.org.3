Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8FA55E6CC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347190AbiF1P0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241367AbiF1P0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:26:49 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428CE2D1F1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:26:48 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u15so26490366ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Kjcf0myN8xEQpjIbs4vYCmYvnjer77kYAUZMxxZfr54=;
        b=MiqvpNPpX09362l61nV5eWebMheEbAXmxJOrBhDRX9t2YTF5o5w2iCtTbO1xXIH5nR
         ASy9dmUFwVTdqmjxSF+6j6raG1Q+AFow9+pdiQfKvQSOG9FnVfm/Iars+cCsYTRDwWJ2
         blL4bPLQKmBe41kTNFlNa3aGPvHmNMHmbNpdL7HfS+YfAaTOlO8pbzXSjqezxbtTGMZ8
         V3Cm91faw349kLNwWbRfZ24EphQ6eUiegf/jmqv6CADm7866SFiOWCcI0lJit/6nzDzr
         GuXsdCATpbqWgsp23sUBuS0b2O8DSdpl4ta0/Snjzwfw7LOF6yuzOCfs1+UHBZGsljsl
         Fryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Kjcf0myN8xEQpjIbs4vYCmYvnjer77kYAUZMxxZfr54=;
        b=xyNmZgMnBhoyQ2VaWcIIZP5pGuzNOcaIHG773BH7yrdUB0vXjB7A3JJNTM0C9DfhmI
         QhnE8DKogqING0AHEMDXLascOypqHG0yPhl3+B+GpORamdi0XZSsIdZcAuyGA/rQxol9
         Kf5SLBgYk0Tt5OeE4dursX1KKzv5h0PNLFOzbgR2yGPqA80LUBfA61/KgOyoZLaVgCgU
         lcTYR91kagsY8mjfORdniT1jGwAUFvFXvdpMcTWUHzVJIOVNl5AWzF+p1gn+OtWE2cXM
         CHntHMsYFLR0E6GYmS07BbybCtrU5y9aeEXLul0gxOIsP4NPnuH6TfzegOXtsipxydwg
         P+Dg==
X-Gm-Message-State: AJIora8H5IKETitvcTI172NGbnEh+EhTFQCzmfMARaIXhxBAMzc2GrB+
        BEwij1BX64UedEl5mFCfjjQoHQ==
X-Google-Smtp-Source: AGRyM1uzxpsWrvBGixfnmSdbGTuYjpVh/2OxG/8e+M42tgEx0u0q8hE/de6Xy/LxgcLt473rap2OJQ==
X-Received: by 2002:a17:907:1693:b0:726:4322:c330 with SMTP id hc19-20020a170907169300b007264322c330mr17576956ejc.9.1656430006883;
        Tue, 28 Jun 2022 08:26:46 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id z15-20020a170906944f00b006fe8d8c54a7sm6527208ejx.87.2022.06.28.08.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 08:26:46 -0700 (PDT)
Message-ID: <c8dddfe6-6385-ed34-e789-9f845c8a32bd@linaro.org>
Date:   Tue, 28 Jun 2022 17:26:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] dt-bindings: chosen: document rng-seed property
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
References: <20220627152107.645860-1-Jason@zx2c4.com>
 <CAJMQK-jGsobw7i4NjQ4oezA0rU03ECs_nY=Txr6TgsHFu2jXhg@mail.gmail.com>
 <Yrsc+50Y2UX1wlYH@zx2c4.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Yrsc+50Y2UX1wlYH@zx2c4.com>
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

On 28/06/2022 17:23, Jason A. Donenfeld wrote:
> Hi Hsin-Yi,
> 
> On Tue, Jun 28, 2022 at 11:39:38AM +0800, Hsin-Yi Wang wrote:
>> On Mon, Jun 27, 2022 at 11:21 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>>>
>>> Document the /chosen/rng-seed property, which has existed for quite some
>>> time but without an entry in this file.
>>>
>>> Fixes: 428826f5358c ("fdt: add support for rng-seed")
>>> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
>>> Cc: Kees Cook <keescook@chromium.org>
>>> Cc: Rob Herring <robh@kernel.org>
>>> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>>> ---
>> It's currently documented in
>> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/chosen.yaml
>>
>> https://lore.kernel.org/lkml/CAL_Jsq+uSdk9YNbUW35yjN3q8-3FDobrxHmBpy=4RKmCfnB0KQ@mail.gmail.com/
> 
> Well, let's see. That email says:
> 
>> Already documented here[1]. I've been meaning to delete chosen.txt so
>> that's a bit more obvious.
>>
>> I realize it's a bit harder to find what's documented where. Long term
>> we'd like to generate documentation from the schema and integrate as
>> part of the spec. Short term, it would be quite trivial to make a 'am
>> I documented' utility.
> 
> That sounds reasonable. But when was that email written? April 2, 2020.
> That's 817 days ago.

817 days And the field is documented, so nothing to do here regarding
"rng-seed".


> So I call BS on this being a continued justification for rejecting this
> patch (which apparently was submitted by Florian over two years ago
> too). 

Because patch is not needed and is already done....

> Rob clearly hasn't followed through.

You got there link to repo, what do you need more to follow? Remove the
chosen.txt? Sure - submit a separate patch.

>  So please apply this patch so
> that chosen.txt remains maintained.

Instead submit a patch removing it. There is no particular point to
duplicate bindings and dt-schema is the core here, the main one.

> 
> Later if he moves forward with his plan, then no harm done, since the
> file will be deleted anyway.
> 
> Sometimes it's best to reassess things based on the reality of the
> situation, you know?


Best regards,
Krzysztof
