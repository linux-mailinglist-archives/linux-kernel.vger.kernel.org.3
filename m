Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8496E4AD9CC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343778AbiBHN2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354920AbiBHN1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 08:27:54 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38F4C0F661E;
        Tue,  8 Feb 2022 05:23:17 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 43D0A1F44D84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644326596;
        bh=opnGxqDeIEOnpsQ9yljfEaIzlBoUQF7+NaaOcrN86+I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=acb0aGkWrQQZ5J9X3qtgqhR7z8pxVBAyIlkxi0kNlQ4AqHuD9Ht60kwZv1N1bySoI
         DUBj8oVN+SusfB6BDvEAunM8bdsB7yoGRsew/LtI4aruBSMoFM2xVchuiacg/3Ga6g
         X1+L0h9c2u8QAO90mmhnxHAqVPoqu7PHYMmK7XIAnhF/1re14l+Tbeisx+zK47vlv1
         BWrIY31g0ymL5lyb9xzS6iBhFAuxKiGeFC5hLYsdCuzKDrblc4EU3xPAJ2/4ilZqow
         PVJ8toTPWQrqbPzAyjB8zvqLuVDykY/Zhbn5xOzQSO22Zu/jNzh7Xy2F1UNYCBe3bB
         crlTFxHqhMYag==
Message-ID: <4d889428-6e11-5df2-3c0a-8f4f60a9b580@collabora.com>
Date:   Tue, 8 Feb 2022 14:23:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3 28/31] clk: mediatek: mt8195: Hook up
 mtk_clk_simple_remove()
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220208124034.414635-1-wenst@chromium.org>
 <20220208124034.414635-29-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220208124034.414635-29-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/02/22 13:40, Chen-Yu Tsai ha scritto:
> Various small clock controllers only have clock gates, and utilize
> mtk_clk_simple_probe() as their driver probe function.
> 
> Now that we have a matching remove function, hook it up for the relevant
> drivers. This was done with the following command:
> 
> sed -i -e '/mtk_clk_simple_probe/a \
>          .remove = mtk_clk_simple_remove,' drivers/clk/mediatek/clk-mt8195-*.c
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Miles Chen <miles.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
