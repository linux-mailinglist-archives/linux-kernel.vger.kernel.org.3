Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57EF464D93
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 13:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349242AbhLAMMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 07:12:39 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35640 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349194AbhLAMMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 07:12:25 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id CB2121F458ED
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638360543; bh=GoJ9zIcpeE/cZjuFGeGwnP+Uu9Wb6grmE9L2/g8Ah0s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OSLBJoFWDe0g0u/ux8NQMGrTgrQddFrO+6LhDiJZDRAalZz5CGGvjuKZXmKPTEu8Q
         qy1jXmeADycRe3uSpHbZ62VDasamNhclN7xtfTzYwdH5Ir4SmbPNRGVJL9M8GDaNtM
         wdxXkhteZMl4XAcO1rA788HjXXZpCFYCbVxmfLWcNPnlZiAmzIv7f1jMW05AX24Kb+
         PKA1+43yRpbyOaLCLLrIOjxn0Ga89t+nH8XdbmbEWmi/srJHD71uczkXFSgtmeHvdz
         irDwdV7vKzasNNVZOLO6uYBVJ+ZyTjV1J5NKMAWqEBI3osNhq3JWl7k7Ft1rBgRUZv
         oxap/KRhT21TA==
Subject: Re: [PATCH v11,14/19] media: mtk-vcodec: Support 34bits dma address
 for vdec
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20211129034201.5767-1-yunfei.dong@mediatek.com>
 <20211129034201.5767-15-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <26b6cd92-c096-1b3b-236d-c9bbc68ff78c@collabora.com>
Date:   Wed, 1 Dec 2021 13:09:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211129034201.5767-15-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/11/21 04:41, Yunfei Dong ha scritto:
> Use the dma_set_mask_and_coherent helper to set vdec
> DMA bit mask to support 34bits iova space(16GB) that
> the mt8192 iommu HW support.
> 
> Whole the iova range separate to 0~4G/4G~8G/8G~12G/12G~16G,
> regarding which iova range VDEC actually locate, it
> depends on the dma-ranges property of vdec dtsi node.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
