Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5A2586807
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiHALVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiHALVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:21:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8607C65DC
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 04:21:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13F16611F6
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 11:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 201E3C433D6;
        Mon,  1 Aug 2022 11:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659352881;
        bh=7NRWCqS615TGM6qj4XSDSpDbBhI4JC8b+SjfDCwTXZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vhbIO+ild2hCq53SfHBz2S0TphH2JabWARiIsU+cspgXIGOzM5UM+wJAH68IuAUjZ
         MPkA9muhJeOWTOchVRRdNlHGTyChrteSRxwvZBCqAVwLR4GB3PKz+WK5It4sH135yC
         8H6D/LzJDO45A3NnftRrlu6R1O68eR9+x/gSGf4w=
Date:   Mon, 1 Aug 2022 13:21:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Adam Thomson <DLG-Adam.Thomson.Opensource@dm.renesas.com>
Cc:     linux-kernel@vger.kernel.org,
        DLG Support Opensource <DLG-Support.Opensource@lm.renesas.com>
Subject: Re: [PATCH] MAINTAINERS: Update Dialog Semiconductor mailing list,
 website
Message-ID: <Yue3LpR7FdHygLze@kroah.com>
References: <20220801110140.7DF6280007F@slsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801110140.7DF6280007F@slsrvapps-01.diasemi.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 11:01:40AM +0000, Adam Thomson wrote:
> Now Dialog Semiconductor is part of Renesas, the mailing list and
> web addresses have been updated. This commit aligns with those
> recent changes.
> 
> Signed-off-by: Adam Thomson <DLG-Adam.Thomson.Opensource@dm.renesas.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 64379c699903..b1015d06d429 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5923,9 +5923,9 @@ F:	arch/arm/boot/dts/stm32mp1*-dhcom-*
>  F:	arch/arm/boot/dts/stm32mp1*-dhcor-*
>  
>  DIALOG SEMICONDUCTOR DRIVERS
> -M:	Support Opensource <support.opensource@diasemi.com>
> +M:	DLG Support Opensource <DLG-Support.Opensource@lm.renesas.com>

I strongly discourage any anonymous "group alias" for maintainers of any
kernel code, as that takes away the personal responsibility from the
maintainer entirely, which defeats one of the strongest reasons that
open source development efforts work so well.

Why not just switch this over to you instead?

thanks,

greg k-h
