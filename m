Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5654F912B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbiDHIvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbiDHIvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:51:18 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B519C357F1C;
        Fri,  8 Apr 2022 01:49:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id EBD411F46C4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649407754;
        bh=/ucyQFsnln0fUdd49CPO4IcMZgAGhdNJGgDPJIZXvBU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=k7NgI401bZto7wIRXjFFsY+lkbrcOJ5N0vgiMqgl0LthCepuCshjIkVZL6NDdn+NS
         GlSr50TKMC5weSkUK3BwNwbO8AtNyQiIT7GOql3Ujcz6ZH3vCdXQmMJVCmB+rOIiDl
         YDCpvOWYAQ3/2SHRxtqOJHfOmKk45gtv9OilkQWoR6nVztiP+3k6InyjSlmaBkRNLa
         Sz/EMQPvqv9QTzpv5NDwXbTUK/5C7u0M/bh38wZ9bE0UqeJbKc2ehQmfrgBSymcGA8
         tm2MMRJVRM63fJKACuIu2qrFi+wlbf+unhf8MO9OemKLI4MmRrmq0bEPQinz5EjiD+
         8GucQsaJfhyig==
Message-ID: <a48df6bb-6be8-6cb9-51d0-9044e706e834@collabora.com>
Date:   Fri, 8 Apr 2022 10:49:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RESEND v17 3/7] soc: mediatek: add mtk-mmsys support for mt8195
 vdosys0
Content-Language: en-US
To:     CK Hu <ck.hu@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, singo.chang@mediatek.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        postmaster@vger.kernel.org, Fabien Parent <fparent@baylibre.com>,
        John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
        linux-stm32@st-md-mailman.stormreply.com, roy-cw.yeh@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        nancy.lin@mediatek.com, linux-mediatek@lists.infradead.org,
        hsinyi@chromium.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, moudy.ho@mediatek.com,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
References: <20220407030409.9664-1-jason-jh.lin@mediatek.com>
 <20220407030409.9664-4-jason-jh.lin@mediatek.com>
 <67b3e42d6a094108f724ed9b8c73f5cd6b2ce219.camel@mediatek.com>
 <d8711b8e4d233240eda73db54a625e88b9b3970b.camel@mediatek.com>
 <1f1692b6d14280fed40e53f464145ed70b67135f.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1f1692b6d14280fed40e53f464145ed70b67135f.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/04/22 03:28, CK Hu ha scritto:
> Hi, Jason:
> 
> On Thu, 2022-04-07 at 14:27 +0800, Jason-JH Lin wrote:
>> Hi CK,
>>
>> Thanks for the reviews.
>>
>> On Thu, 2022-04-07 at 13:45 +0800, CK Hu wrote:
>>> Hi, Jason:
>>>
>>> On Thu, 2022-04-07 at 11:04 +0800, jason-jh.lin wrote:
>>>> 1. Add mt8195 mmsys compatible for vdosys0.
>>>> 2. Add mt8195 routing table settings and fix build fail.
>>>> 3. Add clock name, clock driver name and routing table into the
>>>> driver data
>>>>     of mt8195 vdosys0.
>>>> 4. Add get match data by clock name function and clock platform
>>>> labels
>>>>     to identify which mmsys node is corresponding to vdosys0.
>>>>
>>>> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
>>>> ---
>>>>   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |   2 +-
>>>>   drivers/gpu/drm/mediatek/mtk_drm_drv.c      |   6 +-
>>>>   drivers/soc/mediatek/mt8167-mmsys.h         |   2 +-
>>>>   drivers/soc/mediatek/mt8183-mmsys.h         |   2 +-
>>>>   drivers/soc/mediatek/mt8186-mmsys.h         |   4 +-
>>>>   drivers/soc/mediatek/mt8192-mmsys.h         |   4 +-
>>>>   drivers/soc/mediatek/mt8195-mmsys.h         | 370
>>>> ++++++++++++++++++++
>>>>   drivers/soc/mediatek/mt8365-mmsys.h         |   4 +-
>>>>   drivers/soc/mediatek/mtk-mmsys.c            |  62 ++++
>>>>   drivers/soc/mediatek/mtk-mmsys.h            |   1 +
>>>>   drivers/soc/mediatek/mtk-mutex.c            |   8 +-
>>>>   include/linux/soc/mediatek/mtk-mmsys.h      |  13 +-
>>>>   12 files changed, 461 insertions(+), 17 deletions(-)
>>>>   create mode 100644 drivers/soc/mediatek/mt8195-mmsys.h
>>>>
>>>
>>> [snip]
>>>
>>>> diff --git a/drivers/soc/mediatek/mtk-mmsys.c
>>>> b/drivers/soc/mediatek/mtk-mmsys.c
>>>> index 4fc4c2c9ea20..b2fa239c5f5f 100644
>>>> --- a/drivers/soc/mediatek/mtk-mmsys.c
>>>> +++ b/drivers/soc/mediatek/mtk-mmsys.c
>>>> @@ -4,6 +4,8 @@
>>>>    * Author: James Liao <jamesjj.liao@mediatek.com>
>>>>    */
>>>>   

..snip..

>>
>> I think there might be another chip that needs to get driver data by
>> clk_name .
>> So I use "clk-mt8195" in clk_driver to identify the corresponding
>> platform whose clk_name of mmsys is also "cfg_vod0".
> 
> We usually don't care the future because the future may not happen. If

Hello CK,

I'm sorry, but I really have to disagree here.
Sure, the future may not happen, but from what I can see, MediaTek's commitment
on upstreaming their SoCs is continuative and they care about the future.

Let's also not forget that these drivers are not on a downstream tree, where
you don't care about the past or the future, but on upstream, where you:
- Definitely care about the past
- Should care about the future, if you want to avoid commit noise and
   making big changes to your drivers everytime, which would slow down
   your upstreaming due to reviewers having to put 3x efforts on each
   iteration.

And let's also not forget that this being upstream means that these drivers
may (or may not) be extended even by passionate community developers, for
which, having such mechanisms there for other SoCs that MediaTek didn't try
to upstream yet can only be good - and when these are engineered with a
certain flexibility, while keeping the codebase solid, that can only be good.

Besides, if I've misunderstood your "don't care the future" statement,
pretend that I've never replied.


> it's sure that would happen, I think clk_driver is not a good choice.
> For now, the clk_driver name is different for each SoC, but it could be
> the same for each SoC because only one clock driver would be compiled.
> I think "compatible" would be different for each SoC.
> 

...but I agree on that one (and I gave my own review and suggestions on
how to improve that situation).

Regards,
Angelo
