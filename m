Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CB3496FBB
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 05:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbiAWEdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 23:33:03 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:34839 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiAWEdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 23:33:01 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 210062800B3D2;
        Sun, 23 Jan 2022 05:32:58 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 0D53940D79; Sun, 23 Jan 2022 05:32:58 +0100 (CET)
Date:   Sun, 23 Jan 2022 05:32:58 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Jochen Mades <jochen@mades.net>
Cc:     gregkh@linuxfoundation.org, Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Philipp Rosenberger <p.rosenberger@kunbus.com>
Subject: Re: [PATCH] Bugfix RTS line config in RS485 mode is overwritten in
 pl011_set_mctrl() function.
Message-ID: <20220123043258.GA21313@wunner.de>
References: <20211231171516.18407-1-jochen@mades.net>
 <20220102100710.GA29858@wunner.de>
 <1489312180.3256431.1642068732902@webmail.strato.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489312180.3256431.1642068732902@webmail.strato.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 11:12:12AM +0100, Jochen Mades wrote:
> Find attached the patch with the new subject and corretced commit message.

Greg doesn't accept patches as attachments and during the merge window
(which ends today).  I've just resubmitted your patch as part of a
2-patch series, together with a patch of mine which goes on top of yours:

https://lore.kernel.org/linux-serial/85fa3323ba8c307943969b7343e23f34c3e652ba.1642909284.git.lukas@wunner.de/

(I sent your patch twice because I botched the Date header the first time
around, sorry about that.)

Note that you still get patch authorship (and thus credit for the patch)
even though I submitted it, due to the From: line at the top of the
message body.


> > * Add tags for the offending commit:
> > 
> >   Fixes: 8d479237727c ("serial: amba-pl011: add RS485 support")
> >   Cc: stable@vger.kernel.org # v5.15+
> > 
> > * Be sure to cc the author of the offending commit.
> 
> Sorry I don't know how to do that correctly. Can you please give support/hints?

It just means that you need to add the two above-quoted tags to the
commit message.  The maintainers of stable kernels use them to
determine which patches need to be backported to which kernel
releases.  I've fixed up the commit message of your patch with
the missing tags, no problem.

And "cc the author of the offending commit" just means that when
posting the patch, it is customary to send a copy of the e-mail
to the author of the commit you're fixing, which is Lino in this
case, as he authored 8d479237727c.

Thanks,

Lukas
