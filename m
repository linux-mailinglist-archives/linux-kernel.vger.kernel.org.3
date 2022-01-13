Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AA148DB5B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbiAMQI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbiAMQIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:08:25 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2AFC06161C;
        Thu, 13 Jan 2022 08:08:25 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 7271F1F45F46
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642090104;
        bh=EJCJ/U8x9BufSZOZuD2xdqLDerBdLK0JlNJ0Lc3P0r8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=O63IZ60KePMUX4t7LXts5qjLWpTVTleknfXkdkm4GjReM/TIchvcn5woLrIzAbF8L
         xrFCf4dZ+mgyl/xtHAuSzbCeLFZiYCEN+T7Vn3EodIVKrtbUpe5dX5nkHKlUvTv2J+
         iHZ8kRTVIiZ0na2Oe/bkQQnFXZVfPBCJiU4lbiQulxD+RrkH3NBf+8afO31DymHURs
         VpcZZA4O4sEPlgwIt+9rBXt89PxTNsGoNCjjJ64pqyQe3K2EnVSCW32mNieNZtpyCR
         g5kHc/okwcvYCnuiuspbrJZMt4eLIlR0PwY0642uyIEYI++ss4Lt1D1K3bqWwy8X/R
         jSkpoHN1jf2+Q==
Subject: Re: [PATCH v11 05/22] soc: mediatek: add mtk-mmsys support for mt8195
 vdosys1
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
 <20220110084645.31191-6-nancy.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <1e3ff068-3335-8402-4eb6-ec4fbda44461@collabora.com>
Date:   Thu, 13 Jan 2022 17:08:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220110084645.31191-6-nancy.lin@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/01/22 09:46, Nancy.Lin ha scritto:
> Add mt8195 vdosys1 clock driver name and routing table to
> the driver data of mtk-mmsys.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

