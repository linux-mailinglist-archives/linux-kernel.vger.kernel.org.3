Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8A4484564
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbiADPys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:54:48 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33188 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiADPyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:54:45 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id A745C1F43593
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641311684;
        bh=htPv31qeleLONszyTBV6VHZP/int/iV0NZD4zdhGC3w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PNjmaFmhDh1B1oA3OZ2qRiTKOXyLO9Va9evMvCLECIobU+2Np9rjDMbKK0V8+LqRa
         cTbDRhZkehescMPqhkUYrjA2uBfUvKMH5yShtbnc36y5K3Qq62P/r1fGvrzqIaNmb9
         hAcuxUMGVebkD4TEpubxAA7WawtLmZSMOtwol7VgO++0BefFUWEVzKTxNjPKoZrOjd
         0zBMOQJtg7QxdtqjcfhR8as2VppmtIYDM0QBBNFTvbDSYiUyp3K3Xrf7r0VAvjmJoH
         Jy28C8BZRRflyLFGta+cwynjSd4CpVGWVfQwkqqlzwLdDTKg2Au7OecJijGDOG2Y5f
         GOSn1YShJCHEw==
Subject: Re: [PATCH v3 23/33] iommu/mediatek: Add mt8195 support
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
 <20210923115840.17813-24-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <64436ab1-064b-3a99-8ce0-6af6e23d4db8@collabora.com>
Date:   Tue, 4 Jan 2022 16:54:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-24-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/09/21 13:58, Yong Wu ha scritto:
> mt8195 has 3 IOMMU, containing 2 MM IOMMUs, one is for vdo, the other
> is for vpp. and 1 INFRA IOMMU.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


