Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D698E59B73D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 03:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbiHVBWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 21:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiHVBWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 21:22:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF54820F5E;
        Sun, 21 Aug 2022 18:22:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BC3760EA6;
        Mon, 22 Aug 2022 01:22:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C72C433C1;
        Mon, 22 Aug 2022 01:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661131347;
        bh=xvWdR+0fgYyLTTh1nyxhSjVvFA+Y0K/fsFpoQYBXHf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y4wp+meT48ZkQW2JVkkbuQbR5wfPIN1jpq8Gte6+nB1IAPDHaGDaIsaJZV45LHSWS
         mlBVaxTs7+pHAUgvOKLAMg4XauilCUur7sqa92MUEf8ihsJPiIdwjA7tJMFE5kDNAQ
         wHfs66WkhkMJTs564PChzjSnniIsJ1JueEX1XOSv5+F1vgbuETJ8DkB7pxy6wVbKUY
         x+ArIs3pFsz9FsT1rpSL0FNVcEV4zyZ8wif6laLY/YZfoPQgbDZ9dxakgwcOVTOmJD
         rhbvz/+zHImk1nJ2dl1ZJCoX+p+pUqSZP52lm41mNqOonY2AyZBX9UiL3HDedkLwJJ
         yiaZt3kKYcIFA==
Date:   Mon, 22 Aug 2022 09:22:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Peter Chen <peter.chen@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: verdin-imx8mm: add otg2 pd to usbphy
Message-ID: <20220822012221.GH149610@dragon>
References: <20220811140738.96348-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811140738.96348-1-dev@pschenker.ch>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 04:07:38PM +0200, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> The Verdin iMX8M Mini System on Module does not have USB-ID signal
> connected on Verdin USB_2 (usbotg2). On Verdin Development board this is
> no problem, as we have connected a USB-Hub that is always connected.
> 
> However, if Verdin USB_2 is desired to be used as a single USB-Host port
> the chipidea driver does not detect if a USB device is plugged into this
> port, due to runtime pm shutting down the PHY.
> 
> Add the power-domain &pgc_otg2 to &usbphynop2 in order to detect
> plugging events and enumerate the usb device.
> 
> Fixes: 6a57f224f734 ("arm64: dts: freescale: add initial support for verdin imx8m mini")
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

Applied, thanks!
