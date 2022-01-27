Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC8B49E55B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242741AbiA0PCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:02:51 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54436 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237314AbiA0PCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:02:49 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 21B551F403B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643295768;
        bh=di0QlooY9Xo01DVMWIhw7aG/KryjQggrU+H4kEUJCBs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aGTgsniM1VQF3R1ga0HwRknNztMGKeXKiZ1fuXUfZIxEzqSbVbHW6EmIUbz+3bX5E
         rAOC8sqSNdnChw1Y+L0XhoiLpv0yYFj+XEuWELPt/day6gpS9SvG7StaTcetw33syR
         BJfmf5Q9VcLes8Z/xNaUfWt7FwVRZluWopfwuotYZlLvdnlrpC2lu3jkXSig3banzg
         hKQ+cDD1XeEX9V9yrYiQ0TVpIX5XI27FukUzwcr63FHc0T64zWufYtIMJWdUBQDoEt
         fs+/mT1Rkf7B1D0iB1EIOrsYHOSmEFTBmcNH3YvcxphMJL6Arp+9c2uGCUcUDmeadR
         DJOSTr2ufubKQ==
Subject: Re: [PATCH v1 06/14] media: platform: mtk-mdp3: Modify mtk-img-ipi.h
 for MT8195 SCP
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
References: <20220117055254.9777-1-roy-cw.yeh@mediatek.com>
 <20220117055254.9777-7-roy-cw.yeh@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <f6bbe7ff-1487-0ed1-595d-2449d57098ca@collabora.com>
Date:   Thu, 27 Jan 2022 16:02:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220117055254.9777-7-roy-cw.yeh@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/01/22 06:52, roy-cw.yeh ha scritto:
> From: "Roy-CW.Yeh" <roy-cw.yeh@mediatek.com>
> 
> 1. Modify struct member to 4 byte-alignment for MT8195 SCP limitation
> 2. Add new struct for hw engine adding in MT8195
> 
> Signed-off-by: Roy-CW.Yeh <roy-cw.yeh@mediatek.com>

This will break MT8183; is there any new firmware for that SoC that will
synchronize these structures?

Alternatively, you should add a new version of these structures and select
them with a wrapper function on a per-SoC basis, or per firmware version.
