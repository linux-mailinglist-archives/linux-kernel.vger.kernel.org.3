Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0039153A39C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 13:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352512AbiFALI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 07:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352508AbiFALI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:08:26 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED88D5D1BB;
        Wed,  1 Jun 2022 04:08:25 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 309B11F43FFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654081704;
        bh=f8UaqDooK99deu8q+6dpzulRy5t5QoE3TXUqdXno8fQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YVFOT+A4ShlTY5Zkr6DyBJxCpk79ZaXWTkrvNukTuUyVEddCTqztzJX3FLOSu1X1B
         ftbNEdVSZ8UNU1OKiuBHCK3aKkUaREh0c8CP38jNA3El8nbLZyay40vPhIO6CONIkX
         WxyX3SA54Q4/HrcfJVoEnuqdv1idXQzBuh0cVSN4w477w9thKsrFJamPM89eRTRWu/
         NdzwMl+TXfqwBIo2/24IPc/BLeUy4fP5Aydb8sdZmdusjda79kqTlSO7p7Ed/9RDK5
         mW7DUBcChxZOG/ZcK+Kol3I1plZlAoX28LjgMJ7pNdzc6hyj0lThvqK/nczBZqv9ab
         NO3lZZFPBIfkQ==
Message-ID: <0682f3a6-01c7-66cf-05ec-33bd3d862116@collabora.com>
Date:   Wed, 1 Jun 2022 13:08:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 0/2] MediaTek Helio X10 MT6795 - MT6331/6332 PMIC MFD
 integration
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        lee.jones@linaro.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, johnson.wang@mediatek.com,
        hsin-hsiung.wang@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220520124617.228808-1-angelogioacchino.delregno@collabora.com>
 <fab40b87-7471-83a3-d154-aa2da0b7d23f@collabora.com>
 <c2f2a3a2-ea5d-59a7-eb84-d59b7d9bff47@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <c2f2a3a2-ea5d-59a7-eb84-d59b7d9bff47@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/06/22 13:07, Krzysztof Kozlowski ha scritto:
> On 01/06/2022 13:03, AngeloGioacchino Del Regno wrote:
>> Il 20/05/22 14:46, AngeloGioacchino Del Regno ha scritto:
>>> In an effort to give some love to the apparently forgotten MT6795 SoC,
>>> I am upstreaming more components that are necessary to support platforms
>>> powered by this one apart from a simple boot to serial console.
>>>
>>> This series adds the necessary headers and support for the MT6331 with
>>> MT6332 companion PMIC in the mt6397 MFD driver, along with some basic
>>> devices.
>>>
>>> Adding support to each driver in each subsystem will be done in different
>>> patch series as to avoid spamming uninteresting patches to maintainers.
>>>
>>> This series depends on another series [1] named
>>> "MediaTek Helio X10 MT6795 - MT6331/6332 PMIC Wrapper"
>>>
>>> Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.
>>>
>>>
>>
>> Gentle ping to not let this big effort (with drivers depending on this one) get
>> forgotten and wasted.
> 
> Yeah, but it was not even 2 weeks since posting and we are in merge
> window. Please resend after the merge window.
> 

Understood!

Cheers,
Angelo

>>
>> P.S.: Mark wanted to merge the regulator drivers for MT6331/6332 from another
>>         series that depends on this one (but compile errors due to said dependency)
>>
>> P.P.S.: Lee: Reporting what Mark said (Full context in [2]):
>> "I'll need a pull request for the MFD bits I guess, please make sure Lee knows
>> that's going to be needed."
>>
> 
> Best regards,
> Krzysztof


-- 
AngeloGioacchino Del Regno
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718
