Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11411552428
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 20:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245579AbiFTSmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 14:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239388AbiFTSmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 14:42:18 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB991FCD1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 11:42:17 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id e2so5377910edv.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 11:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=xOKx+qKsJ5kkTi5MlwCM1JyykoXmTfPgRpq/ljnv+ss=;
        b=l8DTBZm8GsYTad7S4RC0ysTwTF2/7iwEpZXfVf+xJV6L1Xa5RkgpPSvvMsZXdaB5/3
         vA5ZRLszN4/4z6paOgn28e8I7sUOS1BHVO92NfI7GwaHggZpG8biH9gkPXkeL471wvEa
         JGrZzUIdgdRmsXpJFaGoXX0LMMRBumNgCXEplSXM9VA0CJe7X7f5IhAC4D8cAh9FhI2W
         BzSB7vBEWJckVGOZyPRgGLkhMAvwVg2m4mLFhmj1s7FDD50lkDcl/LKvHCgVi07xlpOG
         kC6Lxma1miizSrToXMAeHQkIYrDHg0SYmcZYf4XDZBaQkOhRxGWO6WzMjPJdZq/y9k6K
         //BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=xOKx+qKsJ5kkTi5MlwCM1JyykoXmTfPgRpq/ljnv+ss=;
        b=P+F6/UKKmYFdclohgBSRI+3DT937Jz+8bJiRFjboJYlsg1/TaG43E8yBSNVqFs90iH
         g3JgD0MNZ5cbGQTYeJcQeBQ4MEo+dCKUki/Om7OEzjGt3cbXMJF5wyWdPzKOkRFu2Ug6
         xgDYO8brPQilLfQL9rCsZZ++rwaDKbW/hS0mHaC32yv/odYr1h7rXOT3HLl+oeBqo80h
         7kBHjLNdJFLGinAsOLxL0i3VweMRce68jkTq3dQB8/ugHCiAu24YF1nNoUGI/Rfht/1h
         OD9+8EhR+fVKljgd2g3IePGVf8Mo/woYLJif9sa7BGyJt6TI0fzFtxttAVQUWu+u4lYp
         bJJA==
X-Gm-Message-State: AJIora+ONTjfs79pAfawdYWeuslrSY4SgfqEuB1fqwJ+5hOXvNX4+jMB
        pAuzsutebtsEa0Avfx0Fzg+UjA==
X-Google-Smtp-Source: AGRyM1ugdXm1zGuybgNjMaAbTcsHD4Jx9iyyTn2gx9/UGgYYqST+9otKfvbn4e708ZpYpE9wPB13Wg==
X-Received: by 2002:aa7:cf87:0:b0:435:65c0:f59b with SMTP id z7-20020aa7cf87000000b0043565c0f59bmr20650374edx.214.1655750535850;
        Mon, 20 Jun 2022 11:42:15 -0700 (PDT)
Received: from [192.168.0.211] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id o7-20020a170906600700b006fe8ec44461sm6390117ejj.101.2022.06.20.11.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 11:42:15 -0700 (PDT)
Message-ID: <798877f0-707e-2113-300d-38a0205a9f59@linaro.org>
Date:   Mon, 20 Jun 2022 20:42:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] dt-bindings: soc: qcom,rpmh-rsc: simplify qcom,tcs-config
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
References: <20220426110757.80603-1-krzysztof.kozlowski@linaro.org>
 <1b39bff2-7eb1-b613-654d-59d11dcfe03a@linaro.org>
In-Reply-To: <1b39bff2-7eb1-b613-654d-59d11dcfe03a@linaro.org>
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

On 20/05/2022 16:54, Krzysztof Kozlowski wrote:
> On 26/04/2022 13:07, Krzysztof Kozlowski wrote:
>> The schema for "qcom,tcs-config" property can be a little bit simpler,
>> without the need of defining each item.  Also move the description of
>> each part of "qcom,tcs-config" tupple to the tupple items description.
>>
>> Suggested-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Hi,
> 
> This was sent a month ago... any chances for pick up?

I sent it on 26 of April, on 20th of May I pinged, so now it is 20th of
June.

OK, I got the point. :) I'll pick it up. Ping me if anyone wants to take
it instead.

Best regards,
Krzysztof
