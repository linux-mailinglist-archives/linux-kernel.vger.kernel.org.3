Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D165484588
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbiADPzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbiADPzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:55:05 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E34C061799;
        Tue,  4 Jan 2022 07:55:04 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 7BE961F43595
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641311703;
        bh=rOZIRvS+V/BkZvvFWWNJzuwskITaoR11QMgP9Z9JPSc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RrR3mIETgmbD0c63tDbRo4klPhS30MJqtHgS9+jdU5n2HRezVXYPS88ec+AkvEqm0
         hQrfyTIpJrF9PVBJXO6SQt1wc+897dfN4pow69/6YCdZ9FS34j8BsUH5SGjjtbQJjZ
         0SHj7zKmfiw9PqbcPccUl8XDT38WrdMcadVgDNwCI2xNqinK/lBn1lv/tgrNM/KgZw
         eTGnlI54bmygUtEmeDpAlWvAgwwsh0j1SORGDwnSYkzyC8ropiLsO37ilH72IIxTvd
         i/VrGd4nYSaDR3YnmMAPLhHy26iwLIBxUtycCZ7u4XPDk++BDXJl+IoT5GHYspjrSj
         04bxKaac4h8wQ==
Subject: Re: [PATCH v3 18/33] iommu/mediatek: Adjust device link when it is
 sub-common
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Hsin-Yi Wang <hsinyi@chromium.org>, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, chao.hao@mediatek.com,
        yen-chang.chen@mediatek.com
References: <20210923115840.17813-1-yong.wu@mediatek.com>
 <20210923115840.17813-19-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <bc973fde-bf87-570b-ccac-25a200cac4f1@collabora.com>
Date:   Tue, 4 Jan 2022 16:55:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-19-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/09/21 13:58, Yong Wu ha scritto:
> For MM IOMMU, We always add device link between smi-common and IOMMU HW.
> In mt8195, we add smi-sub-common. Thus, if the node is sub-common, we still
> need find again to get smi-common, then do device link.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>



Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
