Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F46A48AC05
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349580AbiAKK6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:58:12 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48538 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238090AbiAKK55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:57:57 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 753EF1F43A25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641898676;
        bh=uOOf2pUBjW2YNPi7A5gOPx8tj+5C9CcAKgPwKosMJPU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ah4whR4PxAPnSeKMaH8D0mIl+AmgJh8yjDIjTCTNd+eYX7zDpXLVhtZWjsdM/qQwi
         3uMfvbbagIzngjXVSy94LJ3N5bwkmXYmdqSqPKpawAPSx7TekssUGqpfx2VKURdw/L
         GciDTpeUZQSy2iI6FO0hSXnu4N/ifwznfBEh/i7ZjXRD39DrHcrjilNnJtU+ZUbAcs
         xmpe9iIVIU6yYCLuOAZt2m1kU25w45Iooh3OTmUI1cSZrwRUZK/vnT3yW+UiKKh6yS
         7tkprjeTlRfaeL+3glwdJpq3Zc1ekIFjxdDdS1DXm5fmOCqEdIqUwC0Qlgqi4kSvjH
         QVYVIxT+hXNpA==
Subject: Re: [PATCH v9 01/15] dt-binding: mediatek: Get rid of mediatek, larb
 for multimedia HW
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
 <20211112105509.12010-2-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <1020e4cf-99d4-0912-eca7-620e44a6d3f0@collabora.com>
Date:   Tue, 11 Jan 2022 11:57:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211112105509.12010-2-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/11/21 11:54, Yong Wu ha scritto:
> After adding device_link between the consumer with the smi-larbs,
> if the consumer call its owner pm_runtime_get(_sync), the
> pm_runtime_get(_sync) of smi-larb and smi-common will be called
> automatically. Thus, the consumer don't need this property.
> 
> And IOMMU also know which larb this consumer connects with from
> iommu id in the "iommus=" property.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Evan Green <evgreen@chromium.org>

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

