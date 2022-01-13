Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0A048DADB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 16:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236230AbiAMPoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 10:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236215AbiAMPoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:44:14 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C167C061574;
        Thu, 13 Jan 2022 07:44:14 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 4A7421F45F52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642088653;
        bh=OCoO1qcOvbTSRnl8cd3s4VLrF0+nSIp3C4F6axnFvE4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hsYI0QU8kAEuHKcWn3ygTE6VlGWOluTXSPxAG10x0EfTk8xP/aPZdqBXt3qK4W8Ml
         rceQtiuf3bRX9VlepakMKRs9MSJnsNg+585JsW1WLe92vTGLmMBPn397qbf5btoP3y
         EmD/TIkY5531qS8GGM9vjfXTA71dhsi7GJ1ebWj73I+MW9k16hRjQ51x8Wg5OoyOSF
         GPCIEXc8oA7FHLuiOXcaQZQSJANTVsxFsbz94T215pZv8P6RDeK7eVpeD7n/fq4QU8
         53Eii705xxn0RpbtXLhOgFmQ72DVjdbon6GUg3NVJb5iYk6FRcB/2SivSLFdSbhkmx
         LDEY4dqU+RZvA==
Subject: Re: [PATCH v3 2/7] dt-bindings: memory: mtk-smi: No need
 mediatek,larb-id for mt8167
To:     Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, lc.kan@mediatek.com, yi.kuo@mediatek.com,
        anthony.huang@mediatek.com
References: <20220113111057.29918-1-yong.wu@mediatek.com>
 <20220113111057.29918-3-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <65919fad-3fbc-728d-4f14-5490b59e30a9@collabora.com>
Date:   Thu, 13 Jan 2022 16:44:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220113111057.29918-3-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/01/22 12:10, Yong Wu ha scritto:
> Mute the warning from "make dtbs_check":
> 
> larb@14016000: 'mediatek,larb-id' is a required property
> 	arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dt.yaml
> larb@15001000: 'mediatek,larb-id' is a required property
> 	arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dt.yaml
> larb@16010000: 'mediatek,larb-id' is a required property
> 	arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dt.yaml
> 
> As the description of mediatek,larb-id, the property is only
> required when the larbid is not consecutive from its IOMMU point of view.
> 
> Also, from the description of mediatek,larbs in
> Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml, all the larbs
> must sort by the larb index.
> 
> In mt8167, there is only one IOMMU HW and three larbs. The drivers already
> know its larb index from the mediatek,larbs property of IOMMU, thus no
> need this property.
> 
> Fixes: 27bb0e42855a ("dt-bindings: memory: mediatek: Convert SMI to DT schema")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



