Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BEF4D4509
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 11:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241398AbiCJKxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 05:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241422AbiCJKxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 05:53:39 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983245C677;
        Thu, 10 Mar 2022 02:52:38 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 548481F454C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646909557;
        bh=9aUbcW04U/4ptYzSIBnfoM+hXNE0ptVvNH6aQoyUu9Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=igI/BZK/FA9bN67UwQfOCHAz40Bvc+sn142E6OatI1gORrtDMHcmx5GF3v8WZv91W
         vPZERPUOJmWusSETIeJmIap+chaysvjB9mHy12BGGcAmNdiX04hWKNfZUYRJ8fkYF+
         3wlQvzgxLYKDFOXLNUwTcP1HEpAoqGRxwZm8W+wRCz80KfFZhdZFuUMBgEZAk5lfIL
         wBGH62C+lCVSyEpk/SjXWceXCuMjkv98X7YvpSQ5HpV+maoybrw/e9XDrbZhygD/Vn
         ktDhfvRlenO3eZv2Hua4o/4TCCr5Q+tc7I5uaBVrV9moXNPkeG/3NoBx6BxrWKNV7k
         rA2ucxVfYlTOA==
Message-ID: <fba2646a-6eb6-eabe-538f-ed54bfd60c14@collabora.com>
Date:   Thu, 10 Mar 2022 11:52:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v14 10/22] drm/mediatek: add display MDP RDMA support for
 MT8195
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
 <20220310035515.16881-11-nancy.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220310035515.16881-11-nancy.lin@mediatek.com>
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
> Add MDP_RDMA driver for MT8195. MDP_RDMA is the DMA engine of
> the ovl_adaptor component.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/gpu/drm/mediatek/Makefile       |   3 +-
>   drivers/gpu/drm/mediatek/mtk_disp_drv.h |   7 +
>   drivers/gpu/drm/mediatek/mtk_drm_drv.c  |   1 +
>   drivers/gpu/drm/mediatek/mtk_drm_drv.h  |   1 +
>   drivers/gpu/drm/mediatek/mtk_mdp_rdma.c | 315 ++++++++++++++++++++++++
>   drivers/gpu/drm/mediatek/mtk_mdp_rdma.h |  20 ++
>   6 files changed, 346 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
>   create mode 100644 drivers/gpu/drm/mediatek/mtk_mdp_rdma.h
> 

