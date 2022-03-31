Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23944ED81D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 13:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbiCaLCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 07:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbiCaLCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:02:53 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139B21F42D9;
        Thu, 31 Mar 2022 04:01:06 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id i4so14397564wrb.5;
        Thu, 31 Mar 2022 04:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+/7/LNYiddHh3daHO4b4y3+lUSSJ6kGwQt036sq4F5s=;
        b=RkWYRYnEQActcnsOIxJdaEOmUujN+0CedWTaT+THPDjGDS+F7p0mIpLnv5t6fiFumP
         TWfbw1i2t6C/QXiZYDga486alGeUynbUh5NrCOEUloaFJLCjrfB37FfbECNprHdIvuQ+
         L4dnPv5FjAUZ8AGD9G1KGc+5t5iDJplfBGbEgLv3dTMWlrJ/GKAoayT3BqeV1cxrbxaQ
         1+IH6sJg7pZrGtCJHFziELhNKJgFfc5N7MC9HflL//lHWbiJgPszerJA7rYT0BuHHSs4
         Md6+Dx0H93l6Fby2KoMjYC9vQdbDX3INf+deJ/B0Ug9af5NpScZ4OakI7PwzjQewE+pL
         ToKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+/7/LNYiddHh3daHO4b4y3+lUSSJ6kGwQt036sq4F5s=;
        b=hMiQOSjHUK3BsKZOmX6c+pxeQeSS6WCFdft9sxrhQsyM9APfGj6mr7tybuRHm9PqXG
         kxI5XpHRQ3c84RiqBaqmXKJKx05BBBbMnj3nk7DgwjwNkPbfPeV/nhB2+24rc5pvRd/i
         QOl8oXnn4BVBbr6rStMvuxbDT/eRcfQeMB/Qz0BFzp6Yn8Ps3p1jEr/h3qgYn4rmPUeR
         WaRU8ZkzJTV6O+xT+60F5v6CRnwuARNembRZgRXyc0aBi10ONeVzf6sUoqFXCq7OOsld
         KN87BrKvljt4n6uGIQHeC9QBlLMo9Fg5if9bK0rcHSviskHILHPMZ3icpxPuo4wlqV4B
         bi+A==
X-Gm-Message-State: AOAM531YvBLBsj+plMt1JzU7Qwypmfi2WFRMH0awVf0YxVORfA6J00e5
        KSbvPnP05F5oaAmkSezSF74=
X-Google-Smtp-Source: ABdhPJxGcX0xWhhwhpsCj5Z5atC5aB+m9HlEq6omTClNah69eRS9M6t6u3wx34IHAplSx1wQ2NI8aA==
X-Received: by 2002:a5d:47a1:0:b0:204:9a7:22cd with SMTP id 1-20020a5d47a1000000b0020409a722cdmr3749629wrb.186.1648724464476;
        Thu, 31 Mar 2022 04:01:04 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id v18-20020a5d5912000000b00205a7d0c6a3sm15295315wrd.69.2022.03.31.04.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 04:01:03 -0700 (PDT)
Message-ID: <01e57ed9-222c-5b74-fe2b-4d22fe802c98@gmail.com>
Date:   Thu, 31 Mar 2022 13:01:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v16 4/8] soc: mediatek: add mtk-mmsys support for mt8195
 vdosys0
Content-Language: en-US
To:     Jason-JH Lin <jason-jh.lin@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        hsinyi@chromium.org, fshao@chromium.org, moudy.ho@mediatek.com,
        roy-cw.yeh@mediatek.com, Fabien Parent <fparent@baylibre.com>,
        nancy.lin@mediatek.com, singo.chang@mediatek.com,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220307032859.3275-1-jason-jh.lin@mediatek.com>
 <20220307032859.3275-5-jason-jh.lin@mediatek.com>
 <a068f2c9b2111f3a7a20da19073ef5fdb7f4a91f.camel@mediatek.com>
 <b9ed8c1511ea26c070dd3fb61f4370e5f858058c.camel@mediatek.com>
 <97bc1358813a2449d6e62653eb7af9906dfb190e.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <97bc1358813a2449d6e62653eb7af9906dfb190e.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/03/2022 12:04, Jason-JH Lin wrote:
> Hi CK,
> 
> Thanks for the review.
> 
> On Mon, 2022-03-28 at 13:39 +0800, CK Hu wrote:
>> Hi, Jason:
>>
>> On Mon, 2022-03-28 at 13:03 +0800, Jason-JH Lin wrote:
>>> Hi CK,
>>>
>>> Thanks for the reviews.
>>>
>>> On Mon, 2022-03-07 at 11:28 +0800, jason-jh.lin wrote:
>>>> Add mt8195 vdosys0 clock driver name and routing table to
>>>> the driver data of mtk-mmsys.
>>>>
>>>> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
>>>> Acked-by: AngeloGioacchino Del Regno <
>>>> angelogioacchino.delregno@collabora.com>
>>>> ---
>>>> Impelmentation patch of vdosys1 can be refered to [1]
>>>>
>>>> [1] soc: mediatek: add mtk-mmsys support for mt8195 vdosys1
>>>> ---
>>>>   drivers/soc/mediatek/mt8195-mmsys.h    | 130
>>>> +++++++++++++++++++++++++
>>>>   drivers/soc/mediatek/mtk-mmsys.c       |  11 +++
>>>>   include/linux/soc/mediatek/mtk-mmsys.h |   9 ++
>>>>   3 files changed, 150 insertions(+)
>>>>   create mode 100644 drivers/soc/mediatek/mt8195-mmsys.h
>>>>
>>>> diff --git a/drivers/soc/mediatek/mt8195-mmsys.h
>>>> b/drivers/soc/mediatek/mt8195-mmsys.h
>>>> new file mode 100644
>>>> index 000000000000..24a3afe23bc8
>>>> --- /dev/null
>>>> +++ b/drivers/soc/mediatek/mt8195-mmsys.h
>>>> @@ -0,0 +1,130 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>>> +
>>>> +#ifndef __SOC_MEDIATEK_MT8195_MMSYS_H
>>>> +#define __SOC_MEDIATEK_MT8195_MMSYS_H
>>>> +
>>>> +#define MT8195_VDO0_OVL_MOUT_EN					
>>>> 0xf14
>>>> +#define MT8195_MOUT_DISP_OVL0_TO_DISP_RDMA0			
>>>> BIT(0)
>>>> +#define MT8195_MOUT_DISP_OVL0_TO_DISP_WDMA0			
>>>> BIT(1)
>>>>   
>>>> Useless, so remove.
>>>>
>>>> +#define MT8195_MOUT_DISP_OVL0_TO_DISP_OVL1			
>>>> BIT(2)
>>>> Ditto.Useless, so remove.
>>>> Regards,
>>>> CK
>>>
>>> Although these definitions are not used, they represent the
>>> functionality provided by this register.
>>>
>>> I think we can show that we have these capabilities by defining
>>> them.
>>>
>>> Can we keep these definitions?
>>
>> It's better that we know how to use it. Even though the symbol name
>> show some information, but I would like to add it to
>> mmsys_mt8195_routing_table[].
>>
>> Regards,
>> CK
>>
> 
> OK, I think I just remove the useless define.

Actually I would prefer to add it to the routing table to describe all the 
capabilities of the HW.

Is there any technical problem with that?

Regards,
Matthias

> Thanks.
> 
> Regards,
> Jason-JH.Lin
>>>
>>> Regards,
>>> Jason-JH.Lin
>>>
>>>> +#define MT8195_MOUT_DISP_OVL1_TO_DISP_RDMA1			
>>>> BIT(4)
>>>> +#define MT8195_MOUT_DISP_OVL1_TO_DISP_WDMA1			
>>>> BIT(5)
>>>> +#define MT8195_MOUT_DISP_OVL1_TO_DISP_OVL0			
>>>> BIT(6)
>>>
>>>
>>> [snip]
>>>
>>
>>
