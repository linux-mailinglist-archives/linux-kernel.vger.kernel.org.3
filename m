Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A2952DEDF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244956AbiESVAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbiESVA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:00:26 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65C5ED706
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:00:23 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id a23so7589946ljd.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jJ5ibJyWgXSEVtzkRw4+wBg9lBfLq6hkUK/PMQO4gu8=;
        b=ruiqItQaoeqAgrJoFFwJ/UR0y1kFMIA4/jFsRXtqkA/UzGJaMIfiqZww1gW8BwBhDH
         YCKHxoyVRuF9CHRNB+qAziSMUqD1JEltX2KQSlMDQ3e2jtR76Fy82aBCGjVPyYNwrNdy
         MwkftIr89LES3mjhfPw3qBR5l1hKK/aFssC1kLYJXCAhOEKBQ7tKPPGtZXaZPQF+qSqO
         sGQR18LNpEO8xu3tNL0RObIImk83UlGl22zjMHmHJyWtdDQ96jgEPvaSJWzrBRB9qp6d
         GiC7oCQuLDj+64B6mFx3acaFfU/xQj3yzdoeThqgPcd5bLhllXm45BzTQF47BEdR/i29
         JB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jJ5ibJyWgXSEVtzkRw4+wBg9lBfLq6hkUK/PMQO4gu8=;
        b=OMQbjT+oTaFpMwui581UNbWyN7qoCKWkEhUbukie6fxZs6wXZ2qSsnp4iDq8MQfMWW
         k65EHO60zFtB643PrhhK8glRBciuuotF89ULJcWCrmAejtsyf1takyVsg02CnDEWM80B
         j3lIFJKIFu14/gNlE6R+DCec4YHgbgFtKRMGqtqDs3b6y4dZtoy7U7o/yER9STRUEyre
         KRxbNCcTdeh6V5GNA/ulmpExmphyMzzlDh55I+/OmaMVk3hI2dHfyr1YXJ9AlPecnA8u
         jKlkp3AmnxO8SKS7xDys+bMeJMA+dwfPMlr+EV4s12GjV5wP8WHMadq1goLZr6DcCkCS
         i0Cw==
X-Gm-Message-State: AOAM531mnDqSCtge2yq1CdsQpWE01mDJdSfrvkEPXZVRrShRot1I9WgB
        4aJlGrN46A+QmihL1KH+LZVq6ykgxg77eg==
X-Google-Smtp-Source: ABdhPJz8OynJaFv5FD/dGoBy3yUXY/Dc5t8MtNwMt5B41FEmq0MCX+2wnuKUQ8pm5p1f9Ytf7jiVsQ==
X-Received: by 2002:a2e:a445:0:b0:24a:c1ba:b62f with SMTP id v5-20020a2ea445000000b0024ac1bab62fmr3744675ljn.81.1652994021950;
        Thu, 19 May 2022 14:00:21 -0700 (PDT)
Received: from localhost (h-85-24-188-65.A463.priv.bahnhof.se. [85.24.188.65])
        by smtp.gmail.com with ESMTPSA id x12-20020a19f60c000000b00477c619f47fsm363543lfe.92.2022.05.19.14.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 14:00:21 -0700 (PDT)
Date:   Thu, 19 May 2022 23:00:20 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Michael Rodin <mrodin@de.adit-jv.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, michael@rodin.online,
        erosca@de.adit-jv.com
Subject: Re: [PATCH 3/3] rcar-vin: handle transfer errors from subdevices and
 stop streaming if required
Message-ID: <Yoav5KjnbIlpkR6c@oden.dyn.berto.se>
References: <1652983210-1194-1-git-send-email-mrodin@de.adit-jv.com>
 <1652983210-1194-4-git-send-email-mrodin@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1652983210-1194-4-git-send-email-mrodin@de.adit-jv.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Thanks for your work.

I like this patch, I think it captures the issue discussed in the 
previous thread quiet nicely. One small nit below.

On 2022-05-19 20:00:09 +0200, Michael Rodin wrote:
> When a subdevice sends a transfer error event during streaming and we can
> not capture new frames, then we know for sure that this is an unrecoverable
> failure and not just a temporary glitch. In this case we can not ignore the
> transfer error any more and have to notify userspace. In response to the
> transfer error event userspace can try to restart streaming and hope that
> it works again.
> 
> This patch is based on the patch [1] from Niklas Söderlund, however it adds
> more logic to check whether the VIN hardware module is actually affected by
> the transfer errors reported by the usptream device. For this it takes some
> ideas from the imx driver where EOF interrupts are monitored by the
> eof_timeout_timer added by commit 4a34ec8e470c ("[media] media: imx: Add
> CSI subdev driver").
> 
> [1] https://lore.kernel.org/linux-renesas-soc/20211108160220.767586-4-niklas.soderlund+renesas@ragnatech.se/
> 
> Signed-off-by: Michael Rodin <mrodin@de.adit-jv.com>
> ---
>  drivers/media/platform/renesas/rcar-vin/rcar-dma.c | 34 ++++++++++++++++++++++
>  .../media/platform/renesas/rcar-vin/rcar-v4l2.c    | 18 +++++++++++-
>  drivers/media/platform/renesas/rcar-vin/rcar-vin.h |  7 +++++
>  3 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/renesas/rcar-vin/rcar-dma.c b/drivers/media/platform/renesas/rcar-vin/rcar-dma.c
> index 2272f1c..596a367 100644
> --- a/drivers/media/platform/renesas/rcar-vin/rcar-dma.c
> +++ b/drivers/media/platform/renesas/rcar-vin/rcar-dma.c
> @@ -13,6 +13,7 @@
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/pm_runtime.h>
> +#include <media/v4l2-event.h>
>  
>  #include <media/videobuf2-dma-contig.h>
>  
> @@ -1060,6 +1061,9 @@ static irqreturn_t rvin_irq(int irq, void *data)
>  		vin_dbg(vin, "Dropping frame %u\n", vin->sequence);
>  	}
>  
> +	cancel_delayed_work(&vin->frame_timeout);
> +	schedule_delayed_work(&vin->frame_timeout, msecs_to_jiffies(FRAME_TIMEOUT_MS));
> +
>  	vin->sequence++;
>  
>  	/* Prepare for next frame */
> @@ -1283,6 +1287,7 @@ int rvin_start_streaming(struct rvin_dev *vin)
>  	spin_lock_irqsave(&vin->qlock, flags);
>  
>  	vin->sequence = 0;
> +	vin->xfer_error = false;
>  
>  	ret = rvin_capture_start(vin);
>  	if (ret)
> @@ -1290,6 +1295,10 @@ int rvin_start_streaming(struct rvin_dev *vin)
>  
>  	spin_unlock_irqrestore(&vin->qlock, flags);
>  
> +	/* We start the frame watchdog only after we have successfully started streaming */
> +	if (!ret)
> +		schedule_delayed_work(&vin->frame_timeout, msecs_to_jiffies(FRAME_TIMEOUT_MS));
> +
>  	return ret;
>  }
>  
> @@ -1332,6 +1341,12 @@ void rvin_stop_streaming(struct rvin_dev *vin)
>  	}
>  
>  	vin->state = STOPPING;
> +	/*
> +	 * Since we are now stopping and don't expect more frames to be captured, make sure that
> +	 * there is no pending work for error handling.
> +	 */
> +	cancel_delayed_work_sync(&vin->frame_timeout);
> +	vin->xfer_error = false;

Do we need to set xfer_error to false here? The delayed work is canceled 
and we reset the xfer_error when we start in rvin_start_streaming().

>  
>  	/* Wait until only scratch buffer is used, max 3 interrupts. */
>  	retries = 0;
> @@ -1424,6 +1439,23 @@ void rvin_dma_unregister(struct rvin_dev *vin)
>  	v4l2_device_unregister(&vin->v4l2_dev);
>  }
>  
> +static void rvin_frame_timeout(struct work_struct *work)
> +{
> +	struct delayed_work *dwork = to_delayed_work(work);
> +	struct rvin_dev *vin = container_of(dwork, struct rvin_dev, frame_timeout);
> +	struct v4l2_event event = {
> +		.type = V4L2_EVENT_XFER_ERROR,
> +	};
> +
> +	vin_dbg(vin, "Frame timeout!\n");
> +
> +	if (!vin->xfer_error)
> +		return;
> +	vin_err(vin, "Unrecoverable transfer error detected, stopping streaming\n");
> +	vb2_queue_error(&vin->queue);
> +	v4l2_event_queue(&vin->vdev, &event);
> +}
> +
>  int rvin_dma_register(struct rvin_dev *vin, int irq)
>  {
>  	struct vb2_queue *q = &vin->queue;
> @@ -1470,6 +1502,8 @@ int rvin_dma_register(struct rvin_dev *vin, int irq)
>  		goto error;
>  	}
>  
> +	INIT_DELAYED_WORK(&vin->frame_timeout, rvin_frame_timeout);
> +
>  	return 0;
>  error:
>  	rvin_dma_unregister(vin);
> diff --git a/drivers/media/platform/renesas/rcar-vin/rcar-v4l2.c b/drivers/media/platform/renesas/rcar-vin/rcar-v4l2.c
> index 2e2aa9d..bd7f6fe2 100644
> --- a/drivers/media/platform/renesas/rcar-vin/rcar-v4l2.c
> +++ b/drivers/media/platform/renesas/rcar-vin/rcar-v4l2.c
> @@ -648,6 +648,8 @@ static int rvin_subscribe_event(struct v4l2_fh *fh,
>  	switch (sub->type) {
>  	case V4L2_EVENT_SOURCE_CHANGE:
>  		return v4l2_event_subscribe(fh, sub, 4, NULL);
> +	case V4L2_EVENT_XFER_ERROR:
> +		return v4l2_event_subscribe(fh, sub, 1, NULL);
>  	}
>  	return v4l2_ctrl_subscribe_event(fh, sub);
>  }
> @@ -1000,9 +1002,23 @@ void rvin_v4l2_unregister(struct rvin_dev *vin)
>  static void rvin_notify_video_device(struct rvin_dev *vin,
>  				     unsigned int notification, void *arg)
>  {
> +	const struct v4l2_event *event;
> +
>  	switch (notification) {
>  	case V4L2_DEVICE_NOTIFY_EVENT:
> -		v4l2_event_queue(&vin->vdev, arg);
> +		event = arg;
> +
> +		switch (event->type) {
> +		case V4L2_EVENT_XFER_ERROR:
> +			if (vin->state != STOPPED && vin->state != STOPPING) {
> +				vin_dbg(vin, "Subdevice signaled transfer error.\n");
> +				vin->xfer_error = true;
> +			}
> +			break;
> +		default:
> +			break;
> +		}
> +
>  		break;
>  	default:
>  		break;
> diff --git a/drivers/media/platform/renesas/rcar-vin/rcar-vin.h b/drivers/media/platform/renesas/rcar-vin/rcar-vin.h
> index 1f94589..4726a69 100644
> --- a/drivers/media/platform/renesas/rcar-vin/rcar-vin.h
> +++ b/drivers/media/platform/renesas/rcar-vin/rcar-vin.h
> @@ -31,6 +31,9 @@
>  /* Max number on VIN instances that can be in a system */
>  #define RCAR_VIN_NUM 32
>  
> +/* maximum time we wait before signalling an error to userspace */
> +#define FRAME_TIMEOUT_MS 1000
> +
>  struct rvin_group;
>  
>  enum model_id {
> @@ -207,6 +210,8 @@ struct rvin_info {
>   * @std:		active video standard of the video source
>   *
>   * @alpha:		Alpha component to fill in for supported pixel formats
> + * @xfer_error:		Indicates if any transfer errors occurred in the current streaming session.
> + * @frame_timeout:	Watchdog for monitoring regular capturing of frames in rvin_irq.
>   */
>  struct rvin_dev {
>  	struct device *dev;
> @@ -251,6 +256,8 @@ struct rvin_dev {
>  	v4l2_std_id std;
>  
>  	unsigned int alpha;
> +	bool xfer_error;
> +	struct delayed_work frame_timeout;
>  };
>  
>  #define vin_to_source(vin)		((vin)->parallel.subdev)
> -- 
> 2.7.4
> 

-- 
Kind Regards,
Niklas Söderlund
