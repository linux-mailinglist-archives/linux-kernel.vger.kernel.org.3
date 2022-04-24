Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D5850D5D9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 00:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239852AbiDXWsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 18:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239805AbiDXWsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 18:48:20 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8255FEB;
        Sun, 24 Apr 2022 15:45:17 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E1242824;
        Mon, 25 Apr 2022 00:45:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1650840316;
        bh=QuNx9M5h0yWH2ZiR8750JVdiuGmZkxKvi94dD/ugCaY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LBPYJd7yjellY+h6G6ncXNqbymTdi1MKZ8AOLeYGA1HzG9W7wPS+1nWRLFC3FQzoL
         vB3gKBMxtw3GH/8JesaIKfEUoZsKFw62gN+EdB6pu1rVAlBHz/PdTE65ElN3o/kKJx
         9hQhO6xJg8fTtK/FwwxFJO6S+cYBBsGKvBcuC+rY=
Date:   Mon, 25 Apr 2022 01:45:15 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2] docs: media: uvcvideo: Use linux-media mailing list
Message-ID: <YmXS+2co6XGEDIDm@pendragon.ideasonboard.com>
References: <20220315221007.1045878-1-j.neuschaefer@gmx.net>
 <YjEQz1GhLV0Kf3mO@pendragon.ideasonboard.com>
 <YjESZwTHRuD4pBkY@latitude>
 <YjEVzF1NMWJZ1MQw@pendragon.ideasonboard.com>
 <YlrhavU2K3neXNEy@latitude>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YlrhavU2K3neXNEy@latitude>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Sat, Apr 16, 2022 at 05:31:54PM +0200, Jonathan Neuschäfer wrote:
> On Wed, Mar 16, 2022 at 12:40:12AM +0200, Laurent Pinchart wrote:
> > On Tue, Mar 15, 2022 at 11:25:43PM +0100, Jonathan Neuschäfer wrote:
> > > On Wed, Mar 16, 2022 at 12:18:55AM +0200, Laurent Pinchart wrote:
> > > > On Tue, Mar 15, 2022 at 11:10:06PM +0100, Jonathan Neuschäfer wrote:
> > > > > As discussed with other developers, the linux-uvc-devel mailing list is
> > > > > not very useful anymore, and it's better to send people to the general
> > > > > linux-media mailing list.
> > > > > 
> > > > > Replace/remove the old mailing list address in uvcvideo.rst and
> > > > > MAINTAINERS.
> > > > > 
> > > > > Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> > > > > ---
> > > > > 
> > > > > v2:
> > > > > - Changed mailing list to linux-media@vger.kernel.org instead
> > > > > 
> > > > > v1:
> > > > > - https://lore.kernel.org/lkml/20220312203323.626657-1-j.neuschaefer@gmx.net/
> > > > > ---
> > > > >  Documentation/userspace-api/media/drivers/uvcvideo.rst | 2 +-
> > > > >  MAINTAINERS                                            | 1 -
> > > > 
> > > > This looks good, but I think we should also add the following:
> > > > 
> > > > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > > > index 5f394d4efc21..6c6a82af07ce 100644
> > > > --- a/drivers/media/usb/uvc/uvc_driver.c
> > > > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > > > @@ -2443,7 +2443,7 @@ static int uvc_probe(struct usb_interface *intf,
> > > >  			 "Forcing device quirks to 0x%x by module parameter for testing purpose.\n",
> > > >  			 dev->quirks);
> > > >  		dev_info(&dev->udev->dev,
> > > > -			 "Please report required quirks to the linux-uvc-devel mailing list.\n");
> > > > +			 "Please report required quirks to the linux-media mailing list.\n");
> > > >  	}
> > > > 
> > > >  	if (dev->info->uvc_version) {
> > > > 
> > > > If you're fine with that change, there's no need to resubmit, I can
> > > > handle this locally.
> > > > 
> > > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > 
> > > Ah, just before I saw your reply, I noticed this instance too, and sent
> > > a separate patch for it.
> > 
> > I'd say great minds think alike if it wasn't presumptuous :-)
> > 
> > > I'll leave it up to you to handle it as you wish, I'm fine with it
> > > either way.
> > 
> > I'll squash the two patches as they're closely related.
> 
> Ping — I don't see this patch in linux-next. Is there something I can do
> to help?

I've just sent a pull request, the patch should make it to v5.19.

-- 
Regards,

Laurent Pinchart
