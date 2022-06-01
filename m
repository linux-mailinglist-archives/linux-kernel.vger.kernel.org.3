Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63BD53A631
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 15:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353337AbiFANt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 09:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348518AbiFANt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:49:56 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716F56EC68
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 06:49:55 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id er5so2245931edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 06:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SSTmyO7r/mS6th8O2P4H7/DxEelyPzQghynixwdI0fw=;
        b=bO8DTowex8MiGGLFPY7tvF6/wGDXcK4tkC0V9koEkl3HGfUXH2oC2o1VSOchys1J8n
         6hpyeQ+GhM8yQvnLuyD0qwLhXwMvycLRUBYkWYQByxnikhuC+CKHCg2skik+Zf7VA68C
         CXduRsfOhC2L4fY1rU/prtawC9XXlec2feeCMFnMHkARNzLX0CmnKcwPDSiV3N28elaa
         cHgBapAtYTLryGCpt/GGJ0+rQfQwU+/JkDi+SZCJQE9NSV5q+qpgRLI6TNX4v5u/8E0H
         ZAXUzU7RDRkshukPiO3d02ewfZ3AIBZp6T6bVlWldszxOh1rAlsgTLlJoafoyeQXC8pn
         EPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SSTmyO7r/mS6th8O2P4H7/DxEelyPzQghynixwdI0fw=;
        b=WjpsDP6oTxKVyiQGy7cn4yba+zLs3lGoeZUXBWjJNJoMrBAFdUm9UjXkYUhk0l56fl
         JGVOZg1Cyv5jjFK/3OBFUBmv7TcULiy2HwUlNcnUt23AVsitT7pVamQTwvKBy2kgIfE3
         HP3ZH2z3DYegIqgBqtnFd0IAYzY2DjtAsRdHqZoivwR6vTpTyqlC5IOPVFiG5XHDKv2T
         gf0et4YKQf9AAKrGTZGceR+bGX7LWbXajsx9kkRHqvzFmH3QDctImIDTVfEaG7t4BZXp
         p3uFnGJln6IrYWp5yY9WNAwMzVvBdJof3SDBY+UFufH3HcaBvgnnslrnwZfkoGsGfjfN
         JtzA==
X-Gm-Message-State: AOAM531gUl3ASsEEHQSnb8baRo6rgVT+ObHNOgcbVY6D9tgn8BJ6KDj4
        WWPmc8BxA9lpOkRRvRqxmk4FVA==
X-Google-Smtp-Source: ABdhPJyZxcpKpGRWORTwSy90l0in3vkdzYK1jCmwYLf7w0jKuXiB3mEJOnpgLSp23aWdqSgXVoTJYg==
X-Received: by 2002:a05:6402:2405:b0:425:a4bc:db86 with SMTP id t5-20020a056402240500b00425a4bcdb86mr12092eda.98.1654091394021;
        Wed, 01 Jun 2022 06:49:54 -0700 (PDT)
Received: from [192.168.0.179] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id m9-20020a170906580900b006feb7b1379dsm699306ejq.181.2022.06.01.06.49.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 06:49:53 -0700 (PDT)
Message-ID: <7978ed42-ff8b-567a-9dbe-8535d8698328@linaro.org>
Date:   Wed, 1 Jun 2022 15:49:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: document deprecated Atheros
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220529111515.182810-1-krzysztof.kozlowski@linaro.org>
 <CAL_JsqKcn+NDaPvRYBFbOZZ-x7fKPLenGBh5xdUPBU3usk9hnw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAL_JsqKcn+NDaPvRYBFbOZZ-x7fKPLenGBh5xdUPBU3usk9hnw@mail.gmail.com>
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

On 01/06/2022 15:47, Rob Herring wrote:
> On Sun, May 29, 2022 at 6:15 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> Two old boards use "atheros" prefix instead of already documented "qca".
>> Document it as deprecated to fix warnings like:
>>
>>   at91-gatwick.dtb: atheros@0: 'atheros,board-id' does not match any of the regexes
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 3 +++
>>  1 file changed, 3 insertions(+)
> 
> Can you resend this not dependent on 'dt-bindings: vendor-prefixes:
> document several vendors for Aspeed BMC boards'.

Indeed there is a trailing "ASRock". I'll send a fresh one.


Best regards,
Krzysztof
