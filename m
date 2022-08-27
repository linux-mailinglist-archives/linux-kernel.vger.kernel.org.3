Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51565A3767
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 13:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245213AbiH0Lki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 07:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242511AbiH0Lkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 07:40:36 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378D259273;
        Sat, 27 Aug 2022 04:40:35 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id v23so3759082plo.9;
        Sat, 27 Aug 2022 04:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=FxHBa/kMuhpcvnwyjwvjPT7VTq+acpEFMgw4YwC0ryA=;
        b=mtmO3894CS9izo3hHWCjemPURz4Ala0fuhapju5THxemDIgAaH7kPEQCnj4DFdmOaF
         WjmI2nmZ1evJ9R6NPGYlEaEl/pyv5H5YGMphoensLDQ9P1R6CRmWtm+953nQgIegAvjg
         GttMrwXi+kgKQTn+wQFinCBVRaoWQ14tNWYuXHroWIi5KZb6w3FeMefOJrpsRPIphisY
         UWI7KylMfA2TI/ELsePc9Bzl+pjtfnpMWEiGgIY0RGmoBH3Ugk/2f9G+pvlx0bPISkWM
         wCQRzcQWsMjJmrnPNg0DMEXzwK9B+0uAvG5R45KyZd/2tX9zlDgfZyebpRFXeGiYux+7
         lOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=FxHBa/kMuhpcvnwyjwvjPT7VTq+acpEFMgw4YwC0ryA=;
        b=Jvwp2a4VRBh93drU46F7T1xW4L3C5QbBqm36AWdf38FOT2E9N0bbv7ZNKvDRPbOzjg
         vzV9Vc8IeNFabjUGGpx2tTGXarWswx4foDlFdQeCuvT0xbnrkXdQeJLgi52p0Nj5ZM1u
         6hP4dY4HYpJuEWWjP8z1XhSKV9VYk66IyXH1JosKBWgjFnP+FEQnoBdES63AsKH1vHKp
         9mz1Wyw5IM++cGcDMFS/xVTLCloLZ24OID9RReq2o3N2SW3k8nzW2uXiT1IgwGX2y0fE
         Hg5OanWe8rElsoyWdJW0DYsqcDFVJlqranJGakvX0o5+BWf+/E9ATtSw7AXuB0ceBb5M
         pnhQ==
X-Gm-Message-State: ACgBeo1wxTIui2hLwaTZxbY661AADB7fJV0GE+HNIabvEh3OQlS5CQ31
        OmJ6G3YfjQW1V4spAutGAv0=
X-Google-Smtp-Source: AA6agR66AN7GBardMgXZGleMoLE6SyVgqmIbwP6Z08W58b6UuPM077F3Y4gLUCYixVffnBwCl4cz7g==
X-Received: by 2002:a17:903:24e:b0:172:6c9d:14e0 with SMTP id j14-20020a170903024e00b001726c9d14e0mr7733259plh.84.1661600434663;
        Sat, 27 Aug 2022 04:40:34 -0700 (PDT)
Received: from DESKTOP-KA7F9LU.localdomain ([49.207.219.204])
        by smtp.gmail.com with ESMTPSA id gi13-20020a17090b110d00b001fb0fc33d72sm3200055pjb.47.2022.08.27.04.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 04:40:33 -0700 (PDT)
Date:   Sat, 27 Aug 2022 17:10:28 +0530
From:   Vimal Kumar <vimal.kumar32@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     chinmoyghosh2001@gmail.com, Mintu Patel <mintupatel89@gmail.com>,
        Vishal Badole <badolevishal1116@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PM: runtime: Add support to disable wakeup sources
Message-ID: <20220827114028.GA258@DESKTOP-KA7F9LU.localdomain>
References: <20220821134533.22901-1-vimal.kumar32@gmail.com>
 <YwI7PM9wVF/H9hQL@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwI7PM9wVF/H9hQL@kroah.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 21, 2022 at 04:03:40PM +0200, Greg KH wrote:
> On Sun, Aug 21, 2022 at 07:15:32PM +0530, Vimal Kumar wrote:
> > User could find many wakeup sources available in the bsp, which
> > they won't be using. Currently users can only get the status and
> > list of enabled wakeup sources, but users can't disable it runtime.
> > It's very difficult to find the driver for each wakeup sources from
> > where it's getting enabled and make the changes for disabling it.
> > 
> > This will help users to disable any wakeup sources at runtime,
> > avoiding any code change and re-compilation. A new class attribute
> > "disable_ws" will be added in the wakeup calss. If user want to disable
> > any wakeup sources, user need to find the wakeup dev node associated
> > with the particular wakeup source and write the devnode name to the
> > class attribute "disable_ws".
> > 
> > Example:
> > Need to disable the wakeup source '1c08000.qcom,pcie'. The dev node
> > associated with this wakeup source is:
> > cat /sys/class/wakeup3/name ==> "1c08000.qcom,pcie", then for disabling
> > this wakeup source :
> > 	echo wakeup3 > /sys/class/wakeup/disable_ws
> > 
> > Co-developed-by: Mintu Patel <mintupatel89@gmail.com>
> > Signed-off-by: Mintu Patel <mintupatel89@gmail.com>
> > Co-developed-by: Vishal Badole <badolevishal1116@gmail.com>
> > Signed-off-by: Vishal Badole <badolevishal1116@gmail.com>
> > Signed-off-by: Vimal Kumar <vimal.kumar32@gmail.com>
> > ---
> >  drivers/base/power/wakeup_stats.c | 63 ++++++++++++++++++++++++++++++-
> >  1 file changed, 62 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeup_stats.c
> > index 924fac493c4f..ad30e97f168b 100644
> > --- a/drivers/base/power/wakeup_stats.c
> > +++ b/drivers/base/power/wakeup_stats.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/kobject.h>
> >  #include <linux/slab.h>
> >  #include <linux/timekeeping.h>
> > +#include <linux/uaccess.h>
> >  
> >  #include "power.h"
> >  
> > @@ -208,9 +209,69 @@ void wakeup_source_sysfs_remove(struct wakeup_source *ws)
> >  	device_unregister(ws->dev);
> >  }
> >  
> > +static ssize_t disable_ws_store(struct class *class,
> > +				struct class_attribute *attr,
> > +				const char *buf, size_t len)
> > +{
> > +	struct device		*dev;
> > +	struct wakeup_source	*ws;
> > +	char                    *ws_name;
> > +	int                     status;
> 
> Please don't pad these out to be in line like this, one space is all
> that is needed.
> 
> > +
> > +	ws_name = kzalloc(sizeof(*(buf)), GFP_KERNEL);
> 
> Are you sure this does what you think it does?  You are allocating 8
> bytes?
When I checked later, It was allocating 1 byte. My intension was to get the
length on string wrriten from user. The parameter "size_t len" can be directly
used adding one more byte.

> 
> > +	if (!ws_name)
> > +		return -ENOMEM;
> > +
> > +	if (copy_from_user(ws_name, buf, sizeof(*(buf))))
> 
> Why are you doing this in a sysfs callback?
> 
> Did you test this code?  How?  Can you provide a test script for it
> also?
> 
> This does not look correct at all :(
> 
> thanks,
> 
> greg k-h

I tested this code by manually wrriting wakeup device name from /sys/class/wakeup/
like "wakeup0", "wakeup13" etc to class attribute "disable_ws". 
Although, the code implementation using copy_from_user is wrong, I end up testing
this code by directly using "buf" in the next call class_find_device_by_name like:
	class_find_device_by_name(wakeup_class, buf);

 I will provide the next version of patch taking care of the review comments.


Warm Regards,
Vimal Kumar
