Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DBF59B76C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 04:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbiHVCIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 22:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbiHVCIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 22:08:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32151DF0F;
        Sun, 21 Aug 2022 19:08:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 672C260F04;
        Mon, 22 Aug 2022 02:08:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4CEC433C1;
        Mon, 22 Aug 2022 02:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661134111;
        bh=S1O4SKhsVT/Ufrlz5CzLeavuTbPmz0Mr2z/zmvq0/y0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SCPKFaK7Gs6nd23rvEk4KJdE4PWFRczwv67YiZN56+dzM2JD5CeHY8ucdF9buaRF4
         nqVdkTwgRdfYvspy8T0E88FK4z6G/kzyFbDLez9zfhUg4EJ2c8Pf7egmTDgsbu1Axa
         HjKySQB0esdcRn1Vl9s1sMmt9qU5upfBuYJFEA2z+uhaTk1gJbF9Ee3Xmi8rsRaigF
         ZpkjEGYPfDV0FBNCcaWuZ/O/PREFkvC8WYR6eLQO3WANoQ/oW2WraOAeku9CEczkbC
         bl7aEH4JGZ5QyxntSraBZrcs14eob1ACh87AduzR2owII5b2pYlA+NUScgKsQsgCFI
         mFTNuphoXv15g==
Date:   Mon, 22 Aug 2022 10:08:24 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Olof Johansson <olof@lixom.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] arm64: dts: freescale: verdin-imx8mm/p: fix
 atmel_mxt_ts reset polarity
Message-ID: <20220822020824.GM149610@dragon>
References: <20220812213905.216065-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812213905.216065-1-marcel@ziswiler.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2022 at 11:39:03PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> 
> Unfortunately, I was not aware of this reset GPIO polarity fix when
> I submitted initial support. Let us correct this oversight. Thanks!
> 
> 
> Marcel Ziswiler (2):
>   arm64: dts: freescale: verdin-imx8mm: fix atmel_mxt_ts reset polarity
>   arm64: dts: freescale: verdin-imx8mp: fix atmel_mxt_ts reset polarity

Applied both, thanks!
