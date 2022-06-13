Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F10547E46
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 05:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiFMDym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 23:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbiFMDye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 23:54:34 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88A1290;
        Sun, 12 Jun 2022 20:54:32 -0700 (PDT)
X-UUID: 682fd261204149ba8f7b0acd1f318bb3-20220613
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:8965c552-923c-43ae-be0a-22ba49894736,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:2a19b09,CLOUDID:65bd53c6-12ba-4305-bfdf-9aefbdc32516,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: 682fd261204149ba8f7b0acd1f318bb3-20220613
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1698871727; Mon, 13 Jun 2022 11:54:29 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 13 Jun 2022 11:54:27 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 13 Jun 2022 11:54:27 +0800
Message-ID: <fd6a9978c0987976f515959f092ec5c28f572aac.camel@mediatek.com>
Subject: Re: [PATCH v20 1/6] soc: mediatek: mutex: add common interface for
 modules setting
From:   CK Hu <ck.hu@mediatek.com>
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        <tfiga@chromium.org>, <drinkcat@chromium.org>,
        <pihsun@chromium.org>, <hsinyi@google.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        <allen-kh.cheng@mediatek.com>, <xiandong.wang@mediatek.com>,
        <randy.wu@mediatek.com>, <jason-jh.lin@mediatek.com>,
        <roy-cw.yeh@mediatek.com>, <river.cheng@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <cellopoint.kai@gmail.com>
Date:   Mon, 13 Jun 2022 11:54:26 +0800
In-Reply-To: <20220610063424.7800-2-moudy.ho@mediatek.com>
References: <20220610063424.7800-1-moudy.ho@mediatek.com>
         <20220610063424.7800-2-moudy.ho@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Moudy:

On Fri, 2022-06-10 at 14:34 +0800, Moudy Ho wrote:
> In order to allow multiple modules to operate MUTEX hardware through
> a common interfrace, two flexible indexes "mtk_mutex_mod_index" and
> "mtk_mutex_sof_index" need to be added to replace original component
> ID so that like DDP and MDP can add their own MOD table or SOF
> settings independently.
> 
> In addition, 2 generic interface "mtk_mutex_write_mod" and
> "mtk_mutex_write_sof" have been added, which is expected to replace
> the "mtk_mutex_add_comp" and "mtk_mutex_remove_comp" pair originally
> dedicated to DDP in the future.

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-mutex.c       | 53
> ++++++++++++++++++++++++++
>  include/linux/soc/mediatek/mtk-mutex.h | 25 ++++++++++++
>  2 files changed, 78 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-mutex.c
> b/drivers/soc/mediatek/mtk-mutex.c
> index 981d56967e7a..1d2c4df18b5c 100644
> --- a/drivers/soc/mediatek/mtk-mutex.c
> +++ b/drivers/soc/mediatek/mtk-mutex.c
> @@ -185,6 +185,7 @@ struct mtk_mutex_data {
>  	const unsigned int *mutex_sof;
>  	const unsigned int mutex_mod_reg;
>  	const unsigned int mutex_sof_reg;
> +	const unsigned int *mutex_table_mod;
>  	const bool no_clk;
>  };
>  
> @@ -606,6 +607,58 @@ void mtk_mutex_release(struct mtk_mutex *mutex)
>  }
>  EXPORT_SYMBOL_GPL(mtk_mutex_release);
>  
> +int mtk_mutex_write_mod(struct mtk_mutex *mutex,
> +			enum mtk_mutex_mod_index idx, bool clear)
> +{
> +	struct mtk_mutex_ctx *mtx = container_of(mutex, struct
> mtk_mutex_ctx,
> +						 mutex[mutex->id]);
> +	unsigned int reg;
> +	unsigned int offset;
> +
> +	WARN_ON(&mtx->mutex[mutex->id] != mutex);
> +
> +	if (idx < MUTEX_MOD_IDX_MDP_RDMA0 ||
> +	    idx >= MUTEX_MOD_IDX_MAX) {
> +		dev_err(mtx->dev, "Not supported MOD table index : %d",
> idx);
> +		return -EINVAL;
> +	}
> +
> +	offset = DISP_REG_MUTEX_MOD(mtx->data->mutex_mod_reg,
> +				    mutex->id);
> +	reg = readl_relaxed(mtx->regs + offset);
> +
> +	if (clear)
> +		reg &= ~BIT(mtx->data->mutex_table_mod[idx]);
> +	else
> +		reg |= BIT(mtx->data->mutex_table_mod[idx]);
> +
> +	writel_relaxed(reg, mtx->regs + offset);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mtk_mutex_write_mod);
> +
> +int mtk_mutex_write_sof(struct mtk_mutex *mutex,
> +			enum mtk_mutex_sof_index idx)
> +{
> +	struct mtk_mutex_ctx *mtx = container_of(mutex, struct
> mtk_mutex_ctx,
> +						 mutex[mutex->id]);
> +
> +	WARN_ON(&mtx->mutex[mutex->id] != mutex);
> +
> +	if (idx < MUTEX_SOF_IDX_SINGLE_MODE ||
> +	    idx >= MUTEX_SOF_IDX_MAX) {
> +		dev_err(mtx->dev, "Not supported SOF index : %d", idx);
> +		return -EINVAL;
> +	}
> +
> +	writel_relaxed(idx, mtx->regs +
> +		       DISP_REG_MUTEX_SOF(mtx->data->mutex_sof_reg,
> mutex->id));
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(mtk_mutex_write_sof);
> +
>  static int mtk_mutex_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> diff --git a/include/linux/soc/mediatek/mtk-mutex.h
> b/include/linux/soc/mediatek/mtk-mutex.h
> index 6fe4ffbde290..2ddab9d2b85d 100644
> --- a/include/linux/soc/mediatek/mtk-mutex.h
> +++ b/include/linux/soc/mediatek/mtk-mutex.h
> @@ -10,6 +10,26 @@ struct regmap;
>  struct device;
>  struct mtk_mutex;
>  
> +enum mtk_mutex_mod_index {
> +	/* MDP table index */
> +	MUTEX_MOD_IDX_MDP_RDMA0,
> +	MUTEX_MOD_IDX_MDP_RSZ0,
> +	MUTEX_MOD_IDX_MDP_RSZ1,
> +	MUTEX_MOD_IDX_MDP_TDSHP0,
> +	MUTEX_MOD_IDX_MDP_WROT0,
> +	MUTEX_MOD_IDX_MDP_WDMA,
> +	MUTEX_MOD_IDX_MDP_AAL0,
> +	MUTEX_MOD_IDX_MDP_CCORR0,
> +
> +	MUTEX_MOD_IDX_MAX		/* ALWAYS keep at the end */
> +};
> +
> +enum mtk_mutex_sof_index {
> +	MUTEX_SOF_IDX_SINGLE_MODE,
> +
> +	MUTEX_SOF_IDX_MAX		/* ALWAYS keep at the end */
> +};
> +
>  struct mtk_mutex *mtk_mutex_get(struct device *dev);
>  int mtk_mutex_prepare(struct mtk_mutex *mutex);
>  void mtk_mutex_add_comp(struct mtk_mutex *mutex,
> @@ -22,5 +42,10 @@ void mtk_mutex_unprepare(struct mtk_mutex *mutex);
>  void mtk_mutex_put(struct mtk_mutex *mutex);
>  void mtk_mutex_acquire(struct mtk_mutex *mutex);
>  void mtk_mutex_release(struct mtk_mutex *mutex);
> +int mtk_mutex_write_mod(struct mtk_mutex *mutex,
> +			enum mtk_mutex_mod_index idx,
> +			bool clear);
> +int mtk_mutex_write_sof(struct mtk_mutex *mutex,
> +			enum mtk_mutex_sof_index idx);
>  
>  #endif /* MTK_MUTEX_H */

