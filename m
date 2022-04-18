Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3239504DA3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 10:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbiDRITk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 04:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbiDRITf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 04:19:35 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89936167D6;
        Mon, 18 Apr 2022 01:16:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E8B24CE0FE8;
        Mon, 18 Apr 2022 08:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0519C385A8;
        Mon, 18 Apr 2022 08:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650269812;
        bh=SBVjmE1FlWFuqBrb88h+5y8vu605936vI5xcMLcy+6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rek8HGbhooQ7nV5e/UVM+AHpzQUiGayk9DfY0LPLNtBUqRJgUYgRIwDN1/r+zsEEV
         DqYYj1o23UXz8w2q+qMfrSnAtqKUfQT1foNY1ndQzFNKhCFeem+UFPv8gXSamVVdu5
         +velR/2DgJHgpVojKDSdit9uEwyJFoD+sOMcAEbXiaCgwTQQGy1lWrBrACVo69VC2p
         p4Kzj0S+6oTBMlR7opOEhxd5h4Kfq6MOdOD7TRumqqsadpXR/MzEcHg9g8t5+5jsTQ
         ibY1bkoQRdUmKJvMZWETcnHuGU0EtMDexQr6e9NxCB3Eg9bTs/vcriKY9GrLxIiB27
         I+THIWOTyc4yA==
Date:   Mon, 18 Apr 2022 16:16:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Changming Huang <jerry.huang@nxp.com>
Cc:     leoyang.li@nxp.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianchao Wang <jianchao.wang@nxp.com>
Subject: Re: [PATCH v2] arm64: dts: fsl-ls1028a: add dspi2 support
Message-ID: <20220418081646.GE391514@dragon>
References: <20220411091157.1965623-1-jerry.huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411091157.1965623-1-jerry.huang@nxp.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 05:11:57PM +0800, Changming Huang wrote:
> Enable MikroBUS SPI port.
> 
> Signed-off-by: Jianchao Wang <jianchao.wang@nxp.com>
> Signed-off-by: Changming Huang <jerry.huang@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 13 +++++++++++++

"arm64: dts: fsl-ls1028a-rdb: ..." to make it clear this is a board
rather than SoC change.

>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> index 68c31cb8eead..6d0508d5abd0 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
> @@ -117,6 +117,19 @@ &duart1 {
>  	status = "okay";
>  };
>  
> +&dspi2 {
> +	bus-num = <2>;
> +	status = "okay";
> +
> +	mikrobus@0 {
> +		compatible = "semtech,sx1301";

Where is the bindings for this?

Shawn

> +		reg = <0>;
> +		spi-max-frequency = <2000000>;
> +		fsl,spi-cs-sck-delay = <1000000>;
> +		fsl,spi-sck-cs-delay = <50>;
> +	};
> +};
> +
>  &enetc_mdio_pf3 {
>  	sgmii_phy0: ethernet-phy@2 {
>  		reg = <0x2>;
> -- 
> 2.25.1
> 
