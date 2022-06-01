Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAE1539B44
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 04:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349186AbiFACZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 22:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240621AbiFACZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 22:25:16 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF96813EE;
        Tue, 31 May 2022 19:25:15 -0700 (PDT)
X-UUID: 1a39456bb36b478eaeb882ffe721512c-20220601
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:42db6c5f-de4f-4397-bcfa-97d13f873f17,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:50
X-CID-INFO: VERSION:1.1.5,REQID:42db6c5f-de4f-4397-bcfa-97d13f873f17,OB:0,LOB:
        0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:50
X-CID-META: VersionHash:2a19b09,CLOUDID:267b7814-f88c-475e-badf-d9ee54230b8f,C
        OID:de123c9a6729,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:0,BEC:nil
X-UUID: 1a39456bb36b478eaeb882ffe721512c-20220601
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 720505080; Wed, 01 Jun 2022 10:25:08 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 1 Jun 2022 10:25:07 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 1 Jun 2022 10:25:06 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 1 Jun 2022 10:25:06 +0800
Message-ID: <0209f3123079f65027bff96d8214129d7bf8393c.camel@mediatek.com>
Subject: Re: [PATCH v17 4/4] media: platform: mtk-mdp3: add Mediatek MDP3
 driver
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
Date:   Wed, 1 Jun 2022 10:25:06 +0800
In-Reply-To: <20220531061338.19555-5-moudy.ho@mediatek.com>
References: <20220531061338.19555-1-moudy.ho@mediatek.com>
         <20220531061338.19555-5-moudy.ho@mediatek.com>
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

On Tue, 2022-05-31 at 14:13 +0800, Moudy Ho wrote:
> This patch adds driver for Mediatek's Media Data Path ver.3 (MDP3).
> It provides the following functions:
>   color transform, format conversion, resize, crop, rotate, flip
>   and additional image quality enhancement.
> 
> The MDP3 driver is mainly used for Google Chromebook products to
> import the new architecture to set the HW settings as shown below:
>   User -> V4L2 framework
>     -> MDP3 driver -> SCP (setting calculations)
>       -> MDP3 driver -> CMDQ (GCE driver) -> HW
> 
> Each modules' related operation control is sited in mtk-mdp3-comp.c
> Each modules' register table is defined in file with "mdp_reg_"
> prefix
> GCE related API, operation control  sited in mtk-mdp3-cmdq.c
> V4L2 m2m device functions are implemented in mtk-mdp3-m2m.c
> Probe, power, suspend/resume, system level functions are defined in
> mtk-mdp3-core.c
> 

[snip]

> 
> +int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
> +{
> +	struct mdp_cmdq_cmd cmd;
> +	struct mdp_path *path = NULL;
> +	struct mdp_cmdq_cb_param *cb_param = NULL;
> +	struct mdp_comp *comps = NULL;
> +	struct device *dev = &mdp->pdev->dev;
> +	int i, ret;
> +
> +	atomic_inc(&mdp->job_count);
> +	if (atomic_read(&mdp->suspended)) {
> +		atomic_dec(&mdp->job_count);
> +		return -ECANCELED;
> +	}
> +
> +	cb_param = kzalloc(sizeof(*cb_param), GFP_KERNEL);
> +	if (!cb_param) {
> +		ret = -ENOMEM;
> +		goto err_cmdq_data;
> +	}
> +
> +	cmd.pkt = cmdq_pkt_create(mdp->cmdq_clt, SZ_16K);
> +	if (IS_ERR(cmd.pkt)) {
> +		ret = PTR_ERR(cmd.pkt);
> +		goto err_cmdq_data;
> +	}
> +
> +	comps = kcalloc(param->config->num_components, sizeof(*comps),
> +			GFP_KERNEL);
> +	if (!comps) {
> +		ret = -ENOMEM;
> +		goto err_cmdq_data;
> +	}
> +
> +	path = kzalloc(sizeof(*path), GFP_KERNEL);
> +	if (!path) {
> +		ret = -ENOMEM;
> +		goto err_cmdq_data;
> +	}
> +
> +	path->mdp_dev = mdp;
> +	path->config = param->config;
> +	path->param = param->param;
> +	for (i = 0; i < param->param->num_outputs; i++) {
> +		path->bounds[i].left = 0;
> +		path->bounds[i].top = 0;
> +		path->bounds[i].width =
> +			param->param->outputs[i].buffer.format.width;
> +		path->bounds[i].height =
> +			param->param->outputs[i].buffer.format.height;
> +		path->composes[i] = param->composes[i] ?
> +			param->composes[i] : &path->bounds[i];
> +	}
> +
> +	ret = mdp_path_ctx_init(mdp, path);
> +	if (ret) {
> +		dev_err(dev, "mdp_path_ctx_init error\n");
> +		goto err_cmdq_data;
> +	}
> +
> +	cmd.event = &mdp->event[0];
> +	ret = mdp_path_config(mdp, &cmd, path);
> +	if (ret) {
> +		dev_err(dev, "mdp_path_config error\n");
> +		goto err_cmdq_data;
> +	}
> +	cmdq_pkt_finalize(cmd.pkt);
> +
> +	for (i = 0; i < param->config->num_components; i++)
> +		memcpy(&comps[i], path->comps[i].comp,
> +		       sizeof(struct mdp_comp));
> +
> +	cb_param->mdp = mdp;
> +	cb_param->user_cmdq_cb = param->cmdq_cb;
> +	cb_param->user_cb_data = param->cb_data;
> +	cb_param->pkt = cmd.pkt;
> +	cb_param->comps = comps;
> +	cb_param->num_comps = param->config->num_components;
> +	cb_param->mdp_ctx = param->mdp_ctx;
> +
> +	cmd.pkt->async_cb.data = (void *)cb_param;

async_cb is part of proprietary callback mechanism and I'm replacing
the proprietary one with standard one. My final patch is [1] (not
upstreamed yet) and 'data' would be removed. The way to get data
related to pkt:

strutc mdp_data {
    struct cmdq_pkt pkt;
    /* Other data such as mdp, user_cmdq_cb, ... */
}

The callback function would callback with pkt and you could use pkt to
find struct mdp_data{}.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/commit/?h=mediatek-cmdq6&id=a35f642aa89f02b7307725cdaa3bfb348b26d093

Regards,
CK


> +	mdp->cmdq_clt->client.rx_callback = mdp_handle_cmdq_callback;
> +
> +	mtk_mutex_prepare(mdp->mdp_mutex[MDP_PIPE_RDMA0]);
> +	for (i = 0; i < param->config->num_components; i++)
> +		mdp_comp_clock_on(&mdp->pdev->dev, path-
> >comps[i].comp);
> +
> +	dma_sync_single_for_device(mdp->cmdq_clt->chan->mbox->dev,
> +				   cmd.pkt->pa_base, cmd.pkt-
> >cmd_buf_size,
> +				   DMA_TO_DEVICE);
> +	ret = mbox_send_message(mdp->cmdq_clt->chan, cmd.pkt);
> +	if (ret < 0) {
> +		dev_err(dev, "mbox send message fail %d!\n", ret);
> +		goto err_clock_off;
> +	}
> +	mbox_client_txdone(mdp->cmdq_clt->chan, 0);
> +
> +	kfree(path);
> +	return 0;
> +
> +err_clock_off:
> +	mtk_mutex_unprepare(mdp->mdp_mutex[MDP_PIPE_RDMA0]);
> +	mdp_comp_clocks_off(&mdp->pdev->dev, cb_param->comps,
> +			    cb_param->num_comps);
> +err_cmdq_data:
> +	kfree(path);
> +	atomic_dec(&mdp->job_count);
> +	wake_up(&mdp->callback_wq);
> +	if (cmd.pkt)
> +		cmdq_pkt_destroy(cmd.pkt);
> +	kfree(comps);
> +	kfree(cb_param);
> +	return ret;
> +}

