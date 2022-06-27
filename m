Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6B555E344
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbiF0H5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbiF0H5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:57:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2306260F7;
        Mon, 27 Jun 2022 00:57:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E89360F0E;
        Mon, 27 Jun 2022 07:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCF1C3411D;
        Mon, 27 Jun 2022 07:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656316626;
        bh=DJiLoJ+ThfWmCYlVKNNjdZDrpzinswGJz5dfkPUweZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YQkLJyn5ctTg1rCesJhmoukogZXvCSvssX1tWrtVuxGunum6LgHXiBezSlw0PNz5+
         z9bESCxa/JA+2GBT7KpNbaoWrCk1OF6G2Z1fqSs/HRr60tT99cWS/tF5F7w1ZcHHXl
         IVcEA707HnFHkR0S6Tf4hfhjJYQ92Tm3mg7N37I4vXePm35irLB1Oo/X9bEC4/bQME
         hkZsm7n3LgjB6vwGJgtxYAQ5q0eLcVt8fOKxszhsdR8H/IxqokSRyKOaAoiqCiKE12
         FI/ZTq0hHGTPg6kOW6H9OKkRA+HZX3bLw5qGjM6oQWQxdo3uI+vdcBv2TbL6NC0KRD
         WFZic3D6iW4Qw==
Date:   Mon, 27 Jun 2022 15:56:58 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        hvilleneuve@dimonoff.com, l.stach@pengutronix.de,
        abbaraju.manojsai@amarulasolutions.com, jagan@amarulasolutions.com,
        matteo.lisi@engicam.com, tharvey@gateworks.com, t.remmet@phytec.de,
        u.kleine-koenig@pengutronix.de, t.remmet@phytec.deh,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 00/14] arm64: dts: imx8mp: correct pad settings
Message-ID: <20220627075658.GH819983@dragon>
References: <20220622061410.853301-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622061410.853301-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 02:13:56PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8MP iomux pad BIT3 and BIT0 are reserved bits. Writing 1 to the
> reserved bit will be ignored and reading will still return 0. Although
> function not broken with reserved bits set, we should not set reserved
> bits.
> 
> Peng Fan (13):
>   arm64: dts: imx8mp-evk: correct mmc pad settings
>   arm64: dts: imx8mp-evk: correct gpio-led pad settings
>   arm64: dts: imx8mp-evk: correct vbus pad settings
>   arm64: dts: imx8mp-evk: correct eqos pad settings
>   arm64: dts: imx8mp-evk: correct vbus pad settings
>   arm64: dts: imx8mp-evk: correct I2C5 pad settings
>   arm64: dts: imx8mp-evk: correct I2C1 pad settings
>   arm64: dts: imx8mp-evk: correct I2C3 pad settings
>   arm64: dts: imx8mp-venice-gw74xx: correct pad settings
>   arm64: dts: imx8mp-phyboard-pollux-rdk: correct uart pad settings
>   arm64: dts: imx8mp-phyboard-pollux-rdk: correct eqos pad settings
>   arm64: dts: imx8mp-phyboard-pollux-rdk: correct i2c2 & mmc settings
>   arm64: dts: imx8mp-icore-mx8mp-edim2.2: correct pad settings
> 
> Sherry Sun (1):
>   arm64: dts: imx8mp-evk: correct the uart2 pinctl value

Applied all, thanks!
