Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE08D476CBE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 10:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhLPJCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 04:02:21 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42242 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhLPJCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 04:02:20 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 6FC181F45D58
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639645338; bh=zL+DWDBWAxAva/LZzsV++QwebWTx6OWlGYYwxqnET50=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LeMrGcf6WrFDjr819fF7rrGXdWK1RGXev2g2Fe3BxmKyDKQR58rfPvyPzN/398uVh
         CPSvLQj6GuCESbkLKlzz3Stme+36QzEnpcECCfGeYxDLf2MMatNd93dxTonUZDi9LQ
         BJk0V+FaevjvId9RUuPdCKlt4PGxD7483tAYQqTmZLxdt2B/nlVMwQMAg/01n1itCP
         VMuJkAawvJXjOmy4Hf48QPoiyaeWbMWppDz17sr7FWfUH1c5ceUg3OnezI7T2vEoBb
         STf2TygCvpj5Q0nqFGVUNrzrD/RH+kXoDuAJ9JKsx+VgkEwHKgzfA9KA6a7H8XI5xG
         u7+7A9sC4+qMw==
Subject: Re: [PATCH v15, 10/19] media: mtk-vcodec: Add msg queue feature for
 lat and core architecture
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
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20211216085745.18732-1-yunfei.dong@mediatek.com>
 <20211216085745.18732-11-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <0eda55f9-6961-0ee5-b7f3-916a4e0a3d7c@collabora.com>
Date:   Thu, 16 Dec 2021 10:02:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211216085745.18732-11-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/12/21 09:57, Yunfei Dong ha scritto:
> For lat and core architecture, lat thread will send message to core
> thread when lat decode done. Core hardware will use the message
> from lat to decode, then free message to lat thread when decode done.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
