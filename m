Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A4148ABFC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238230AbiAKK6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:58:05 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48502 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349370AbiAKK5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:57:54 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 7DDD31F43A1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641898673;
        bh=6wNTz84+3ppqtpBY400+qokq8ilHyLriAqhO1jTt7WY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bOyZnJYRSG1IeiFNEA1vdrZDcq7HUWAO8NfRIzfYIFpbLpIKMPMW38bsUA+mxKY5A
         QZdold2V3e+xjNZzQ89/JA9zUkTrWm/7WEQiTrOtFLJZs5S80zJFFWe1gkOjGwOP85
         trid1U1bzWobWVbpW2icMcUqleBgHF2/TYKHCRXDZuerudNGz0d+SSUROkbNN8/P7A
         aZfiAuAzsu8X+hBZUdyC8/CwZkEBBfCJlpmVcxarA0cZ3ZEc/gmZ2GxbFl9aeo1z8j
         k7S6lm7xjWCJIgOQ271z35CkkS4wILbKJvaXd97s1xIgGwnvAZHdGw6H6/U2KzUJnY
         MltG58gR/jPyg==
Subject: Re: [PATCH v9 03/15] iommu/mediatek: Return ENODEV if the device is
 NULL
To:     Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        David Airlie <airlied@linux.ie>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        dri-devel@lists.freedesktop.org, yf.wang@mediatek.com,
        anthony.huang@mediatek.com, youlin.pei@mediatek.com,
        Evan Green <evgreen@chromium.org>,
        Eizan Miyamoto <eizan@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-kernel@lists.infradead.org, mingyuan.ma@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>, libo.kang@mediatek.com,
        yi.kuo@mediatek.com, linux-mediatek@lists.infradead.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>, anan.sun@mediatek.com,
        srv_heupstream@mediatek.com, acourbot@chromium.org,
        linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
        Robin Murphy <robin.murphy@arm.com>
References: <20211112105509.12010-1-yong.wu@mediatek.com>
 <20211112105509.12010-4-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <a6a8bb2b-8538-a27c-8e6b-21eb33ecfacd@collabora.com>
Date:   Tue, 11 Jan 2022 11:57:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211112105509.12010-4-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/11/21 11:54, Yong Wu ha scritto:
> The platform device is created at:
> of_platform_default_populate_init:  arch_initcall_sync
>    ->of_platform_populate
>          ->of_platform_device_create_pdata
> 
> When entering our probe, all the devices should be already created.
> if it is null, means NODEV. Currently we don't get the fail case.
> It's a minor fix, no need add fixes tags.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

