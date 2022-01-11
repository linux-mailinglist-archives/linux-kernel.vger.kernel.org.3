Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55CC48ABF0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349436AbiAKK57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:57:59 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48528 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349401AbiAKK5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:57:50 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 9C4581F43A34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641898668;
        bh=NvBp4xkPJVbNU3MK/oJVdRowkuSL4h8ZkX5EWIFweAI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=U90UTcwrcHl7lAE18Dd1C2v+QTtECGqSHw6u7imCFmXlIJL8hlnErzEALxjHebYGo
         +fX9GGbwyyHdQr6yWIf1R+4fIiSzm0ohVZ9OFu0EJURw3P+45Ov1dfR4XQ+l6wAu5w
         SqLnH3tJ/SqyxTnzhU5uzPKBkh/Upr5Ew6S7bis+rrdnmMuCaLIcC4LV1rwxeKbaP8
         GPViTBYhTVDaZe4JzcIT8jTKycSTqNkRWe2QbsOA3XcTj1HRzpsYp/TDvR92B+YJP2
         +1pyNwJm+S7KfKQ0YFaT768zI5+B0U2sipkCh2WkA24w6qQeSUfCNhohyyI3vlbx6L
         XipzmjZI9bz0Q==
Subject: Re: [PATCH v9 07/15] media: mtk-mdp: Get rid of mtk_smi_larb_get/put
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
        Houlong Wei <houlong.wei@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>, anan.sun@mediatek.com,
        srv_heupstream@mediatek.com, acourbot@chromium.org,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
        Robin Murphy <robin.murphy@arm.com>
References: <20211112105509.12010-1-yong.wu@mediatek.com>
 <20211112105509.12010-8-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <16f77e36-fffe-d2d3-2c7c-6412a038238c@collabora.com>
Date:   Tue, 11 Jan 2022 11:57:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211112105509.12010-8-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/11/21 11:55, Yong Wu ha scritto:
> MediaTek IOMMU has already added the device_link between the consumer
> and smi-larb device. If the mdp device call the pm_runtime_get_sync,
> the smi-larb's pm_runtime_get_sync also be called automatically.
> 
> CC: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
> CC: Houlong Wei <houlong.wei@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Evan Green <evgreen@chromium.org>
> Reviewed-by: Houlong Wei <houlong.wei@mediatek.com>
> Reviewed-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

