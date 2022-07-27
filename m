Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EA45820DE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiG0HNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiG0HNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:13:50 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CBA9586
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:13:49 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id w15so17799785lft.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ssg4tRasr4DBZJdl6J73astDPl5I4c2/6pZV2Ko1zDg=;
        b=p7y2YstySuGWCWGMOCXucGNBqC60lFvOVhWKJj4kFmbSertbFPzRAen3ld28vGIP/V
         cVqz0GdshAIp19Q85UxA3WWuPVbhMvIQDf1MsRsn1wc++jPYBV2he98aQaANdhUSbsMz
         bAQkNv0J7JIFzft9JYLrUjhavcW9aaw967EZQE8Qq3mDl+chdRUNerZj4Sp3l6FGHZjd
         t20+lQbIowTX0GJWhelQZFJueC4uDd7BuVgXuy1oV4GMXaOKmITg4q58+qBhnUy1x5u0
         yviK4Nz/cEvWTiLB8CcyqUXQFUVV5Vy/ofoqZXOH1EyhRzSIcMdZ9keZPHAEPKu/2L6X
         I/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ssg4tRasr4DBZJdl6J73astDPl5I4c2/6pZV2Ko1zDg=;
        b=sjWt8ryJjCWBBkS4Q84ScpeXAXXrIEQ8+8Q2QRJmuAluCIwwPBquqDAA5n4AETFYFz
         NM4nCIepUnO0FdwSVv/K/cekztBfSTwbYW12VbhB1tbfFzRHjDLnf30AqA5m2X30TwD+
         dFJzQN7TL2uUiPUKiM5vdTnNVfwf0SXy0iuMrqr5xwnbLB7mS11q5fF/SUDSee/D8v+k
         irCBZwJgQnAmA0aRAzq6XKilwccrAL5ZlEDBTG9piUP08eQzjxciCHSYCxvoJoUcf3E6
         /b+s0HYxTyPxJlyzlFJWCKdqwYQTxD9eV4joiIJ4BWLN9LDK1HeYnppOwcVsh+ZS8MLt
         SPjQ==
X-Gm-Message-State: AJIora87yw7MbaduPUcrX8cQeT9hpJ9yfIknza7elMYPxtI+g1rxgcIF
        sce6HaorAL55r9tWACAX5GwR5A==
X-Google-Smtp-Source: AGRyM1tnPRmGL8sIq6AcjbGyICwHFDjJ/A/xNKBKL5VlEN4NDa4zhRLe4k8vMTsts1cvocOPufsErg==
X-Received: by 2002:a05:6512:3041:b0:48a:9c71:8ee2 with SMTP id b1-20020a056512304100b0048a9c718ee2mr3208891lfb.369.1658906027938;
        Wed, 27 Jul 2022 00:13:47 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id u11-20020ac258cb000000b0048a884bdb84sm1756297lfo.52.2022.07.27.00.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 00:13:47 -0700 (PDT)
Message-ID: <bf470847-9e96-fc5e-0b82-d05068aaeb47@linaro.org>
Date:   Wed, 27 Jul 2022 09:13:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 1/2] dt-bindings: sifive: add cache-set value of 2048
Content-Language: en-US
To:     Conor.Dooley@microchip.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        atulkhare@rivosinc.com, sagar.kadam@sifive.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220726170725.3245278-1-mail@conchuod.ie>
 <20220726170725.3245278-2-mail@conchuod.ie>
 <246f132a-a23d-7c53-38a7-2bcec50d65e5@linaro.org>
 <c77f34aa-ff29-b18a-a3a7-9d90145364a8@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c77f34aa-ff29-b18a-a3a7-9d90145364a8@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2022 19:39, Conor.Dooley@microchip.com wrote:
> 
> 
> On 26/07/2022 18:35, Krzysztof Kozlowski wrote:
>> On 26/07/2022 19:07, Conor Dooley wrote:
>>> From: Atul Khare <atulkhare@rivosinc.com>
>>>
>>> Fixes Running device tree schema validation error messages like
>>> '... cache-sets:0:0: 1024 was expected'.
>>>
>>> The existing bindings had a single enumerated value of 1024, which
>>> trips up the dt-schema checks. The ISA permits any arbitrary power
>>> of two for the cache-sets value, but we decided to add the single
>>> additional value of 2048 because we couldn't spot an obvious way
>>> to express the constraint in the schema.
>>
>> There is no way to express "power of two" but enum for multiple values
>> would work. Is there a reason to limit only to 2048?
> 
> Copy pasting from the cover:
>> I don't think that there's value in speculatively adding values to this
>> enum especially as (I think at least) the scala for this cache IP has
>> been released publicly:
>> https://github.com/sifive/block-inclusivecache-sifive/blob/master/design/craft/inclusivecache/src/Parameters.scala#L32
>>
>> The two compatibles in the file match only against two specific cache
>> implemenations: the fu540's & the fu740's. I would seem to me that, it
>> would be better to lock this to a single value per compatible since the
>> 1024 applies to the fu540 & the new value of 2048 applies only to the
>> fu740.
>>
>> I have not made that change, I simply wanted to repackage this series
>> in a way that could be more easily applied & restart the discussion.
> 
> TL;DR: I would limit it to 1024 & 2048 to match the only implementations
> although not in the way this patch did it.

The explanation in cover letter is good, but it would be good to have
one sentence like this in the commit msg. Otherwise your commit is
actually confusing - you mention that you want power of two and then set
only 1k + 2k.


Best regards,
Krzysztof
