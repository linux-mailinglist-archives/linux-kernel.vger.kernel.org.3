Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32A8489CB1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbiAJPuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:50:39 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38476 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236555AbiAJPtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:49:35 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 8E3F71F431E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641829774;
        bh=ne0Jraqe7n9mrUjbbOsC59asC6NyKUf8d8vKtrvix6g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=L2wlniuov95/Oi9A1Q1uEyADH0A7GRTGJsw0YDc6LlbnqV31MqLNSbx/Zvl1yFABF
         hHGDlBj9mlInDnzT+sUDTpgI3rQaqpeJCXM9XmAYW04gTzP+YtmmokOjc9uLsXpb7s
         khllVkTRCXdQaIZEhRrSCWiNSvcirxyKt8vpQMTiaoY2zfcYkRmMTIqmoBWFwSgIQL
         +LFzKUo9O7nu8r+nAOaYVLTKrVq27rCyB5MD7gr+lnp2HmM/W3cBaoeA+MqAyXNqeP
         n/J7T7Q7hmHKisTyenyHPvw6Pb0SzB9vRZFav81CEGGeFDusPD4kl6+GGQZ48Mqwl2
         O1D6mE3ni3LCA==
Subject: Re: [v1 13/16] clk: mediatek: Add MT8186 vencsys clock support
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
 <20220110134416.5191-14-chun-jie.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <159e2406-4f1b-9ade-8daa-51d8eb055394@collabora.com>
Date:   Mon, 10 Jan 2022 16:49:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220110134416.5191-14-chun-jie.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/01/22 14:44, Chun-Jie Chen ha scritto:
> Add MT8186 vencsys clock controller which provide clock gate
> control for video encoder.
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

