Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3D7504F98
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 13:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237918AbiDRL4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 07:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiDRL4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 07:56:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14D8E1C;
        Mon, 18 Apr 2022 04:53:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 693F760E04;
        Mon, 18 Apr 2022 11:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB936C385A1;
        Mon, 18 Apr 2022 11:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650282816;
        bh=JM0VZXpo1a7hlU2aCKr/auPVvFfycI3yTMj+6jV3yxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jOHsTrpR5tU5QxbrrMGQiA7GgYfDgSRHlYvI3ROCUrbp5HaXihT3KnjAH8F+kWy6t
         6hv7mCsRINRwnoXzz49Zccbr7PCXICH6CXDBHjBOD5zJOYUkSsVCihCkhE3b+pF/ru
         wjVCQhYMIuDZ4mDa1slQkuWf5begQXuk9fCF+UG1WywR5y7yhqjVPwuRkiI8mjWC7+
         7TVdmU0hek1nWDCHe9zvgROPXI9HhPDYeuhSpQpwRHycpmDkTeWbfp/LtBJJ7Lok4O
         Wg8ZJc5VNmpiptOfEVJayiVpKkHf6dShIs+oB2w5FxCfIoFayzyQ40cu/Vbb/nHvPl
         oLmk0cKBZcIpg==
Date:   Mon, 18 Apr 2022 19:53:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>, David Jander <david@protonic.nl>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>
Subject: Re: [PATCH v1 09/17] arm: dts: imx6q-vicut1.dts: remove sata node
Message-ID: <20220418115331.GJ391514@dragon>
References: <20220412074004.2485264-1-o.rempel@pengutronix.de>
 <20220412074004.2485264-10-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412074004.2485264-10-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 09:39:56AM +0200, Oleksij Rempel wrote:
> From: David Jander <david@protonic.nl>
> 
> Only the prototype had the SATA interface. No are no existing products
> and plans to add any.

No are?

Shawn

> 
> Signed-off-by: David Jander <david@protonic.nl>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx6q-vicut1.dts | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-vicut1.dts b/arch/arm/boot/dts/imx6q-vicut1.dts
> index 0a4e251be162..e6c5d3cb48d7 100644
> --- a/arch/arm/boot/dts/imx6q-vicut1.dts
> +++ b/arch/arm/boot/dts/imx6q-vicut1.dts
> @@ -11,7 +11,3 @@ / {
>  	model = "Kverneland UT1Q Board";
>  	compatible = "kvg,vicut1q", "fsl,imx6q";
>  };
> -
> -&sata {
> -	status = "okay";
> -};
> -- 
> 2.30.2
> 
