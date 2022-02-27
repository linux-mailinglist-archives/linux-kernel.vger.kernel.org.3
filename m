Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442974C5FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 00:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbiB0XHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 18:07:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiB0XHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 18:07:38 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B86AB55493;
        Sun, 27 Feb 2022 15:07:00 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 8918892009C; Mon, 28 Feb 2022 00:06:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 7BAA292009B;
        Sun, 27 Feb 2022 23:06:58 +0000 (GMT)
Date:   Sun, 27 Feb 2022 23:06:58 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] serial: 8250: Report which option to enable for
 blacklisted PCI devices
In-Reply-To: <alpine.DEB.2.21.2202251753530.25061@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2202271516420.39915@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2202121646020.34636@angie.orcam.me.uk> <alpine.DEB.2.21.2202121706060.34636@angie.orcam.me.uk> <Yhiixm/iRlnF18B7@kroah.com> <alpine.DEB.2.21.2202251753530.25061@angie.orcam.me.uk>
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

On Sat, 26 Feb 2022, Maciej W. Rozycki wrote:

> On Fri, 25 Feb 2022, Greg Kroah-Hartman wrote:
> 
> > We don't do this for any other driver subsystem, so why is it really
> > needed?  What is so special about this driver that distros can't
> > just enable all of the drivers and all is good?  What is keeping those
> > drivers fromb eing enabled?
> 
>  My justification is we have a supposedly generic PCI 8250 UART driver, 
> except it explicitly and silently refuses to handle a handful of devices 
> chosen by their PCI IDs based on that they may have extra features, even 
> though they are otherwise fully compatible with a generic 8250.

 Actually as it happens we do have a precedent too, as here's what I have 
just spotted on my laptop by chance when hibernating:

psmouse serio1: synaptics: The touchpad can support a better bus than the too old PS/2 protocol. Make sure MOUSE_PS2_SYNAPTICS_SMBUS and RMI4_SMB are enabled to get a better touchpad experience.

(with a distribution kernel, so clearly whoever packaged that has not 
enabled what might be needed).  Someone else wanted to be helpful too as 
it seems.

  Maciej
