Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68543504F90
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 13:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237891AbiDRLuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 07:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiDRLuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 07:50:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5309F16597;
        Mon, 18 Apr 2022 04:48:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E240B60C78;
        Mon, 18 Apr 2022 11:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F15C385A9;
        Mon, 18 Apr 2022 11:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650282493;
        bh=5O9SWzynufeSwbknVQU7oGW1K9f4nECMGHNkcfEIclo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TyQEvTxowU2Bk8t1VhUHf0MxWjU4JM2jrxsUFR6PdHsIO5t/w2/NJ/ObZL8LYz5Qa
         qeAcmURYMNePyFLBudvO79cpIqCe5/4Uphp+UYxlhpbwl3cWOAMwybjchplYm3o4HT
         brBqU6ICCGAtikbz4chU8NrjCQKQuzw7ZblZ4uufw4ZdW7VUtIHpT0Z23gbkk/ebm5
         stPU78PJ7PHoMQHdb+L7KRMr0CougmH7TFUnmXjX2VDt97almEMTjIDE7sPXdzCxUB
         oej+o9mIaOcG8LXgvRetKuP6OyXC8RZ744tNJapISYyIPIDmbJwhrc0xpbZ0aw1xpZ
         OvS+yMX2+kPdQ==
Date:   Mon, 18 Apr 2022 19:48:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>
Subject: Re: [PATCH v1 00/17] protonic fixes
Message-ID: <20220418114806.GH391514@dragon>
References: <20220412074004.2485264-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412074004.2485264-1-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 09:39:47AM +0200, Oleksij Rempel wrote:
> This patch series provide two main part of changes:
> - Remove prototype specific deprecated code not used in production.
> - Unify vicut1 and victgo variants to reduce maintaining overhead.
> 
> David Jander (16):
>   arm: dts: imx6qdl-vicut1.dtsi: remove TiWi module
>   arm: dts: imx6qdl-vicut1.dtsi: Put nON_SWITCH in own pinctrl grp
>   arm: dts: imx6qdl-vicut1.dtsi: Remove PCIe
>   arm: dts: imx6qdl-vicut1/victgo: Remove UART2
>   arm: dts: imx6qdl-vicut1.dtsi: Fix LED names
>   arm: dts: imx6qdl-vicut1.dtsi: Fix debug LED gpio pins
>   arm: dts: imx6qdl-vicut1.dtsi: Update GPIO line names
>   arm: dts: imx6qdl-vicut1.dtsi: Remove conflicting pinctrl entry
>   arm: dts: imx6q-vicut1.dts: remove sata node
>   arm: dts: imx6dl-victgo.dts: update gpio names
>   arm: dts: imx6dl-victgo.dts: Factor out common parts to
>     imx6qdl-victgo.dtsi
>   arm: dts: imx6qdl-vicut1.dtsi: Move some node out to DTS files
>   arm: dts: Remove imx6qdl-victgo.dtsi
>   arm: dts: imx6qdl-vicut1: Factor out common parts of 12inch board
>     variants
>   arm: dts: imx6dl-victgo.dts: Remove touchscreen x axis inversion
>   arm: dts: imx6qdl-vicut1.dtsi: Add missing ISB led node
> 
> Oleksij Rempel (1):
>   arm: dts: imx6qdl-vicut1.dtsi: add thermal zone and attach tmp103 to
>     it.

s/arm:/ARM: in patch subject.

Shawn

> 
>  arch/arm/boot/dts/imx6dl-victgo.dts          | 682 +------------------
>  arch/arm/boot/dts/imx6dl-vicut1.dts          |   1 +
>  arch/arm/boot/dts/imx6q-vicut1.dts           |   5 +-
>  arch/arm/boot/dts/imx6qdl-vicut1-12inch.dtsi | 128 ++++
>  arch/arm/boot/dts/imx6qdl-vicut1.dtsi        | 222 +-----
>  arch/arm/boot/dts/imx6qp-vicutp.dts          |   1 +
>  6 files changed, 178 insertions(+), 861 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx6qdl-vicut1-12inch.dtsi
> 
> -- 
> 2.30.2
> 
