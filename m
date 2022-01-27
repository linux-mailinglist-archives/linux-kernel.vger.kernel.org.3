Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CEC049E024
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239919AbiA0LDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239910AbiA0LDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:03:00 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0148DC061714;
        Thu, 27 Jan 2022 03:03:00 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B63611F41701
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643281378;
        bh=oRWo0Veii/RC5thoeHrP2GZT3yztnRxOcV4vMVuDWrw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DANWTO2FuWyYw+H4LLdsbFJmnTtEtz5IZacT9Oz68afHtrV7NRm06X0lo3vwg3UJm
         V1LZuevKoqhzsir9cBe8plY1suyuFyV7sLFfOgxuc21r/uzgpd02jWnsCHqmLiHZCP
         uR5XTKgXcOr1TL5PNucboFSqbHcRs9ABkmMQFjs8xQoHYsIPhgzhWT2maVE4l0K9s+
         ef1iScK99eK4ivp0lZGLoB2GEqZXSBcPJV9/Wcf0/Y/reJ5LwpgIMHW0YMqbkj6K4t
         R2mc4XPJiG5KMPSDuycY2bkNil4FYxSbh1VDKJgzorpeZBz3tYMsuAUK4IqQDu4/OY
         u8zz6qVVTth6w==
Subject: Re: [PATCH v4 07/35] iommu/mediatek: Add mutex for data in the
 mtk_iommu_domain
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
 <20220125085634.17972-8-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <8576a0c5-aa69-aaed-be48-125ae2004f47@collabora.com>
Date:   Thu, 27 Jan 2022 12:02:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220125085634.17972-8-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/01/22 09:56, Yong Wu ha scritto:
> Same with the previous patch, add a mutex for the "data" in the
> mtk_iommu_domain. Just improve the safety for multi devices
> enter attach_device at the same time. We don't get the real issue
> for this.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

