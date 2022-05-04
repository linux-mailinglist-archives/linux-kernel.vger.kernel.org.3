Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2764519BF4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347731AbiEDJjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347712AbiEDJi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:38:29 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDAF26564;
        Wed,  4 May 2022 02:34:19 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 2CAAF1F4473A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651656858;
        bh=VSz/LLsmEm1Js0cfKn+Hmm9ubakkhyVvI6T42wiqQyk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PlOwHCc+CFruh7L8UWYeg6XK6tzGsIY3A2394VHvH8aGKIVw+zd8ST1yVt4m+INrb
         1s2k2q32Gv5bC+41o+SmWhFiphpzbJ5yQeajgxwHooH6zkckIfkifHf+w5AiGDMPl0
         kvWZ/JneQLrziWClXJmWNeiaRwTHVMxFAl979XZzVmor5c1E3dIP3XMqRbhxJnys5D
         jU3dtS3ImUuZ+T3SUIxjalgdj5OGQqtW0p6BlQSIsAkxPaIYRuZllU0A9Bm9ffb1ks
         ewmt7ax2IyoGLZzG1KddFzEgFs3BA1Quzi3aVXfLG6uDsHnxXTEDEXzqTVeIKzBMRW
         jM+1TX3J5eQ+A==
Message-ID: <3bd77be6-82ea-8c24-242a-0ee486ce888c@collabora.com>
Date:   Wed, 4 May 2022 11:34:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] soc: mediatek: devapc: Add support for MT8186
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com
Cc:     neal.liu@mediatek.com, runyang.chen@mediatek.com,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220429065429.7957-1-rex-bc.chen@mediatek.com>
 <20220429065429.7957-3-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220429065429.7957-3-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/04/22 08:54, Rex-BC Chen ha scritto:
> Add devapc data and compatible to support MT8186 devapc.
> 
> Signed-off-by: Runyang Chen <runyang.chen@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>   drivers/soc/mediatek/mtk-devapc.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
> index 7c65ad3d1f8a..762e0e4d967d 100644
> --- a/drivers/soc/mediatek/mtk-devapc.c
> +++ b/drivers/soc/mediatek/mtk-devapc.c
> @@ -227,10 +227,25 @@ static const struct mtk_devapc_data devapc_mt6779 = {
>   	.vio_shift_con_offset = 0xF20,
>   };
>   
> +static const struct mtk_devapc_data devapc_mt8186 = {
> +	.vio_idx_num = 519,
> +	.vio_mask_offset = 0x0,
> +	.vio_sta_offset = 0x400,
> +	.vio_dbg0_offset = 0x900,
> +	.vio_dbg1_offset = 0x904,
> +	.apc_con_offset = 0xF00,
> +	.vio_shift_sta_offset = 0xF10,
> +	.vio_shift_sel_offset = 0xF14,
> +	.vio_shift_con_offset = 0xF20,
> +};

Hello Rex,
since the register layout is common across a lot of MediaTek SoCs and basically
only the vio_idx_num wildly varies between them, can you separate this parameter
from the mtk_devapc_data struct?

I propose the following:

struct mtk_devapc_regs {
	/* reg offset */
	u32 vio_mask_offset;
	u32 ... etc
};

struct mtk_devapc_data {
	u32 vio_idx_num;
	const struct mtk_devapc_regs *regs;
};

static const struct mtk_devapc_regs devapc_regs_mt6779 = {
	.vio_mask_offset = 0x0,
	.vio...etc
};

static const struct mtk_devapc_data devapc_mt6779 = {
	.vio_idx_num = 511,
	.regs = devapc_regs_mt6779,
};

static const struct mtk_devapc_data devapc_mt8186 = {
	.vio_idx_num = 519,
	.regs = devapc_regs_mt6779,
};

Regards,
Angelo

