Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABCB576C98
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 10:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiGPI1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 04:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiGPI1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 04:27:34 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE726402CC
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 01:27:32 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oCd99-0006P8-00; Sat, 16 Jul 2022 10:27:31 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 9C699C0671; Sat, 16 Jul 2022 09:37:48 +0200 (CEST)
Date:   Sat, 16 Jul 2022 09:37:48 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: remove VR41XX related char driver
Message-ID: <20220716073748.GA9148@alpha.franken.de>
References: <20220715142437.137411-1-tsbogend@alpha.franken.de>
 <YtJP+k5JBbqS5QgY@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtJP+k5JBbqS5QgY@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 07:43:22AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jul 15, 2022 at 04:24:36PM +0200, Thomas Bogendoerfer wrote:
> > Commit d3164e2f3b0a ("MIPS: Remove VR41xx support") removed support
> > for MIPS VR41xx platform, so remove exclusive drivers for this
> > platform, too.
> > 
> > Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > ---
> >  drivers/char/Kconfig  |   5 -
> >  drivers/char/Makefile |   1 -
> >  drivers/char/tb0219.c | 358 ------------------------------------------
> >  3 files changed, 364 deletions(-)
> >  delete mode 100644 drivers/char/tb0219.c
> 
> This does not apply to my tree, what tree did you make it against?

I've used linux-next.

> Nothing has touched the drivers/char/tb0219.c file in a very long time,

there is commit c9d86760342f ("fs: do not set no_llseek in fops") in
linux-next, which touches it.

> perhaps you might want to wait for this driver removal series until
> after d3164e2f3b0a is merged into Linus's tree?

I'll respin against your tree.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
