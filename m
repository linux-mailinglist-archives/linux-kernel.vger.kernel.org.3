Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45E44895E9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 11:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243533AbiAJKBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 05:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243561AbiAJKBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:01:33 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06467C061756;
        Mon, 10 Jan 2022 02:01:33 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 1D5A31F43727
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641808891;
        bh=fRV4dFn3irT6J0vQoA0RItda1+ceONurgTgIO7cm5k4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=S1cpCYLYuHJTUi+1Ij27MvLzhLfJzzBU6Ah2/Yx4I54IibcqHQeuSt5R+8Nt/tvrD
         rW3IDIp8sg8abc/RN/Pdi6a8/YM9e7MiWJ9UUcy0aXlfm9XCdomlezxR//Kbyy33kR
         z10C2eem3vaJX34/id0pr+iNsvge5bBY9r1Opd/TuSp5hK3KQ563yQ3wpmlWb6UQNU
         n14B4rSZ9RU23aeFU1C0IhPFVJ9KqJGxBytMwbCVpgwDStFWrSdC2aJYpcx0Vv3JDJ
         hUT5bakZDqAuPWLmvEbMlrbapxe0+yphptydHpbXx42I70WqPVLZ1KX1vAcXzbiDFz
         FklGFVbuLazaA==
Subject: Re: [PATCH v1 2/2] iio: adc: mt8186: Add compatible node for mt8186
To:     Guodong Liu <guodong.liu@mediatek.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220110084841.575-1-guodong.liu@mediatek.com>
 <20220110084841.575-2-guodong.liu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <292950d7-d057-4e66-5d0d-a5144f50f2ce@collabora.com>
Date:   Mon, 10 Jan 2022 11:01:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220110084841.575-2-guodong.liu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/01/22 09:48, Guodong Liu ha scritto:
> This commit adds mt8186 compatible node.
> 
> Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/iio/adc/mt6577_auxadc.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
> index d4fccd52ef08..fb08d761589a 100644
> --- a/drivers/iio/adc/mt6577_auxadc.c
> +++ b/drivers/iio/adc/mt6577_auxadc.c
> @@ -46,6 +46,11 @@ struct mt6577_auxadc_device {
>   	const struct mtk_auxadc_compatible *dev_comp;
>   };
>   
> +static const struct mtk_auxadc_compatible mt8186_compat = {
> +	.sample_data_cali = false,
> +	.check_global_idle = false,
> +};
> +
>   static const struct mtk_auxadc_compatible mt8173_compat = {
>   	.sample_data_cali = false,
>   	.check_global_idle = true,
> @@ -334,6 +339,7 @@ static const struct of_device_id mt6577_auxadc_of_match[] = {
>   	{ .compatible = "mediatek,mt2712-auxadc", .data = &mt8173_compat},
>   	{ .compatible = "mediatek,mt7622-auxadc", .data = &mt8173_compat},
>   	{ .compatible = "mediatek,mt8173-auxadc", .data = &mt8173_compat},
> +	{ .compatible = "mediatek,mt8186-auxadc", .data = &mt8186_compat},
>   	{ .compatible = "mediatek,mt6765-auxadc", .data = &mt6765_compat},
>   	{ }
>   };
> 
