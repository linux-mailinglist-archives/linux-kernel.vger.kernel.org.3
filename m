Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2645763AA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 16:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbiGOOb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 10:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGOOb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 10:31:57 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 270266D9D0;
        Fri, 15 Jul 2022 07:31:57 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oCMMG-0000On-00; Fri, 15 Jul 2022 16:31:56 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 04116C054D; Fri, 15 Jul 2022 16:31:40 +0200 (CEST)
Date:   Fri, 15 Jul 2022 16:31:40 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH] gpio: remove VR41XX related gpio driver
Message-ID: <20220715143140.GA4809@alpha.franken.de>
References: <20220715135945.135351-1-tbogendoerfer@suse.de>
 <YtF0Xt0Ja9biwwnt@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtF0Xt0Ja9biwwnt@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 04:06:22PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jul 15, 2022 at 03:59:44PM +0200, Thomas Bogendoerfer wrote:
> > From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > 
> > Commit d3164e2f3b0a ("MIPS: Remove VR41xx support") removed support
> > for MIPS VR41xx platform, so remove exclusive drivers for this
> > platform, too.
> > 
> > Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> > ---
> >  drivers/char/Kconfig       |   5 -
> >  drivers/char/Makefile      |   1 -
> >  drivers/char/tb0219.c      | 358 ------------------------
> >  drivers/gpio/Kconfig       |   6 -
> >  drivers/gpio/Makefile      |   1 -
> >  drivers/gpio/gpio-vr41xx.c | 541 -------------------------------------
> >  6 files changed, 912 deletions(-)
> >  delete mode 100644 drivers/char/tb0219.c
> >  delete mode 100644 drivers/gpio/gpio-vr41xx.c
> 
> This should be 2 patches, one for the char driver and one for the gpio
> driver.

sure, new patches sent.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
