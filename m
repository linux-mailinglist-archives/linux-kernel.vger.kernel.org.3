Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FFB543E2A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 23:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbiFHVEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 17:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234873AbiFHVEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 17:04:37 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955B12271B7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 14:04:33 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id a2so28927804lfg.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 14:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3og44WXkQ15rtspRUHybs2AJ6uWnEPTknKE2/uTVFhk=;
        b=c9xQrWqUh3Y4y7wrrShTgfIjJfpd+ZpKRWC1HqYB9YTGBsndvDvQ9cfoHXRsCTr7fg
         DpZTYZrXWeOQVFKT1Oj+a+8fWZuO+gj894/2qkaeh6Mh0Mg/nqsl+KeZonNzjx+kciDI
         3OvoDonBlGyAnUfyd+0ej7hSwrjhsacmDpywsibtSC4TegswuwuHhPJVRY9fBGTcRqLn
         dq/GIqfb6FFtkTPV3w6HPstioV4BsjXoFFCDgZgesBgZKuey3gwQBzp9QVilvmjolP85
         Qys9ZClOx5k/vtufUzMJe6/Qr8oPJiVJ+yUIGFoWlmA/6DbBzLTKtQ5AXawsuVpWaRCh
         Yv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3og44WXkQ15rtspRUHybs2AJ6uWnEPTknKE2/uTVFhk=;
        b=l8K7ZGOPXM87YdaMAcincwxb3KhZPajzismeD5mQ0RiMPvLPIezC/usqnHTqEZ0Fdv
         ew0JgK1d6EzlnI4Oe5McvAtdyQwVs/Nne0i6dmc6UeqgcJtFSfdBcneQlsI7GjNsIqHW
         nyK0Dzhf9PDeEgTXEUemhZgYeyvv4E4Gk/NL27aKXplr5qoXM7i66CRTsUHPmTZnB31Z
         Vrj57kSzJhboIrBFWCxhGl6q5WMxuKV9h4xYCh23WWPRmN9+Q1IZsS3Q7sXBi7JSaNQW
         OgRpgn6vwlS72rvEyiYuzfziobPz7hmzmlVSauKWmN78yripgGxiNOZ570SPdFNgP2Dw
         KlDQ==
X-Gm-Message-State: AOAM531J7CsdoQ1LdI4Odl75KttDCDSs0yvK1oXtnzukDW/1y3kP6Ut8
        T9RShicRjuV6dsw1kFI0bzCmAQ==
X-Google-Smtp-Source: ABdhPJznMyIMvmIa9+UbNg9WB1mTMChsKt3TSYKKErioRbkh5g61JmjB1k+SFRhuuel2BnXY69ASYQ==
X-Received: by 2002:a05:6512:1504:b0:478:d3a1:11 with SMTP id bq4-20020a056512150400b00478d3a10011mr23059178lfb.622.1654722271860;
        Wed, 08 Jun 2022 14:04:31 -0700 (PDT)
Received: from localhost (h-85-24-188-65.A463.priv.bahnhof.se. [85.24.188.65])
        by smtp.gmail.com with ESMTPSA id x36-20020a0565123fa400b004744bfd620fsm3864284lfa.236.2022.06.08.14.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 14:04:31 -0700 (PDT)
Date:   Wed, 8 Jun 2022 23:04:31 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Michael Rodin <mrodin@de.adit-jv.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, michael@rodin.online,
        erosca@de.adit-jv.com
Subject: Re: [PATCH 3/3] rcar-vin: handle transfer errors from subdevices and
 stop streaming if required
Message-ID: <YqEO3/KekkZhVjW+@oden.dyn.berto.se>
References: <1652983210-1194-1-git-send-email-mrodin@de.adit-jv.com>
 <1652983210-1194-4-git-send-email-mrodin@de.adit-jv.com>
 <Yoav5KjnbIlpkR6c@oden.dyn.berto.se>
 <20220520195041.GA18056@vmlxhi-121.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220520195041.GA18056@vmlxhi-121.adit-jv.com>
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

On 2022-05-20 21:50:41 +0200, Michael Rodin wrote:

[snip]

> > 
> > Do we need to set xfer_error to false here? The delayed work is canceled 
> > and we reset the xfer_error when we start in rvin_start_streaming().
> > 
> 
> You are right, this seems to be redundant. But I think that there might be
> a different case where we have to reset xfer_error:
> 
>  1. A non-critical transfer error has occurred during streaming from a
>     HDMI source.
>  2. Frames are still captured for an hour without any further problems,
>     since it was just a short glitch
>  3. Now the source (e.g. HDMI signal generator) has been powered off by the
>     user so it does not send new frames.
>  4. Timeout occurs due to 3 but since xfer_error has been set 1 hour ago,
>     userspace is notified about a transfer error and assumes that streaming
>     has been stopped because of this.
> 
> To avoid this scenario I think maybe we have to restrict validity of
> xfer_error. Maybe it would be better to make xfer_error a counter which is
> set after a transfer error to e.g. 10 frames and then decremented after
> each captured frame so after 10 successfully captured frames we know that a
> timeout has occurred definitely not due to a transfer error?
> 
> Another possible improvement might be to make FRAME_TIMEOUT_MS configurable,
> maybe via a v4l2 control from userspace? Or we could also define the timeout
> as a multiple of the frame interval of the source. This would allow us to
> reduce the timeout further based on the particular source so the userspace
> does not have to wait for a second until it knows that it has to restart
> streaming.
> 
> What do you think?

I discussed this problem last week at a conference and the consensus was 
that this problem of timeouts and the like should in the first hand be 
handled in user-space. The reason being that there might be use-cases 
that are better dealt with there.

If the monitor thread is is strictly needed for some reason in kernel 
thread it should likely be moved to the V4L2 core as all drivers would 
then be able to use it instead of deeding on slightly different 
implementations in each driver.

So I fear we are back to only try to signal xfer errors in the driver 
and then leave it to either user-space or some new V4L2 code to help 
monitoring.

Sorry for only understanding this so late in the review, it took some 
time for me to understand it but once explained to me it made sens.

-- 
Kind Regards,
Niklas Söderlund
