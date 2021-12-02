Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DC64665B9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358762AbhLBOux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244209AbhLBOut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:50:49 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A075C06174A;
        Thu,  2 Dec 2021 06:47:27 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 3555F1F42F85
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638456445; bh=MUykvhec7Q+F9BL/7BZmg4/vwqFlvV1Za/LaHrYPEZQ=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=OdOE84s+zI270tgBwZnMRazDnisyZnQwxoeFE7beFmkgNIs0x0ZhtHuU5rUDkeMPt
         NR+KgZY1QdEMTQJ1uTwzm0pgKLh3VFbkbunMmFb1xLrVd5fY4QU2nO+k9xl6DxZujs
         NbELgg//hXI97t3vn/VZvcihXKe8JDeFoCBtfetrfgJguarGJbtLIhsG3h8esFxAkX
         EVHJYf2hPU5QvZMadNg+Puv/4NhDtnCzMO2q3CvqJZb8avNQREfbVQGO2N19ApFQ4b
         DrMMdQwZBprc3cjX6WDvLhVirLEACqf4H30xgPqYtJp7xrKRWD95x1WuI1Hfkiidol
         Lc44APz6aaUZA==
Subject: Re: [PATCH v3 8/9] media: platform: mtk-mdp3: support mt8195
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     "roy-cw.yeh" <roy-cw.yeh@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Fabien Parent <fparent@baylibre.com>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>,
        "river . cheng" <river.cheng@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20211022022146.3577-1-roy-cw.yeh@mediatek.com>
 <20211022022146.3577-9-roy-cw.yeh@mediatek.com>
 <59d184c6-87ee-918c-b3cb-abb923c39912@collabora.com>
Message-ID: <f85f1433-00c6-20b9-8fe0-2ab1500f8520@collabora.com>
Date:   Thu, 2 Dec 2021 15:47:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <59d184c6-87ee-918c-b3cb-abb923c39912@collabora.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 22/10/21 10:58, AngeloGioacchino Del Regno ha scritto:
>> From: "Roy-CW.Yeh" <roy-cw.yeh@mediatek.com>
>>
>> Add mt8195 driver
>>
>> Signed-off-by: Roy-CW.Yeh <roy-cw.yeh@mediatek.com>
> 
> 
> Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> 
> 
>> ---
>>   drivers/media/platform/mtk-mdp3/mdp_reg_aal.h |   24 +
>>   .../media/platform/mtk-mdp3/mdp_reg_color.h   |   29 +
>>   drivers/media/platform/mtk-mdp3/mdp_reg_fg.h  |   23 +
>>   drivers/media/platform/mtk-mdp3/mdp_reg_hdr.h |   31 +
>>   .../media/platform/mtk-mdp3/mdp_reg_merge.h   |   23 +
>>   drivers/media/platform/mtk-mdp3/mdp_reg_ovl.h |   24 +
>>   drivers/media/platform/mtk-mdp3/mdp_reg_pad.h |   20 +
>>   .../media/platform/mtk-mdp3/mdp_reg_rdma.h    |   31 +
>>   drivers/media/platform/mtk-mdp3/mdp_reg_rsz.h |    6 +
>>   .../media/platform/mtk-mdp3/mdp_reg_tdshp.h   |  114 ++
>>   .../media/platform/mtk-mdp3/mdp_reg_wrot.h    |   18 +
>>   drivers/media/platform/mtk-mdp3/mtk-img-ipi.h |  215 ++-
>>   .../media/platform/mtk-mdp3/mtk-mdp3-cmdq.c   |  496 ++++++-
>>   .../media/platform/mtk-mdp3/mtk-mdp3-comp.c   | 1196 ++++++++++++++++-
>>   .../media/platform/mtk-mdp3/mtk-mdp3-comp.h   |   83 +-
>>   .../media/platform/mtk-mdp3/mtk-mdp3-core.c   |  703 +++++++++-
>>   .../media/platform/mtk-mdp3/mtk-mdp3-core.h   |   31 +-
>>   .../media/platform/mtk-mdp3/mtk-mdp3-m2m.c    |    4 +
>>   .../media/platform/mtk-mdp3/mtk-mdp3-regs.c   |  143 +-
>>   .../media/platform/mtk-mdp3/mtk-mdp3-regs.h   |    2 +
>>   20 files changed, 3020 insertions(+), 196 deletions(-)
>>   create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_aal.h
>>   create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_color.h
>>   create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_fg.h
>>   create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_hdr.h
>>   create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_merge.h
>>   create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_ovl.h
>>   create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_pad.h
>>   create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_tdshp.h
>>


Hello,
this patch doesn't apply anymore against the latest MDP3 driver series [1].

Can you please rebase ASAP?

[1]: https://patchwork.kernel.org/project/linux-mediatek/list/?series=588989

Thanks,
- Angelo
