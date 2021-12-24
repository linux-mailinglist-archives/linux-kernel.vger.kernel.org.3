Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DEB47EE18
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 10:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352364AbhLXJzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 04:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343931AbhLXJzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 04:55:07 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F328C061401
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 01:55:07 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 0FB081F40AF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1640339705;
        bh=g/qrKxbq81374OPNyBlN5b0Uw2S7uiZ13C5P82NahIA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XD9uQAp0iU8aU0GqQ/lNnkmvJNxU383e2Yc/NoWpqgEgWtz7InHOogu4bzmkWBmeE
         Zv0AUV3njiViMoqEIJxm7Yi2TDvE5vn2s0jMlZ21Nv8iRQcjvZALBP+DljqbrEs7jc
         /BtqdCo8dWLYheyk9rw6E3xMnUh0OKATLitRDINxJnvomKWzBQa+GXfO5lPEa7Juz7
         3eahIa7UqFFd1PMGGRU5x0IHymST1gnfE+ZAhfwxk0nxZ40ZG11/hoQ45Wxn5Ck2id
         F53JT34LitY7UVJVR3z7hf1qnp54N7/adwr1LBN8WjXLLePm8iKVPaAaxR4oFqehSK
         WnU9EONoPKT9w==
Subject: Re: [PATCH] phy: mediatek: Fix missing check in mtk_mipi_tx_probe
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211224082103.7658-1-linmq006@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <badadf88-f912-9794-774f-ec344f2303c0@collabora.com>
Date:   Fri, 24 Dec 2021 10:55:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211224082103.7658-1-linmq006@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/12/21 09:21, Miaoqian Lin ha scritto:
> The of_device_get_match_data() function may return NULL.
> Add check to prevent potential null dereference.
> 
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
