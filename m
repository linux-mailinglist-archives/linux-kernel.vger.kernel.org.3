Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E54C94845A3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbiADP4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbiADPzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:55:47 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B069C06137B;
        Tue,  4 Jan 2022 07:55:47 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 6AD791F43595
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641311746;
        bh=qtsUEmGD51j+2uo99ESXu0PQjwuGLjPJy+zkSz7EjSE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JICc5cF8qNAmaxQsDW8LUiAiHhoETf7CyEZg6oD2u22vte6wYc3YwTwLW8iJT41Ox
         8Wq32QlhyYM2ayl0M1/5K4FhgV7lnyWT6yO3d0VMxAhz2NQxvTyfyzkQe0UfJkHrkk
         uwkwNdpwdD1bGGpCPLqMdIANj2ecRLmyvc7XN/uv31b/fTuo6SLJIHNMvTW+aAMARq
         pvUSH89KDRK68wTSI5gfwygf4HhnR0P6i32j5MbBN2IfgvKz/Cw84dxZhSmDxuk7gv
         xNkwOKeS6sXswvjMl2TcnjAI1pyCwKYCPLmnjcCpJwfKpvU5Cz5I21LtuIvFS8NpmZ
         JPtjpLKX1Myaw==
Subject: Re: [PATCH v3 05/33] iommu/mediatek: Adapt sharing and non-sharing
 pgtable case
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
 <20210923115840.17813-6-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <06b124b3-fadc-da03-648f-907c622e2272@collabora.com>
Date:   Tue, 4 Jan 2022 16:55:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-6-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/09/21 13:58, Yong Wu ha scritto:
> In previous mt2712, Both IOMMUs are MM IOMMU, and they will share pgtable.
> However in the latest SoC, another is infra IOMMU, there is no reason to
> share pgtable between MM with INFRA IOMMU. This patch manage to
> implement the two case(sharing and non-sharing pgtable).
> 
> Currently we use for_each_m4u to loop the 2 HWs. Add the list_head into
> this macro.
> In the sharing pgtable case, the list_head is the global "m4ulist".
> In the non-sharing pgtable case, the list_head is hw_list_head which is a
> variable in the "data". then for_each_m4u will only loop itself.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

