Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DD449E0BC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbiA0LZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235759AbiA0LZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:25:07 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7BFC061714;
        Thu, 27 Jan 2022 03:25:06 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id AEB611F450C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643282705;
        bh=tb/UqL1WfiQAsAVHo/IniIBGl5T6FOXpUra+9byZHPc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dft+9zu4GosFe6lxR39lR/MXp7jg3zPW2DtXn/dflw38u9vvZM78dQ5jY/0A017oD
         RFlQ6Z7xd/ozv/Z3skQN1bh2hlysrSmcb3/msYFmCeOEiCPHVxTB4zLUNx2QRzULhI
         AhMoRQg1muZEhghItNzPsFD/q6UnAiwLQbL+Fa/ldy5D+CukNzsMzJaFNIFkFiIGpA
         3ue0MYIHoRdRnvf8heLxYDBw3jTLQ2DwJUANSEe4ZJ3XCFcAq22UiA2/E8B04nKG+y
         0vQIWR9DZP+Sid58n5T4ROvgxpDuZS/oWmuRskX/YeIWPMZ+cDrODepj59j+Uz0A8y
         xg1rgB2f5TO+A==
Subject: Re: [PATCH v4 35/35] iommu/mediatek: mt8195: Enable multi banks for
 infra iommu
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
 <20220125085634.17972-36-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <35ddad90-a13b-0370-a218-87887f47c0da@collabora.com>
Date:   Thu, 27 Jan 2022 12:25:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220125085634.17972-36-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/01/22 09:56, Yong Wu ha scritto:
> Enable the multi-bank functions for infra-iommu. We put PCIE in bank0
> and USB in the last bank(bank4). and we don't use the other banks
> currently, disable them.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

