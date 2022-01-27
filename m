Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E262749E0B6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240226AbiA0LYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbiA0LYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:24:18 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0B9C061714;
        Thu, 27 Jan 2022 03:24:18 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E612D1F450C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643282656;
        bh=xoJYb7yLNdqcLOsJBRdXhk1XOETuJ9T5Y6SWYvR+lRs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ACpOQoxj+c5UV+KWe8EZFPgr1ZsW6yaxb1gX7+tXDKMZ1oMHxWGguvHmprL3xI5EO
         KQ1DMMBKcz/anWkLRuY3an5gRWvNJBadkVUKG4DN1K+ZMBVKZjugEKR5EpntlqQXhB
         Sm7rBtosZc5tFlwrTVeMgAly3MVqBpaYlcem5nN+bTkoNU27k6VsBO6GVr1HNbpEhC
         90wPhdHiwpnalYIhSmwyx/2+dL1bf68Zi8Hdh43pWnemI3P/7khEnRfcDk5z8KGpEg
         PAykca/s0HG8ZTwbE4TR8l4aVXGwpe2DHhthmfpsjLWj7DS0vk45bHJE+4WekaKFXF
         ogP8vC1fWSWiA==
Subject: Re: [PATCH v4 34/35] iommu/mediatek: Backup/restore regsiters for
 multi banks
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
 <20220125085634.17972-35-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <471f2317-24eb-9d94-8ba2-1124cdc95ed6@collabora.com>
Date:   Thu, 27 Jan 2022 12:24:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220125085634.17972-35-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/01/22 09:56, Yong Wu ha scritto:
> Each bank has some independent registers. thus backup/restore them for
> each a bank when suspend and resume.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

