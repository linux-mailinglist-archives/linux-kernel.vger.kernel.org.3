Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07364B1D51
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 05:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242946AbiBKEWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 23:22:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiBKEWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 23:22:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDDC55A3;
        Thu, 10 Feb 2022 20:22:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02048B827CD;
        Fri, 11 Feb 2022 04:22:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42741C340E9;
        Fri, 11 Feb 2022 04:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644553339;
        bh=KCVnkX+Z9cVMrEqCXSKN4Pdp1T9BE5FNaTBzbnXXT8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nm1F8EKPKvsJqQJZXEdXofOJ+YMwk8VZSzzWbeNCCLIqARqT3UbvrRtdE3NKV5rB8
         zlxPRfhqaY68rFgbJZ4YmTaCxuH3XtdCpYvSyw4IB9lVnsM2ilMG36kQfo0yX126u/
         CqYMlRvMAfuShTJA6OfWmNCxodEvUBCsKhlS9Z2RUyU75/5BVijV04B6UaG4EFxuLO
         ird/ru9AKw7JBD4txaPgiIMrMuRkNZX4OVT2J/FlZnqe1uEPtZsuw9YtCm/A5G10+x
         ZXA3I01W9FeFgZ8NxUPTGycc8m0UZb+e/z9KKY7nwX2A8nu9M68Mm4gdQqju2v68PM
         Irrr0/C+HnZPQ==
Date:   Fri, 11 Feb 2022 12:22:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mike Turquette <mturquette@baylibre.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Frank Li <frank.li@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/2] arm: dts: imx7: Use audio_mclk_post_div instead
 audio_mclk_root_clk
Message-ID: <20220211042212.GM4909@dragon>
References: <20220127141052.1900174-1-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127141052.1900174-1-abel.vesa@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 04:10:51PM +0200, Abel Vesa wrote:
> The audio_mclk_root_clk was added as a gate with the CCGR121 (0x4790),
> but according to the reference manual, there is no such gate. Moreover,
> the consumer driver of the mentioned clock might gate it and leave
> the ECSPI2 (the true owner of that gate) hanging. So lets use the
> audio_mclk_post_div, which is the parent.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Applied, thanks!
