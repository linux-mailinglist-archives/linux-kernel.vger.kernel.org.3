Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACECD49E000
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239856AbiA0LAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiA0LAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:00:07 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA62C061714;
        Thu, 27 Jan 2022 03:00:07 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id A55B71F45069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643281205;
        bh=ANnHQ3AW7cDcFPINFPyo+6Bw6O0a8MPJooTmRyKn1hE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Caw17/VTX8SU25VO7GP+5IiEs1dWo3oL/oYurRO63dZMfiD658/+0GTHMpC+GisE1
         lWS7UzOfaW8MWrVl7WYfDzdSQMNihCeu4FGO71j/YRQ/27J2ALxag45996kyXvtbSH
         QJJVIzvmiXDpWGMbTtKF5pWTD2V2fSI8LjekX7tdGRbgac5fjfWx9SgJCkNQnzF/vT
         NAgc1ZxUvsccvUC5S3aUN/TU8jU+o37BlVLMwllnO5CGAUXFoL1FIJ/Y410Cm1SZas
         9u5WQxsoYUbcohM2ohbOBvPOtb5G7Hn1UEhFk4tRNJwv2Ib6Zixedmhj7Jd5uM4lHE
         of0t90CtngClw==
Subject: Re: [PATCH v4 03/35] iommu/mediatek: Fix 2 HW sharing pgtable issue
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
References: <20220125085634.17972-1-yong.wu@mediatek.com>
 <20220125085634.17972-4-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <fc505da2-809c-c466-2256-b5293f242128@collabora.com>
Date:   Thu, 27 Jan 2022 11:59:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220125085634.17972-4-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/01/22 09:56, Yong Wu ha scritto:
> In the commit 4f956c97d26b ("iommu/mediatek: Move domain_finalise into
> attach_device"), I overlooked the sharing pgtable case.
> After that commit, the "data" in the mtk_iommu_domain_finalise always is
> the data of the current IOMMU HW. Fix this for the sharing pgtable case.
> 
> Only affect mt2712 which is the only SoC that share pgtable currently.
> 
> Fixes: 4f956c97d26b ("iommu/mediatek: Move domain_finalise into attach_device")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

