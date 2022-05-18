Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990E452B9F8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 14:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236336AbiERMSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 08:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236300AbiERMSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 08:18:35 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7251F51329;
        Wed, 18 May 2022 05:18:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id A7A801F45034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652876312;
        bh=PFgx984+FuMCxbDdd6hqK/nxYtdSH9hLGtbOymoK8NY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RasqO0zP3KyeUtT66qDWuwaCJ1/Y0wy30WtrFygZfkptrGsCjxo7ZTOwFDi9KTBda
         L67uEr5HdlT7PKBIodRG8JgKanA/4TGhOd9Yrti50h3rTn7MKfFuZ0KSfTKwnB7q1k
         o5ZcddUKS334nPgssh/io9SNq8EVB4dPXZ2WABovKbt1yvHQJjxG7xGz1ZVPkdfp9f
         2tPf7CnBM2qinxKhUhg5EGbXnS+XCOmBsAJXGPAPsZIKICHWpTgoaDPhdmWGyvoR3o
         okLr5Cb97N8hOQHuXO3IiJg2txppFYC6Yi4ybz/c3zLYRzMo8ryyhKTfutowbWh0Q2
         bB+tPbsVK4uCw==
Message-ID: <e06b9256-3fb3-6ac4-9362-b23574f4da6e@collabora.com>
Date:   Wed, 18 May 2022 14:18:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] clk: mediatek: use en_mask as a pure div_en_mask
Content-Language: en-US
To:     Mandy Liu <mandyjh.liu@mediatek.com>, mturquette@baylibre.co,
        sboyd@kernel.org
Cc:     miles.chen@mediatek.com, wenst@chromium.org,
        chun-jie.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220513073621.12923-1-mandyjh.liu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220513073621.12923-1-mandyjh.liu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/05/22 09:36, Mandy Liu ha scritto:
> From: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> 
> We no longer allow en_mask to be a combination of
> pll_en_bit and div_en_mask, so remove pll_en_bit(bit0)
> from en_mask to make en_mask a pure en_mask that only
> used for pll dividers.
> 
> This commit continues the work done in commit 7cc4e1bbe300
> ("clk: mediatek: Fix asymmetrical PLL enable and disable
> control") and commit f384c44754b7 ("clk: mediatek:
> Add configurable enable control to mtk_pll_data") to
> clean up en_mask(bit0) default setting.
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Mandy Liu <mandyjh.liu@mediatek.com>


Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

