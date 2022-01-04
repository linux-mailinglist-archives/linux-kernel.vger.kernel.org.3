Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0533148459B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbiADPzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:55:45 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33430 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbiADPzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:55:25 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 595281F43595
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641311724;
        bh=mT55sEIhz+ZViNl1TjdLrnqAEkSGD0ha5i2STjrdvA0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZNbkj8e6y+LgMWHeFEfa+iWF8ALjy7AZee0LzFDih7hG97iQr1CXdNT6ACwpPNc6u
         n56MyNtfhzWCw6KNdIOa8fYIB+bMAc8ho5eetsvJ3Fc45BGlJk9IDQSkW0GGq7mFEK
         vOjZH3a/yqiZASpAWCQlJoTF9mmNYOUZHdGCEvuqzG7OCcXzHJ8WGji3ypr+AGvJYY
         IJJ5ALJxaoBRmcmWU8X0oTeYNN6iSzMNA6EyKgxQa+7vaO9LfXign1/KG8Qy3YotsR
         6Vb0+0+puysGL07M7LfolZMhpKjckvMyRkfJVxft9bDQYGzCZKwgLDqZCmV5qPvObw
         QrtuPyHD8nHzw==
Subject: Re: [PATCH v3 10/33] iommu/mediatek: Add tlb_lock in tlb_flush_all
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
 <20210923115840.17813-11-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <4444ddfd-c028-9549-0a1a-a3380fdd2d54@collabora.com>
Date:   Tue, 4 Jan 2022 16:55:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-11-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/09/21 13:58, Yong Wu ha scritto:
> The tlb_flush_all also touches the registers about tlb operations.
> Add spinlock in it to protect the tlb registers. since the tlb_range
> already hold the spinlock, move it a bit outside the spinlock to
> print log.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
