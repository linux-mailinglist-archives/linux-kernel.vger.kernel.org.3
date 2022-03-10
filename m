Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFE64D4524
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 11:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241477AbiCJKyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 05:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241510AbiCJKyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 05:54:07 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628437CDC6;
        Thu, 10 Mar 2022 02:53:02 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B624E1F454C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646909581;
        bh=NzjD8M8Z7FALTKD4/SpsqIKFZb2xgKUIypduj+2Faho=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Mw8rhciUK0bnm0l8ajtjvgVsdanDHIGyhtsghP3gQXxXfM/WHT5/UgQX0XodPxX2T
         IrCsFBBlRhpf7veSTGNQZtUPN8Foc4Z7KUDCHCNFavxJn3Sv9Qz/cCbFLoMBXgzNjG
         6S3lb4OVkrLMrG8v9BfpY1xo+M34eGo626FeZbdx1GcaTogxafd/kejxSXbw6MzQbP
         8eWDB7q6RWs3VtO/d0MyyLj/vHlBqBGAMfrs8rWx6q7BssmS3iEURJkyjJerVZy3Kf
         MwLrPqxTKrQD2+c0vkb8cttYnmJGs9sPnj8RUL0DtMnBHWsItyvLBN4GLxm4uhC7CE
         rf4ogISZIlFGg==
Message-ID: <91129692-6706-ccac-6614-55f71cc30ce0@collabora.com>
Date:   Thu, 10 Mar 2022 11:52:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v14 16/22] drm/mediatek: add mediatek-drm plane color
 encoding info
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
 <20220310035515.16881-17-nancy.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220310035515.16881-17-nancy.lin@mediatek.com>
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
> Add plane color encoding information for color space conversion.
> It's a preparation for adding support for mt8195 ovl_adaptor mdp_rdma
> csc control.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/gpu/drm/mediatek/mtk_drm_plane.c | 1 +
>   drivers/gpu/drm/mediatek/mtk_drm_plane.h | 1 +
>   2 files changed, 2 insertions(+)
> 
