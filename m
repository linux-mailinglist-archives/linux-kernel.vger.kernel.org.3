Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD08E4BB977
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235315AbiBRMw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:52:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbiBRMwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:52:49 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A73D17DB8B;
        Fri, 18 Feb 2022 04:52:32 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 284BB1F469B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645188751;
        bh=yHDbz65IOr6g3ppelLD5Jk+jL9V5d6x0E66r5ToMDm0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=k08DZUBBKIVt/8PeW/wF/8J22fbzm3781RPF5QTXz8x3CXocP5/mXRKIzO4QnW5B2
         S4NmCmD7rbrNkwFQfWBmZS0y3PVU14zr9OEy6XVok0x8GGwGxS5wa45X3uqcVdPSaV
         ODPoqGXYiGjccJ0BhbpqB8fhxQNKjMh1qsWeLnn+GwaET4hLQGucbOb/NjNofqMobG
         xXARnFdQ1Zo1qeg3EUqyzUVau4fJcw7TifDm2A4FjacZ2eCOv/l31E6Qtoc/M7s61f
         KNlDmFx1BJdfV+/nvOof1oaNJa5z3+6mecEMB/5crGF2vTuCGAEVFRJKCE5Rls2/Tt
         Yn2KpWDJJfldw==
Message-ID: <b0099ae4-922d-8096-0b6a-ec3595c65b7a@collabora.com>
Date:   Fri, 18 Feb 2022 13:52:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v5 25/34] iommu/mediatek: Separate mtk_iommu_data for v1
 and v2
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Hsin-Yi Wang <hsinyi@chromium.org>, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, xueqi.zhang@mediatek.com,
        yen-chang.chen@mediatek.com, mingyuan.ma@mediatek.com,
        yf.wang@mediatek.com, libo.kang@mediatek.com,
        chengci.xu@mediatek.com
References: <20220217113453.13658-1-yong.wu@mediatek.com>
 <20220217113453.13658-26-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220217113453.13658-26-yong.wu@mediatek.com>
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

Il 17/02/22 12:34, Yong Wu ha scritto:
> Prepare for adding the structure "mtk_iommu_bank_data". No functional
> change. The mtk_iommu_domain in v1 and v2 are different, we could not add
> current data as bank[0] in v1 simplistically.
> 
> Currently we have no plan to add new SoC for v1, in order to avoid affect
> v1 when we add many new features for v2, I totally separate v1 and v2 in
> this patch, there are many structures only for v2.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/iommu/mtk_iommu.c    | 82 +++++++++++++++++++++++++++++++++---
>   drivers/iommu/mtk_iommu.h    | 81 -----------------------------------
>   drivers/iommu/mtk_iommu_v1.c | 29 +++++++++++++
>   3 files changed, 106 insertions(+), 86 deletions(-)
> 
