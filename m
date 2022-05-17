Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE13F529AB0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240521AbiEQHXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240026AbiEQHXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:23:10 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C3E433A7
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:23:08 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gh6so33009371ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XCRBYrzQvjS4psczJqPKiR1yzwCr9m3dz6Q37fPyVWc=;
        b=Y+3U6RnS5g0NIQcBmmgAFfin+pi/+a/jPrVCWPhBW+wYgF2cSsb3M9D77GNCflSTLE
         DuAd444CkknzbOxbH53oJu1XKZgh2AoixtIitZUNJO3NO+Ydx9EvUHuDQMCpvSe43iEQ
         QEhcbkeZmmMYjJLcHMC8U+Cc712bPHzz/R0J0VQC32sQlLTywUuST3WoQJOu6G10pDPd
         Cs33cc3KwxDjJTyh9y51ug9mQtClFsS1n9R2JjShh8Eu1uO3rT90uSqpi64EvY/3rOFI
         ogIZHNtUCvcKf4lDtXgaceDzl7RbqErhWse6Z/rn76GdjFd8u+2WoqA6AufZNKXXBQD6
         U0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XCRBYrzQvjS4psczJqPKiR1yzwCr9m3dz6Q37fPyVWc=;
        b=BKuSIs5y0Uoq4e9VkIXWUUywUULQXtJ44XJy4iOjEqBDgVLEyF/IylD1ry7cOUEFZY
         aIcc/1TAYzwFw+xSFwd+CCm/JVefsDVV1e46eIEo7gr4dlFPXwXgWsqlU2cL3/fgYV9a
         DadxYyi6nRBLhI0ejlh1ra+6rpQ/foQeaQZbY+RfUGsRUwwzsR1vZ3SL/XHi8HGn3e1P
         4j79v+oPeAXNtAPJOa04WFRpIwvk5WgK+FqOb6oHLMCbloRTHIilEyLj4uxD9n9l5uzl
         NhYU2aYRYiCDlALqno0+3jY4aI1mZgMKHRgiZGHh9g9T04xykI5FC8I5kBsaDbNkcW4L
         lC5A==
X-Gm-Message-State: AOAM533zXRhN0kSjdMkS02zrfKtxr3vtBzM2nBjBHqAcyYIFVWHX6TY7
        kAYMfXEGdjPWyX+xQ69wxwB+YQ==
X-Google-Smtp-Source: ABdhPJzfy58cHRd3DOtRyIs4xD25jMmDSEeBJchqbp3rg8jiISTRXl4sNXSb1FiD4HqnpEQqekmgeA==
X-Received: by 2002:a17:907:3f1d:b0:6f4:ce49:52ea with SMTP id hq29-20020a1709073f1d00b006f4ce4952eamr17969703ejc.47.1652772187446;
        Tue, 17 May 2022 00:23:07 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id s12-20020a508d0c000000b0042617ba63d7sm6354380eds.97.2022.05.17.00.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 00:23:07 -0700 (PDT)
Message-ID: <c948c2ed-d222-5c16-4df4-daf078c886cc@linaro.org>
Date:   Tue, 17 May 2022 09:23:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 4/4] dt-bindings: arm: qcom: Add more sc7180 Chromebook
 board bindings
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Alexandru M Stan <amstan@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220513095722.v2.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
 <20220513095722.v2.4.Ie8713bc0377672ed8dd71189e66fc0b77226fb85@changeid>
 <125970b0-af71-1695-a3ab-10a159ac63a5@linaro.org>
 <CAD=FV=XR+WwWmrB1wGX65=szBc2PbGNOHbm2tiQT5Wp8CPG0Kg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=XR+WwWmrB1wGX65=szBc2PbGNOHbm2tiQT5Wp8CPG0Kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2022 17:16, Doug Anderson wrote:
> Hi,
> 
> On Mon, May 16, 2022 at 12:05 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 13/05/2022 18:59, Douglas Anderson wrote:
>>> This adds board bindings for boards that are downstream but not quite
>>> upstream yet.
>>>
>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>> ---
>>>
>>> Changes in v2:
>>> - Use a "description" instead of a comment for each item.
>>> - Use the marketing name instead of the code name where possible.
>>
>> These should be published with the patch adding their upstream DTS/DTSI.
>> There is no point to list all possible boards in the world from any
>> downstream source. For upstream there is no particular benefit for such
>> bindings, for downstream you also said there is no.
> 
> Joe has been working on upstreaming these boards:
> 
> https://lore.kernel.org/r/20220510154406.v5.1.Id769ddc5dbf570ccb511db96da59f97d08f75a9c@changeid/
> 
> I think there is little chance that they won't go upstream at this
> point. However, we're at a time in the merge window where it will be
> several weeks before anything can land. If Joe were to include this
> patch as part of his series I suspect it would be much more confusing
> because it would add an unnecessary dependency between my series and
> his and make it harder for Bjorn to apply it later. Keeping the patch
> with my series means that the series can be applied more easily.
> 
> How about: I'll add a link to his latest posting in my next version.
> Then, in the future (after these bindings patches have landed) then
> future boards can go together with their bindings.


Sure, sounds good.


Best regards,
Krzysztof
