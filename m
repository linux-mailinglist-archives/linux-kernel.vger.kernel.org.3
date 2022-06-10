Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129CA545F5B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347804AbiFJIhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347951AbiFJIhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:37:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFDE38792;
        Fri, 10 Jun 2022 01:34:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62162B82B7D;
        Fri, 10 Jun 2022 08:34:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9D6C34114;
        Fri, 10 Jun 2022 08:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654850047;
        bh=mkIa/msz/HXqM2VctHo0gwG0bUa+pqLMLaIgND87LnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W5whV86YPbNRC3inrh3PqFGXfqdgf0ZXQhp3RtdLPM0nkHU+T3X4lpOnfJbNNic4U
         q9rT22pI0HzOnR59S+5RvAdUVQZ6NrnG7mukOVi9FDOO72hdpwNvP1cNO37oKGSNEb
         CfDynhtwSV4nZco7MBZIZDXeFrzec5HEjY3WmrhZjo1VJ8HTlJtk5v6vFWo6CAL+ie
         wV//e4PAlwwqtPUvuIoTsEq214jO+zl5qoqBRP61xRni+bGQ3hogKsc38JXCx+RiqG
         VhR+8D/NYs9fhu/B7UigmRMfYaDrsGJARiFlBa7DWJPJ4yVDd3/zlgzfzc5ZkGyiy2
         2djGIBBOI9yZw==
Date:   Fri, 10 Jun 2022 16:34:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V6 0/4] arm64: add i.MX93 support
Message-ID: <20220610083401.GC254723@dragon>
References: <20220510124050.398891-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510124050.398891-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 08:40:46PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Sorry for sending several versions in short time, just wanna to catch 5.19
> 
> V6:
>  Per Fabio's comments, drop unused uart2/uart5 pinmux
> 
> V5:
>  Add R-b from Aisheng
>  drop iomuxc status from board dts
> 
> V4:
>  Add A-b
>  In patch 1 to move imx93 behind imx8ulp
>  Drop a whitespace in patch 2
> 
> V3:
>  Add a new patch patch 1 for board binding doc
>  Add A-b from Rob
>  Fix dtb warnings.
> 
> V2:
>  Update License
> 
> Add i.MX93 dtsi and 11x11 evk board support
> 
> The required bindings and drivers has already been in tree.
> There arem checkpatch error for the pin header files as other i.MX pin
> pin header files.
> 
> 
> Peng Fan (4):
>   dt-bindings: arm: fsl: add imx93 11x11 evk board
>   arm64: dts: freescale: Add i.MX93 dtsi support
>   arm64: dts: freescale: add i.MX93 11x11 EVK basic support
>   arm64: defconfig: enable i.MX93 clk & pinctrl

Applied all, thanks!
