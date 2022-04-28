Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA0E513D06
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 23:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351996AbiD1VLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 17:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237046AbiD1VLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:11:10 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52466BF534;
        Thu, 28 Apr 2022 14:07:53 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (89-27-103-169.bb.dnainternet.fi [89.27.103.169])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 2DA111B0029D;
        Fri, 29 Apr 2022 00:07:51 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1651180071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BNdaIGfl1oTNmZ1z18jwQdqe5S5UFYhc+No0/RbEmds=;
        b=OF3c2w3OnPb/EBbgqmLRqgNU547xWhie3X3z4PWvgSUT9cv75X8wQtJs6cU/cPtIMxZMqf
        DSGH3RnMgLmfYaRDEsNR4OgMgzEg2WzzFjc/m3tlpYcECYNReYfGk717WejOrrXPV3ajOB
        posWAH1nnBC5Z+ZQTRiEXVpaT6JDZGQPgkixPM3XRk07ssb/O6uJSVTSOBP2/yfm9SqtP8
        u003Ab9YMsYQWuPCtMaPVOSO57BmWIQVp70Qw3slukhweKb5P35fqFJ+jpSt2M2uOiVBbT
        6LCULxoSNlTWkbV8QaZqdaOutQGe8hilRioSTFDzrKAGpTxZJ0DJj+UmBGBkFw==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id AF355634C91;
        Fri, 29 Apr 2022 00:07:50 +0300 (EEST)
Date:   Fri, 29 Apr 2022 00:07:50 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 3/4] staging: media: Add support for the Allwinner A31
 ISP
Message-ID: <YmsCJicyzf+Bz98y@valkosipuli.retiisi.eu>
References: <20220415153708.637804-1-paul.kocialkowski@bootlin.com>
 <20220415153708.637804-4-paul.kocialkowski@bootlin.com>
 <YmqFQSRBsqs4ghNQ@valkosipuli.retiisi.eu>
 <Ymqk89e+mn/1kLLx@aptenodytes>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ymqk89e+mn/1kLLx@aptenodytes>
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1651180071; a=rsa-sha256;
        cv=none;
        b=v/eA8lS+Dp459dHx9/YdvegyAVAdv3h9a0Yr+jBgaydoEWsMHmpWnCANwH4q+NvNWvgBc/
        Ypsn41WgRTpTB97ijt1OUYuRhT58pZprzMZagaNYwt3BnDOyWCSa2TU1+4lRVLr/+hCncR
        hOK9x8B100L22M1i+vtllvm9sA9c10RqHn3EwUK8f2J3dVL3eun5oiB8QDr6Zv58FZLZz1
        Gpe4IJUSBMrx1R+VysazTYzvMdINCSQxIbufpslydr7/2FwHGd1brz3UT8nJYskmX8elp+
        sxauh6ytrRyWn2ixbdZR3UrmL+nI7Zhynw8gnnUNOXFXA5sey16FDWyWC4bchQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1651180071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BNdaIGfl1oTNmZ1z18jwQdqe5S5UFYhc+No0/RbEmds=;
        b=OxkxCwGcsbm/q1m2Q5iQsGZNvtjwLun+G9uMjYkxW1IaBm0CCL4+sX5F0ZzNDLRtoj5nl5
        Nrtcv7gdIGS57mAdAW58Q/wheXnwcTAcPcAcXwJL7aRhiFu7c0T9PW9mEF+2C7RBuDY+We
        c7pP3rpvO3szIXh721jhadkOuyLP+17JWKQnmdQJ3H6kQMraonrthuRqItJ+3Z0Jnp0OC/
        6R9Rw99g6KtOSO/0YM+a+26FNr0ZRMxjyDC3VvU2LTGD8PS6ltxY1y5TclbyzjhTlzvtow
        QSKnOn59GR3fDjfpu1hDdg42/9Wxfd3avqjlpBXVJauzC9JGaVB+Ly+Wq9RbhQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Thu, Apr 28, 2022 at 04:30:11PM +0200, Paul Kocialkowski wrote:
> Hi Sakari,
> 
> On Thu 28 Apr 22, 15:14, Sakari Ailus wrote:
> > Hi Paul,
> > 
> > Thanks for the set.
> > 
> > A few comments below.
> 
> Thanks a lot for your review!

You're welcome!

...

> > I understand this is an online ISP. How do you schedule the video buffer
> > queues? Say, what happens if it's time to set up buffers for a frame and
> > there's a buffer queued in the parameter queue but not in the image data
> > queue? Or the other way around?
> 
> The ISP works in a quite atypical way, with a DMA buffer that is used to
> hold upcoming parameters (including buffer addresses) and a bit in a "direct"
> register to schedule the update of the parameters at next vsync.
> 
> The update (setting the bit) is triggered whenever new parameters are
> submitted via the params video device or whenever there's a capture buffer
> available in the capture video device.
> 
> So you don't particularly need to have one parameter buffer matching a capture
> buffer, the two can be updated independently. Of course, a capture buffer will
> only be returned after another buffer becomes active.

This also means it's not possible to associate a capture buffer to a
parameter buffer by other means than timing --- which is unreliable. The
request API would allow that but it's not free of issues either.

Alternatively, I think in this case you could always require the capture
buffer and grab a parameter buffer when it's available. As ISPs are
generally requiring device specific control software, this shouldn't be a
problem really.

I wonder what Laurent thinks.

> 
> I hope this answers your concern!
> 
> [...]
> 
> > > +static int sun6i_isp_tables_setup(struct sun6i_isp_device *isp_dev)
> > > +{
> > > +	struct sun6i_isp_tables *tables = &isp_dev->tables;
> > > +	int ret;
> > > +
> > > +	/* Sizes are hardcoded for now but actually depend on the platform. */
> > 
> > Would it be cleaner to have them defined in a platform-specific way, e.g.
> > in a struct you obtain using device_get_match_data()?
> 
> Absolutely! I didn't do it at this stage since only one platform is supported
> but we could just as well introduce a variant structure already for the table
> sizes.

I think that would be nice already, especially if you know these are going
to be different. Otherwise macros could be an option.

...

> > > +	ret = v4l2_ctrl_handler_init(&v4l2->ctrl_handler, 0);
> > 
> > I suppose you intend to add controls later on?
> 
> I might be wrong but I thought this was necessary to expose sensor controls
> registered by subdevs that end up attached to this v4l2 device.
> 
> I doubt the drivers itself will expose controls otherwise.

Now that this is an MC-enabled driver, the subdev controls should be
accessed through the subdev nodes only. Adding them to the video device's
control handler is quite hackish and not guaranteed to even work (as e.g.
multiple subdevs can have the same control).

...

> > > +{
> > > +	struct sun6i_isp_device *isp_dev = video_drvdata(file);
> > > +	struct video_device *video_dev = &isp_dev->capture.video_dev;
> > > +	struct mutex *lock = &isp_dev->capture.lock;
> > > +	int ret;
> > > +
> > > +	if (mutex_lock_interruptible(lock))
> > > +		return -ERESTARTSYS;
> > > +
> > > +	ret = v4l2_pipeline_pm_get(&video_dev->entity);
> > 
> > Do you need this?
> > 
> > Drivers should primarily depend on runtime PM, this is only needed for
> > compatibility reasons. Instead I'd like to see sensor drivers being moved
> > to runtime PM.
> 
> Yes it's still needed to support sensor drivers that don't use rpm yet.

To that I suggested adding runtime PM support for the affected sensors.
This doesn't seem to get done otherwise. E.g. ipu3-cio2 driver does not
call s_power() on sensor subdevs.

...

> > > +	ret = video_register_device(video_dev, VFL_TYPE_VIDEO, -1);
> > > +	if (ret) {
> > > +		v4l2_err(v4l2_dev, "failed to register video device: %d\n",
> > > +			 ret);
> > > +		goto error_media_entity;
> > > +	}
> > > +
> > > +	v4l2_info(v4l2_dev, "device %s registered as %s\n", video_dev->name,
> > > +		  video_device_node_name(video_dev));
> > 
> > This isn't really driver specific. I'd drop it.
> 
> I agree but I see that many drivers are doing it and the information can
> actually be quite useful at times.

You can get that information using media-ctl -e 'entity name'.

I guess this could be also added to video_register_device() on debug level.

> > > +struct sun6i_isp_params_config_bdnf {
> > > +	__u8	in_dis_min; // 8
> > > +	__u8	in_dis_max; // 10
> > 
> > Are these default values or something else? Better documentation was in the
> > TODO.txt file already.
> 
> Yes that's the default register values, but these comments are and overlook on
> my side and should be removed.

I'm fine leaving these here. Just wondering. Up to you.

-- 
Kind regards,

Sakari Ailus
