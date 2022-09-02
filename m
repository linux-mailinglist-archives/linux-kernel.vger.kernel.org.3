Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F505AB790
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 19:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236715AbiIBRbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 13:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbiIBRbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 13:31:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF739F191;
        Fri,  2 Sep 2022 10:31:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD021621F5;
        Fri,  2 Sep 2022 17:31:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48667C433D6;
        Fri,  2 Sep 2022 17:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662139865;
        bh=xEjU6ABREWMOVvsUbeCrVUhQ+TEkw5DfKozvpaZ2bQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lProDyoBo3NGRmpi1Fpxj5p6lnNPV9AgAPut4N3CeswqR3mFMfFxG2Nffr1aTTcQc
         ybQJx70pYYiM67AlHvWDRUMjXcqea6We00/KpGQVsBdM/EpXcWgkdr5RlEaRywwP4e
         dIR28dJNCKDTlyMhkf0J4382RU/CAqcBgRc2iXquSgzniu7yvfHnQYk+JtImRco3Ua
         Vs6rGkXMGGHPx8SZkXB3qeaz+Vns+UEp7xb/h0ZW9U5yYR2i5WXwoarJkwpvt9H4zw
         NAHHcp87zGCeqIDYtfo4um3Fpl4DGx/riPL2J+J9j/dUt7/YD1+Y4Z+YxgSzx8W1QH
         uIg+SYAEwLy1Q==
Date:   Fri, 2 Sep 2022 23:01:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liang Chen <cl@rock-chips.com>
Subject: Re: [PATCH 0/3] Add support for the RK356x variant of the Inno CSI
 DPHY
Message-ID: <YxI91NRExHFQP5FM@matsya>
References: <20220720091527.1270365-1-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720091527.1270365-1-michael.riesch@wolfvision.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-22, 11:15, Michael Riesch wrote:
> Hi all,
> 
> This series adds support for the variant of the Innosilicon MIPI CSI DPHY that
> can be found in Rockchip RK356x SoCs.
> 
> Please note that only the basic operating mode is supported, in which all four
> CSI lanes are controlled by the Rockchip ISP. Split lane operation (e.g., two
> lanes to ISP and two lanes to VICAP) is not supported.
> 
> This has been tested on a Radxa ROCK3 Model A board together with an IMX219
> camera sensor and a patched version of the rkisp1 driver (with support for the
> RK356x variant V2.1 added in a very crude way).

Applied 1-2, thanks
-- 
~Vinod
