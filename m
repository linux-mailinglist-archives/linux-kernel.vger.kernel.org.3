Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A91C59B2A5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 09:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiHUHwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 03:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHUHwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 03:52:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1991129CAA;
        Sun, 21 Aug 2022 00:52:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C04E2B80B2E;
        Sun, 21 Aug 2022 07:52:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7B7C433C1;
        Sun, 21 Aug 2022 07:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661068367;
        bh=4HE7PUbyJI7Wuw654atuUptpii9Iqk65EOWgePXwnDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=imCBLy+6MmOGiG0ms6vdKrV5LnCD9Lz8SrrOhZRDTCQ2/QmI+urIxKVU/nEoxRyyP
         5imkBICLmymFVI93bRqHuThTiie2Lz0PY3vLAxKAxmNb6iXSkIArlRxPg3mBOPtsN7
         iaM0VYtl+YNYjhi9y7+GDubAKO3tCWJlaKCUiacXDgbNMowynh1tWd3ifz36a1U75g
         +q+qZCWhMoKIuo0V/FQ2ftVDovJMEP1q/8QMj96EWs9IPZ/Y2+5urwm7J5HkqkwVoJ
         yj7imvbj+av555TiqzWBbURPXB8hLjdVnoMAmP6pH6I5XCrnxUf/MPc7tYOFbkJph1
         4t2d7X2LsboUw==
Date:   Sun, 21 Aug 2022 15:52:39 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lucas Stach <dev@lynxeye.de>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] ARM: arm64: dts/clk: imx8mm: indentation
 whitespace cleanup
Message-ID: <20220821075239.GP149610@dragon>
References: <20220722215445.3548530-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722215445.3548530-1-marcel@ziswiler.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 11:54:33PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> 
> While synchronising them imx device trees with U-Boot I stumbled over
> various checkpatch warnings. This series addresses those trivial
> indentation and/or whitespace cleanups.
> 
> Changes in v2:
> - The GPL part of the boilerplate license was actually GPL-2.0 only.
> - Add Alexander's acked-by. Thanks!
> - Add Lucas' acked-by. Thanks!
> 
> Marcel Ziswiler (12):
>   ARM: dts: imx6-sabrelite: change to use SPDX identifiers
>   ARM: dts: imx6qdl-mba6: don't use multiple blank lines
>   ARM: dts: imx6qdl: phytec: no spaces at start of line, indent use tabs
>   ARM: dts: imx6qdl-sabre: change to use SPDX identifiers
>   ARM: dts: imx7d-pico: indent use tabs, no spaces at start of line
>   ARM: dts: vf610: no spaces in indent but tabs
>   ARM: dts: vf610-twr: indent use tabs, no spaces at start of line
>   ARM: dts: vf610: don't use multiple blank lines
>   arm64: dts: imx8mm-venice-gw72xx-0x: blank line at end of file
>   arm64: dts: imx8mp-verdin: don't use multiple blank lines
>   arm64: dts: mnt-reform2: don't use multiple blank lines
>   clk: imx8mm: don't use multiple blank lines

Applied all, thanks!
