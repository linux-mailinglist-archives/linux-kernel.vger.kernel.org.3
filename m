Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0C850D208
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 15:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbiDXN1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 09:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbiDXN1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 09:27:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FE92CCBA;
        Sun, 24 Apr 2022 06:24:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D717FB80E01;
        Sun, 24 Apr 2022 13:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962D5C385A7;
        Sun, 24 Apr 2022 13:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650806641;
        bh=wvQkc+2uA8mjgxPugS0x7bNJfDwXVzXM+L26GM9WiR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ueZMAQKT1e3rLJ4BaF6WWyYA/bLVkFMlZmuJB85pVPfB2fw+q8BgoYPg0BDE6N3Yg
         eKaYsk9Qh62K/EcOJFvTRgZXnsJcM29iL5Av5A9QN/T53g0CmLugGluEugd+kztq9b
         PJiFEx8hJth2an/TlBGvQn38tD2l+O0z953UDmbUJ68/Pp5qAAXtlUqI2qZLrOMAC/
         PuG0RUWXQVvsmXzT+LhTN2X9fYALyLqeqTEjAq/Y3p7Vv9xxMpH1ZKiftN7dzgbdhW
         i23yHfp2RJL+a5ZnHUqLwqO7oSYngDyB8MzQrniS+ru5zPbmYJvmt9e7sMOtfxSroG
         DSthwVarRpj2Q==
Date:   Sun, 24 Apr 2022 21:23:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>
Subject: Re: [PATCH v2 00/17] protonic fixes
Message-ID: <20220424132355.GD988429@dragon>
References: <20220419044824.981747-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419044824.981747-1-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 06:48:07AM +0200, Oleksij Rempel wrote:
> changes v2:
> - spell fixes
> - rename arm -> ARM
> 
> This patch series provide two main part of changes:
> - Remove prototype specific deprecated code not used in production.
> - Unify vicut1 and victgo variants to reduce maintaining overhead.
> 
> David Jander (16):
>   ARM: dts: imx6qdl-vicut1.dtsi: remove TiWi module
>   ARM: dts: imx6qdl-vicut1.dtsi: Put nON_SWITCH in own pinctrl grp
>   ARM: dts: imx6qdl-vicut1.dtsi: Remove PCIe
>   ARM: dts: imx6qdl-vicut1/victgo: Remove UART2
>   ARM: dts: imx6qdl-vicut1.dtsi: Fix LED names
>   ARM: dts: imx6qdl-vicut1.dtsi: Fix debug LED gpio pins
>   ARM: dts: imx6qdl-vicut1.dtsi: Update GPIO line names
>   ARM: dts: imx6qdl-vicut1.dtsi: Remove conflicting pinctrl entry
>   ARM: dts: imx6q-vicut1.dts: remove sata node
>   ARM: dts: imx6dl-victgo.dts: update gpio names
>   ARM: dts: imx6dl-victgo.dts: Factor out common parts to
>     imx6qdl-victgo.dtsi
>   ARM: dts: imx6qdl-vicut1.dtsi: Move some node out to DTS files
>   ARM: dts: Remove imx6qdl-victgo.dtsi
>   ARM: dts: imx6qdl-vicut1: Factor out common parts of 12inch board
>     variants
>   ARM: dts: imx6dl-victgo.dts: Remove touchscreen x axis inversion
>   ARM: dts: imx6qdl-vicut1.dtsi: Add missing ISB led node
> 
> Oleksij Rempel (1):
>   ARM: dts: imx6qdl-vicut1.dtsi: add thermal zone and attach tmp103 to
>     it.

Applied all, thanks!
