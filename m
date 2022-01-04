Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A18D484550
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbiADPxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235090AbiADPxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:53:37 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD8AC061761;
        Tue,  4 Jan 2022 07:53:36 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 9B5961F434D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641311615;
        bh=cNd00AijAfU8AatU+tmQmAubCvXlTu/1+TRUQDeo7LM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=g6GxEklG4TK7WDuq2pOGWIgsJtmf/+d2GHHTWjJqo/k62gdnCM4B5DAwJABs1ZseM
         3UtMnPU2JL/kaqN0H1hJzeWHmmhtJnjNXoYoeDuZElLzWXq0IV0ju8o++FA3aGD4Cu
         yolSNexqk4GIrSLDpWPTGrRKBkiY5jz01m1C7Niui2CDC+/Gw5fbi85aRvZX1a/vT+
         FmDN3IHE9S9DO12KsnDSG2iXOrMYPp2LxeSv8WrbusQJBz7B8M46rTpGMs0HZG+YCg
         Qu2XWsKK9QjpzGD+5DrqAbn4pHzY2IJUD6GAKHLEhyN12SyAw30L6D+8F9swCc2R0T
         hOZas5YenRVgg==
Subject: Re: [PATCH v3 29/33] iommu/mediatek: Change the domid to
 iova_region_id
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
 <20210923115840.17813-30-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <bd0a2a6f-5edc-e036-d82a-81dffe31e293@collabora.com>
Date:   Tue, 4 Jan 2022 16:53:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-30-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/09/21 13:58, Yong Wu ha scritto:
> Prepare for adding bankid, also no functional change.
> 
> In the previous SoC, each a iova_region is a domain; In the multi-banks
> case, each a bank is a domain, then the original function name
> "mtk_iommu_get_domain_id" is not proper. Use "iova_region_id" instead of
> "domain_id".
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>



Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>




