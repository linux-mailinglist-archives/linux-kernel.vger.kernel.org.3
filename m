Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9D148DB52
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236502AbiAMQIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:08:12 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47880 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236465AbiAMQIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:08:09 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 6FD951F45F4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642090088;
        bh=CX5BVrZGpnMjtmnkkGDBUrKDbK+wnrQ4jlu0suFe+d0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ClpxEEt4qs9QScYID5xGreji+sSRuBNpKzpbKOHLFD9gzfnhZ6nktAue31R/ETqEV
         YlU7aRquOn4DONf+lTAezOsbYJQcX33XRKyzGP9D7l+eqEc8MJXX/Q85eXPG5oOswH
         kIYvrHt7D5B/0tMC5dWKbAWXt3TNunpv/dUcEicLB5wEOott5RqMf3O61GhvJ5Iq6R
         BohwOBDago+2BQtAvsYjCGbD/NuJJ0o19eyBXlpJ0HFDUK6YgIml4NcUz4qTTrA82i
         pg22z+b61uCIK0jZA2PeIA1v+WiwRIv/4A/PHLc5Fq718HUAFi7mBlNPiaz0SiYPuA
         AvqaPrqT319hQ==
Subject: Re: [PATCH v11 09/22] soc: mediatek: change the mutex defines and the
 mutex_mod type
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
 <20220110084645.31191-10-nancy.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <c8f94e10-1830-6da9-f3eb-ca973b74b330@collabora.com>
Date:   Thu, 13 Jan 2022 17:08:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220110084645.31191-10-nancy.lin@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/01/22 09:46, Nancy.Lin ha scritto:
> This is a preparation for adding support for mt8195 vdosys1 mutex.
> The vdosys1 path component contains ovl_adaptor, merge5,
> and dp_intf1. Ovl_adaptor is composed of several sub-elements,
> so change it to support multi-bit control.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

