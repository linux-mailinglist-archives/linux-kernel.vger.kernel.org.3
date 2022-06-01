Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49FA53A387
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 13:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346775AbiFALDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 07:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345880AbiFALDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:03:38 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD7C606D0;
        Wed,  1 Jun 2022 04:03:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 244651F43E8F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654081415;
        bh=gMn+H2/HTrmAs4pmgTH2YddRCIS1nTJanRQ0x2I/SF0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ow8WrVmiRTstSmMgXfyTnE7sL1r3gOuwSKcUnJBBfqAapK8uOl7BapDCSw0pzSdl5
         X25szV0ezJxN2Z3trhZcEq6gIrZXFmdAQ7JYOaPDykjcQY6xnj7zz0ppVeIo/1MRxD
         BKcJ7FAAZEYPUH8YHCxb9vaIgVcfUjxreZRfadWrAER0AsSOddoaZe4wLJ0h+ngGIG
         B3xBpV8rvec28FKU+uxNjarnBvyz2zewGkZMNWqKj8sTQ0cgu8RTZ+uxT1JEbGhhrf
         /D35VgcHRxjuVw0bDgeWDYO9AHo5psrvI5GFsMnFxp9COpKMcgfOFs5iquCLfnU0xc
         Zmr3+j4j01kWg==
Message-ID: <fab40b87-7471-83a3-d154-aa2da0b7d23f@collabora.com>
Date:   Wed, 1 Jun 2022 13:03:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 0/2] MediaTek Helio X10 MT6795 - MT6331/6332 PMIC MFD
 integration
Content-Language: en-US
To:     lee.jones@linaro.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, johnson.wang@mediatek.com,
        hsin-hsiung.wang@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220520124617.228808-1-angelogioacchino.delregno@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220520124617.228808-1-angelogioacchino.delregno@collabora.com>
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

Il 20/05/22 14:46, AngeloGioacchino Del Regno ha scritto:
> In an effort to give some love to the apparently forgotten MT6795 SoC,
> I am upstreaming more components that are necessary to support platforms
> powered by this one apart from a simple boot to serial console.
> 
> This series adds the necessary headers and support for the MT6331 with
> MT6332 companion PMIC in the mt6397 MFD driver, along with some basic
> devices.
> 
> Adding support to each driver in each subsystem will be done in different
> patch series as to avoid spamming uninteresting patches to maintainers.
> 
> This series depends on another series [1] named
> "MediaTek Helio X10 MT6795 - MT6331/6332 PMIC Wrapper"
> 
> Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.
> 
> 

Gentle ping to not let this big effort (with drivers depending on this one) get
forgotten and wasted.

P.S.: Mark wanted to merge the regulator drivers for MT6331/6332 from another
       series that depends on this one (but compile errors due to said dependency)

P.P.S.: Lee: Reporting what Mark said (Full context in [2]):
"I'll need a pull request for the MFD bits I guess, please make sure Lee knows 
that's going to be needed."

[2]: 
https://patchwork.kernel.org/project/linux-mediatek/patch/20220523154709.118663-5-angelogioacchino.delregno@collabora.com/#24876722

Thank you,
Angelo

> [1]: https://lore.kernel.org/lkml/20220520124039.228314-1-angelogioacchino.delregno@collabora.com/T/#t
> 
> AngeloGioacchino Del Regno (2):
>    dt-bindings: mfd: mt6397: Add compatibles for MT6331 RTC and keys
>    mfd: mt6397: Add basic support for MT6331+MT6332 PMIC
> 
>   .../devicetree/bindings/mfd/mt6397.txt        |   2 +
>   drivers/mfd/mt6397-core.c                     |  47 ++
>   drivers/mfd/mt6397-irq.c                      |   9 +-
>   include/linux/mfd/mt6331/core.h               |  53 ++
>   include/linux/mfd/mt6331/registers.h          | 584 ++++++++++++++++
>   include/linux/mfd/mt6332/core.h               |  53 ++
>   include/linux/mfd/mt6332/registers.h          | 642 ++++++++++++++++++
>   include/linux/mfd/mt6397/core.h               |   2 +
>   8 files changed, 1391 insertions(+), 1 deletion(-)
>   create mode 100644 include/linux/mfd/mt6331/core.h
>   create mode 100644 include/linux/mfd/mt6331/registers.h
>   create mode 100644 include/linux/mfd/mt6332/core.h
>   create mode 100644 include/linux/mfd/mt6332/registers.h
> 

