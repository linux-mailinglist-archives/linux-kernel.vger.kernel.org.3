Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8317B4ED4A0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 09:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbiCaHPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 03:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbiCaHPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 03:15:00 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 590C21BB795;
        Thu, 31 Mar 2022 00:12:07 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 9DB9192009D; Thu, 31 Mar 2022 09:12:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 970F292009B;
        Thu, 31 Mar 2022 08:12:06 +0100 (BST)
Date:   Thu, 31 Mar 2022 08:12:06 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PING][PATCH v3 0/2] serial: 8250: Fixes for Oxford Semiconductor
 950 UARTs
In-Reply-To: <YjR2zeyAfeXHVa+0@kroah.com>
Message-ID: <alpine.DEB.2.21.2203310127380.44113@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2202100424280.34636@angie.orcam.me.uk> <alpine.DEB.2.21.2203011748460.11354@angie.orcam.me.uk> <YjR2zeyAfeXHVa+0@kroah.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2022, Greg Kroah-Hartman wrote:

> > >  Here's v3 of the outstanding fixes for Oxford Semiconductor 950 UARTs.  
> > > As the change for the default FIFO rx trigger level has been already 
> > > merged with commit d7aff291d069 ("serial: 8250: Define RX trigger levels 
> > > for OxSemi 950 devices") only one patch of the original series remains.  
> > 
> >  Ping for:
> > 
> > <https://lore.kernel.org/lkml/alpine.DEB.2.21.2202100424280.34636@angie.orcam.me.uk/>
> 
> These aren't in my review queue, can you resend?

 Reposted now, thanks!

  Maciej
