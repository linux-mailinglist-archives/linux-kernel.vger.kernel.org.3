Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09CE0464DA7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 13:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349343AbhLAMNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 07:13:24 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35748 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349254AbhLAMM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 07:12:58 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 468B31F458EB
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638360577; bh=QeEqEDtOecDK4Kb3DJwm3YYrksMuIw5id0yxMAABmcc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=TtUGI1CXSHdO+nJWaEL4I6OB1+YXXPYU9/3sRSHnDNmiAXWUwfPJOhlV9XkzS5KKM
         LvUscIrrct16pBZWKSHpwFqS7oOU4qMYnyMCYzZVUiqRu5NQScr5JllKBIGu2sjZyW
         W2biuNqoEzzlXWPo9mbnhhPNXQBkwGlU0fia625I6ScYNxgu4oaHv579NoEPfB911E
         IotnIqUX4mXkTHJuSEBFE/Ed54/fpsm4ilHW6K4fJWRv5ImEhG4eeA68rWm2VNqQCr
         bHdj/obI7I4aFYv+97RHeB53eCIM15L7LkUyKegriKywQJB9RwgKeqDAaSR8DD8CVL
         ku97afABjxOzQ==
Subject: Re: [PATCH v11, 05/19] media: mtk-vcodec: Support MT8192
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
 <20211129034201.5767-6-yunfei.dong@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <3fb4e348-295d-9ec4-43b4-0fad06b33010@collabora.com>
Date:   Wed, 1 Dec 2021 13:09:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211129034201.5767-6-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/11/21 04:41, Yunfei Dong ha scritto:
> From: Yunfei Dong <yunfei.dong@mediatek.corp-partner.google.com>
> 
> Adds MT8192's compatible "mediatek,mt8192-vcodec-dec".
> Adds MT8192's device private data mtk_lat_sig_core_pdata.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
