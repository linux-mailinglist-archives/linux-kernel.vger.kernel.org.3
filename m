Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3E854F06D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 07:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379837AbiFQFKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 01:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiFQFKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 01:10:15 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E488666BE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 22:10:14 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id CF14E5C013E;
        Fri, 17 Jun 2022 01:10:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 17 Jun 2022 01:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1655442613; x=
        1655529013; bh=06SXRPZNOocNXWxGRqH7I0OqfFWahXsedY1b35/Z7kg=; b=m
        QpCBOk+A3bZ7Tj+yITJ9PcO2R0EOx2TzLK9A0kssJSnLhJdbh8SYQ3XUTcUTY7mA
        PuLdmTvkIpC0iHh6/WRK1ocg50Q+Wnfmn3aGwJX9MaJ4LMmnRx3KxGLuoaSgVsDS
        BEWcLvATdWINOhNiwKn79y5CrqIQpVedIK2czNc16SNx2WDr/a0tbddplJHzeAly
        ptRCAvjj1IjLF5/PQO6f5qJ78CAnZyFpKHbwXgt9h1+rZdXqTuBGx8DrrL0uFRBu
        RGV5cPWsEKSegCPr2vkTmQikDFxDvfdwY88TD9lo4pcKiQhS2Vkf6ds27zKxBTGc
        1kCs767MQot9CzOWqCotA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1655442613; x=
        1655529013; bh=06SXRPZNOocNXWxGRqH7I0OqfFWahXsedY1b35/Z7kg=; b=H
        eDa6XUadrlVUi+qPuOSMQ6F7qJbaSJKkDRAq4waHFO2Wf4EuRMipr+VZD3drxqIZ
        FQiGxgPfZNlV/nXtrYY5l9AmfbKQcatQo7xFzD/ZQhoej+XdpcdkKSX0MRbRsKKc
        cFWMa0O2ziyCCVoD1UShA6YWCAEsfFstJjHojEpxMUnxzk2Nl2U5jinmtpEpgGbT
        qcCCaDhdK5RaAlSLCoTpFJRU1bvzGDTCl5HgKF8AZqZlKADfdkbCQWDo81idca0t
        SKbeHz4WOFygQO+VPtJAd/D6ymPUnk61ICTMYiKZU2Tqv8pkNj8boZIpQ0qKqu2Y
        RYEynEKJBze6sRCHO4rlg==
X-ME-Sender: <xms:tQysYusCyoW36daozlmhwR4dmRRr_rjLiTEOJmYl4nxXwaqRe45mQA>
    <xme:tQysYjd8PDjO5tOirRIll1GTabLSasIKRMH7l-NyEModTcCAl9WnF4zpabzrMAWCa
    KZRI1OuQVDRjvc1Dg>
X-ME-Received: <xmr:tQysYpylbnXpTJ7PARkCV19BEcC4Rctf3xoqUTcdmJEKSFI8KVrmD2pN88Ph3mqsjB-a9HnzNjK09bhvhGmBftQGvul9U-m_rVgQio6STBUKDaNFimGRU1P2ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvgedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedtvefhheehgfdvkeetffeludeuudehudeuvddtveelleekvedv
    uedviefhkeeuheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:tQysYpMXmqEh2krUGY75xpV2MmG_3NXL2pwfNwxgKdMRfDw4Dp0U6Q>
    <xmx:tQysYu_fkbHfkcKYu4CIQm1VZIKovrvXs6RoN3q0fHIvre7bntFunw>
    <xmx:tQysYhWvh92esinX1dQs5GXe0rbPKg9nAg9Unw0JtyYm-mMYGIanNQ>
    <xmx:tQysYjOCqZuk0xchhj3WIBzBDtqeoU5MCaL9o-fj3iaE0EXbIGalxw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jun 2022 01:10:12 -0400 (EDT)
Subject: Re: [PATCH] drm/sun4i: Add DMA mask and segment size
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        mripard@kernel.org, wens@csie.org
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220616213240.392041-1-jernej.skrabec@gmail.com>
 <e4a73a0f-c725-fad2-021b-5b5ee5ead1b3@sholland.org>
 <10094862.nUPlyArG6x@jernej-laptop>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <8a805401-457d-41c1-1be2-be1076bb02c9@sholland.org>
Date:   Fri, 17 Jun 2022 00:10:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <10094862.nUPlyArG6x@jernej-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/22 11:13 PM, Jernej Škrabec wrote:
> Dne petek, 17. junij 2022 ob 05:03:11 CEST je Samuel Holland napisal(a):
>> Hi Jernej,
>>
>> On 6/16/22 4:32 PM, Jernej Skrabec wrote:
>>> Kernel occasionally complains that there is mismatch in segment size
>>> when trying to render HW decoded videos and rendering them directly with
>>> sun4i DRM driver.
>>>
>>> Fix that by setting DMA mask and segment size.
>>>
>>> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>>> ---
>>>
>>>  drivers/gpu/drm/sun4i/sun4i_drv.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c
>>> b/drivers/gpu/drm/sun4i/sun4i_drv.c index 275f7e4a03ae..83f4e87f77f6
>>> 100644
>>> --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
>>> +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
>>> @@ -7,6 +7,7 @@
>>>
>>>   */
>>>  
>>>  #include <linux/component.h>
>>>
>>> +#include <linux/dma-mapping.h>
>>>
>>>  #include <linux/kfifo.h>
>>>  #include <linux/module.h>
>>>  #include <linux/of_graph.h>
>>>
>>> @@ -367,6 +368,9 @@ static int sun4i_drv_probe(struct platform_device
>>> *pdev)> 
>>>  	INIT_KFIFO(list.fifo);
>>>
>>> +	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
>>
>> Isn't this already the default, from of_dma_configure_id or
>> setup_pdev_dma_masks?
> 
> Not sure, I need to check.

Looking at the DE2 and DE3 spec to answer your question, I noticed that all of
the address fields have a corresponding 8-bit "high address" field, so from a
hardware perspective, the DMA mask should be 40 bits.

However, currently we do not use these fields, so we are limited to 32 bits. I
would suggest we comment that, so I am fine with setting the mask even if
redundant, as it provides a good place to add the comment.

>>> +	dma_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(32));
>>
>> This looks like a good change. In fact, I think we need a similar change in
>> some other drivers.
> 
> Should be DMA_BIT_MASK(25) as in your other patch?

No, that limit is specific to the other DMA engine. I do not see any limit for
the display engine. BSP uses sg_tables only for dma-buf, and then it puts the
entire framebuffer in one segment. So I think DMA_BIT_MASK(32) (the maximum
possible value) is correct.

Regards,
Samuel
