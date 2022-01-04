Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C5048458E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbiADPz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbiADPzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:55:00 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18116C06139C;
        Tue,  4 Jan 2022 07:54:59 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 02C4E1F43595
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641311698;
        bh=chdnCOkGZy0A9uOFAgo19cZHBIHzLzuSg8BWqq7GwWY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=P2YkueBJHCs9rKKoRIim2/R1yHyL8imeEhKrUankAp6kj9RYiCeuE5gxKvGv3lYcx
         7Eul/z3XnMZ1CAHN//bkD2TCEIDmF5XA+ssEQv7fUXjgp6NsK03Lvwu+HSX+4WMfCF
         4PbDGDegE14F7sKZkllpx7/WGhCurmyrfO7bEinIYWi6/QAQuK98DAp+g8n3bNQ+U2
         yNO/FZt4moMj2ObV+NQk3iPDciJyu5OpcJhw9sLGG5iA9uze+iSwEs308VlshEYCgC
         w2VBOcSHwX0YSctDUsWKTDSBa10kT3no0O90L7CpCH/vVMueyS1nKDvU3uxeQ8tGo1
         h6az5qV6qDLqw==
Subject: Re: [PATCH v3 20/33] iommu/mediatek: Allow IOMMU_DOMAIN_UNMANAGED for
 PCIe VFIO
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
 <20210923115840.17813-21-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <d10be4b8-c095-7a20-c6b5-c3b63dfd31e6@collabora.com>
Date:   Tue, 4 Jan 2022 16:54:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-21-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/09/21 13:58, Yong Wu ha scritto:
> Allow the type IOMMU_DOMAIN_UNMANAGED since vfio_iommu_type1.c always call
> iommu_domain_alloc. The PCIe EP works ok when going through vfio.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>



Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

