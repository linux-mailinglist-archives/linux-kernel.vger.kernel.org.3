Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035FE48DB48
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236455AbiAMQIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:08:06 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47834 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbiAMQIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:08:05 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 016CD1F45F44
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642090084;
        bh=grp7me+DC1tymcFVDuQBF2qCAT4WsTSUuXfAL8gosJQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ny+rEgZVHPJRlCPgjIkYrm37bk9oR+IaeqZkOkNA7ocvkFNuWpNDquYxbvEgxmKSO
         wcBUO8MmtQL4GN8n3BPbq3YUBSgY8Y43xXxiRkjsELV0duTm9RpOFOs/7kWmt1847d
         xbbloF7jq27G+OqEX96pX6Atl1cZl+AYYz5pueuWOc64ER1CcEcikvRt5q5n3WjY3F
         sZ7E9oNnVd7PWOMxrxgDQ8vFb4BCdLJ1DotUdOlZ0zjs2qDX3QuyTKF+5+kMbRXZet
         hGGEvST0bK0Xi4Yv5gpmvqTKHnwSGEhvHTIsr78s4AM28PWx/92ZA5T4ERyn+01urw
         wZU4qNTpsw+EQ==
Subject: Re: [PATCH v11 19/22] drm/mediatek: modify mediatek-drm for mt8195
 multi mmsys support
To:     "Nancy.Lin" <nancy.lin@mediatek.com>, CK Hu <ck.hu@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        singo.chang@mediatek.com, srv_heupstream@mediatek.com
References: <20220110084645.31191-1-nancy.lin@mediatek.com>
 <20220110084645.31191-20-nancy.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <d50c21ea-c62f-7d47-80e7-1db8522b2d38@collabora.com>
Date:   Thu, 13 Jan 2022 17:08:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220110084645.31191-20-nancy.lin@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/01/22 09:46, Nancy.Lin ha scritto:
> MT8195 have two mmsys. Modify drm for MT8195 multi-mmsys support.
> The two mmsys (vdosys0 and vdosys1) will bring up two drm drivers,
> only one drm driver register as the drm device.
> Each drm driver binds its own component. The last bind drm driver
> allocates and registers the drm device to drm core.
> Each crtc path is created with the corresponding drm driver data.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

