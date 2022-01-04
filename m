Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C831B48459D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235395AbiADPzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbiADPze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:55:34 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229F8C061394;
        Tue,  4 Jan 2022 07:55:33 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 102FA1F43596
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641311732;
        bh=icBLMUonunjpmX9rW+0plsHzwxROBGPHnt6LCs9+8RU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iCJ8g6eszCN0ha04hpDyyq5hPraa4vVwFaNybDlyDirnfaF8oDX22VJOSeyewzwNb
         Z5tfkuvhj4sC9EQSkF/OGPgTXw+fRe29stg7mI1llaWiWRULsDeedvXmSmnfGBRMC6
         yS6TObQmaaHdzmsXygwwZwpvvO04OZ1FchwKvxWg8BDNcPefKa++sSOZ4OLHVXXinQ
         aBCt4wGKp7YTC7oYhbCBshowoPpwQTKWCaHx86xsv9fxFHuDSCHdmCGoQ2kPdO0rTt
         qb6mR7D+ojF04T9qubdr57hwBuPwWtog95+nxEeK5H/FMkFTp4FSvf7VPWfTucpNZZ
         ircJfvbEUYMRw==
Subject: Re: [PATCH v3 19/33] iommu/mediatek: Add list_del in mtk_iommu_remove
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
 <20210923115840.17813-20-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <301a89d6-13ca-25db-facd-1860bc77f02b@collabora.com>
Date:   Tue, 4 Jan 2022 16:55:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-20-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/09/21 13:58, Yong Wu ha scritto:
> Lack the list_del in the mtk_iommu_remove, and remove
> bus_set_iommu(*, NULL) since there may be several iommu HWs.
> we can not bus_set_iommu null when one iommu driver unbind.
> This issue is not so important, No need fix tags.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

I would still add a Fixes tag on this commit, as that would schedule it for
backporting - and that's rather important, solidifying older releases.

Please add the required tag, after which...


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

