Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D45D530CFD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbiEWKE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 06:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbiEWKEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 06:04:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C00656F;
        Mon, 23 May 2022 03:04:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id A2EE61F41C09
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653300286;
        bh=hUasYgHF+fPKLk/4YEcyxnSp3Yt3vaTDlOnRTUToFZs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SeWvtFpW6V9YfJIB8dnpoZx6ZnPvjZ+/pY+kzYk6SVo8WrMHyGcEkMGKjhJLpqe5/
         lhpUX91Ck326DdvEG6HNi2oTMFqXWupvA+lVtT5nw3AKS4V4C3Q2/8z/567oMn7PZH
         rJltzwZ3ecr8V1Yf2WzzbYEN8MXZijPXQjEFYs5d95/i+c7yEnKDo0FuYyTMb8c5RX
         3+Mz7em3WcGtrXC068EK2v4Sf7YYlh2JaWFIigtqU2m/IMYYNMRfNrtKV9ZtCEt59w
         IRLk6Ngmq+jhAKRSctfzVJwZZ0ImzzJx+aB3ERI+5G4P8nAbek4/mBStsTSrdz2pkg
         3r5dDg379tzdQ==
Message-ID: <fc68ebcd-74d1-4ed5-381a-ea6e676a7680@collabora.com>
Date:   Mon, 23 May 2022 12:04:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 2/4] clk: mediatek: mt8183: mfgcfg: Propagate rate
 changes to parent
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220523085923.1430470-1-wenst@chromium.org>
 <20220523085923.1430470-3-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220523085923.1430470-3-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/05/22 10:59, Chen-Yu Tsai ha scritto:
> The only clock in the MT8183 MFGCFG block feeds the GPU. Propagate its
> rate change requests to its parent, so that DVFS for the GPU can work
> properly.
> 
> Fixes: acddfc2c261b ("clk: mediatek: Add MT8183 clock support")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

