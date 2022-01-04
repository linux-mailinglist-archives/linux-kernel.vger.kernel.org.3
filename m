Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB5648458D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbiADPz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235253AbiADPzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:55:09 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62416C0617A0;
        Tue,  4 Jan 2022 07:55:06 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 79D5F1F43598
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641311705;
        bh=pq/JTgM1Y8Z1Sk0vY1Nt0JrvfIMu8/2rCeHaoTIWlBo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MW1aTru7IdhJQrd08iFNoIToZjPwU4YtogjfexL6Gp9MvQuPq+bgq5ZLbEzzzvlfM
         pclJo3CD5sSN20fBdRYdh8Z/P/hGnih6TWpNHPBzSLxc9foTNGAtUDX7gOkv3adbiK
         vJ9VelGnB7Iz732SQCgYsKN32enh4z5VxPqK8pdEEB2l1twYGg8K24opYSaEmSM4Nf
         c8Q7mSOQooGnrl65Edzt3QLxCeNKsJ1d58WNswPkFPmkikF3AfiHtSTV0isPsWUWPq
         zKTV4CBR3pxCHK54z8axAvPm8WqESnKMqEf5u0BL/ieNbAixyRgYR91lcrd4SEaWp5
         0ZPKe3PzSisLw==
Subject: Re: [PATCH v3 17/33] iommu/mediatek: Contain MM IOMMU flow with the
 MM TYPE
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
 <20210923115840.17813-18-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <9e65ac5b-1b8b-03e6-c7f1-7104e96e06d2@collabora.com>
Date:   Tue, 4 Jan 2022 16:55:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-18-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/09/21 13:58, Yong Wu ha scritto:
> Prepare for supporting INFRA_IOMMU, and APU_IOMMU later.
> 
> For Infra IOMMU/APU IOMMU, it doesn't have the "larb""port". thus, Use
> the MM flag contain the MM_IOMMU special flow, Also, it moves a big
> chunk code about parsing the mediatek,larbs into a function, this is
> only needed for MM IOMMU. and all the current SoC are MM_IOMMU.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>



Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
