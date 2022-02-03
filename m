Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F344A81DA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349890AbiBCJuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:50:32 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42598 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbiBCJu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:50:29 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id D5E981F45305
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643881828;
        bh=lYgHb3dAkmY8mypiBgZpo6dpa8MBYUylGU6Ko2OA/+c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EvtqZBlVczSaej9X+PZau4GjQnWxdLp09eKfiGyk0DgHHIvFJ6H7AKdoD3jte5r2V
         4N9jJbnlMuFUxft8LrnzvyISCSIgn7g4TiBc0mytzUKK1u4LT3HTpMB5DXIeHv2k1p
         mnR8xz09oZyd69f4zxSQb5GaKrukgFcmSyQcrjC+CilAUJqlUjprog9Fle8mzJDOhT
         NVo5deWM51SZX4gm4mhZ9EWebRun+TO49rrQVheZMsIihHhM9zeQLlcRhll8x+Wp++
         9JY1b06ocduj0ozy9fuHujbGajPkhIEn7buoF0vdxFKegBQyfcIwneaCjOJtzNj+Wl
         VS9bDbDLOOQXQ==
Message-ID: <a6a8e54a-7ae8-6085-42ba-f12cadb0f98d@collabora.com>
Date:   Thu, 3 Feb 2022 10:50:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 14/31] clk: mediatek: pll: Clean up included headers
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220202134834.690675-1-wenst@chromium.org>
 <20220202134834.690675-15-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220202134834.690675-15-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/02/22 14:48, Chen-Yu Tsai ha scritto:
> Some included headers aren't actually used anywhere, while other headers
> with the declaration of functions and structures aren't directly
> included.
> 
> Get rid of the unused ones, and add the ones that should be included
> directly.
> 
> Also, copy the MHZ macro from clk-mtk.h, and drop clk-mtk.h from the
> included headers.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

