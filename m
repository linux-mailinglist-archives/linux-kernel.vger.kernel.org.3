Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A7C482592
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 19:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhLaS4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 13:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhLaS4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 13:56:14 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4B8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 10:56:14 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v7so57156688wrv.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 10:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XRfpr7i3YGNRNX+sqa8uo1YTDTIBpi+zjFAQkEMU4QY=;
        b=k6gdIM6pyiOdhwcd7Yddxv5Od0x2vC3baD9lr+K7rDR+ZqYhitE4PWr8n4+ZhhP36+
         PB68qWV5bmsWOkmK/h6NIMffgSY4Hi9BnHa39LxI56+RwgIf1+vpnSuSAfitXuRoQyQq
         7XPxIj+PV+SvkGNpsYgbT5qwXj4BS9X7I1b0OsnWlz3hF5SM4ka1IOwbG7GQrhkduFid
         u7FtaD/MguCCYOI4TPafF+s+nBvMtglgVZA4Nofex3vED+z5UR7rNGw0n2N4QLEnTDKj
         wNdaowr1U3lzn5nNOCelXU0H4CmDFTtnTeKndFsNqMPssWQMP0TLsvyuP0RBdUUTg5ca
         aqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XRfpr7i3YGNRNX+sqa8uo1YTDTIBpi+zjFAQkEMU4QY=;
        b=ahxDTE/mYBFBUTsu9QT12qMUjWznXrJdP79fLLqceskdB7znWtLIwEdTan+ojr37PA
         tPl92faqaK7kbyedrXHYJMZfHdLFu7qpJKjkLMyxTtflxqAOtkCSP0st+J6Gbz1QFR5q
         Qo5GvUdttQdSzoaq8z65rgoEP1DL4moJNageFhJTRCUoGamfd9rUEYwQXHz6NW2hpvD7
         XlG3/8IVArLBpS/GbUz2lXf8bT3UFaQM/mAGzQG6gfx2kVzn+KH3Gr7dN6kZAEopbQRl
         ALTWlH9hylVkIeLAP9gO0DAgyh+DHn3WBrL1bMiQMn0kMsWjvd7zuiMJyUXmUiafqdFI
         pZlg==
X-Gm-Message-State: AOAM532PKdWHXfyrgcOYqgncxeyKEF6q95LlMyvFey3pQKOsfeHVrdjs
        l75rh7TftytepVvOAUYhrQo=
X-Google-Smtp-Source: ABdhPJw3U7gOLz7Dj+wHwrpDAZe/nshH5EUBFQgXENLjhVcz1NdMBQjc5fmkNxL3xmhlZ6wZPByQZw==
X-Received: by 2002:a05:6000:2aa:: with SMTP id l10mr30698378wry.518.1640976972309;
        Fri, 31 Dec 2021 10:56:12 -0800 (PST)
Received: from pswork (i5E86B4D2.versanet.de. [94.134.180.210])
        by smtp.gmail.com with ESMTPSA id g198sm30659446wme.23.2021.12.31.10.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Dec 2021 10:56:11 -0800 (PST)
Date:   Fri, 31 Dec 2021 19:56:11 +0100
From:   Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, nsaenz@kernel.org,
        Gaston Gonzalez <gascoar@gmail.com>,
        Ojaswin Mujoo <ojaswin98@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v2] staging: vc04_services: Fix RCU dereference check
Message-ID: <20211231185611.GA4463@pswork>
References: <20211230133430.GA10256@pswork>
 <20211230145415.11962-1-treasure4paddy@gmail.com>
 <1f52892e-ca86-33e4-25da-eb0b40f45b04@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f52892e-ca86-33e4-25da-eb0b40f45b04@i2se.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 10:39:58PM +0100, Stefan Wahren wrote:
> Hi Padmanabha,
> 
> Am 30.12.21 um 15:54 schrieb Padmanabha Srinivasaiah:
> > In service_callback path RCU dereferenced pointer struct vchiq_service
> > need to be accessed inside rcu read-critical section.
> >
> > Accessing same with rcu_read_[lock/unlock] fixes the issue.
> >
> > [   32.201659] =============================
> > [   32.201664] WARNING: suspicious RCU usage
> > [   32.201670] 5.15.11-rt24-v8+ #3 Not tainted
> > [   32.201680] -----------------------------
> > [   32.201685] drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h:529 suspicious rcu_dereference_check() usage!
> > [   32.201695]
> > [   32.201695] other info that might help us debug this:
> > [   32.201695]
> > [   32.201700]
> > [   32.201700] rcu_scheduler_active = 2, debug_locks = 1
> > [   32.201708] no locks held by vchiq-slot/0/98.
> > [   32.201715]
> > [   32.201715] stack backtrace:
> > [   32.201723] CPU: 1 PID: 98 Comm: vchiq-slot/0 Not tainted 5.15.11-rt24-v8+ #3
> > [   32.201733] Hardware name: Raspberry Pi 4 Model B Rev 1.4 (DT)
> > [   32.201739] Call trace:
> > [   32.201742]  dump_backtrace+0x0/0x1b8
> > [   32.201772]  show_stack+0x20/0x30
> > [   32.201784]  dump_stack_lvl+0x8c/0xb8
> > [   32.201799]  dump_stack+0x18/0x34
> > [   32.201808]  lockdep_rcu_suspicious+0xe4/0xf8
> > [   32.201817]  service_callback+0x124/0x400
> > [   32.201830]  slot_handler_func+0xf60/0x1e20
> > [   32.201839]  kthread+0x19c/0x1a8
> > [   32.201849]  ret_from_fork+0x10/0x20
> >
> > Signed-off-by: Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
> > ---
> > Changes in v2:
> > 	RCU dereferenced pointer need to be accessed inside rcu
> > read-side critical section.
> >
> >  .../vc04_services/interface/vchiq_arm/vchiq_arm.c      | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> > index 6759a6261500..8ddd400ab2c3 100644
> > --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> > +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> > @@ -1053,24 +1053,30 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
> >  	struct vchiq_service *service;
> >  	struct vchiq_instance *instance;
> >  	bool skip_completion = false;
> > +	unsigned int localport;
> >  
> >  	DEBUG_INITIALISE(g_state.local);
> >  
> >  	DEBUG_TRACE(SERVICE_CALLBACK_LINE);
> >  
> > +	rcu_read_lock();
> >  	service = handle_to_service(handle);
> > -	if (WARN_ON(!service))
> > +	if (WARN_ON(!service)) {
> > +		rcu_read_unlock();
> >  		return VCHIQ_SUCCESS;
> > +	}
> >  
> >  	user_service = (struct user_service *)service->base.userdata;
> 
> user_service is part of the service struct and it's modification below
> in this function is protected by a spinlock ( msg_queue_spinlock ). So i
> would expected that all read accesses to user_service before the
> spinlock are protected by RCU. After applying this patch there would be
> still the check for "user_service->is_vchi" unprotected. But i'm not
> sure about this.
>
Thank you stefan for identfying it. Yes, userdata/user_service can be
potentially released after graceperiod.

Also here pointer is used around different synchronization mechanism,
taking an extra reference will keep semantics simpler and will not
prolong the graceperiod. Will regenerate the patch again.

> Best regards
> 
> >  	instance = user_service->instance;
> > +	localport = service->localport;
> > +	rcu_read_unlock();
> >  
> >  	if (!instance || instance->closing)
> >  		return VCHIQ_SUCCESS;
> >  
> >  	vchiq_log_trace(vchiq_arm_log_level,
> >  			"%s - service %lx(%d,%p), reason %d, header %lx, instance %lx, bulk_userdata %lx",
> > -			__func__, (unsigned long)user_service, service->localport,
> > +			__func__, (unsigned long)user_service, (int)localport,
> >  			user_service->userdata, reason, (unsigned long)header,
> >  			(unsigned long)instance, (unsigned long)bulk_userdata);
> >  
> 
