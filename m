Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5CC512AC4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 06:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242836AbiD1FCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 01:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238853AbiD1FCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 01:02:42 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3607398F60;
        Wed, 27 Apr 2022 21:59:23 -0700 (PDT)
X-UUID: 41f69475db6241fc87c8fcc89c3886a4-20220428
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:05d974db-9775-4f64-b046-f987e440036f,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.4,REQID:05d974db-9775-4f64-b046-f987e440036f,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:faefae9,CLOUDID:724afd2e-6199-437e-8ab4-9920b4bc5b76,C
        OID:IGNORED,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil,QS:0
        ,BEC:nil
X-UUID: 41f69475db6241fc87c8fcc89c3886a4-20220428
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 692952606; Thu, 28 Apr 2022 12:59:20 +0800
Received: from MTKMBS07N2.mediatek.inc (172.21.101.141) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 28 Apr 2022 12:59:19 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 Apr 2022 12:59:19 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 Apr 2022 12:59:19 +0800
Message-ID: <3e6bed63ed817381eb9d4d65d60c90172bef0440.camel@mediatek.com>
Subject: Re: [PATCH v14 3/3] media: platform: mtk-mdp3: add Mediatek MDP3
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
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 28 Apr 2022 12:59:19 +0800
In-Reply-To: <20220427070514.10355-4-moudy.ho@mediatek.com>
References: <20220427070514.10355-1-moudy.ho@mediatek.com>
         <20220427070514.10355-4-moudy.ho@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Moudy:

On Wed, 2022-04-27 at 15:05 +0800, Moudy Ho wrote:
> 

[snip]

> +
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
> +
> +	if (atomic_read(&mdp->suspended)) {
> +		atomic_dec(&mdp->job_count);
> +		return -ECANCELED;
> +	}
> +
> +	cmd.pkt = cmdq_pkt_create(mdp->cmdq_clt, SZ_16K);
> +	if (IS_ERR(cmd.pkt)) {
> +		atomic_dec(&mdp->job_count);
> +		wake_up(&mdp->callback_wq);
> +		return PTR_ERR(cmd.pkt);
> +	}
> +	cmd.event = &mdp->event[0];
> +
> +	path = kzalloc(sizeof(*path), GFP_KERNEL);
> +	if (!path) {
> +		ret = -ENOMEM;
> +		goto err_destroy_pkt;
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
> +		goto err_destroy_pkt;
> +	}
> +
> +	mtk_mutex_prepare(mdp->mdp_mutex[MDP_PIPE_RDMA0]);
> +	for (i = 0; i < param->config->num_components; i++)
> +		mdp_comp_clock_on(&mdp->pdev->dev, path-
> >comps[i].comp);
> +
> +	ret = mdp_path_config(mdp, &cmd, path);
> +	if (ret) {
> +		dev_err(dev, "mdp_path_config error\n");
> +		goto err_destroy_pkt;
> +	}
> +
> +	cb_param = kzalloc(sizeof(*cb_param), GFP_KERNEL);
> +	if (!cb_param) {
> +		ret = -ENOMEM;
> +		goto err_destroy_pkt;
> +	}
> +
> +	comps = kcalloc(param->config->num_components, sizeof(*comps),
> +			GFP_KERNEL);
> +	if (!comps) {
> +		ret = -ENOMEM;
> +		goto err_destroy_pkt;
> +	}
> +
> +	for (i = 0; i < param->config->num_components; i++)
> +		memcpy(&comps[i], path->comps[i].comp,
> +		       sizeof(struct mdp_comp));
> +	cb_param->mdp = mdp;
> +	cb_param->user_cmdq_cb = param->cmdq_cb;
> +	cb_param->user_cb_data = param->cb_data;
> +	cb_param->pkt = cmd.pkt;
> +	cb_param->comps = comps;
> +	cb_param->num_comps = param->config->num_components;
> +	cb_param->mdp_ctx = param->mdp_ctx;
> +
> +	cmdq_pkt_finalize(cmd.pkt);
> +	ret = cmdq_pkt_flush_async(cmd.pkt,
> +				   mdp_handle_cmdq_callback,
> +				   (void *)cb_param);

Matthias has applied patch [1], so I think you have better to base on
patch [1] to send patch.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/commit/?h=v5.18-next/soc&id=5252c1c5a08e583ab1363f809002cd8a59272b35

Regards,
CK

> +	if (ret) {
> +		dev_err(dev, "cmdq_pkt_flush_async fail!\n");
> +		goto err_clock_off;
> +	}
> +	kfree(path);
> +	return 0;
> +
> +err_clock_off:
> +	mtk_mutex_unprepare(mdp->mdp_mutex[MDP_PIPE_RDMA0]);
> +	mdp_comp_clocks_off(&mdp->pdev->dev, cb_param->comps,
> +			    cb_param->num_comps);
> +err_destroy_pkt:
> +	cmdq_pkt_destroy(cmd.pkt);
> +	atomic_dec(&mdp->job_count);
> +	wake_up(&mdp->callback_wq);
> +	kfree(comps);
> +	kfree(cb_param);
> +	kfree(path);
> +
> +	return ret;
> +}
> 



