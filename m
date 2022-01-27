Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C6A49E080
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235639AbiA0LRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:17:18 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51398 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiA0LRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:17:17 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B033F1F45091
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643282235;
        bh=wZVt4wJ3ZIXwm5J3WkeI7DmuycE/6AgP9kxAmGl4MHk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RNpe9lY8NzKzJx8wUI+P77Ig0n7bSCYdR9WTVZzouOFw6c+LfKA1Kt6KIFOmCSjO3
         avcutdFnsOoW1N8IruruloGhYR9o1NgPvQA9mABR7Hq6ejP6NEhREHIAebGIbyhdth
         JWEWY7k+uAPjmo6BIPgOdD+0ZBOteQayMekEJAe/9ShguNUg/kwbt+LaRquKUT+Xwo
         GqBDAk/5+240cemf8Zn5kFDGKBolI2674mKtm4AnCwRaX3x0EM8gzJrDz8iH5chhlT
         Wxkpzu2KUmN92wCeUPl7swGx4YViUtqUfuuLRXa7vr8vZjpUjx4IjJLsuKQta7zGgw
         6/0p+2qKt+SYA==
Subject: Re: [PATCH v4 29/35] iommu/mediatek: Add mtk_iommu_bank_data
 structure
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Hsin-Yi Wang <hsinyi@chromium.org>, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, xueqi.zhang@mediatek.com,
        yen-chang.chen@mediatek.com, mingyuan.ma@mediatek.com,
        yf.wang@mediatek.com, libo.kang@mediatek.com,
        chengci.xu@mediatek.com
References: <20220125085634.17972-1-yong.wu@mediatek.com>
 <20220125085634.17972-30-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <fd39758a-b5a7-c6d9-3d29-0c6221d0c533@collabora.com>
Date:   Thu, 27 Jan 2022 12:17:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220125085634.17972-30-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/01/22 09:56, Yong Wu ha scritto:
> Prepare for supporting multi-banks for the IOMMU HW, No functional change.
> 
> Add a new structure(mtk_iommu_bank_data) for each a bank. Each a bank have
> the independent HW base/IRQ/tlb-range ops, and each a bank has its special
> iommu-domain(independent pgtable), thus, also move the domain information
> into it.
> 
> In previous SoC, we have only one bank which could be treated as bank0(
> bankid always is 0 for the previous SoC).
> 
> After adding this structure, the tlb operations and irq could use
> bank_data as parameter.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

