Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073C653109C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbiEWMQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235354AbiEWMPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:15:55 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709AD11C18;
        Mon, 23 May 2022 05:15:54 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 106EB1F430CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653308153;
        bh=OWdjhw1YAsTUorGsOR2BtjPFSahtCs7HpdU+uvF1qak=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ci4hDwZcJOJWbusqGkj9L1NaiEoJwkfa8tYgNkhpOIH3UQqOYQWGsFAXX0b8UdO9O
         u6LWRo+4sLf6jYxV6lCtFZG66ObvT5TnLRLJ/OrL/NbmbSTKU3P1kTwA2T2FyHQ2Ot
         hjGsBKFML9JmOFwrCiMiLpK7PkebZq3scBvAk6HOQfTzBb7rG2MAF0u0nOAbtdMOXJ
         EK3o7ij10s4pkaiarPjFwgO7cGRfV27yee5bcT4QIxzJbJrZLB671g5iEH31328qBi
         ZihHOv0MTOhoX8ZE2VEiNGEXju3mFAtoyMFt1BFQP7NxFanKZeA2GAYRMSM1GihSOJ
         NWb6ZZXRLihcg==
Message-ID: <9639208e-1afc-30ef-d0ea-5eaaa6316af3@collabora.com>
Date:   Mon, 23 May 2022 14:15:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 2/4] dt-bindings: reset: Add MT6735 reset bindings
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Rob Herring <robh@kernel.org>
References: <20220519142211.458336-1-y.oudjana@protonmail.com>
 <20220519142211.458336-3-y.oudjana@protonmail.com>
 <d54ea1d3-903f-0b2a-3db4-99f1adfadce0@collabora.com>
 <T9C6CR.ZDXJ22Q377EZ1@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <T9C6CR.ZDXJ22Q377EZ1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/05/22 11:13, Yassine Oudjana ha scritto:
> 
> On Fri, May 20 2022 at 10:55:24 +0200, AngeloGioacchino Del Regno 
> <angelogioacchino.delregno@collabora.com> wrote:
>> Il 19/05/22 16:22, Yassine Oudjana ha scritto:
>>> From: Yassine Oudjana <y.oudjana@protonmail.com>
>>>
>>> Add reset definitions for Mediatek MT6735 resets provided by
>>> infracfg and pericfg.
>>>
>>> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>>> Acked-by: Rob Herring <robh@kernel.org>
>>> ---
>>>   MAINTAINERS                                   |  2 ++
>>>   .../reset/mediatek,mt6735-infracfg.h          | 31 +++++++++++++++++++
>>>   .../reset/mediatek,mt6735-pericfg.h           | 31 +++++++++++++++++++
>>>   3 files changed, 64 insertions(+)
>>>   create mode 100644 include/dt-bindings/reset/mediatek,mt6735-infracfg.h
>>>   create mode 100644 include/dt-bindings/reset/mediatek,mt6735-pericfg.h
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index a59069263cfb..1c0af554a7b6 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -12503,6 +12503,8 @@ F:    
>>> include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
>>>   F:    include/dt-bindings/clock/mediatek,mt6735-infracfg.h
>>>   F:    include/dt-bindings/clock/mediatek,mt6735-pericfg.h
>>>   F:    include/dt-bindings/clock/mediatek,mt6735-topckgen.h
>>> +F:    include/dt-bindings/reset/mediatek,mt6735-infracfg.h
>>> +F:    include/dt-bindings/reset/mediatek,mt6735-pericfg.h
>>>     MEDIATEK MT76 WIRELESS LAN DRIVER
>>>   M:    Felix Fietkau <nbd@nbd.name>
>>
>> ..snip..
>>
>>> diff --git a/include/dt-bindings/reset/mediatek,mt6735-pericfg.h 
>>> b/include/dt-bindings/reset/mediatek,mt6735-pericfg.h
>>> new file mode 100644
>>> index 000000000000..6cdfaa7ddadf
>>> --- /dev/null
>>> +++ b/include/dt-bindings/reset/mediatek,mt6735-pericfg.h
>>> @@ -0,0 +1,31 @@
>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>>> +
>>> +#ifndef _DT_BINDINGS_RST_MT6735_PERICFG_H
>>> +#define _DT_BINDINGS_RST_MT6735_PERICFG_H
>>> +
>>> +#define UART0_SW_RST            0
>>> +#define UART1_SW_RST            1
>>> +#define UART2_SW_RST            2
>>> +#define UART3_SW_RST            3
>>> +#define UART4_SW_RST            4
>>
>> where's number 5?
>>
>>> +#define BTIF_SW_RST            6
>>> +#define DISP_PWM_SW_RST            7
>>> +#define PWM_SW_RST            8
>>
>> ...and where's 9?
>>
>>> +#define AUXADC_SW_RST            10
>>> +#define DMA_SW_RST            11
>>> +#define IRDA_SW_RST            12
>>> +#define IRTX_SW_RST            13
>>
>> and 14, 15?
>>
>>> +#define THERM_SW_RST            16
>>> +#define MSDC2_SW_RST            17
>>> +#define MSDC3_SW_RST            17
>>
>> MSDC 2 and 3 are both 17?! :-)
>>
>>> +#define MSDC0_SW_RST            19
>>> +#define MSDC1_SW_RST            20
>>
>> 21?
>>
>>> +#define I2C0_SW_RST            22
>>> +#define I2C1_SW_RST            23
>>> +#define I2C2_SW_RST            24
>>> +#define I2C3_SW_RST            25
>>> +#define USB_SW_RST            28
>>> +
>>
>> and 29-32?
>>
>>> +#define SPI0_SW_RST            33
>>> +
>>> +#endif
>>
>> I have a hunch that you've misunderstood the changes in the resets...
>>
>> What Rex-BC has done in his reset cleanup is exactly to stop directly
>> mapping these to the actual bits that we're using... so the definitions
>> in there will simply be sequential, and the actual mapping is done in
>> your clk-mt6735-pericfg.c driver.
> 
> I did notice that, but reading the documentation in reset.h:
> 
> * @rst_idx_map:Pointer to an array containing ids if input argument is index.
> *        This array is not necessary if our input argument does not mean index.
> 
> I thought that it wasn't necessary to use it. Thinking
> about it now however, I guess that was to maintain compatibility
> with old device trees. I'll change it next time.
> Maybe a note should be put there to avoid confusion
> in the future.

I agree this comment should be clarified.

Thanks,
Angelo



