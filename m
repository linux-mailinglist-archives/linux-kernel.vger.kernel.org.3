Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B165D529C16
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240931AbiEQIRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243356AbiEQIQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:16:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C03C4B43B;
        Tue, 17 May 2022 01:14:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 219F71F4423C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652775273;
        bh=e71S4wIuVuA79Q95c0v+L8CnYV43+ZQVjRchLsfKsx4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AgCoAKkvvp4nrjNV6aZz6RXQXb+Cbzt9PK5dhhR/erkMhq0ItVYzF1/P1PhHRKphY
         fLHouYqsatBCKHd13F/oHLAs1qXZm3VB6Lce50gDDVQdjP6+Kvowpjpk/XfQvr9PA5
         oZB4W1Lwo7z3O5LqI6W9ob1uw2YQ3D7BkKMSegMcFRr+rdooEx1H5u+zWnNCsgnDt2
         xMA5crRT44j96Is+3ExKju/RWR5c5lUzWqZKbP7aZ+LQ6xAa9M0CEq6GT9VMZ8CYAS
         Eb92pow2UakeOR+Y6Bdh6Xc8/hdxs3Tue8G2sTBpPN5mzcv5fVfG+xB2xxRrUIXhNZ
         LycdNcCNjLVYg==
Message-ID: <32c97e47-47a8-d033-4948-3c73a4313703@collabora.com>
Date:   Tue, 17 May 2022 10:14:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 5/7] arm64: dts: mediatek: mt6795: Add fixed clocks for
 32kHz and 26MHz XOs
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com
References: <20220513171617.504430-1-angelogioacchino.delregno@collabora.com>
 <20220513171617.504430-6-angelogioacchino.delregno@collabora.com>
 <03e99a02-1233-3882-e1e5-24ab1bbaf257@linaro.org>
 <0f303425-3b12-7573-b201-030d4d044db8@collabora.com>
 <d78e1936-a0ab-663d-1381-b537bfd7f07d@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <d78e1936-a0ab-663d-1381-b537bfd7f07d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/05/22 16:51, Krzysztof Kozlowski ha scritto:
> On 16/05/2022 10:51, AngeloGioacchino Del Regno wrote:
> 
>>>
>>>
>>
>> I should reword the commit description to be clearer, sorry about that: I
>> went with "exactly what I've done", but looking at the actual diff, it is
>> just a rename. What my brain was ticking on here was about removing clocks
>> that didn't really exist (uart_clk is not a fixed clock, etc), and adding
>> the ones that do exist.... but then again, the result, casually, is a rename.
> 
> Yes, some better explanation would help.
> 

Will do for v2 then!

>>
>> In any case... no, these clocks are not board-specific for two reasons:
>> 1. AFAIK, these fixed clock outputs are from the SoC itself, not from
>>      external components placed on the board, and
> 
> This would be fine.
> 
>> 2. Even if these were from external components, the SoC *needs* these
>>      ones to work and any board that doesn't have these fixed XOs simply
>>      wouldn't be able to work.
> 
> This is common pattern and Mediatek is not different here. In all cases
> these are needed by SoC and in (almost?) all cases these should be
> provided by board DTS. The DTS describes here the hardware, the board
> has the clock thus the board DTS should define it.
> 

Right. If external components are strictly necessary, physically, they're
still external components and not inside of the SoC, and anything external
*may* change depending on the (hardware) implementation.

Anyway - I was wondering if splitting this change in two commits would be
better to let people understand what's going on... probably it would, as
that would clearly show both the addition of the 32K/26M clocks and the
subsequent removal of the other two: I would at this point do that, what
do you think?

Regards,
Angelo
