Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAD4484562
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbiADPye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:54:34 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33166 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbiADPyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:54:31 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 701451F43593
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641311670;
        bh=BKNFCtDzHiW7aW81Sd1qNrBnwDcorML47S0xIXNAwkw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=FqOOjUJTIvT83idev9h546g9Zx2hOlE6/KiwsyMy+fKf8Obo9TeAOn1B6XhWAZG9W
         JyB4tUzMGJxMTKAkHX5+GXGqSxjxnzuDfhFhJpiOsuo85HcqEWlU1UVPzVeY4CrueC
         5reAsMtgmVAzyNEwvzG0AMhZ2aQZUpjABi650dqvXzuI9Yro8kt1DmngwJFfeH8eXM
         gY44On5kwm1LQ0yYJuo6XRi7y52qGm/7LOtQiTyjH+L53d5DlWa9gDdZF9ll9vKbfY
         JR+sUBkmsPqZa8Y4dSDq3coUjLM7uNRR14b4aC8rB/RT7lND7FQLH4qhpeA9SJubU6
         /lzO94Iw4SGjQ==
Subject: Re: [PATCH v3 06/33] iommu/mediatek: Add 12G~16G support for multi
 domains
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
 <20210923115840.17813-7-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <0b4a4b95-813a-ef79-395d-da6ea80147d8@collabora.com>
Date:   Tue, 4 Jan 2022 16:54:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-7-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/09/21 13:58, Yong Wu ha scritto:
> In mt8192, we preassign 0-4G; 4G-8G; 8G-12G for different multimedia
> engines. This depends on the "dma-ranges=" in the iommu consumer's dtsi
> node.
> 
> Adds 12G-16G region here. and reword the previous comment. we don't limit
> which master locate in which region.
> 
> CCU still is 8G-12G. Don't change it here.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

