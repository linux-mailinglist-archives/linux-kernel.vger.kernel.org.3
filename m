Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE22F4D450E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 11:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241454AbiCJKxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 05:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241433AbiCJKxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 05:53:43 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE2369284;
        Thu, 10 Mar 2022 02:52:42 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 31F9C1F454C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646909561;
        bh=dwruVMKHe8Hzj+ZT1aHSQLRWF4u7URdyyePyiB1hmoY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=j1F3PRLNQcQHEhimDXLzLRdU3QZPcoDHEIJoD4/sNChZVlNtrCCWY/wxyDDgvu3eQ
         uBIvRR0rBev+Jtv+Eb7Y+3hymYU+A9gnIp7lIkYnjrf8dHWrtOSfHwqs/gKtynbQTu
         Rnt5OfPv+U5hOqdt5QWKflQSciv/oSNpxmtOATeTFXC7/YtB40ZojqoDimsAptZsiU
         3Vt6eSmYBMotYjQPuRSNJqYoGLg0ThkzOM+qdvARgqdLE7yvejVp4ejoKfFZOK8IBS
         8SCp7Z3Om5TFdBvnUw9hQYcsExVV4TkuWsTEBY96mLOtLxvbJkJUEk2yJHI/TJZMJy
         ojQE0jCXKYGfg==
Message-ID: <3fa9546b-2331-e25e-7768-4bb56753ee4d@collabora.com>
Date:   Thu, 10 Mar 2022 11:52:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v14 11/22] drm/mediatek: add display merge advance config
 API for MT8195
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
 <20220310035515.16881-12-nancy.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220310035515.16881-12-nancy.lin@mediatek.com>
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
> Add merge new advance config API. The original merge API is
> mtk_ddp_comp_funcs function prototype. The API interface parameters
> cannot be modified, so add a new config API for extension. This is
> the preparation for ovl_adaptor merge control.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/gpu/drm/mediatek/mtk_disp_drv.h   |  3 ++
>   drivers/gpu/drm/mediatek/mtk_disp_merge.c | 52 ++++++++++++++++++++---
>   2 files changed, 48 insertions(+), 7 deletions(-)
> 
