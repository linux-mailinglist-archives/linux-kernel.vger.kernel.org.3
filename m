Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B47E3489B3D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 15:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbiAJO2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 09:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbiAJO2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 09:28:34 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B312FC06173F;
        Mon, 10 Jan 2022 06:28:30 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 2BD8E1F43965
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641824908;
        bh=wGHQz4aZXJUlLvuS23HzaOjfM4EVtupP1GIjfzLwJf0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=LGOx3pR4H6mpWRbDdbbBvR/3gZbLz1Pyx9FXUaWAy09uyAEtDm7PBvIcdQJ4NfadH
         ceKAGb09dutec948Vhhky212kCtoJwpzyklhhFF52qfR5V/u6eUmDUHww+1en4j4h/
         BCd6HKeuttaEm2/gf1EpKtQ+9wNVR1o8diEG0DWoDLwx/wWL+U4egqLXd6ztlrNYzP
         qt3YlHW4Ag1Ai1nP75JkjjZjOmElmsxP1ROyoRXm8FN1oMekBHafM/n7Hyirp54D2p
         n1Fy6JGaX9j2sdocRzikKwlR2xZ/dISH/skEbtYoq5fHRWaoriDqMrBEy4Kv8Lwk0E
         E6B/2xURuZ7uA==
Subject: Re: [v2 1/3] clk: mediatek: Add error handle when fail to register
 clock provider
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220110005902.27148-1-chun-jie.chen@mediatek.com>
 <20220110005902.27148-2-chun-jie.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <b3d59493-7819-94e4-343e-d0514ab9f72b@collabora.com>
Date:   Mon, 10 Jan 2022 15:28:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220110005902.27148-2-chun-jie.chen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/01/22 01:59, Chun-Jie Chen ha scritto:
> Need to deference registered clocks when fail to
> regisiter clock provider.
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
