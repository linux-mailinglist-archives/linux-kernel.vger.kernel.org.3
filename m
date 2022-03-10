Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E099E4D4520
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 11:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241473AbiCJKyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 05:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241470AbiCJKyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 05:54:05 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C5C71EF5;
        Thu, 10 Mar 2022 02:52:57 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 8C15C1F454CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646909576;
        bh=XZu2CPgKfnoR/3OvjjvechU+ohZ+UyXg7yVflCM7u2g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FAn8r3GcOBRnrfY3T3yAWonrmQaUcN9D4zoyLw/LS8kjC0dUhh1xBwkWW/XhkcEdL
         iKI/uEQLSEw22gE8lT0MRAV/CEiwiH8sfotY7UrNHS0B54/FLPW78sM9c9FXNIp2k0
         +aqmnPVWh7alE+0I8PexgjONUSP4FaXqU2Vxn65XfkNAj+aGxJ1Ma082JjpdL7wVBd
         KJ2lxyEsG18ubw0L+Ge5YfpJ1RR5oJbcR2AOdttniPaOFVISI4YBnW/GnXu5b0ip+0
         H3e2j82uWchH4RHhO4wJrtYZTcC8tzSn9brF/7M+5qBGzUd5oOJIMwfNUjF1pcMZhZ
         tEpXA0v9max3Q==
Message-ID: <85e126f5-b90f-c78f-5ae4-3757b6bc4b7a@collabora.com>
Date:   Thu, 10 Mar 2022 11:52:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v14 15/22] drm/mediatek: add ETHDR support for MT8195
Content-Language: en-US
To:     "Nancy.Lin" <nancy.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>, wim@linux-watchdog.org,
        linux@roeck-us.net
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org, llvm@lists.linux.dev,
        singo.chang@mediatek.com, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220310035515.16881-1-nancy.lin@mediatek.com>
 <20220310035515.16881-16-nancy.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220310035515.16881-16-nancy.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/03/22 04:55, Nancy.Lin ha scritto:
> ETHDR is a part of ovl_adaptor.
> ETHDR is designed for HDR video and graphics conversion in the external
> display path. It handles multiple HDR input types and performs tone
> mapping, color space/color format conversion, and then combine
> different layers, output the required HDR or SDR signal to the
> subsequent display path.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/gpu/drm/mediatek/Makefile      |   1 +
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c |   1 +
>   drivers/gpu/drm/mediatek/mtk_drm_drv.h |   1 +
>   drivers/gpu/drm/mediatek/mtk_ethdr.c   | 376 +++++++++++++++++++++++++
>   drivers/gpu/drm/mediatek/mtk_ethdr.h   |  23 ++
>   5 files changed, 402 insertions(+)
>   create mode 100644 drivers/gpu/drm/mediatek/mtk_ethdr.c
>   create mode 100644 drivers/gpu/drm/mediatek/mtk_ethdr.h
> 
