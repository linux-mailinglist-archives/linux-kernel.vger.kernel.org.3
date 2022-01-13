Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8966148D575
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 11:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiAMKLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 05:11:47 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44366 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiAMKLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 05:11:46 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E4E661F4585E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642068704;
        bh=D/XYC6ZGl5zYQW2bPb5HgmDBOTYg/Taj7564Kp6Xo1w=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=mE4sw4YvYqPtPCeGgdYDQbOGYr1D0sRwnP4JUyOyjhZj86DL2KdqFn53kzdPhLzVf
         Bw1VvaPOhimlqvAni2KTggbrrVF2tMVgZUYZ8GT3HumFLMHl/swIw8OEmuB63xYT9D
         ry4EVMAhrR1d8HMl2egIRfzRMjosarxVeMM5DKaB83CPATfsl/FDKcekgbGiXopEIL
         MnHuCbLxWgj6rZKBy6qsMzCkq0MxYh4lCNn7zCBOc/+l8UBmSPACrlbKg9pzt44nrH
         jFeTmjYUIPMAWJwQeXwYslmZrcg0H+P/WZvI2jlUHmT8gdPkXem6ziG4wdUDcl9DH5
         E8ZqIX9/NoQSw==
Subject: Re: [PATCH v9 12/15] media: mtk-vcodec: enc: Remove
 mtk_vcodec_release_enc_pm
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
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
        Irui Wang <irui.wang@mediatek.com>,
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
 <20211112105509.12010-13-yong.wu@mediatek.com>
 <68c3a573-8453-38e9-93b2-2067bedcd06f@collabora.com>
Message-ID: <4bd9e849-96dd-6f1c-2841-979459366ee5@collabora.com>
Date:   Thu, 13 Jan 2022 11:11:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <68c3a573-8453-38e9-93b2-2067bedcd06f@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/01/22 11:57, AngeloGioacchino Del Regno ha scritto:
> Il 12/11/21 11:55, Yong Wu ha scritto:
>> After this patchset, mtk_vcodec_release_enc_pm has only one line.
>> then remove that function, use pm_runtime_disable instead.
>>
>> meanwhile, mtk_vcodec_init_enc_pm only operate for the clocks,
>> rename it from the _pm to _clk.
>>
>> No functional change.
>>
>> CC: Tiffany Lin <tiffany.lin@mediatek.com>
>> CC: Irui Wang <irui.wang@mediatek.com>
>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 

Hello Yong,
the mtk-vcodec patches were merged in Yunfei's vcodec patch series and Hans has
scheduled that for v5.18.

Can you please send a v10 and drop patches 10/15, 11/15, 12/15 (all of the
media: mtk-vcodec: *) from this series?

For the records, I think that after sending v10 this series is ready to be merged,
as it was well reviewed and also tested on many MTK platforms.

Thank you,
- Angelo
