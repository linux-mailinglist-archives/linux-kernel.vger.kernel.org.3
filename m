Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDB64FAB51
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 03:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbiDJBPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 21:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbiDJBPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 21:15:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C8E19B;
        Sat,  9 Apr 2022 18:12:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EA0860E33;
        Sun, 10 Apr 2022 01:12:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1284C385A0;
        Sun, 10 Apr 2022 01:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649553171;
        bh=11X7BFVd63x1Y3vMcLyg2CEPEkM0R057PGTYfGDr/Xc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t+C92Bse7Ij2ZSHUZhYTs21YiFrxBMPT+CvQsJdq3m/8FZCAmCPz/3aB1vJ0/Nb8u
         931L4P8E6/wUKQwSZ7AW0FYtmvqCaVQILwXfy736u0MjzGQfgkopbEZ3+Zeq2NAE3B
         QIPVJpa86pC/tEaXBa2iqonmeIr0ciNTvvabCtyNJx2qpT+CtFeejlVOP/N3rq8psh
         kDlEwwYu3qXATMhjOPFvRqfe37ihDpy9EJkpYK6LWdKF+WWLzOASN8ujpO4RwXm6Dt
         fS4u8KxVdoUg0cUiVuXzvxMUf+pPTx4KlsWAmP/S0ZVOOJAmhIX4s3ToWgU5Mo4MYv
         X7zCFWUEihiVA==
Date:   Sun, 10 Apr 2022 09:12:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] arm64: dts: ls2080a-rdb: add phy nodes
Message-ID: <20220410011244.GH129381@dragon>
References: <20220317190109.3742-1-leoyang.li@nxp.com>
 <20220317190109.3742-3-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317190109.3742-3-leoyang.li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 02:01:06PM -0500, Li Yang wrote:
> Define PHY nodes on the board.
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  .../boot/dts/freescale/fsl-ls2080a-rdb.dts    | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls2080a-rdb.dts
> index 44894356059c..1c8c99a74071 100644
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
> +	mdio1_phy1: emdio1_phy@1 {

We prefer hyphen rather than underscore in node name.

Shawn

> +		reg = <0x10>;
> +	};
> +
> +	mdio1_phy2: emdio1_phy@2 {
> +		reg = <0x11>;
> +	};
> +
> +	mdio1_phy3: emdio1_phy@3 {
> +		reg = <0x12>;
> +	};
> +
> +	mdio1_phy4: emdio1_phy@4 {
> +		reg = <0x13>;
> +	};
> +};
> +
> +&emdio2 {
> +	/* AQR405 PHYs */
> +	mdio2_phy1: emdio2_phy@1 {
> +		compatible = "ethernet-phy-ieee802.3-c45";
> +		interrupts = <0 1 0x4>; /* Level high type */
> +		reg = <0x0>;
> +	};
> +
> +	mdio2_phy2: emdio2_phy@2 {
> +		compatible = "ethernet-phy-ieee802.3-c45";
> +		interrupts = <0 2 0x4>; /* Level high type */
> +		reg = <0x1>;
> +	};
> +
> +	mdio2_phy3: emdio2_phy@3 {
> +		compatible = "ethernet-phy-ieee802.3-c45";
> +		interrupts = <0 4 0x4>; /* Level high type */
> +		reg = <0x2>;
> +	};
> +
> +	mdio2_phy4: emdio2_phy@4 {
> +		compatible = "ethernet-phy-ieee802.3-c45";
> +		interrupts = <0 5 0x4>; /* Level high type */
> +		reg = <0x3>;
> +	};
> +};
> -- 
> 2.25.1
> 
