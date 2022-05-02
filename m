Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE985169BD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 06:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357566AbiEBEPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 00:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357492AbiEBEPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 00:15:12 -0400
Received: from mail1.bemta33.messagelabs.com (mail1.bemta33.messagelabs.com [67.219.247.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF90DFC0;
        Sun,  1 May 2022 21:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com;
        s=Selector; t=1651464703; i=@motorola.com;
        bh=eH/1/pgPyZWGp/9S1ke2bugzLKOrlj8TXZ/Qgsu3Tlw=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=Qii8V64zUlwFnEDs8JwLgizcC1ajNfJ886cKMc4YV/z/H9A5rU7Af8WTKqF0I+MTk
         eu8s47eBBEr8Xlg50NvgmQganehTzYw0pIC2W6+WDaTNHMCI973V5iETpXlc3xTa5Y
         saEQ7knT8tukQ8LaG/LacJLcSp3u+/tFvTUkg5TlywhHe72qyBiS5cH/nBnRb/B56q
         sAiXzKjYpy3KDab9hyHyn5MTi9FNs/BCVs8FbdcpWQSJEMft9/az329jb+0tBvsLPS
         trqxXY5nHOY3fdMZI/vixbl75ystPLsl1KXtj80RoyXSy27gkvRtgaiTbzUbqkavo5
         8GgCpZxxzDCzw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRWlGSWpSXmKPExsUyYU+Ds+7/yPw
  kg/knGS2OtT1ht2hevJ7NonPiEnaLy7vmsFksWtbK7MDqMbtjJqvHplWdbB77565h9/i8SS6A
  JYo1My8pvyKBNWPip61sBXcVKj72bWJrYOyS7mLk4hASmMYk8W3OIuYuRk4gZxGQ85EVxGYRU
  JH4++MDE4jNJqAmseD1KrAaEQFjif6zs9hBmpkFpjBKvD+8ghEkISwQKNEy5wZLFyMHB6+Ass
  SHL6YQM8MlXjxqBJvDKyAocXLmExYQm1lAS+LGv5dMIOXMAtISy/9xgIQ5BTQlJnxbyDyBkXc
  Wko5ZSDpmIXQsYGRexWidVJSZnlGSm5iZo2toYKBraGiia2apa2RsqpdYpZuoV1qsm5pYXKJr
  pJdYXqyXWlysV1yZm5yTopeXWrKJERi8KUWur3cwPlr5U+8QoyQHk5Ior+SHvCQhvqT8lMqMx
  OKM+KLSnNTiQ4wyHBxKErw+gflJQoJFqempFWmZOcBIgklLcPAoifCqhQKleYsLEnOLM9MhUq
  cYdTkuHbqyl1mIJS8/L1VKnJcFGJdCAiBFGaV5cCNgUX2JUVZKmJeRgYFBiKcgtSg3swRV/hW
  jOAejkjDv4wigKTyZeSVwm14BHcEEdERTei7IESWJCCmpBqZlBxqjjR9+DTs7KSFjh4KEZ2VG
  +gkBL+mZyzT83PawaUzOcMyUuc22kXeuTu4n8RcrllnOW8RydLmKUvypOIPbvLv7A/fq+sno9
  0999O6gjG2FisfU5fnCuq2Cn5/uTolfmiMkb1P/4Gv5O6l1Sg7LqqM3ei5M+aMXsD3G1teYm9
  ty41m9LgOrS+9i+SRWdKmnvmvW25X53ZiJ/ambvsOH0DWJLBYuStetLZazdMSGVCe/3behYKm
  FydscRS+xhZI3w1ce7LJvMemQrhOZeeXk9CWll/Y9m1Lg619enCtyVGRbwo/vv0299uWyphp1
  3r7ta53+sKhvZqhhAsONJPawnV/aQhz21nYwVQkosRRnJBpqMRcVJwIApyHYtWUDAAA=
X-Env-Sender: w36195@motorola.com
X-Msg-Ref: server-15.tower-715.messagelabs.com!1651464702!208247!1
X-Originating-IP: [144.188.128.67]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.86.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 4682 invoked from network); 2 May 2022 04:11:42 -0000
Received: from unknown (HELO ilclpfpp01.lenovo.com) (144.188.128.67)
  by server-15.tower-715.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 2 May 2022 04:11:42 -0000
Received: from va32lmmrp02.lenovo.com (va32lmmrp02.mot.com [10.62.176.191])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by ilclpfpp01.lenovo.com (Postfix) with ESMTPS id 4Ks8mZ3qS9zfBZq;
        Mon,  2 May 2022 04:11:42 +0000 (UTC)
Received: from p1g3 (unknown [10.45.4.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: w36195)
        by va32lmmrp02.lenovo.com (Postfix) with ESMTPSA id 4Ks8mZ16gBzf6WS;
        Mon,  2 May 2022 04:11:42 +0000 (UTC)
Date:   Sun, 1 May 2022 23:11:36 -0500
From:   Dan Vacura <w36195@motorola.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: uvc: allow for application to cleanly
 shutdown
Message-ID: <Ym9Z+BfHcwDKlwjy@p1g3>
References: <20220429192001.385636-1-w36195@motorola.com>
 <YmzrwgiEO2hoKM4U@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmzrwgiEO2hoKM4U@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 09:56:50AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Apr 29, 2022 at 02:20:01PM -0500, Dan Vacura wrote:
> > Several types of kernel panics can occur due to timing during the uvc
> > gadget removal. This appears to be a problem with gadget resources being
> > managed by both the client application's v4l2 open/close and the UDC
> > gadget bind/unbind. Since the concept of USB_GADGET_DELAYED_STATUS
> > doesn't exist for unbind, add a wait to allow for the application to
> > close out.
> > 
> > Some examples of the panics that can occur are:
> > 
> > <1>[ 1147.652313] Unable to handle kernel NULL pointer dereference at
> > virtual address 0000000000000028
> > <4>[ 1147.652510] Call trace:
> > <4>[ 1147.652514]  usb_gadget_disconnect+0x74/0x1f0
> > <4>[ 1147.652516]  usb_gadget_deactivate+0x38/0x168
> > <4>[ 1147.652520]  usb_function_deactivate+0x54/0x90
> > <4>[ 1147.652524]  uvc_function_disconnect+0x14/0x38
> > <4>[ 1147.652527]  uvc_v4l2_release+0x34/0xa0
> > <4>[ 1147.652537]  __fput+0xdc/0x2c0
> > <4>[ 1147.652540]  ____fput+0x10/0x1c
> > <4>[ 1147.652545]  task_work_run+0xe4/0x12c
> > <4>[ 1147.652549]  do_notify_resume+0x108/0x168
> > 
> > <1>[  282.950561][ T1472] Unable to handle kernel NULL pointer
> > dereference at virtual address 00000000000005b8
> > <6>[  282.953111][ T1472] Call trace:
> > <6>[  282.953121][ T1472]  usb_function_deactivate+0x54/0xd4
> > <6>[  282.953134][ T1472]  uvc_v4l2_release+0xac/0x1e4
> > <6>[  282.953145][ T1472]  v4l2_release+0x134/0x1f0
> > <6>[  282.953167][ T1472]  __fput+0xf4/0x428
> > <6>[  282.953178][ T1472]  ____fput+0x14/0x24
> > <6>[  282.953193][ T1472]  task_work_run+0xac/0x130
> > 
> > <3>[  213.410077][   T29] configfs-gadget gadget: uvc: Failed to queue
> > request (-108).
> > <1>[  213.410116][   T29] Unable to handle kernel NULL pointer
> > dereference at virtual address 0000000000000003
> > <6>[  213.413460][   T29] Call trace:
> > <6>[  213.413474][   T29]  uvcg_video_pump+0x1f0/0x384
> > <6>[  213.413489][   T29]  process_one_work+0x2a4/0x544
> > <6>[  213.413502][   T29]  worker_thread+0x350/0x784
> > <6>[  213.413515][   T29]  kthread+0x2ac/0x320
> > <6>[  213.413528][   T29]  ret_from_fork+0x10/0x30
> > 
> > Signed-off-by: Dan Vacura <w36195@motorola.com>
> > ---
> >  drivers/usb/gadget/function/f_uvc.c    | 24 ++++++++++++++++++++++++
> >  drivers/usb/gadget/function/uvc.h      |  2 ++
> >  drivers/usb/gadget/function/uvc_v4l2.c |  3 ++-
> >  3 files changed, 28 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
> > index 50e6e7a58b41..3cc8cf24a7c7 100644
> > --- a/drivers/usb/gadget/function/f_uvc.c
> > +++ b/drivers/usb/gadget/function/f_uvc.c
> > @@ -892,13 +892,36 @@ static void uvc_function_unbind(struct usb_configuration *c,
> >  {
> >  	struct usb_composite_dev *cdev = c->cdev;
> >  	struct uvc_device *uvc = to_uvc(f);
> > +	int wait_ret = 1;
> >  
> >  	uvcg_info(f, "%s()\n", __func__);
> 
> Ick, wait, is that in the kernel?  That needs to be removed, ftrace can
> do that for you.

Yes, part of the kernel, and tbh, I find it to be quite helpful in
debugging field issues from customers, where enabling ftrace isn't
practical. If you still want to remove, there are other locations in
this gadget driver that log function entry. Perhaps it'd be better to
do a separate change that cleans up logging a bit or do you prefer to
just refactor this one now?

> 
> > +	/* If we know we're connected via v4l2, then there should be a cleanup
> > +	 * of the device from userspace either via UVC_EVENT_DISCONNECT or
> > +	 * though the video device removal uevent. Allow some time for the
> > +	 * application to close out before things get deleted.
> > +	 */
> > +	if (uvc->func_connected) {
> > +		uvcg_info(f, "%s waiting for clean disconnect\n", __func__);
> > +		wait_ret = wait_event_interruptible_timeout(uvc->func_connected_queue,
> > +				uvc->func_connected == false, msecs_to_jiffies(500));
> > +		uvcg_info(f, "%s done waiting with ret: %u\n", __func__, wait_ret);
> 
> Please remove debugging code before submitting patches.

Will do.

> 
> thanks,
> 
> greg k-h
