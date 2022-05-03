Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04CA518CD2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241732AbiECTGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239531AbiECTGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:06:46 -0400
Received: from mail1.bemta33.messagelabs.com (mail1.bemta33.messagelabs.com [67.219.247.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE293B3F8;
        Tue,  3 May 2022 12:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com;
        s=Selector; t=1651604588; i=@motorola.com;
        bh=XtyFhq7Q1eLkmO9etWjYMVijdPQniE2mXV3LOdbh9Pg=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=X8gXWvfYvtpN9Y8wXs/LTzcvtTJDGxvpZO67Zz8ySvDUGxNv7bZjUkjl+Gw87xz23
         eaO6tRNli8JZ0rQcPnlpMxlwacMGc33IonO3CRaZfUakhLNe/u921CYFKRZGvM2qeP
         a+1J6xnouQT5Ggq/TWpsbsQ1B4EpO+fdLo/AuU5oFU7S3DwxhpJVhtBNo4q6Q8WDkV
         X2pS716a4Z/YVCTzfpFXhq6StmG6TebUJfBeqXuvOLG3ZhCJR4A+SNOT5lnxvjq9eA
         cokamfylIDA1VRRIWPcxWA/FKYfeMr+HMCsUFjcMkphAI3h9F3hWIC6VK7MEYiOv13
         YwnmoTn1AaYBw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRWlGSWpSXmKPExsUyYU+Ds25OTWG
  SwZoGIYtjbU/YLZoXr2ez6Jy4hN3i8q45bBaLlrUyO7B6zO6YyeqxaVUnm8f+uWvYPT5vkgtg
  iWLNzEvKr0hgzVi8aTZTwS7xisWXrrE3MD4R6mLk4hASmMYkMW3aFmYIZxGTROPOg4xdjBwcL
  AIqEutXxXQxcnKwCahJLHi9ihnEFhEwlug/O4sdpJ5ZYAqjxPvDKxhBEsICgRItc26wgNi8As
  oSvw4eZAOxhQT6GCU27c2BiAtKnJz5BKyGWUBL4sa/l0wgu5gFpCWW/+MACXMKaEqcOdXDPoG
  RdxaSjllIOmYhdCxgZF7FaJVUlJmeUZKbmJmja2hgoGtoaKJrDqL0Eqt0E/VKi3VTE4tLdI30
  EsuL9VKLi/WKK3OTc1L08lJLNjECgzelyI17B+PZlT/1DjFKcjApifKqlRQmCfEl5adUZiQWZ
  8QXleakFh9ilOHgUJLgPVoGlBMsSk1PrUjLzAFGEkxagoNHSYSXFxhNQrzFBYm5xZnpEKlTjL
  oclw5d2cssxJKXn5cqJc7rVw1UJABSlFGaBzcCFtWXGGWlhHkZGRgYhHgKUotyM0tQ5V8xinM
  wKgnz1oJM4cnMK4Hb9AroCCagI47Fgx1RkoiQkmpgmunec2t66bTdsecuHLNfMPlj64Mj2fHF
  HgVczmfC5FIW3V+r++Bt+2uh7LzuoEMfUx3XrG3Ul1ZXFde4stnoYvuq2R/+NwdtDPxivjpY4
  V/IoXYZj6Oy29ec/eHtdk5ePjbGV+b5vLi9B5W/5cuc2Tx7i6S7Qw9vQmh9z4blzwS69vgGmN
  yzF4/wKLfZtvmo2PmMDA8Xr+s3lzG/VZE6Ifhh2zRVhx8vgw8+8eNVYyi+abhXl/9Jmfpl5Yn
  fPCwvvf5xR6fh3hStnIni0iqPZdVtWdeo3xTuvuF0vnv6tIPBR+dHM+z5yRXd9MPEwrqB6eID
  YYHjSXZ3Tq8M7Zslf9c39tBtwd3yBYKnPp8QVGIpzkg01GIuKk4EAP0UuL1lAwAA
X-Env-Sender: w36195@motorola.com
X-Msg-Ref: server-15.tower-715.messagelabs.com!1651604587!94122!1
X-Originating-IP: [144.188.128.67]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.86.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6841 invoked from network); 3 May 2022 19:03:08 -0000
Received: from unknown (HELO ilclpfpp01.lenovo.com) (144.188.128.67)
  by server-15.tower-715.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 3 May 2022 19:03:08 -0000
Received: from va32lmmrp02.lenovo.com (va32lmmrp02.mot.com [10.62.176.191])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by ilclpfpp01.lenovo.com (Postfix) with ESMTPS id 4Kt8Vg5p1VzfBZq;
        Tue,  3 May 2022 19:03:07 +0000 (UTC)
Received: from p1g3 (unknown [10.45.5.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: w36195)
        by va32lmmrp02.lenovo.com (Postfix) with ESMTPSA id 4Kt8Vg31Nmzf6WS;
        Tue,  3 May 2022 19:03:07 +0000 (UTC)
Date:   Tue, 3 May 2022 14:02:58 -0500
From:   Dan Vacura <w36195@motorola.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: uvc: allow for application to cleanly
 shutdown
Message-ID: <YnF8YmKqFm5oONkB@p1g3>
References: <20220429192001.385636-1-w36195@motorola.com>
 <YmzrwgiEO2hoKM4U@kroah.com>
 <Ym9Z+BfHcwDKlwjy@p1g3>
 <Ym/En8EjfkpIVm+a@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ym/En8EjfkpIVm+a@kroah.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thanks for the feedback.

On Mon, May 02, 2022 at 01:46:39PM +0200, Greg Kroah-Hartman wrote:
> On Sun, May 01, 2022 at 11:11:36PM -0500, Dan Vacura wrote:
> > On Sat, Apr 30, 2022 at 09:56:50AM +0200, Greg Kroah-Hartman wrote:
> > > On Fri, Apr 29, 2022 at 02:20:01PM -0500, Dan Vacura wrote:
> > > > diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
> > > > index 50e6e7a58b41..3cc8cf24a7c7 100644
> > > > --- a/drivers/usb/gadget/function/f_uvc.c
> > > > +++ b/drivers/usb/gadget/function/f_uvc.c
> > > > @@ -892,13 +892,36 @@ static void uvc_function_unbind(struct usb_configuration *c,
> > > >  {
> > > >  	struct usb_composite_dev *cdev = c->cdev;
> > > >  	struct uvc_device *uvc = to_uvc(f);
> > > > +	int wait_ret = 1;
> > > >  
> > > >  	uvcg_info(f, "%s()\n", __func__);
> > > 
> > > Ick, wait, is that in the kernel?  That needs to be removed, ftrace can
> > > do that for you.
> > 
> > Yes, part of the kernel, and tbh, I find it to be quite helpful in
> > debugging field issues from customers, where enabling ftrace isn't
> > practical.
> 
> Why isn't ftrace ok to enable in a running kernel?

ftrace is totally fine to enable. I should've said convenient instead of
practical, from my experience there's a bit more offline/developer
overhead for setup and integrating the trace logs with a panic or kmsg,
then bundling that with the bug reports we get.

> 
> Worst case, this should be dev_dbg(), right?
> 
> > If you still want to remove, there are other locations in
> > this gadget driver that log function entry. Perhaps it'd be better to
> > do a separate change that cleans up logging a bit or do you prefer to
> > just refactor this one now?
> 
> This commit is fine, it's a separate issue, I just noticed it as it was
> in the context of this change.
> 
> > > > +	/* If we know we're connected via v4l2, then there should be a cleanup
> > > > +	 * of the device from userspace either via UVC_EVENT_DISCONNECT or
> > > > +	 * though the video device removal uevent. Allow some time for the
> > > > +	 * application to close out before things get deleted.
> > > > +	 */
> > > > +	if (uvc->func_connected) {
> > > > +		uvcg_info(f, "%s waiting for clean disconnect\n", __func__);
> > > > +		wait_ret = wait_event_interruptible_timeout(uvc->func_connected_queue,
> > > > +				uvc->func_connected == false, msecs_to_jiffies(500));
> > > > +		uvcg_info(f, "%s done waiting with ret: %u\n", __func__, wait_ret);
> > > 
> > > Please remove debugging code before submitting patches.
> > 
> > Will do.
> 
> But this should be removed :)
> 
> Feel free to change it to dev_dbg(), which gives you the __func__
> automatically without anything extra needed.

Yes, I'll go with this approach, as it doesn't make sense to always
print, but is good to have when developing or debugging. The timeouts
seem reasonable to me and work for our setup, but I was expecting some
comments about them or a suggestion for a different approach.

Thanks,

Dan
