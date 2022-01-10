Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1FB489CA0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236583AbiAJPuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236568AbiAJPt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:49:57 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583D7C06173F;
        Mon, 10 Jan 2022 07:49:57 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 778E81F43224
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641829788;
        bh=xtsNVNvDwlKbwSMsa8+rh3ndFCEccIfXfJEe81bHcpA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=A85IUG9tv1PogL9Ef2w4Vqqq9HQpGHhALrx6PT+u80Tmp6XsuitQkU5yBK+/md1AC
         DEZaXnuW2psJcbQWgEz2+zC/k3qYPpQpRNnq3LwAOwHWGZ6u8/iatB+6yBdvwAH+uc
         +nx9axw0BhCASnXFYLgYLZUwPJTZNGHrVTRxk5RMoxQbl7sdEC18S6xFaFgQNqf3fM
         WL0G4kLyO9D3PmtM47N1PIeF1ORtBb3F64Nj3/Ca6hmtxpE9a8FvbnTVhcX+RG/ZBc
         mvUFVKHXMtA6Kyspem7OHzuoJLsT+eXQYSf38ZLDIn62BcsMbGY8cdNfnSVmJLN6U6
         FCvqzHvUZsg+Q==
Subject: Re: [v1 11/16] clk: mediatek: Add MT8186 imgsys clock support
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
 <20220110134416.5191-12-chun-jie.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <81447fb8-eedc-d51f-a697-a631cadb8aaa@collabora.com>
Date:   Mon, 10 Jan 2022 16:49:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220110134416.5191-12-chun-jie.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/01/22 14:44, Chun-Jie Chen ha scritto:
> Add MT8186 imgsys clock controllers which provide clock gate
> control for image IP blocks.
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

