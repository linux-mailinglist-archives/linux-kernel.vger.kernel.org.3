Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6939576360
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 16:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbiGOOGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 10:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiGOOGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 10:06:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16149D126;
        Fri, 15 Jul 2022 07:06:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9628261302;
        Fri, 15 Jul 2022 14:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83757C34115;
        Fri, 15 Jul 2022 14:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657893986;
        bh=9T4ThuiTJCtjRAjx9EJleMTz8+18XdDwvflltBOS1EQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oBgcdrA/2Vgol16khTl1g+brSL747ShsqwST4gYWiESSeg6/XGeJLh4iQaJyIE83I
         rVBmVr9WFSQyotHp4PiIf5IOho7CNSK45sCZjVNT0qZuti+FEVcjfSOmZIUqjTeYL+
         OyaLZ5DWbsh3UYVCZ7aVnBOchBBr4ukGp6XC4GHs=
Date:   Fri, 15 Jul 2022 16:06:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH] gpio: remove VR41XX related gpio driver
Message-ID: <YtF0Xt0Ja9biwwnt@kroah.com>
References: <20220715135945.135351-1-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715135945.135351-1-tbogendoerfer@suse.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 03:59:44PM +0200, Thomas Bogendoerfer wrote:
> From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> 
> Commit d3164e2f3b0a ("MIPS: Remove VR41xx support") removed support
> for MIPS VR41xx platform, so remove exclusive drivers for this
> platform, too.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>  drivers/char/Kconfig       |   5 -
>  drivers/char/Makefile      |   1 -
>  drivers/char/tb0219.c      | 358 ------------------------
>  drivers/gpio/Kconfig       |   6 -
>  drivers/gpio/Makefile      |   1 -
>  drivers/gpio/gpio-vr41xx.c | 541 -------------------------------------
>  6 files changed, 912 deletions(-)
>  delete mode 100644 drivers/char/tb0219.c
>  delete mode 100644 drivers/gpio/gpio-vr41xx.c

This should be 2 patches, one for the char driver and one for the gpio
driver.

thanks,

greg k-h
