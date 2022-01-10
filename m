Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4598D489CB6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236609AbiAJPuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:50:44 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38572 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236632AbiAJPum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:50:42 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B3FE91F43321
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641829841;
        bh=6/zAzRnOeziEg/t5fiEim35KaWTuX68SxoEub32prlI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GW3Dg4Rw20Hg99jcjFlDX54Ot1QMlbkQrEFbUjMG/t9RtxJySOh0ukk+h+5dfStGq
         scqaQ9FCp5AeUbe8tp5UCEijojFV193Bijw385i2iWw0fLdcxdf2tiS+rSCb3xO4eh
         UOBU6YPwl+lpB77MDoRH4NVXJhrQXAsAtw3CVcuwPo8MHilBc7ptr4NFbmF11iCp7Z
         OIXkwWy2zEfw6ztJDREhkj/ywpau/chRiMEwONxoWDZa3rif5dt04OfQ6Ae7lfKind
         mA0fHYJ8G8YIaNndzkA1iygNUZwLqWfr52mIvKnVGxH7E3i7zYLJHOqmf6pBUN5++f
         OS4MoSbn6Hq2Q==
Subject: Re: [v1 06/16] clk: mediatek: Add MT8186 apmixedsys clock support
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
 <20220110134416.5191-7-chun-jie.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <9f15a4ea-9a45-9c8c-92c8-401144bab929@collabora.com>
Date:   Mon, 10 Jan 2022 16:50:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220110134416.5191-7-chun-jie.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/01/22 14:44, Chun-Jie Chen ha scritto:
> Add MT8186 apmixedsys clock controller which provides Plls
> generated from SoC.
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
