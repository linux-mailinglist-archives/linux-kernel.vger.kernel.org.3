Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9513751B60F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 04:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239841AbiEECqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 22:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239791AbiEECqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:46:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF534D604;
        Wed,  4 May 2022 19:42:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 021E4B82B1D;
        Thu,  5 May 2022 02:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F68FC385A4;
        Thu,  5 May 2022 02:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651718546;
        bh=3eHb7EIdSPLfgesF9HzKJvUCDSgi+lW/ZwMmFKVynUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P4kwGXuyRAhYJMq1ppu6xkMmAPy4uH6ViW4TreXyPHewQrOUNxP5N1hF3YHXfLnna
         ebrQH/lO5km6i9UqDfOzUy78dJyTUh7XYNsBqbWU3/UJuWyaCi33iKWgC+szgzq0/Y
         NcVDJ+gTj6iTjU7DstKqZF24NruvgiB3H2KCaMQhtEXCPh1ps3E9C0rSElWw5ouOcw
         wTBGMX82V8FuNzEDkDDb6bbdHzFwUyWjaAAt+P5NftIew1YXqDFlyp2TfrKsUY3tB8
         tKN7mIn4DiBDivcn+fYa0KkfXCCzysqV+ipad+Iw/V9ZWJpVYBDqtvUmYCNnCe/+Ap
         oOtviDBlP6szw==
Date:   Thu, 5 May 2022 10:42:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/14] dt-bindings: arm: fsl: add
 toradex,colibri-imx6ull
Message-ID: <20220505024218.GN14615@dragon>
References: <20220425162356.176665-1-marcel@ziswiler.com>
 <20220425162356.176665-9-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425162356.176665-9-marcel@ziswiler.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 06:23:50PM +0200, Marcel Ziswiler wrote:
> From: Denys Drozdov <denys.drozdov@toradex.com>
> 
> Add toradex,colibri-imx6ull for carrier board dts,
> including aster, iris and iris-v2 device tree,
> wifi and nonwifi variants for NAND and eMMC modules.
> 
> Signed-off-by: Denys Drozdov <denys.drozdov@toradex.com>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Applied, thanks!
