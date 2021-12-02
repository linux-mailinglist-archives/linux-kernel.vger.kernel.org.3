Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F20D466AA0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 20:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242950AbhLBTwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 14:52:33 -0500
Received: from netrider.rowland.org ([192.131.102.5]:44909 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S240554AbhLBTwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 14:52:31 -0500
Received: (qmail 399327 invoked by uid 1000); 2 Dec 2021 14:49:08 -0500
Date:   Thu, 2 Dec 2021 14:49:08 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/4] Docs: usb: update usb_bulk_msg receiving example
Message-ID: <YakjNGEBFKm9pHCw@rowland.harvard.edu>
References: <cover.1638152984.git.philipp.g.hortmann@gmail.com>
 <28a76eedad7027277754cef84ca34810b0cfe6f4.1638152984.git.philipp.g.hortmann@gmail.com>
 <YaaFNO1t3GIaGFPI@rowland.harvard.edu>
 <ad2fcdfa-5688-4d09-2c82-c405adeae4ee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad2fcdfa-5688-4d09-2c82-c405adeae4ee@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 05:49:47AM +0100, Philipp Hortmann wrote:
> On 11/30/21 9:10 PM, Alan Stern wrote:
> > On Mon, Nov 29, 2021 at 09:21:41PM +0100, Philipp Hortmann wrote:
> > > Clarification that this example is not in the driver template anymore.
> > > Update code example so that it fits best to usb-skeleton.c
> > > 
> > > Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> > > ---
> > >   .../driver-api/usb/writing_usb_driver.rst     | 30 +++++++++----------
> > >   1 file changed, 15 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
> > > index b43e1ce49f0e..a9608ad18d77 100644
> > > --- a/Documentation/driver-api/usb/writing_usb_driver.rst
> > > +++ b/Documentation/driver-api/usb/writing_usb_driver.rst
> > > @@ -218,36 +218,36 @@ do very much processing at that time. Our implementation of
> > >   ``skel_write_bulk_callback`` merely reports if the urb was completed
> > >   successfully or not and then returns.
> > > -The read function works a bit differently from the write function in
> > > +This read function works a bit differently from the write function in
> > >   that we do not use an urb to transfer data from the device to the
> > > -driver. Instead we call the :c:func:`usb_bulk_msg` function, which can be used
> > > +driver. Instead we call `usb_bulk_msg` function, which can be used
> > >   to send or receive data from a device without having to create urbs and
> > > -handle urb completion callback functions. We call the :c:func:`usb_bulk_msg`
> > > +handle urb completion callback functions. We call `usb_bulk_msg`
> > >   function, giving it a buffer into which to place any data received from
> > 
> > The reason for the last two changes above isn't clear.  You removed some of the
> > markup indicators and made the text ungrammatical.  This does not seem like an
> > improvement.
> > 
> > Alan Stern
> > 
> This two changes were made because of an earlier comment to the same
> document, but may be I understood this wrong:
> On 10/19/21 11:17 PM, Jonathan Corbet wrote:
> ...
> We shouldn't be using :c:func: anymore; just say usb_register() and the
> right things will happen.  Definitely worth fixing while you are in the
> neighborhood.
> ...
> If you're making this change, take out "the" (as well as :c:func:).
> ...
> ___
> Please find the full email under the link:
> https://lore.kernel.org/linux-usb/87h7dcsohs.fsf@meer.lwn.net/T/
> 
> Please give me an example for the right wording. I am not a native English
> speaker. Is the article in this case required?

Okay, now I see what's going on.  You should change it like this:

-driver. Instead we call the :c:func:`usb_bulk_msg` function, which can be used
+driver. Instead we call `usb_bulk_msg`, which can be used
 to send or receive data from a device without having to create urbs and
-handle urb completion callback functions. We call the :c:func:`usb_bulk_msg`
+handle urb completion callback functions. We call `usb_bulk_msg`,
 giving it a buffer into which to place any data received from

Alan Stern
