Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D499484560
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbiADPyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:54:31 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33146 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235081AbiADPy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:54:29 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B8B151F43596
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641311668;
        bh=I/TGeXshiIEtIXNbqSEavdV0+k3jnqVBRVJ7vhGUeSQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HUQfvdW5xT38wE1W3MsaitIaEd8IBiUZn2xO+2pUmUGmuvG3KeiCr2yXQmhY3BzzR
         eQsOCgZA9hFGPvJfyaih9sW3DMvYoierZD2EMdGGGK5C2yqYkHZS6rNdARa82fQhIa
         akuN7P1Iow8fUV7UQzQstdJ+jAJMDaP1Wzc4Pttze4m+PSHfHppWNDbLklU1EHNI+p
         h8ftJc9e5bUIbmXgJlwuo9kITEGRq5GEcTZQ5rALqZV5nqQCV8PAemVsnHJxFItyoS
         cPSIbLrcscSl7S84K0jnF4QvEE+wsMmgIptTaVNaHC6KQ9rCXrnCbpyTGtshUzgFZc
         ZkS5V80/pilxA==
Subject: Re: [PATCH v3 16/33] iommu/mediatek: Add IOMMU_TYPE flag
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
 <20210923115840.17813-17-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <b51db2d3-2788-2d6a-ef40-d842c88eae27@collabora.com>
Date:   Tue, 4 Jan 2022 16:54:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-17-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/09/21 13:58, Yong Wu ha scritto:
> Add IOMMU_TYPE definition. In the mt8195, we have another IOMMU_TYPE:
> infra iommu, also there will be another APU_IOMMU, thus, use 2bits for the
> IOMMU_TYPE.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>



Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
