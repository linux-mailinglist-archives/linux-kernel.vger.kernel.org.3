Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B535B29EE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 01:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiIHXM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 19:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiIHXM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 19:12:26 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B61A109D22;
        Thu,  8 Sep 2022 16:12:22 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o4so19213208pjp.4;
        Thu, 08 Sep 2022 16:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=5s4UNt4PONIR/SOOlBa2vyZhROb/D/zuzP0k9TznZGU=;
        b=qZBLd3GFTPng6oySVtNG9MHGbpvNg+SBXrABObMcHQRm8GcpXmPJticaBFkqqVtoAW
         +Guea9lyA8hWL4XHhK2uu4xPAEB9ooZMKZ+zOWp4YuVzntYtkIJ38C9s7shanxlZXjaF
         Jmt48j6tEey19DDjy09uafxpZ9bM+n1LT6LCTENr+Cadl5GMlrT/gXHjxJVVd2ppAyOj
         05b3WODtNX2auNdKVlOXKJ5zQGZB3MIu3U3B+s/YNqEbKYomu4V3fqCVivJYzXTfiEmm
         7V7r6S04Kk0od4jFwrNZJfADtQWrj1+QlVMP5Vc/+alvTp8uYoEIGUkp7hM0tlhnEjCN
         JiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5s4UNt4PONIR/SOOlBa2vyZhROb/D/zuzP0k9TznZGU=;
        b=HWnUxfkhYooGg6QFxNrrv1w9QYbLtvAUvSeS7A2EqNgvdbGGWwIFi250qCO6yoYNX3
         1x9UVjKti8yOzDppn3zuYP3eU/EuNiSWfR1PAS3zX/gr7d8UgffyG2bENRdED9VTL2A3
         wOFYh1TvqXKBjJ1S5m4+cIQcAvZN6A7kAtuLmZQDXjhjHm+Jf+NpnyDsR/r5L71/GN5C
         5F5AKS/xi1aVgiofSRI0uYVobqTHiW8DWm4BvDxOp3X88oTyhwVtcDxjy2fdNkSZbZS5
         OxaXKOBpkTw/YmV8A+8PzGFXIHWuiaOEnirGI8SEDn3wqgjzzeRWkWQ1RMLaSabvgQSz
         40XQ==
X-Gm-Message-State: ACgBeo0JIq5H/2rf1HPGlJ1t0kntIhU/A/XiGtDSsajn0axDXxNg0COD
        rfCHfqYBNz3nWvZ2h09NrJqf6vjQdg97bQ==
X-Google-Smtp-Source: AA6agR52Df6biRjya1V1sJ7BG22wP8BJqgxr9iZsf3AVtKQu+Nh/EfRpZENNGfHHIEBK1yMNp9Z0Nw==
X-Received: by 2002:a17:903:41ca:b0:177:eb43:71a5 with SMTP id u10-20020a17090341ca00b00177eb4371a5mr7473792ple.131.1662678741304;
        Thu, 08 Sep 2022 16:12:21 -0700 (PDT)
Received: from Negi ([207.151.52.163])
        by smtp.gmail.com with ESMTPSA id z21-20020a630a55000000b0042254fce5e7sm7276pgk.50.2022.09.08.16.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 16:12:20 -0700 (PDT)
Date:   Thu, 8 Sep 2022 16:12:19 -0700
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH] media: em28xx: Enable v4l2 file ops at the end of
 em28xx_v4l2_init()
Message-ID: <20220908231219.GA13068@Negi>
References: <20220829132548.23520-1-soumya.negi97@gmail.com>
 <082ba39a-aa00-ac49-ac2a-eceac0bca5ff@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <082ba39a-aa00-ac49-ac2a-eceac0bca5ff@xs4all.nl>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 03:25:58PM +0200, Hans Verkuil wrote:
> Hi Soumya,
> 
> On 29/08/2022 15:25, Soumya Negi wrote:
> > Fix syzbot bug KASAN: use-after-free Read in v4l2_fh_open
> > Syzbot link:
> > https://syzkaller.appspot.com/bug?id=0e3c97f1c4112e102c9988afd5eff079350eab7f
> > Repro: https://syzkaller.appspot.com/text?tag=ReproC&x=12663ebdd00000
> > 
> > The bug arises because the em28xx driver registers a v4l2 video
> > device(struct video_device) with the V4L2 interface in
> > em28xx_v4l2_init() but the v4l2 extension initialization eventually
> > fails and the video device is unregistered. v4l2_open() in the V4L2
> > interface views the device as registered and allows calls to
> > em28xx_v4l2_open(). Due to race between video_unregister_device() and
> > v4l2_open(), em28xx_v4l2_open() is accessing video device after it has
> > been freed(by the release callback) and is passing it on to
> > v4l2_fh_open().
> > 
> > In em28xx_v4l2_init(), temporarily disable v4l2 file operations on
> > struct video_device devices(video, vbi, radio) before registering them
> > and enable the file ops at the end when v4l2 extension initialization
> > succeeds.
> 
> That's not the right approach. The problem is the roll-your-own v4l2->ref
> refcount. Instead this should use the refcount that is built into struct
> v4l2_device.
> 
> Specifically v4l2_dev->release should be set to the release function, and
> v4l2_device_put(&v4l2->v4l2_dev); should be called in remove() or in the
> error path of em28xx_v4l2_init().
> 
> Using this the release callback of v4l2_device will be called when the last
> open file handle is closed, i.e. it keeps track of the open()s.
> 
> The roll-your-own approach in the em28xx driver (written before this v4l2_device
> refcounting existed), is not taking that into account, so that causes these
> problems.
> 
> What is also bad is that em28xx_vb2_setup() is called after the video devices
> are registered. That should happen before.
> 
> Regards,
> 
> 	Hans

Hi Hans,
Thank you for explaining both the issues in detail. I will get working
on both and get back to you. 

Regards,
Soumya

> > 
> > Reported-by: syzbot+b2391895514ed9ef4a8e@syzkaller.appspotmail.com
> > Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> > ---
> >  drivers/media/usb/em28xx/em28xx-video.c | 45 +++++++++++++++++++++----
> >  1 file changed, 39 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/media/usb/em28xx/em28xx-video.c b/drivers/media/usb/em28xx/em28xx-video.c
> > index 8181c0e6a25b..900a1eacb1c7 100644
> > --- a/drivers/media/usb/em28xx/em28xx-video.c
> > +++ b/drivers/media/usb/em28xx/em28xx-video.c
> > @@ -2320,6 +2320,19 @@ static int em28xx_v4l2_close(struct file *filp)
> >  	return 0;
> >  }
> >  
> > +/* Used to temporarily disable file operations on video_device until successful
> > + * initialization in em28xx_v4l2_init().
> > + */
> > +static const struct v4l2_file_operations em28xx_v4l_fops_empty = {
> > +	.owner         = THIS_MODULE,
> > +	.open          = NULL,
> > +	.release       = NULL,
> > +	.read          = NULL,
> > +	.poll          = NULL,
> > +	.mmap          = NULL,
> > +	.unlocked_ioctl = NULL,
> > +};
> > +
> >  static const struct v4l2_file_operations em28xx_v4l_fops = {
> >  	.owner         = THIS_MODULE,
> >  	.open          = em28xx_v4l2_open,
> > @@ -2375,12 +2388,22 @@ static const struct v4l2_ioctl_ops video_ioctl_ops = {
> >  };
> >  
> >  static const struct video_device em28xx_video_template = {
> > -	.fops		= &em28xx_v4l_fops,
> > +	.fops		= &em28xx_v4l_fops_empty,
> >  	.ioctl_ops	= &video_ioctl_ops,
> >  	.release	= video_device_release_empty,
> >  	.tvnorms	= V4L2_STD_ALL,
> >  };
> >  
> > +/* Used to temporarily disable file operations on video_device until successful
> > + * initialization in em28xx_v4l2_init().
> > + */
> > +static const struct v4l2_file_operations radio_fops_empty = {
> > +	.owner         = THIS_MODULE,
> > +	.open          = NULL,
> > +	.release       = NULL,
> > +	.unlocked_ioctl = NULL,
> > +};
> > +
> >  static const struct v4l2_file_operations radio_fops = {
> >  	.owner         = THIS_MODULE,
> >  	.open          = em28xx_v4l2_open,
> > @@ -2404,7 +2427,7 @@ static const struct v4l2_ioctl_ops radio_ioctl_ops = {
> >  };
> >  
> >  static struct video_device em28xx_radio_template = {
> > -	.fops		= &radio_fops,
> > +	.fops		= &radio_fops_empty,
> >  	.ioctl_ops	= &radio_ioctl_ops,
> >  	.release	= video_device_release_empty,
> >  };
> > @@ -2833,9 +2856,6 @@ static int em28xx_v4l2_init(struct em28xx *dev)
> >  				"can't register radio device\n");
> >  			goto unregister_dev;
> >  		}
> > -		dev_info(&dev->intf->dev,
> > -			 "Registered radio device as %s\n",
> > -			 video_device_node_name(&v4l2->radio_dev));
> >  	}
> >  
> >  	/* Init entities at the Media Controller */
> > @@ -2851,14 +2871,27 @@ static int em28xx_v4l2_init(struct em28xx *dev)
> >  	}
> >  #endif
> >  
> > +	/* Enable v4l2 file operations for v4l2 video video_device */
> > +	v4l2->vdev.fops = &em28xx_v4l_fops;
> >  	dev_info(&dev->intf->dev,
> >  		 "V4L2 video device registered as %s\n",
> >  		 video_device_node_name(&v4l2->vdev));
> >  
> > -	if (video_is_registered(&v4l2->vbi_dev))
> > +	if (video_is_registered(&v4l2->vbi_dev)) {
> > +		/* Enable v4l2 file operations for v4l2 vbi video_device */
> > +		v4l2->vbi_dev.fops = &em28xx_v4l_fops;
> >  		dev_info(&dev->intf->dev,
> >  			 "V4L2 VBI device registered as %s\n",
> >  			 video_device_node_name(&v4l2->vbi_dev));
> > +	}
> > +
> > +	if (video_is_registered(&v4l2->radio_dev)) {
> > +		/* Enable v4l2 file operations for v4l2 radio video_device */
> > +		v4l2->radio_dev.fops = &radio_fops;
> > +		dev_info(&dev->intf->dev,
> > +			 "Registered radio device as %s\n",
> > +			 video_device_node_name(&v4l2->radio_dev));
> > +	}
> >  
> >  	/* Save some power by putting tuner to sleep */
> >  	v4l2_device_call_all(&v4l2->v4l2_dev, 0, tuner, standby);
> 
