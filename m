Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4825A4FF49F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 12:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbiDMKXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 06:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbiDMKWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 06:22:53 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29792E9ED
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 03:20:30 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id t11so2893184eju.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 03:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bATJ4q38nza8nm3TeCObwq3H2oesrO8r2myYf6nLdCE=;
        b=XRxxEqkC57hek0ngIr5A7g8gQGrFiEqUrtiZQgCisY9SlNLiaUU8uegv55IJbBEtD2
         JRWf2bZd3D4Ye6V7+a4j9Kz6daBe2+myG7Kr9FvaDn7tfWLnrtCh7aQIBiTjwN9M41B4
         EsVdJJOl5yyuIGED3eDqS9uvFpnUDG4soGKDywLr942t4CLlUMy+fS1PO3/hvv+qPcHo
         EDjy46toDrzMFcT7plWXsNcWJJD2a+xSC7bGYdqiwmhLxushwI56l/ZklKkaq0i20OlQ
         MCvWNfsDwCH4pJbLCOTU0kjBqY+pW3tYuIlwcf2RXkhBpRHsU94uonmaCcNAnRmxdUhL
         k7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bATJ4q38nza8nm3TeCObwq3H2oesrO8r2myYf6nLdCE=;
        b=oudH1+jX6uEOeIxr7LpPoxSMd3f2Gsi5rw2DtsBVzFB6jh8kR79CsRhtDeOa6xQ0AG
         hLPk0lO9BgDirojszi2RURNeaWVWQFt3d4/DFHd0jbfVc3xk7cB4sqmCXYSaqlc3pfZq
         RuMYeFuk3Fx8S7nKfN378985acz8tmH0gQhrSr4TfFswZBr0E2aF5MRg4z3NA52N/2e6
         T2l+xmXtcF2vX2aSzQB5A3Leq5PdBvapImISaqUHgfWKkRcEr9NkZ8biiIHRgGNuLscs
         +aA8XW3Z9kKMl/sM5NGPbTVDCQ+wiILn6j7tZ9wuv7I/So47lzC6XVtutOySV4Ie2bEi
         Sotw==
X-Gm-Message-State: AOAM531rcsv3/aqNAk5tAIRQ6UoYCo9GKuf4FadPjjzgFSucZpvnGAEq
        ZzI5ZyNUUU55m3KCFUn9YhiYfQ==
X-Google-Smtp-Source: ABdhPJxhPTLP15qmVOv/Ev8JlAjIqGOrsXGJmG/K04tp00IOszuQBygrxlGDOEtz2wioDGbXRlRFCQ==
X-Received: by 2002:a17:907:7f8d:b0:6da:b3d6:a427 with SMTP id qk13-20020a1709077f8d00b006dab3d6a427mr37062103ejc.509.1649845229375;
        Wed, 13 Apr 2022 03:20:29 -0700 (PDT)
Received: from [192.168.0.203] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id a1-20020a50da41000000b0041c83587300sm1035533edk.36.2022.04.13.03.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 03:20:28 -0700 (PDT)
Message-ID: <ed2167af-fc9f-1f52-e8e2-c0881f5d53c6@linaro.org>
Date:   Wed, 13 Apr 2022 12:20:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 0/2] memory: omap-gpmc: Allow module build
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>, krzk@kernel.org
Cc:     linux-omap@vger.kernel.org, nm@ti.com,
        linux-kernel@vger.kernel.org, kishon@ti.com, tony@atomide.com,
        miquel.raynal@bootlin.com, vigneshr@ti.com
References: <20220411095516.24754-1-rogerq@kernel.org>
 <164984299612.34759.11981181842672620752.b4-ty@linaro.org>
 <20428012-f164-c03b-fcc5-d3d8df812aff@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20428012-f164-c03b-fcc5-d3d8df812aff@linaro.org>
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

On 13/04/2022 11:50, Krzysztof Kozlowski wrote:
> On 13/04/2022 11:43, Krzysztof Kozlowski wrote:
>> On Mon, 11 Apr 2022 12:55:14 +0300, Roger Quadros wrote:
>>> These patches allow OMAP_GPMC config to be visible in menuconfig
>>> and buildable as a module.
>>>
>>> Changelog:
>>> v3:
>>> - Remove not required MODULE_ALIAS
>>> - Mention in commit message why we need to remove of_match_node() call
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/2] memory: omap-gpmc: Make OMAP_GPMC config visible and selectable
>>       commit: 656d1be692be78b825954e0a2a47fcae81834633
>> [2/2] memory: omap-gpmc: Allow building as a module
>>       commit: eb55c7180be67774aa728a3c450de441e0dedb5d
> 
> And dropped. You have a checkpatch issue:
> 
> WARNING: Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db ("module:
> Cure the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
> #127: FILE: drivers/memory/omap-gpmc.c:2664:
> +MODULE_LICENSE("GPL v2");

I kept your first patch (visible/selectable) but I think it should be
dropped as well. You need to test it more:

https://krzk.eu/#/builders/63/builds/162

Best regards,
Krzysztof
