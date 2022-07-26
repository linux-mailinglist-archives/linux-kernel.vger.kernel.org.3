Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3D2581507
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239104AbiGZOWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238935AbiGZOWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:22:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21081D32D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:22:09 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4D1FA66017E7;
        Tue, 26 Jul 2022 15:22:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658845328;
        bh=4zmP1FrOBGWRTxzO5xPnrH9vexzpAmeNeZdmwxjZBQY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=I33YrZIMdevJsy17cxsuWq4ptnwFrYml93lqWkg7Uu/N3xR5hbaAEE0xoVtFNUnDg
         veh64GYs9lfg6OmryApl6rU7FC45SyB2+yXzrZLWH4/GzFyR0K9lMZH6jGknLuyKxw
         ZMj4rriRSc5p4q53137JzbeKZAbB/qFzZv8/WB7TOaaQB71LiFlpj4xh7nX6WG7fVP
         K7INGCKoEq0F20PQ2mVP1HEq7Plq+lhSOfHfkF6XcPgTNGE2upHjXrWqzrmPgaHzAW
         i3eT5LB4M/BXoQuyZNXodOyFKKs9BIDVQDYqrom0uV0RdOebaXLQqoqJzqcOSRDbkz
         MyztuzqZuuyqw==
Message-ID: <c9441276-34ae-19dc-8a19-5e03dc14628e@collabora.com>
Date:   Tue, 26 Jul 2022 16:22:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/6] soc: mediatek: Cleanups for MediaTek SVS driver
Content-Language: en-US
To:     matthias.bgg@gmail.com
Cc:     roger.lu@mediatek.com, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, kernel@collabora.com
References: <20220726141653.177948-1-angelogioacchino.delregno@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220726141653.177948-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/07/22 16:16, AngeloGioacchino Del Regno ha scritto:
> This is a cleanup-only series for the mtk-svs driver, enhancing the
> usage of standard Linux macros for bitfields for better readability
> and register set/get safety, switches to devm_ functions variants
> where possible and other general cleanups, getting this driver in a
> better overall shape.
> 

Sorry, I forgot to write in the cover letter that this series depends
on [1] adding MT8195 and MT8186 support.

[1]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=660955

Regards,
Angelo

> AngeloGioacchino Del Regno (6):
>    soc: mediatek: mtk-svs: Commonize t-calibration-data fuse array read
>    soc: mediatek: mtk-svs: Switch to platform_get_irq()
>    soc: mediatek: mtk-svs: Remove hardcoded irqflags
>    soc: mediatek: mtk-svs: Drop of_match_ptr() for of_match_table
>    soc: mediatek: mtk-svs: Use devm variant for dev_pm_opp_of_add_table()
>    soc: mediatek: mtk-svs: Use bitfield access macros where possible
> 
>   drivers/soc/mediatek/mtk-svs.c | 325 ++++++++++++++++++---------------
>   1 file changed, 176 insertions(+), 149 deletions(-)
> 
