Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2315B1931
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 11:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiIHJsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 05:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiIHJsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 05:48:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87D8491C5;
        Thu,  8 Sep 2022 02:48:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5488561C19;
        Thu,  8 Sep 2022 09:48:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15870C433D6;
        Thu,  8 Sep 2022 09:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662630480;
        bh=twVKFDNBiJV5imqH0rJ1FX3tasybHNqPAbjuEtEEwBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FTq/jmjllxhZf4zqdTbijiuwMtav33tMrjaok6lXSDwstIvkbH0YUMS4yDf20f60i
         ZVdSXww5SMFHSElQwpEitJ9FoqjQZ/g4EkeyQPPUI4epDqcZs9o3EOIdfmhDAdMH6s
         YEItpf+8/16v3s554D+vQ39R+LZgo0XQmgjJ3bnbJeI9DmBSt/4PIr9tbPQz7deN6T
         krbmFeljz554fQy/FmUfKvuJxkUqcxkXN6f60A+LJy6KsdS90OIev6KZ6oW5cPDebA
         gQqyywgAeG4xCdRFKRyTA4LgOblHtVFa2LL71xeynVJxwELW4CkSkO9t+VgKvREazq
         m2yHENAGjSIgw==
Date:   Thu, 8 Sep 2022 10:47:51 +0100
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Robert Jones <rjones@gateworks.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Ripard <mripard@kernel.org>,
        - <patches@opensource.cirrus.com>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Chris Zhong <zyw@rock-chips.com>,
        Zhang Qing <zhangqing@rock-chips.com>,
        Alistair Francis <alistair@alistair23.me>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Renner Berthing <kernel@esmil.dk>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] dt-bindings: mfd: Add missing
 (unevaluated|additional)Properties on child nodes
Message-ID: <Yxm6R21Uw0/ghRsn@google.com>
References: <20220823145649.3118479-4-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220823145649.3118479-4-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2022, Rob Herring wrote:

> In order to ensure only documented properties are present, node schemas
> must have unevaluatedProperties or additionalProperties set to false
> (typically).
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../mfd/allwinner,sun6i-a31-prcm.yaml         | 40 +++++++++++++++++++
>  .../mfd/allwinner,sun8i-a23-prcm.yaml         | 10 +++++
>  .../bindings/mfd/cirrus,lochnagar.yaml        |  5 +++
>  .../devicetree/bindings/mfd/dlg,da9063.yaml   |  7 ++--
>  .../bindings/mfd/gateworks-gsc.yaml           |  5 ++-
>  .../bindings/mfd/maxim,max14577.yaml          |  1 +
>  .../bindings/mfd/maxim,max77843.yaml          |  1 +
>  .../bindings/mfd/rockchip,rk817.yaml          |  2 +
>  .../bindings/mfd/silergy,sy7636a.yaml         |  1 +
>  .../bindings/mfd/st,stm32-lptimer.yaml        |  4 ++
>  .../bindings/mfd/st,stm32-timers.yaml         |  3 ++
>  .../devicetree/bindings/mfd/st,stmfx.yaml     |  1 +
>  .../bindings/mfd/stericsson,ab8500.yaml       | 22 ++++++++++
>  .../devicetree/bindings/mfd/ti,tps65086.yaml  |  1 +
>  .../bindings/mfd/x-powers,axp152.yaml         |  1 +
>  15 files changed, 100 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
