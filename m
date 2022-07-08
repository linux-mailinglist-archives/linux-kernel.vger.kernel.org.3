Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12F956B448
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237403AbiGHIQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237157AbiGHIQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:16:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFBD7392C;
        Fri,  8 Jul 2022 01:16:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1EBE62462;
        Fri,  8 Jul 2022 08:16:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB080C341C0;
        Fri,  8 Jul 2022 08:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657268160;
        bh=JEz9DFkfYpjH2VbktvdAda0D97Ly8+Ea+npuRhSdmdw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K4+vhU1a37n2zp6a4oK8p0GF9WbyzpbefqfCg/ZXbt+d82EIlBUdhm3UH2X2ywIlT
         g9FvuwWiJ4vp6mFmGW4xM8F+u0h5QrJvWD38IgANR7WB+hCMaJqOe6n6zHp/dWKVT/
         DRKeckJEpT4aQ4KqgTl0K34P7Xw8ATTA9eFyQYmBmRtW0thxgw+k4DAUXN+oJ/8cHN
         5KIZctdxgcji5XOaSJiGQdOI3mtCbaey2Vi5Tk6hRt3SkCHQiOJ/5LsIDhhga45i4g
         HBjFhbr0I5uDCeE9gXaziJRGdmw6XSbfLi/s/tNxyUsGwwJZMkrXoTTE/l81cmHHwU
         4ZrZKLICpOViw==
Date:   Fri, 8 Jul 2022 16:15:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     max.krummenacher@toradex.com,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: colibri-imx6ull: fix snvs pinmux group
Message-ID: <20220708081553.GT819983@dragon>
References: <20220705085825.21255-1-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705085825.21255-1-max.oss.09@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 10:58:24AM +0200, Max Krummenacher wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> A pin controlled by the iomuxc-snvs pin controller must be
> specified under the dtb's iomuxc-snvs node.
> 
> Move the one and only pin of that category from the iomuxc node
> and set the pinctrl-0 using it accordingly.
> 
> Fixes: 2aa9d6201949 ("ARM: dts: imx6ull-colibri: add touchscreen device nodes")
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

Applied, thanks!
