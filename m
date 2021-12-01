Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281C8464BA0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 11:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348662AbhLAKcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 05:32:43 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34346 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348628AbhLAKcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 05:32:42 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B78CB1F454F0
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638354561; bh=WV0G9yZFIKe2fqvqgmNdk7lxP5b9KSdc9XCdw4wHdIc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VMZewMlXa2qjyTF8y1kRqn8Vc2mMM0PF/uFVPSUzQOGCcuRs0AJLn4jpJenBr+2Zw
         wOho7QGFLAe5GZt72/QiONfPlo4sXV3wHl1FIEVwtpQr4soS2cjW3kvYwNdVPnu/8s
         0JqnvqSoz6JYGKTYIxjUTDiVayte14sXC8RKkaC7qLL1hNLouBTmeNt440GxS5xXku
         ON22jWW3t/eg28700/8L/gWQoQPaQYUi1heIRX4W2Zdbz9jLLXsbWxS2tETsRR4alh
         jdhaMpZsuRNL5saLvWY78dXVkGVs622/hdPwpi5fZj/xYzmTOBFVA70CyViIAlh/+Z
         HP16yHwBuhvAg==
Subject: Re: [PATCH v9 2/7] soc: mediatek: mmsys: add support for ISP control
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>, tfiga@chromium.org,
        drinkcat@chromium.org, pihsun@chromium.org, hsinyi@google.com,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        menghui.lin@mediatek.com, sj.huang@mediatek.com,
        allen-kh.cheng@mediatek.com, randy.wu@mediatek.com,
        jason-jh.lin@mediatek.com, roy-cw.yeh@mediatek.com,
        river.cheng@mediatek.com, srv_heupstream@mediatek.com
References: <20211201095031.31606-1-moudy.ho@mediatek.com>
 <20211201095031.31606-3-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <8aab6aec-054d-a0fc-dc26-b272ef8472bc@collabora.com>
Date:   Wed, 1 Dec 2021 11:29:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211201095031.31606-3-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/12/21 10:50, Moudy Ho ha scritto:
> This patch adds 8183 ISP settings in MMSYS domain and interface.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> ---
>   drivers/soc/mediatek/mt8183-mmsys.h    |  26 ++++++
>   drivers/soc/mediatek/mtk-mmsys.c       | 117 +++++++++++++++++++++++++
>   drivers/soc/mediatek/mtk-mmsys.h       |   1 +
>   include/linux/soc/mediatek/mtk-mmsys.h |  30 +++++++
>   4 files changed, 174 insertions(+)
> 

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
