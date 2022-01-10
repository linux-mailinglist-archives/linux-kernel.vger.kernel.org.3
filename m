Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F67489C93
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236446AbiAJPt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:49:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236493AbiAJPtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:49:20 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D301BC06173F;
        Mon, 10 Jan 2022 07:49:19 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id AD1671F431E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641829758;
        bh=h8/ZybSkjTANhLXAkddHPctf8TJco3amtHZ3qngOj/w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kRfsoAASOVLSZA05f3L5jCsW4eCrlUTXS9b3u8/dbwqx2IMQrlHbK5YLM+xaEFg3u
         jkVUNKOsbHq3gzBg/nJw0DlXI2jYlF3QWByTHribcqEbNNdlcuQI1GMra3u5sVuaQy
         USzNQ62oHI2Lp1ERqKu5jgIsAPpKGtopfyNrJlnHoz8cVfPv6GJlrQLB7tNk5th9lb
         oK8e5waQVk1vwL27b1nnOLBjX8zsWK8XQedxDMH5YTgOMEOr5Sg+hXgo5NqZpjZaQM
         VOtEk/EO1FmA2NzqavBT5cnfYuVJxOPR+tuVYZrWw3gNrrk61yiuUgSkfHxtOPfixO
         SOVY7+OZfNLOw==
Subject: Re: [v1 16/16] clk: mediatek: Add MT8186 ipesys clock support
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
 <20220110134416.5191-17-chun-jie.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <ac78fbe2-cb96-5426-8281-3730f2114214@collabora.com>
Date:   Mon, 10 Jan 2022 16:49:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220110134416.5191-17-chun-jie.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/01/22 14:44, Chun-Jie Chen ha scritto:
> Add MT8186 ipesys clock controller which provides clock gate
> control for Image Process Engine.
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

