Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8858C504FC8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 14:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238053AbiDRMPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 08:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236080AbiDRMP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 08:15:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD211A829;
        Mon, 18 Apr 2022 05:12:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 790FF60F07;
        Mon, 18 Apr 2022 12:12:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5363FC385A7;
        Mon, 18 Apr 2022 12:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650283967;
        bh=sTDHUW8H0Ju0SV7mP2T0ccSD+m9Wyqkx8gNkRMj7XuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E+HI4BvBiOBx8bp1xWUOYDFCgyTltZVUIUBGmnsrzDETzHjyJWg5Ji2+mOuaJ4gXo
         80R/HdIt1py897GU53mJ+a3spXGgkcdA33nkaLX2cj8Ns2KSMv89sOaKPbAYW7WKD0
         CPzz9Y97vVBYe88R6rd2XDlbttF33OrlOK06waRoH8XyJLbIwVtKeiCfquqvyP0qvK
         VnSWyj+x3sx6hWQ9wvHgXaXEbPEFMi2uQEPj/nZMFUMIHZqBYwsDxdhFCEX2wAPmYy
         Bg+CQr4SFsZa/g9EFsDeJ8ggtgKe52vh8ss6dyHC1ATdHi8MPhmc1jHfDvgf0KuKTb
         4GIAkbtCDfifA==
Date:   Mon, 18 Apr 2022 20:12:41 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     linux-amarula@amarulasolutions.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Li Jun <jun.li@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] arm64: dts: imx8mm-evk: add pwm1/backlight support
Message-ID: <20220418121241.GL391514@dragon>
References: <20220413213313.11511-1-tommaso.merciai@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413213313.11511-1-tommaso.merciai@amarulasolutions.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 11:33:11PM +0200, Tommaso Merciai wrote:
> Add pwm1/backlight support nodes for imx8mm_evk board.
> Align with u-boot dts
> 
> References:
>  - https://patchwork.ozlabs.org/project/uboot/patch/20220326111911.13720-9-tommaso.merciai@amarulasolutions.com/
> 
> Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>

Applied, thanks!
