Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491C64DAE5A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 11:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355177AbiCPKli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 06:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244662AbiCPKlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 06:41:37 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C416850050
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 03:40:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B255E1F4440A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647427222;
        bh=6HfrXX6kj8MJICTuM+ecnk15KUT574Z69o6G90jNQS8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IB8kfAy1h7y3n32fNOTs9ePoDLrvI3c5Hf412n+cTcSTTassKABkYo97j2exYIvji
         x7ANB9jdE6pPVFVQ4dvsyyuEQ3IIIeBIYfAqhhZMJLxDDFMQAeZRepNJmEDzfA8DN0
         d3kbzLQimiZjwhPZaU3vWxJslT5lw6bDu+I54oiEu03PkDdHZHFutjd3eF10Nu/423
         Xv+5iofl+b+Zpir7bzh+/Ma6wRQa9/O/nAnYkEaOznIOo+WhzvLIfya+NfroIJ0yjk
         wC6dq+VgYiOHu0PFXjRGPKaeedJj3JCkcGe/ONx5hkAd8d7TDAryVuj7sVrYZaZoaf
         15yHMQP3b6+8A==
Message-ID: <e4b16e67-ccb5-78d1-bbbb-a4a7f82b7c11@collabora.com>
Date:   Wed, 16 Mar 2022 11:40:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 1/2] drm: mediatek: mtk_drm_plane: Use kmalloc in
 mtk_plane_duplicate_state
Content-Language: en-US
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>
References: <20220118133759.112458-1-angelogioacchino.delregno@collabora.com>
 <CAAOTY__59-tYZNAQqFytdZgAYs+hmFxHUrF1FAj4zphiguv12g@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAAOTY__59-tYZNAQqFytdZgAYs+hmFxHUrF1FAj4zphiguv12g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/01/22 17:36, Chun-Kuang Hu ha scritto:
> Hi, AngeloGioacchino:
> 
> AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> 於
> 2022年1月18日 週二 下午9:38寫道：
>>
>> There is no need to zero out the newly allocated memory because we are
>> duplicating all members of struct mtk_plane_state: switch to kmalloc
>> to save some overhead.
> 
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> 
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/gpu/drm/mediatek/mtk_drm_plane.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>

Hello,

this series was sent and reviewed two months ago, but it hasn't been picked
in any maintainer tree.

This is a friendly ping to not let these two patches to be lost and forgotten.

Cheers,
Angelo
