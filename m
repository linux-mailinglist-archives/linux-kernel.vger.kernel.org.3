Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685895AC92E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 05:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiIEDlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 23:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiIEDl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 23:41:26 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA382A94D;
        Sun,  4 Sep 2022 20:41:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 902FECE0FAA;
        Mon,  5 Sep 2022 03:41:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9530C433D6;
        Mon,  5 Sep 2022 03:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662349282;
        bh=HfIID0O+0aFGHzgZtHfS/CQNHIMr9Do6LgHjvPSu/sc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YBT0YIs19+XLwmftEL5uXV3FkxVUChpW7MsRiaMi2SE7i5LUllM646pSv/gB5Wv3O
         aaCuA4HAlDIl5VoH7T9F9jslKZzbEvJhT1Mvj7+EaYSgl2hEwYJjclVfQQjCC3M/jP
         sBHKkmste/7Ux3POr2stwhghYH6k+YDmofhAzuuiF7b8tGmuv78xMuaAVD0Kdagruk
         DOgF8ttta88IEPj8/TaDYzhbuRy9rs2QSlXBCGE54KQnZZxczAQf8ElhEVJ4vfmxFL
         r5ixMLLSSQEqfWNbRgiOSyYf+iVgYgSrEzjQi/kvY7c24qcfMd4chRQsqDCHzgq+GO
         zu1AmbMlmAwww==
Date:   Mon, 5 Sep 2022 11:41:15 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/4] arm64: dts: verdin-imx8mm: display and pmic
 related additions and fixes
Message-ID: <20220905034115.GL1728671@dragon>
References: <20220901100151.1378709-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901100151.1378709-1-marcel@ziswiler.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 12:01:47PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> 
> This series contains a few display and PMIC related additions and fixes.
> 
> 
> Marcel Ziswiler (2):
>   arm64: dts: verdin-imx8mm: rename sn65dsi83 to sn65dsi84
>   arm64: dts: verdin-imx8mm: add lvds panel node
> 
> Philippe Schenker (2):
>   arm64: dts: verdin-imx8mm: introduce hdmi-connector
>   arm64: dts: imx8mm-verdin: extend pmic voltages

Applied all, thanks!
