Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0FE49E19E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbiA0LwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:52:13 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51908 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235985AbiA0LwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:52:12 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 88FBE1F44C9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643284331;
        bh=DdkbTxmQp+SAGpru29bn+MIufi/Uo6XEdozCAJeoQCA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=F2bnAYU8uI72bl5vlNkwoqevgKkS8YDqOxLqWH1AVI/Oz7uHfuEyR2j1zlyRhCyrU
         KA4dQOtCZrxMGXoJNRq5seiVWzZCcw7dWVNTYeT9sO4+oFRlbjxZ+baq1p+f20q0bt
         l4KiSkx3weERNzfRa/d5V0F7XfkQm+WGf/8ffo6194uFGj2SoibE7nT6pl6n1KrAoN
         vwOFTqU93wATdpATITdELcYrF4I43+lqnZ/FP6HG4vz1L8kYT4qTKCZNWDX23artwK
         6dKyGDJE+/acBBCHrCZk4dqguiUHm/rOI82QUlKMJv2GYNxKDnY6TF6HXop3r0dAfx
         Vh9z9PNzauPgQ==
Subject: Re: [PATCH] spi: spi-mtk-nor: make some internal variables static
To:     guochun.mao@mediatek.com, Mark Brown <broonie@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Bayi Cheng <bayi.cheng@mediatek.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Bin Zhang <bin.zhang@mediatek.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        project_global_chrome_upstream_group@mediatek.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20220126091159.27513-1-guochun.mao@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <528883a0-0d55-a44e-ea18-3b0293505f54@collabora.com>
Date:   Thu, 27 Jan 2022 12:52:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220126091159.27513-1-guochun.mao@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/01/22 10:11, guochun.mao@mediatek.com ha scritto:
> From: Guochun Mao <guochun.mao@mediatek.com>
> 
> Variables mtk_nor_caps_mt8173, mtk_nor_caps_mt8186 and
> mtk_nor_caps_mt8192 are not declared.
> Make them static.
> 
> Fixes: 5b177234e9fd ("spi: spi-mtk-nor: improve device table for adding more capabilities")
> Signed-off-by: Guochun Mao <guochun.mao@mediatek.com>
> Reported-by: kernel test robot <lkp@intel.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

