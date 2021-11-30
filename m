Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B9F46358B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 14:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240770AbhK3Nhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 08:37:38 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53678 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhK3Nhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 08:37:36 -0500
Received: from [IPv6:2a01:e0a:120:3210:b422:9841:4afb:11b5] (unknown [IPv6:2a01:e0a:120:3210:b422:9841:4afb:11b5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 331AC1F450C4;
        Tue, 30 Nov 2021 13:34:11 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638279251; bh=8dFt0ved6B1YlHXel+R6Z2zNSNgLE7JvZbncVuRC5Qw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CXXTXeNJfZ9/XZgE6YFUstBI4Ouw4A5FsgohbT2N95JbtcK2UIipznG5/gVg8Sfem
         JCpbIkg8WQz69wj4MwV68UV40duRU21gjgJFkjoUma0tvpF6V3TmFiLdyhORfTItD9
         /R124eq8PRPWQYM4QqhiMUgfBZnzdfyvYb3rb37PdMwAOuSOQGehdscmDifViugAFH
         mEhQ/PuzYsPcY/L0OCUhp4r0Gf/lYpE1D+9ZT3iiYuLqFxocIyV+GNSdae1CRYolzI
         2PMMkcwokvYFBO1SwrmmVUTFgsj8//HfcsE9pyAjEBFQtt3oBrbKPl3TbheQKrlmRO
         8jrbiFcGxJf1A==
Subject: Re: [PATCH v11, 04/19] media: mtk-vcodec: export decoder pm functions
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
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20211129034201.5767-1-yunfei.dong@mediatek.com>
 <20211129034201.5767-5-yunfei.dong@mediatek.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
Message-ID: <2fa4e19f-d57c-6264-4284-8387c4182d1f@collabora.com>
Date:   Tue, 30 Nov 2021 14:34:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211129034201.5767-5-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 29/11/2021 à 04:41, Yunfei Dong a écrit :
> Register each hardware as platform device, need to call pm functions
> to open/close power and clock from module mtk-vcodec-dec, export these
> functions.

The commit message confuse me, maybe something like:
"When mtk vcodec decoder is build as a module we need to export
mtk-vcodec-dec pm functions to make them visible by the other components"

With that:
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

>
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>   drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
> index 20bd157a855c..221cf60e9fbf 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c
> @@ -77,12 +77,14 @@ int mtk_vcodec_init_dec_pm(struct platform_device *pdev,
>   	put_device(pm->larbvdec);
>   	return ret;
>   }
> +EXPORT_SYMBOL_GPL(mtk_vcodec_init_dec_pm);
>   
>   void mtk_vcodec_release_dec_pm(struct mtk_vcodec_pm *pm)
>   {
>   	pm_runtime_disable(pm->dev);
>   	put_device(pm->larbvdec);
>   }
> +EXPORT_SYMBOL_GPL(mtk_vcodec_release_dec_pm);
>   
>   int mtk_vcodec_dec_pw_on(struct mtk_vcodec_pm *pm)
>   {
> @@ -94,6 +96,7 @@ int mtk_vcodec_dec_pw_on(struct mtk_vcodec_pm *pm)
>   
>   	return ret;
>   }
> +EXPORT_SYMBOL_GPL(mtk_vcodec_dec_pw_on);
>   
>   void mtk_vcodec_dec_pw_off(struct mtk_vcodec_pm *pm)
>   {
> @@ -103,6 +106,7 @@ void mtk_vcodec_dec_pw_off(struct mtk_vcodec_pm *pm)
>   	if (ret)
>   		mtk_v4l2_err("pm_runtime_put_sync fail %d", ret);
>   }
> +EXPORT_SYMBOL_GPL(mtk_vcodec_dec_pw_off);
>   
>   void mtk_vcodec_dec_clock_on(struct mtk_vcodec_pm *pm)
>   {
> @@ -129,6 +133,7 @@ void mtk_vcodec_dec_clock_on(struct mtk_vcodec_pm *pm)
>   	for (i -= 1; i >= 0; i--)
>   		clk_disable_unprepare(dec_clk->clk_info[i].vcodec_clk);
>   }
> +EXPORT_SYMBOL_GPL(mtk_vcodec_dec_clock_on);
>   
>   void mtk_vcodec_dec_clock_off(struct mtk_vcodec_pm *pm)
>   {
> @@ -139,3 +144,4 @@ void mtk_vcodec_dec_clock_off(struct mtk_vcodec_pm *pm)
>   	for (i = dec_clk->clk_num - 1; i >= 0; i--)
>   		clk_disable_unprepare(dec_clk->clk_info[i].vcodec_clk);
>   }
> +EXPORT_SYMBOL_GPL(mtk_vcodec_dec_clock_off);
