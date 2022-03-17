Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08E24DD133
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 00:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiCQXdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 19:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiCQXdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 19:33:36 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE7C2986F6;
        Thu, 17 Mar 2022 16:32:18 -0700 (PDT)
X-UUID: c3f41a52f448425ebc731f678739e579-20220318
X-UUID: c3f41a52f448425ebc731f678739e579-20220318
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 48263738; Fri, 18 Mar 2022 07:32:12 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 18 Mar 2022 07:32:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Mar 2022 07:32:10 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <irui.wang@mediatek.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <acourbot@chromium.org>, <andrew-ct.chen@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <devicetree@vger.kernel.org>, <frkoenig@chromium.org>,
        <hsinyi@chromium.org>, <hverkuil-cisco@xs4all.nl>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <longfei.wang@mediatek.com>,
        <maoguang.meng@mediatek.com>, <matthias.bgg@gmail.com>,
        <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <srv_heupstream@mediatek.com>, <tfiga@google.com>,
        <tiffany.lin@mediatek.com>, <tzungbi@chromium.org>,
        <yong.wu@mediatek.com>, <yunfei.dong@mediatek.com>
Subject: Re: [PATCH v3, 03/10] dt-bindings: media: mtk-vcodec: Adds encoder cores dt-bindings for mt8195
Date:   Fri, 18 Mar 2022 07:32:10 +0800
Message-ID: <20220317233210.6744-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220317082230.23622-4-irui.wang@mediatek.com>
References: <20220317082230.23622-4-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Irui,

> +
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/media/mediatek,vcodec-encoder-core.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Mediatek Video Encoder Accelerator With Multi Core

s/Mediatek/MediaTek/
> +
> +maintainers:
> +  - Irui Wang <irui.wang@mediatek.com>
> +
> +description: |
> +  Mediatek Video Encode is the video encode hardware present in Mediatek

s/Mediatek/MediaTek/

> +  SoCs which supports high resolution encoding functionalities. Required
> +  parent and child device node.
> +

Thanks,
Miles
