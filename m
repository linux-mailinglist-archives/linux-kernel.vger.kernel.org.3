Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712CE48459F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbiADPzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235187AbiADPzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:55:37 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB60C061792;
        Tue,  4 Jan 2022 07:55:37 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B35BF1F43596
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641311736;
        bh=hboQ0UccWWyk5yTva3vHB8Cda2X22RbuvWrIz+nuRK0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jLTzurliT0qIfOEFzR+9yaEiggyTlVDteq69iaFHhXMe8uFqk2zHh2aulUfvN+eIg
         k7s26VHxvNBid6ge3PydVg4I1l7MhtyaSm8eZ1uzjkbtBEqnOCezKT4mutXdYzJF3p
         yFNOimKCbDeoVsquuTZnUGfe9lyGqArZZWEnYZCnJ91KNTcb0UdMYqG5HLMAiDlu+/
         FtCOevYZYrTp4XiEN2UZ1PVHRu05pijNG5pnJnJpaMu3evgJVo69bhxpCq9HN9yMUk
         duT1HwvMYclEr7TQ5ysvYIyKT9/jPSMeYFIw6xkpCNiITpRXV/WIMzVvC1q2d7OvqC
         psbjEotdH+jlw==
Subject: Re: [PATCH v3 14/33] iommu/mediatek: Always enable output PA over
 32bits in isr
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
 <20210923115840.17813-15-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <ea6a6cf3-9215-f7f9-d049-afaa3f58a7cd@collabora.com>
Date:   Tue, 4 Jan 2022 16:55:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-15-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/09/21 13:58, Yong Wu ha scritto:
> Currently the output PA[32:33] is contained by the flag IOVA_34.
> This is not right. the iova_34 has no relation with pa[32:33], the 32bits
> iova still could map to pa[32:33]. Move it out from the flag.
> 
> No need fix tag since currently only mt8192 use the calulation and it
> always has this IOVA_34 flag.
> 
> Prepare for the IOMMU that still use IOVA 32bits but its dram size may be
> over 4GB.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>



Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

