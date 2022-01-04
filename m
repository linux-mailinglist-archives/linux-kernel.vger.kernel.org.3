Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F3848457D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbiADPzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:55:10 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33268 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbiADPy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:54:56 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 47BA81F43593
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641311695;
        bh=nZtZOEtytaUQcxSF0fDujQOcByfRCuHgzsSYmEcHraA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZECJ1qAJpbp/5J99/GNFFYUnVXcBNUp1NkoItJ2S6Qk9Emdi8DIiBmmNOmkZSx0oJ
         IoVLOG2n9g42K/EDPtxIUrS8JSKEapnaZcUbTPfig1V8A84+J2cfYZSkdO88OsiWXh
         WsTQMVfIu1zz+4P5HE3Sd1V5WOgRRsBnwOcuX4rz1jPSRr3mlqqptssnIFpmUcDKmA
         ZVHGs+RUVJ/7mX5RKLgtzqPSeFGcKOg9r7EdA2zgpT+tHAgHSyCeL7L+G6/fEU7bNN
         5BlesiGLftMpWBgxTpc0UcXlXFkK9IAyWe1Hm/eVn+e/JKzO3oj2W4/oZmKWQJB9jh
         GuClj0bbWHQJQ==
Subject: Re: [PATCH v3 21/33] iommu/mediatek: Add infra iommu support
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
 <20210923115840.17813-22-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <f1e93e9e-cc89-146a-410f-13ea94445d31@collabora.com>
Date:   Tue, 4 Jan 2022 16:54:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-22-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/09/21 13:58, Yong Wu ha scritto:
> The infra iommu enable bits in mt8195 is in the pericfg register segment,
> use regmap to update it.
> 
> If infra iommu master translation fault, It don't have the larbid/portid,
> thus print out the whole register value.
> 
> Since regmap_update_bits may fail, add return value for mtk_iommu_config.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>



Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


