Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632FD50D1C6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 15:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiDXNF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 09:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbiDXNFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 09:05:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FF217C50A;
        Sun, 24 Apr 2022 06:02:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D56060DBA;
        Sun, 24 Apr 2022 13:02:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE58C385AA;
        Sun, 24 Apr 2022 13:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650805374;
        bh=Sfn37A1dh/fhIxC3f/qXOh/1zuOdRPddO4X4656m+Vc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ev44lSZXtB/5w8YjY8IM8XfTN6cfrvEuTbIjzHk7qrbgL7TMss7qaa2EBAKn3PlgB
         xGLMXk2wts6/AIFZNcvNF+Vw0Hu5rcBGAh47fZ/fv4FXOA1obYGfZtTtDpF+RJ+fMr
         TPzMoeJWf2qKnFAfA/5+qzfiwFphHoie8I7nwMTGbHrwE/3NQcy2EuX3KRJxzff29f
         8Jfl7NsBb7URapT0+Gvsy06leM8GtJLCR5W9LbR5QD+irivnTjF1UHXz5qXvtp9Svp
         xXvWUkYOhMhyNj5o4laqCEjEJJqm0wPJ9GCEqBA2tjMXxUERVsXDjYI8ISxn8tJdgE
         VABFusXR0/M9g==
Date:   Sun, 24 Apr 2022 21:02:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 02/14] ARM: dts: imx6ull-colibri: fix vqmmc regulator
Message-ID: <20220424130247.GV391514@dragon>
References: <20220414085106.18621-1-marcel@ziswiler.com>
 <20220414085106.18621-3-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414085106.18621-3-marcel@ziswiler.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 10:50:54AM +0200, Marcel Ziswiler wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> The correct spelling for the property is gpios. Otherwise, the regulator
> will neither reserve nor control any GPIOs. Thus, any SD/MMC card which
> can use UHS-I modes will fail.
> 
> Fixes: c2e4987e ("ARM: dts: imx6ull: add Toradex Colibri iMX6ULL support")
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> Signed-off-by: Denys Drozdov <denys.drozdov@toradex.com>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Applied, thanks!
