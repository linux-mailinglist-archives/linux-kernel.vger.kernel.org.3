Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4857A48AAA7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 10:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349304AbiAKJiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 04:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236860AbiAKJiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 04:38:03 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2A5C06173F;
        Tue, 11 Jan 2022 01:38:03 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 667821F443C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641893882;
        bh=b8Xg2TY9K50GlJfbze5lcpegIc1dskT5b3FS7WqdRO4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=i2PLvZs8vfmY7doeiSC5KcbrBqFDVWWMHoFXb5TKCQPOKkk8wx9Axe4UyVrX2rQuP
         etjlE/X1sacDQCNP8Mr5JosCt8FbdgnJNlV0IM/Oe1Q9HwvCC10WbH+3qjazZxpmPt
         3XyaPez4hN30Q1GLQ7mXfWgQSOR7Gym4eLktEiSGzlhYokbAUdAztk3YP3zBkJj+cY
         q8sp6tp91sIiabYJIdTPi03NFt0rMxCUMz1NedBnhsWoIokznXadvQRZRY+1TNVfc+
         5Gkkcgdf3gvb+jX9cNzhpi3nZVrST1alH/lf6tSRn70UiMYpKj9a6TPlGK4DFUQYt0
         N3udFBEvvmZjg==
Subject: Re: [PATCH v11 4/4] soc: mediatek: mutex: add functions that operate
 registers by CMDQ
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
References: <20220104091712.25670-1-moudy.ho@mediatek.com>
 <20220104091712.25670-5-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <a78a4654-2442-e4b1-8e81-2a6d399407ec@collabora.com>
Date:   Tue, 11 Jan 2022 10:37:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220104091712.25670-5-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/01/22 10:17, Moudy Ho ha scritto:
> Considering that some functions have timing requirements
> in specific situation, this patch adds several interface that
> operate registers by CMDQ.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

