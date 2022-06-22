Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6E4554669
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348072AbiFVKKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346272AbiFVKKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:10:30 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410D63A700
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:10:28 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e25so18794080wrc.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=eEsdR3TRm+vL6zz3f95iag483n0NsrY0R5hgPLAoA04=;
        b=KXA4foDCHZexV2GRRixlxLA8pD/5pHbA8m8EJU7/l65KRqcO+XBNv5/lmNLCQz5iBL
         z0Wq4QTvnxqpZ/UmxFoBwts0BUcz/vPtka/fc+cX2vHTJNQ0hJSjZTXjHC/VxdLP7hmk
         46/35SbGwUU7S/usG51/yAZD5lVEo7EkQv8APGTUGFYCyw5iPKy6twKk1h/Y5RGr2i7A
         Wc0ccV7xND46AUXzBQH1umQGBPtYmXtMn1otWXR/ZCgNbL0uRYytWrlAMfjqM6BLQ0uZ
         zZ94oFK35dheDf7cMHPqDQJMsQFUCCg+yFiXkvAHO1UpIBGOGxxPjK/Aqr21kSli12gC
         2fQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=eEsdR3TRm+vL6zz3f95iag483n0NsrY0R5hgPLAoA04=;
        b=RZ70qZGyESWC7iidD1Dor6jlHbGqmM2/8NdMwUpkwmUlVAEp71WCgE2pcrGAj4KbKc
         awy0yXB7X5oU/V8TeuIHGwmzxUf5E56jslVwBQthxiAFdopymy9oltWLDVGlSo9+HN6K
         Oz75u+FZFaDIsAx+e+8UkVRdZN7xgWGFh3wrD/2rH8ro3deUUzylsnz/6GiaECj5o1he
         dg2aXsAfLBLcPzeFFZhtHwqmn39bio8YdIab37vOGCdf+N6fwNOIs48cJE/QeRhvK7D3
         SBPwAFGxvI/JrbW6LvHtGUc47vGHx19y9NC8wdnnkgr5l5WRLlnmg07YV7UbPSvdBpUm
         jw8w==
X-Gm-Message-State: AJIora+7TAxyIqBBAcI+ms4gY+GdDrRxsg+53QXV9Rn7ehJd16GItWE/
        PlDxuADBe7J0INpukHW0VcyL/A==
X-Google-Smtp-Source: AGRyM1vEBgwyvTcItxhgT5nHyKeJjZ+rV6peH7ZoCYG/Da8zdGhFiHumewdl3lV9D2JKYjJVuJJ0uw==
X-Received: by 2002:a5d:5c07:0:b0:218:544d:4347 with SMTP id cc7-20020a5d5c07000000b00218544d4347mr2402611wrb.107.1655892626865;
        Wed, 22 Jun 2022 03:10:26 -0700 (PDT)
Received: from [192.168.0.224] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id v6-20020a1cac06000000b0039c673952bfsm25057577wme.6.2022.06.22.03.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 03:10:26 -0700 (PDT)
Message-ID: <fd015563-0326-c897-4ecc-cc77e8a4a14c@linaro.org>
Date:   Wed, 22 Jun 2022 12:10:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/7] dt-bindings: arm: aspeed: document board compatibles
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org,
        David Wang <David_Wang6097@jabil.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Steven Lee <steven_lee@aspeedtech.com>,
        Ken Chen <chen.kenyy@inventec.com>
References: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org>
 <20220529104928.79636-2-krzysztof.kozlowski@linaro.org>
 <0207c2fe-7c01-7852-3cd1-74297cd4857d@linaro.org>
In-Reply-To: <0207c2fe-7c01-7852-3cd1-74297cd4857d@linaro.org>
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

On 20/06/2022 13:06, Krzysztof Kozlowski wrote:
> On 29/05/2022 12:49, Krzysztof Kozlowski wrote:
>> Document all compatibles used in existing upstreamed Aspeed AST2400,
>> AST2500 and AST2600 based boards.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../bindings/arm/aspeed/aspeed.yaml           | 83 +++++++++++++++++++
>>  MAINTAINERS                                   |  1 +
>>  2 files changed, 84 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> 
> Joel, Andrew,
> 
> Any comments on the series? Rob applied only patch 1, so the rest is
> supposed through Aspeed tree. Shall I pick them up and send to arm-soc?

I'll grab the bindings and DTS. I'll keep it on separate branch, so I
can share to avoid conflicts. If anyone prefers to pick it up, let me
know so I will drop them from my tree.

Best regards,
Krzysztof
