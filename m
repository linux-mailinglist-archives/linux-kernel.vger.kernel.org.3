Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B41598566
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245237AbiHROJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245672AbiHROJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:09:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFFC719A3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:09:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AC7761718
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 14:09:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BBFC433C1;
        Thu, 18 Aug 2022 14:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660831746;
        bh=Q1bOxzXeC93ibsIgYuRH4a88gKRIqaYkONkJUBrF22I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0S6EUZ4APSk22IGXBXjI33iAngR8BE0D8cvjSyl3b/oaVUJ1qdSqt2OyDS3LTWWcM
         HnciSDSouQVKh0+h+LenRf9IHVOzOw22ByT5jPN2/7UDtVTeDgZXtyoynLdY9coSga
         IzPPiNfvxJuPaadtfIshmsohPn2VtrwO81SXSCuA=
Date:   Thu, 18 Aug 2022 16:09:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Peter Chen <peter.chen@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Joel Stanley <joel@jms.id.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] ARM: defconfig: drop CONFIG_USB_FSL_USB2
Message-ID: <Yv5H/wHQUPNkPOzt@kroah.com>
References: <20220818135522.3143514-1-arnd@kernel.org>
 <20220818135737.3143895-1-arnd@kernel.org>
 <20220818135737.3143895-7-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818135737.3143895-7-arnd@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 03:57:17PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> USB_FSL_USB2 is no longer available for Arm platforms and
> was replaced by the chipidea driver.
> 
> Fixes: a390bef7db1f ("usb: gadget: fsl_mxc_udc: Remove the driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/configs/multi_v7_defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 7af627a816ec..1cb293adecb1 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -869,7 +869,6 @@ CONFIG_USB_GPIO_VBUS=y
>  CONFIG_USB_ISP1301=y
>  CONFIG_USB_MXS_PHY=y
>  CONFIG_USB_GADGET=y
> -CONFIG_USB_FSL_USB2=y
>  CONFIG_USB_RENESAS_USBHS_UDC=m
>  CONFIG_USB_ASPEED_VHUB=m
>  CONFIG_USB_CONFIGFS=m
> -- 
> 2.29.2
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
