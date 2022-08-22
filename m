Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81E259B812
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 05:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbiHVDlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 23:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbiHVDlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 23:41:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B96B248F5;
        Sun, 21 Aug 2022 20:41:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 065ADB80E72;
        Mon, 22 Aug 2022 03:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44DEC433D6;
        Mon, 22 Aug 2022 03:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661139671;
        bh=LeNzZ7evt9HlL2miujCAljmvclYPY6B83Drx+/5CLJg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bxp1OpZbIhjCLm3iv7XbTdI5IqIj9C7wN/e1Ov4lRFJc6zObERx5BLxAXyppzZ4j8
         rlC/diH7Jb8n6FgeWNUr9G/3ilwX/nJqgBlC+7sajxbVRPBIk6TLlk6MWNWWRMnm9F
         1Tbm3UsKjwjuqRykjcxQGCz35HZGZ3PqFIHsbP57oRbTRXTxBsl8QsEyxI8LpU/z6E
         EMQ9S7NkFYsqUAa1Q63Qi0uXAOiGLW8Kr8b/UfFZEgcrlC2TllLF5Z74QebUDZNswZ
         SFf5WCYJqGh1XEeE8BW9cPPDgMnhfrbyL665JUzI8IoucboT7AD4IDHydkt9aa1WCg
         IKLrohJ7HJQiA==
Date:   Mon, 22 Aug 2022 11:41:05 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] arm64: dts: ls2080a-rdb: add phy nodes
Message-ID: <20220822034105.GR149610@dragon>
References: <20220817204357.21753-1-leoyang.li@nxp.com>
 <20220817204357.21753-4-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817204357.21753-4-leoyang.li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 03:43:54PM -0500, Li Yang wrote:
> Define PHY nodes on the board.
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  .../boot/dts/freescale/fsl-ls2080a-rdb.dts    | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts
> index 44894356059c..fec02fd754be 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts
> @@ -23,3 +23,71 @@ chosen {
>  		stdout-path = "serial1:115200n8";
>  	};
>  };
> +
> +&dpmac5 {
> +	phy-handle = <&mdio2_phy1>;
> +	phy-connection-type = "10gbase-r";
> +};
> +
> +&dpmac6 {
> +	phy-handle = <&mdio2_phy2>;
> +	phy-connection-type = "10gbase-r";
> +};
> +
> +&dpmac7 {
> +	phy-handle = <&mdio2_phy3>;
> +	phy-connection-type = "10gbase-r";
> +};
> +
> +&dpmac8 {
> +	phy-handle = <&mdio2_phy4>;
> +	phy-connection-type = "10gbase-r";
> +};
> +
> +&emdio1 {
> +	status = "disabled";
> +
> +	/* CS4340 PHYs */
> +	mdio1_phy1: emdio1-phy@1 {
> +		reg = <0x10>;

unit-address doesn't match 'reg'.

> +	};
> +
> +	mdio1_phy2: emdio1-phy@2 {
> +		reg = <0x11>;
> +	};
> +
> +	mdio1_phy3: emdio1-phy@3 {
> +		reg = <0x12>;
> +	};
> +
> +	mdio1_phy4: emdio1-phy@4 {
> +		reg = <0x13>;
> +	};
> +};
> +
> +&emdio2 {
> +	/* AQR405 PHYs */
> +	mdio2_phy1: emdio2-phy@1 {
> +		compatible = "ethernet-phy-ieee802.3-c45";
> +		interrupts = <0 1 0x4>; /* Level high type */

What does '0' mean here?  And why not IRQ_TYPE_LEVEL_HIGH for polarity
cell?

Shawn

> +		reg = <0x0>;
> +	};
> +
> +	mdio2_phy2: emdio2-phy@2 {
> +		compatible = "ethernet-phy-ieee802.3-c45";
> +		interrupts = <0 2 0x4>; /* Level high type */
> +		reg = <0x1>;
> +	};
> +
> +	mdio2_phy3: emdio2-phy@3 {
> +		compatible = "ethernet-phy-ieee802.3-c45";
> +		interrupts = <0 4 0x4>; /* Level high type */
> +		reg = <0x2>;
> +	};
> +
> +	mdio2_phy4: emdio2-phy@4 {
> +		compatible = "ethernet-phy-ieee802.3-c45";
> +		interrupts = <0 5 0x4>; /* Level high type */
> +		reg = <0x3>;
> +	};
> +};
> -- 
> 2.37.1
> 
