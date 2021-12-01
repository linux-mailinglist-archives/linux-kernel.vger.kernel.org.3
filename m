Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5971F464D92
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 13:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349230AbhLAMMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 07:12:37 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35636 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349173AbhLAMMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 07:12:23 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 42FF61F458EC
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638360541; bh=Pph0h28u90fWIpAEnT37cWqdNQe0Gk7uaTOWOIg4P9Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Vp1a4AnNC/hCYZImxafQPXGE6lBaxAJp+NpFtPmFYARGG2tdk+b0/U3v/ustS4H9i
         FOI0ql6mGk9KG0SaguWGmT6UhxEwnGwSmL+2qwZIywym1GVTRPNz24PHdlOSoHySWu
         XsicMKGJWClwyRyX+Ja3p0V4w8pMICqADb/r1CZjrz+F/x4pshyu2+wWx2XYRrF09G
         7Nf4XpjfXAvLfyiql6V/l9x0v1pAatAEAB4JqRfbQd43e4j7sJQH/yjOVeLixF+vSv
         gTGDoYq6xP8fjVjYw4geuQp2PQzBvMkVn7LvTmLJSkHme3Cf1NG2FTPqQ1z6gxCZp3
         FG0bomir76f/g==
Subject: Re: [PATCH v11, 19/19] media: mtk-vcodec: Remove
 mtk_vcodec_release_enc_pm
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20211129034201.5767-1-yunfei.dong@mediatek.com>
 <20211129034201.5767-20-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <5d235ba6-213a-598f-e18f-93b51e535285@collabora.com>
Date:   Wed, 1 Dec 2021 13:08:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211129034201.5767-20-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/11/21 04:42, Yunfei Dong ha scritto:
> There are only two lines in mtk_vcodec_release_enc_pm, using
> pm_runtime_disable and put_device instead directly.
> 
> Move pm_runtime_enable outside mtk_vcodec_release_enc_pm to symmetry with
> pm_runtime_disable, after that, rename mtk_vcodec_init_enc_pm to *_clk since
> it only has clock operations now.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> Co-developed-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c | 9 ++++++---
>   drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c  | 9 +--------
>   drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.h  | 3 +--
>   3 files changed, 8 insertions(+), 13 deletions(-)
> 





Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
