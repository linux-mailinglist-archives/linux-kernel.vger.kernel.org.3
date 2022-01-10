Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70302489CAE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbiAJPug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236496AbiAJPud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:50:33 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67612C06173F;
        Mon, 10 Jan 2022 07:50:33 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id ACEA11F4331A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641829832;
        bh=QSlVm5Djrgd/teW7o4tjSoRPfgMOgy5pEDv/QJP+kuM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZfqBin+xuTfCp+u5VjI5q2cthgjAobXQC3l5Pnsi4VicrF107eYtx62s0RbrVaWjn
         rlx/vNgrO1GIlt/uqsKuiw/OvCCbIc+84tQWY40zdmumxeSrN775zeKfpTozPmDxXa
         RSfOLJ852XOhEZLebi1UsphofgkB2/V+Iwpjy/TG01l/fFx77B/nyPl90N9INfWNyh
         aqFewn/1FpaJRWphPFE7sfhdN9nHPAG2QDCayyeKEqxhBfsPejciAp4V4WacoIavQ7
         PMI3BQ1jgLmsLV6rKatRwJrTnMdwhPJi7mimCZSHvrZr5iGM6CuTCBzVXaGiJ+mhVg
         AviY+foZjbe4A==
Subject: Re: [v1 07/16] clk: mediatek: Add MT8186 imp i2c wrapper clock
 support
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220110134416.5191-1-chun-jie.chen@mediatek.com>
 <20220110134416.5191-8-chun-jie.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <9233bc50-b377-c16d-2d03-a71770de0973@collabora.com>
Date:   Mon, 10 Jan 2022 16:50:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220110134416.5191-8-chun-jie.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/01/22 14:44, Chun-Jie Chen ha scritto:
> Add MT8186 imp i2c wrapper clock controllers which provide clock gate
> control in i2c IP blocks.
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

