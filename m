Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031C459B3BA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 14:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiHUMTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 08:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiHUMTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 08:19:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B14C22B19;
        Sun, 21 Aug 2022 05:19:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B32EB80B2E;
        Sun, 21 Aug 2022 12:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1039C433D6;
        Sun, 21 Aug 2022 12:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661084380;
        bh=LIzsi2DhOwknBgqso0AgS4X1lYq0tfEFFNz7+quVlrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nsijGt6PVNMM6pcHObuu4cNQRp69K2JKJI6bICgO+m9wsv8crMdLK2TP6rGrfLXhs
         UYuXLG0SwOnK5ppvnNjojk2RjrsEgdNozuilM+G0Q1BH5AkFgkhRz2z0EccKyjJT/4
         6nclJSFuhvaTRUQNGgEtZkIqcI7IAyfv9atrRpdy6r/C+zwoECT9nP/J3Kh5UO2ttM
         dayWFTq0LI/qcgTbHPjmC7Y6GAZkl3/1/PCvKuYUx4ofAz+BYuSdx+Pxq5bUxuDA/D
         Yw05aRdiZa3STeVRykP5fDrW9uFWosFeNMls5kVfs6ghKAiz2tb4tahn4oTHXMbwg/
         uaS9B+c0JjKWg==
Date:   Sun, 21 Aug 2022 20:19:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     David Jander <david@protonic.nl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] arm: dts: imx6qdl-vicut1.dtsi: Add backlight-isb
 node
Message-ID: <20220821121934.GX149610@dragon>
References: <20220726123222.1074876-1-david@protonic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726123222.1074876-1-david@protonic.nl>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 02:32:20PM +0200, David Jander wrote:
> This series adds the backlight-isb node and fixes existing backlight_led
> node name.
> 
> ---
> v2:
>  - Fix node names to use minus character instead of underscore.
> 
> David Jander (2):
>   arm: dts: imx6qdl-vicut1.dtsi: Add backlight-isb node
>   arm: dts: imx6qdl-vicut1.dtsi: Fix node name backlight_led

Applied both, thanks!
