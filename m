Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25E45AC89E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 03:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbiIEB5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 21:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiIEB5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 21:57:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C514024095;
        Sun,  4 Sep 2022 18:57:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70C94B80E7E;
        Mon,  5 Sep 2022 01:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB298C433D6;
        Mon,  5 Sep 2022 01:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662343032;
        bh=VQ9DRmIAHFvGh6fxvmTt8AH9xQdjK7PrOI7X7SWf9+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rl4Tvf/PEZaBsq0MDT0x6q+CLnx2u2c+fD93YZCRZMy1Hug2Sld5Go3DJyK4vAE8+
         Yu8Qxb902848vjxvMZdDKXP78Qc86bNysvKEK0AOYxhwWJQjJkDgtiKIrw/RekHWnH
         nyxN/s5QXYZGfHiibqPHEO+DWmW5SjWTE0JZGaOF81z+iVTl+3Qn2kvsfy+Hsda8sS
         5W1vm4XTsc8FqCPV2oVAzl0u5Xh9MA3d9KqrMab2D2F5t8SjjeLyMz062voTNrJYHZ
         k0/2O4sVhIr0Ki1HhqjCY/53IiwjivN5XMDYwqdxB40og3OAXnK/PA5rQ0SWlWmX8x
         PNNM7THK5chHQ==
Date:   Mon, 5 Sep 2022 09:57:05 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/5] ARM: dts: imx6sl: use tabs for code indent
Message-ID: <20220905015705.GX1728671@dragon>
References: <20220826192252.794651-1-marcel@ziswiler.com>
 <20220826192252.794651-2-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826192252.794651-2-marcel@ziswiler.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 09:22:48PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> This fixes the following error:
> 
> arch/arm/boot/dts/imx6sl.dtsi:714: error: code indent should use tabs
> where possible
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Applied, thanks!
