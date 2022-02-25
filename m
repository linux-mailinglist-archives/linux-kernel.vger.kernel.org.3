Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F44A4C45D3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241088AbiBYNS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbiBYNSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:18:53 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE761CF0A6;
        Fri, 25 Feb 2022 05:18:16 -0800 (PST)
Received: from hillosipuli.retiisi.eu (dkvn5pty0gzs3nltj987t-3.rev.dnainternet.fi [IPv6:2001:14ba:4457:9640:1e2d:1f75:a607:ef37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 922BC1B0004B;
        Fri, 25 Feb 2022 15:18:11 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1645795091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gQL3lJTAk3YtI0VvJzj1nN5q4+4iHZhkRQtY8Rg5EXQ=;
        b=j67P1uJCWcjbrCk9L6TAP4pZoda8RtJ9zxg4X1y9UtD4YQW88Ikp9P/mBfQwcjLJUN7V8A
        o3GXXh5G9Qoc6IcvEnPRwOP75j5Ba30vLs3qc5YctMuvTKzgKrKggRob3Wg2QIqpbOVs6D
        hO6I+KrwRhzD376gPUmnqr9cvBmkxM+j+89XDyKOHbzFzeXZEmgrZ1iKQY8i0aEkG005CD
        Z1Ol0a8Z/rUbKJQ11pkoIlpp+tsdOJpPSJ84CDq+LEbpEZRlZS7ipIE3OlkvlYCHvlBX8D
        LYTgL7ypMKFG/jjF8lkxyqeZeIV8VzsUGx/qgrrVIi1wpw+JwNM6tze/9flPrg==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 5BF5B634C90;
        Fri, 25 Feb 2022 15:18:10 +0200 (EET)
Date:   Fri, 25 Feb 2022 15:18:10 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v7 2/2] Driver for ON Semi AR0521 camera sensor
Message-ID: <YhjXEvtPlOv/jH4n@valkosipuli.retiisi.eu>
References: <m3czl9eylt.fsf@t19.piap.pl>
 <m34k6leyb1.fsf@t19.piap.pl>
 <20220109153439.bfnfigocaeeeghmp@uno.localdomain>
 <m35yp387n4.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <m35yp387n4.fsf@t19.piap.pl>
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1645795091; a=rsa-sha256;
        cv=none;
        b=vjgP/AeYybEzuLQZdgwt7d4o9rjt+v1wTpFtVx9aWhdA2dfouLcEOoN7M2S8jzJbtwC2Oq
        DxccSFwAitVYYt9DXycjN/J6P81ClwgiB7d1aIgP1xUrISOhtEofj6k1KP6Dgb9cz3MAcL
        kNc8ujE9mENGqPC+pZ9HyDXu3I5o33yznQEhdNO82lFVc1tSuJpLnWJoDkZ5rfjCR301p/
        yXNmN0Z9fAeqV4V1Sa1g+692gx+lkdJKsy2MsHk1FGCO7P8rfjULTjbY6aMAgPqmWoz/RW
        ThdLlY/duHH9z/bYCvl8ah0MunC6vvpe5UAEpv/MRYZA27V/ZWZ/m5Kv11IP4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1645795091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gQL3lJTAk3YtI0VvJzj1nN5q4+4iHZhkRQtY8Rg5EXQ=;
        b=Bbpv6y82yujcWT3KMtsp8/Z3s9Lg4FGLJwzQg//WP4hiRQObln/kbafLVg+DJV0rMmpGwe
        9MwWIQusavjqlzENTb8y5vFqXdMPa5246iPLf1r+aPJHuvZrvX5khI1+nuRGFZt0KjlBBp
        YKBJ1SGOoWKV4V49urItF+b+HwBfA/82RAb8wMNUuslSdkq0dkQN0QkixUxGX65KprkilY
        VMjs20nGJyd5FrDsKGeupm7W9Bykg+YP5/m+Ih+kTLdIFqsUSlZdriLRLd8F4MGi0TmXOc
        CjdwuN8hSnmz4ZU4SrQEo3vL88Hi/1KLFmKa5Rk/F/C30Pp4EKPDWIaSBBe1LA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krysztof,

On Fri, Feb 25, 2022 at 01:15:11PM +0100, Krzysztof Hałasa wrote:
> Hi Jacopo,
> 
> Sorry it took that long. Unfortunately I no longer have much time to
> work on this, thus the delays.
> 
> Jacopo Mondi <jacopo@jmondi.org> writes:
> 
> >> +static int ar0521_s_ctrl(struct v4l2_ctrl *ctrl)
> >> +{
> >> +	struct v4l2_subdev *sd = ctrl_to_sd(ctrl);
> >> +	struct ar0521_dev *sensor = to_ar0521_dev(sd);
> >> +	int ret;
> >> +
> >> +	/* v4l2_ctrl_lock() locks our own mutex */
> >> +
> >> +	dev_dbg(&sensor->i2c_client->dev, "%s(0x%X)\n", __func__, ctrl->id);
> >> +
> >> +	switch (ctrl->id) {
> >> +	case V4L2_CID_HBLANK:
> >> +	case V4L2_CID_VBLANK:
> >> +		sensor->total_width = sensor->fmt.width +
> >> +			sensor->ctrls.hblank->val;
> >> +		sensor->total_height = sensor->fmt.width +
> >> +			sensor->ctrls.vblank->val;
> >> +		break;
> >> +	default:
> >> +		ret = -EINVAL;
> >> +		break;
> >> +	}
> >> +
> >> +	// access the sensor only if it's powered up

/* This is the preferred comment style */

> >> +	if (!pm_runtime_get_if_in_use(&sensor->i2c_client->dev))
> >
> > As you correctly do not access the chip's registers if it's powered
> > off, you have to call __v4l2_ctrl_handler_setup() at power on time to
> > make sure controls are actually set.
> 
> These registers are also written in ar0521_set_stream(), isn't it
> enough?
> 
> >> +	ctrls->hblank = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_HBLANK,
> >> +					  AR0521_WIDTH_BLANKING_MIN, 4094, 1,
> >> +					  AR0521_WIDTH_BLANKING_MIN);
> >> +	ctrls->vblank = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_VBLANK,
> >> +					  AR0521_HEIGHT_BLANKING_MIN, 4094, 2,
> >> +					  AR0521_HEIGHT_BLANKING_MIN);
> >> +	v4l2_ctrl_cluster(2, &ctrls->hblank);
> >
> > Is it intended to have vblank and hblank as cluster, can't they change
> > independently ?
> 
> They can. It appears, though, that clusters aren't about controls which
> can't change independently. Both of the two are written to the hardware
> at the same time, which appears to be a valid reason to combine them
> into a cluster.
> This is similar to the gain/balance controls, and BTW the use of
> clusters there was suggested by you.
> 
> Please correct me if I'm wrong.
> 
> >> +	/* Read-only */
> >> +	ctrls->pixrate = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_PIXEL_RATE,
> >> +					   AR0521_PIXEL_CLOCK_MIN,
> >> +					   AR0521_PIXEL_CLOCK_MAX, 1,
> >> +					   AR0521_PIXEL_CLOCK_RATE);
> >
> > so you have to mark it as read-only
> 
> Oh, I'd be happy for this control to be R/W. Unfortunately the core
> media core enforces R/O. This is only a comment about what the core code
> does, currently at least.
> 
> >> +	dev_dbg(dev, "%s()\n", __func__);
> >
> > Rather useless, please drop. Same for all other debug functions that
> > just print the current function name in other parts of the driver.
> > While maybe useful when developing, they're mostly noise for users
> > imo.
> 
> Fine, will drop the rest of the debug. In fact, I already dropped the
> most useful parts (I2C register access debugging).
> 
> >> +	endpoint = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev), 0, 0,
> >> +						   FWNODE_GRAPH_ENDPOINT_NEXT);
> >
> > The drivers supports a single endpoint right ? Then
> > fwnode_graph_get_next_enpoint() can be used
> 
> Well, I originally used
> fwnode_graph_get_next_endpoint(of_fwnode_handle(dev->of_node), NULL).
> Sakari suggested I should use the above
> fwnode_graph_get_endpoint_by_id().
> It could be a good idea to agree on this. Not sure about the difference.

The OF folks have shunned to the use of the iterative varants as that can
often lead to complicated parsing of the endpoints. As obtaining the
endpoint based on port and endpoint IDs works well in all cases I've
suggested people to use that. But as the backend, at least currently, uses
iterative functions, they're unlikely to disappear in the future.

> 
> >> +	for (cnt = 0; cnt < ARRAY_SIZE(ar0521_supply_names); cnt++) {
> >> +		struct regulator *supply = devm_regulator_get(dev,
> >> +						ar0521_supply_names[cnt]);
> >> +
> >> +		if (IS_ERR(supply)) {
> >> +			dev_info(dev, "no %s regulator found: %li\n",
> >> +				 ar0521_supply_names[cnt], PTR_ERR(supply));
> >> +			return PTR_ERR(supply);
> >> +		}
> >> +		sensor->supplies[cnt] = supply;
> >> +	}
> >
> > Using the regulator bulk api would simplify this.
> > See drivers/media/i2c/ccs/ccs-core.c
> 
> The bulk API doesn't allow for delays between individual supplies, does it?
> The delays are mandated by the manufacturer.

If that is the case, then you can't use the bulk API.

That also requires the board to be wired in such a way that these
regulators have no other users.

> 
> >> +
> >> +	mutex_init(&sensor->lock);
> >> +
> >> +	ret = ar0521_init_controls(sensor);
> >> +	if (ret)
> >> +		goto entity_cleanup;
> >> +
> >> +	ar0521_adj_fmt(&sensor->fmt);
> >
> > Called already here above.
> 
> Right, I will remove the first one.
> 
> >> +	ret = v4l2_async_register_subdev(&sensor->sd);
> >> +	if (ret)
> >> +		goto free_ctrls;
> >> +
> >> +	/* Turn on the device and enable runtime PM */
> >> +	ret = ar0521_power_on(&client->dev);
> >> +	if (ret)
> >> +		goto disable;
> >
> > Does the device stay powered all the time ?
> 
> Depends on the hw, but the power could be disabled, yes.
> 
> > Doesn't your resume callback call power_on() already ?
> 
> It does, when the PM is enabled.
> 
> Should the above code be changed?

I think you'll need pm_runtime_idle() call after enabling runtime PM.

> 
> >> +static struct i2c_driver ar0521_i2c_driver = {
> >> +	.driver = {
> >> +		.name  = "ar0521",
> >> +		.pm = &ar0521_pm_ops,
> >> +		.of_match_table	= ar0521_dt_ids,
> >> +	},
> >> +	.probe    = ar0521_probe,
> >
> > You could use probe_new and drop the "const struct i2c_device_id *id"
> > argument to probe()
> 
> You are right again.
> 
> That said, I wonder if it would be better (like easier) to have this
> driver added to the staging area instead.

-- 
Regard,s

Sakari Ailus
