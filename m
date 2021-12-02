Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E545346634F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357899AbhLBMQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346630AbhLBMQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:16:02 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41E4C061757;
        Thu,  2 Dec 2021 04:12:39 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 6E15B1F46337
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638447158; bh=Twt1cnHo5fIrWUn+6iuF4Co9D3Mu6kCIZI4gl+verPU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AUWnUaLzrxGiZCOJlSCwRigO1BcOjW4jKIffy2bzgNp8uICEVK7pTQjlk07DwJ5Wz
         FyfIU78kD0Kjra02UijJQrnzJGzKnX4CWcwgMGEeNykOHFuwcmmGhCtpecLOc2aD2D
         UdcQO7S7YFWgp7pyiJRoIZFgEUS1NLxvRjF6t4254TLxljT9xeTCHv7ZnvbVvNgEp5
         ci9vtyL2vgrxtluyz1hxyV4Z47GO3iTkQh3/xi+U2/cVJ/ihpoztJG4VLgtJ1J5hnx
         DMdPZ60vnydD+wV/+YfmSt5NgNos15QgJgz6ZTxQQC9YN+wXiWkPLS5CGNq4CVcr/0
         +JvS9SUOUhTXQ==
Subject: Re: [PATCH v10 2/4] soc: mediatek: mmsys: add support for ISP control
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
References: <20211202061322.19917-1-moudy.ho@mediatek.com>
 <20211202061322.19917-3-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <fc8b94fa-e5af-380e-4055-29c2b772619f@collabora.com>
Date:   Thu, 2 Dec 2021 13:12:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211202061322.19917-3-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/12/21 07:13, Moudy Ho ha scritto:
> This patch adds 8183 ISP settings in MMSYS domain and interface.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
