Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA668464D8C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 13:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349195AbhLAMMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 07:12:25 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35614 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242864AbhLAMMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 07:12:22 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 20F951F458EB
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638360540; bh=e6GNEu+wR3rqkC7g+n4jt6R8FC/jvcD5LlLpfyUKevg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VqJz1bIHMb5HoP/P4opc9HPfG7iK1rCTWApS2B5acoRWT9mCRCnuain9t0YnHzexF
         qHJ88mE/PiqXBmKXm8hg33riacLDMzs/mMWiRGGv2sykNbRqgM9gKVwfrcbZM/zjM4
         136OPMrVKAuwcAuPwHQOhhZibY9RPLJcJBXFJKg7ERYxEENSwqABTZfhZ7osoRqTPF
         TWLslssNBDT1VxQ4EgB4ZsBfy82/WYlSGSP0moa7h0TPoanLREVUtUU4ZaWoyORsgx
         BChCZ3DN3kCERAiucn2aPhflUQbasMzW4Q8HHtqI2umDDv1cCfjCRlPwycaWsVSHcO
         G8URgRKgQUGng==
Subject: Re: [PATCH v11, 18/19] media: mtk-vcodec: Remove
 mtk_vcodec_release_dec_pm
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
 <20211129034201.5767-19-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <540a5ac7-80a2-a72c-87fe-5042f21f8deb@collabora.com>
Date:   Wed, 1 Dec 2021 13:08:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211129034201.5767-19-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/11/21 04:42, Yunfei Dong ha scritto:
> There are only two lines in mtk_vcodec_release_dec_pm, using
> pm_runtime_disable and put_device instead directly.
> 
> Move pm_runtime_enable outside mtk_vcodec_init_dec_pm to symmetry with
> pm_runtime_disable, after that, rename mtk_vcodec_init_dec_pm to *_clk since
> it only has clock operations now.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> Co-developed-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   .../media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c   | 10 +++++++---
>   .../media/platform/mtk-vcodec/mtk_vcodec_dec_hw.c    |  7 +++++--
>   .../media/platform/mtk-vcodec/mtk_vcodec_dec_pm.c    | 12 ++----------
>   .../media/platform/mtk-vcodec/mtk_vcodec_dec_pm.h    |  3 +--
>   4 files changed, 15 insertions(+), 17 deletions(-)
> 





Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
