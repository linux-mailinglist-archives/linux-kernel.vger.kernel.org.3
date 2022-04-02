Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51384F061F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 22:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbiDBUVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 16:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344372AbiDBUVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 16:21:01 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D057336E01
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 13:19:07 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u16so8840316wru.4
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 13:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=efzOv4dIr4tgBETsjp5OsgnPN6Aum/KcEtDZ5+WY/5s=;
        b=NWCjcZfwqzrcjp5G5OuxNnq/23Iby1ljMuBql2dbBOBMNfS6NzDqEVqTbC0EETLXxw
         9U9H72AWN9sdKdf4Ds5vMKB0jy7J8JqOVB8NWX6zyWmv1ZNy9P71C9heOmKCvJhSX9sB
         rJhUI5CgZwfD5XZxm7gS9hELr3qWF9wY3KHePW5cvO9ismWLhNC+9vbjVaawNAWYHt3E
         t1OtmWsPSjuP1X4If5aUxoxG3bxQBBSDeMfnljMbpCyH/JvOStbnsesYxBL1Tg+gVmPi
         r7ZDAFCaXKIaNjkgnKj9OOtz03dpR6cthm3YvqSBnJZ+8bELz8fvkBGlhVL8ViSPc9RW
         6wFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=efzOv4dIr4tgBETsjp5OsgnPN6Aum/KcEtDZ5+WY/5s=;
        b=RiuC6r2DVtLZZqgsbHX5xs1z937UrEoly1tocdv+Z7U3uUb6r9ussSNrTJxwvPTotJ
         O4/WgwEzZWM7uMM7AlhsaB+RYu7/C8CrBG8qJLzz3QvD4Jc3DS4Jd4JPjpIaS3eOmHPp
         YS4VdEaiaawSmyJTuHqsJ9AijB6PAIo/T+BtT5nA5yKOC3lEJzRYau6fahiXxU7g2QC3
         b6suOHxJe/nmUyAFkiCPEbFHa1FRmYX6d5hred7tN3715d0o/YEqeNTkSqkTLYNlbIzb
         rxjegoETeQmoDTewplxKUvGTSmJTsKQwSYKezIEE6iYcT0AX3Co88UvISfa5HtbxBgbg
         yYdw==
X-Gm-Message-State: AOAM530GXHanlQcPXwTEZ3czId1Cf984kgItBGomdLxsuYzp5N5ytJ4t
        8lTWTnCZlRkjqlkNykSDMGuY6g==
X-Google-Smtp-Source: ABdhPJwwADkU22Qt/uwzkEAdoHaiz77EIhH44oK6ZYfgfzgGV14uHRVicGD7jKPWsdyDYtAt/fb4Sg==
X-Received: by 2002:a5d:58d9:0:b0:203:fc5c:ba87 with SMTP id o25-20020a5d58d9000000b00203fc5cba87mr11845270wrf.79.1648930746405;
        Sat, 02 Apr 2022 13:19:06 -0700 (PDT)
Received: from [192.168.0.171] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id 2-20020a056000154200b00203ee1fd1desm5810812wry.64.2022.04.02.13.19.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 13:19:05 -0700 (PDT)
Message-ID: <793a88b8-148e-c9a0-3c21-4f15380e1085@linaro.org>
Date:   Sat, 2 Apr 2022 22:19:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 28/33] dt-bindings: crypto: rockchip: convert to new
 driver bindings
Content-Language: en-US
To:     LABBE Corentin <clabbe@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     heiko@sntech.de, herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <20220401201804.2867154-1-clabbe@baylibre.com>
 <20220401201804.2867154-29-clabbe@baylibre.com>
 <30305936-4b69-e1ce-44c2-0d1d113b460e@linaro.org> <Ykitm1uLmQtNy3b2@Red>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Ykitm1uLmQtNy3b2@Red>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2022 22:10, LABBE Corentin wrote:
> Le Sat, Apr 02, 2022 at 01:53:58PM +0200, Krzysztof Kozlowski a écrit :
>> On 01/04/2022 22:17, Corentin Labbe wrote:
>>> The latest addition to the rockchip crypto driver need to update the
>>> driver bindings.
>>>

>>>  
>>>    reset-names:
>>> -    maxItems: 1
>>> +    deprecated: true
>>
>> Why reset-names are being deprecated? Did we talk about this?
>>
> 
> Since I use the devm_reset_control_array_get_exclusive, there is no need to have reset-names.

The reset-names are not only for Linux driver. In any case, Linux driver
could get always reset/clock/gpio by index, not by name.

Additionally, there can be different implementation in different
system/user of bindings.

Therefore the driver implementation does not matter (or matters little)
for the bindings, so for multi entries the reset-names are needed.

Best regards,
Krzysztof
