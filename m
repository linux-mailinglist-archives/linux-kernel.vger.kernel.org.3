Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757AC4F8392
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344968AbiDGPfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345280AbiDGPe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:34:59 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BC31275F
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:32:47 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a6so11759767ejk.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 08:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DFgO9JddDHmoRuVn2ZPzU+MXFPn5DQlDECjTYk/+IjM=;
        b=etnNwUNrZy+kn1KBn4YIpJwNbeshptJH4Fm6WZ+D4OqvvMVOUq0rLC0veEqzlPjQmB
         6jcYLMPVZ5rrNmVHisvWszE0xv0oteiK+4lHaPAuOktcV35kdr08ILA52HkCCCAFyEm3
         BGRrvucNz7UduF8B3mSY97tls+29nup8xDi3h+0XvvxUdncbBpUm65jRbM/KrU6En3q6
         qvkiGNHmtiNYbsH4Nkr8aI8UsKvI8DX46Xr0odQBjHxtz3893zyk9V6V+rWUzvBonVav
         AobD41RDLEWiY5+K0G49Q5CvjzqK7MV6ZFR75Rp+WMN2gQhiNBHIQag/sqzZsenvJ/p8
         Mcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DFgO9JddDHmoRuVn2ZPzU+MXFPn5DQlDECjTYk/+IjM=;
        b=Gy2pkUIDIrfRqIvK93f1bWtpn0K5I0Oa1Ah9fucDXfHjog0VqNO+LyUDfycS2rPyiA
         VydSfhCBAWFBR3I/jJu/DiOwGIyZZYj73Tqb73JLD/F+73eAC+ndmFHeJ0p+esFhaGRZ
         n6n6fnboR2eLYJbe+AkPPL/sFUIp0tDcyAqYqKFtXM6UbjVo0hQkKc0jHY2tl6N+SHbT
         RIlPp/7x+xXgJy2y9HOVCVTNXuZv+2dRatL13T4dGr+QXAw9eRLBqMQCcX+84x4VlfT3
         xtn9tAZPRk4O8TUj1lkPHbZ+Mw+64Z4it1XOXgHp/wrq8TkqM9Dnfvo3t1XQQysyZ5Wb
         Eybg==
X-Gm-Message-State: AOAM533qWK8NiDOsXJqpbh3HeDHzf0pOrhAz4L/VXMwT4/TA+e9ASxk6
        HNfsZcDqp20Ow598/2OuGD3sDQ==
X-Google-Smtp-Source: ABdhPJyCd/4Er+epPFAKRZT1fWjWQhW/F7nuejDSiXLEHH7ibZ0yXXXeFBsJf3FdnumCHcknC+egKw==
X-Received: by 2002:a17:906:bb01:b0:6a7:df9:d67c with SMTP id jz1-20020a170906bb0100b006a70df9d67cmr13784767ejb.733.1649345565891;
        Thu, 07 Apr 2022 08:32:45 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id f3-20020a056402004300b004162aa024c0sm9283672edu.76.2022.04.07.08.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 08:32:45 -0700 (PDT)
Message-ID: <4c9161b2-0146-56c0-5c86-7df31f43b0ac@linaro.org>
Date:   Thu, 7 Apr 2022 17:32:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [GIT PULL] ARM: samsung: Fixes for v5.18 (current cycle)
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, arm@kernel.org,
        Olof Johansson <olof@lixom.net>, soc@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>
References: <20220407080545.112290-1-krzysztof.kozlowski@linaro.org>
 <164933532417.2189563.2554142563906098629.b4-ty@arndb.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <164933532417.2189563.2554142563906098629.b4-ty@arndb.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 14:42, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On Thu, 7 Apr 2022 10:05:45 +0200, Krzysztof Kozlowski wrote:
>> For the v5.18, please.
>>
>> Best regards,
>> Krzysztof
>>
>>
>> The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:
>>
>> [...]
> 
> Merged into arm/fixes, thanks!

Thanks!

Let me just remind about possible conflict (but you were on CC):

-------

Documentation/devicetree/bindings/memory-controllers/renesas,h8300-bsc.yaml

between commit:

  8a1e6bb3f78f ("dt-bindings: update Krzysztof Kozlowski's email")

from the samsung-krzk-fixes tree and commit:

  1c4b5ecb7ea1 ("remove the h8300 architecture")
-------

Best regards,
Krzysztof
