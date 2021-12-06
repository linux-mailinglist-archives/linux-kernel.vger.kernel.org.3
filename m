Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C0446954E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242776AbhLFL4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:56:40 -0500
Received: from 8bytes.org ([81.169.241.247]:40118 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242675AbhLFL4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:56:32 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 4F708396; Mon,  6 Dec 2021 12:52:58 +0100 (CET)
Date:   Mon, 6 Dec 2021 12:52:36 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        David Airlie <airlied@linux.ie>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Matthias Kaehlcke <mka@chromium.org>, anan.sun@mediatek.com,
        yi.kuo@mediatek.com, acourbot@chromium.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Eizan Miyamoto <eizan@chromium.org>,
        anthony.huang@mediatek.com,
        Frank Wunderlich <frank-w@public-files.de>,
        mingyuan.ma@mediatek.com, yf.wang@mediatek.com,
        libo.kang@mediatek.com
Subject: Re: [PATCH v9 00/15] Clean up "mediatek,larb"
Message-ID: <Ya35hNY0iAR/JPmI@8bytes.org>
References: <20211112105509.12010-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112105509.12010-1-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 06:54:54PM +0800, Yong Wu wrote:
> Yong Wu (14):
>   dt-binding: mediatek: Get rid of mediatek, larb for multimedia HW
>   iommu/mediatek-v1: Free the existed fwspec if the master dev already
>     has
>   iommu/mediatek: Return ENODEV if the device is NULL
>   iommu/mediatek: Add probe_defer for smi-larb
>   iommu/mediatek: Add device_link between the consumer and the larb
>     devices
>   media: mtk-jpeg: Get rid of mtk_smi_larb_get/put
>   media: mtk-mdp: Get rid of mtk_smi_larb_get/put
>   drm/mediatek: Get rid of mtk_smi_larb_get/put
>   media: mtk-vcodec: Get rid of mtk_smi_larb_get/put
>   media: mtk-vcodec: dec: Remove mtk_vcodec_release_dec_pm
>   media: mtk-vcodec: enc: Remove mtk_vcodec_release_enc_pm
>   memory: mtk-smi: Get rid of mtk_smi_larb_get/put
>   arm: dts: mediatek: Get rid of mediatek, larb for MM nodes
>   arm64: dts: mediatek: Get rid of mediatek, larb for MM nodes
> 
> Yongqiang Niu (1):
>   drm/mediatek: Add pm runtime support for ovl and rdma

What is the plan for merging this? If Matthias has no objections I can
take the iommu-parts, or will this go through another tree?

Regards,

	Joerg
