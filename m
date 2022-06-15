Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5949454C585
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244049AbiFOKKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbiFOKKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:10:50 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60F239816;
        Wed, 15 Jun 2022 03:10:49 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id y19so22200634ejq.6;
        Wed, 15 Jun 2022 03:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=jrcxqBgeBMFGKSHBxhc/jF2djg5DMvwK3R7ae1/jdEE=;
        b=Bb5loLhs9dHlLWivn3H13vmj48GcNUF3s/Qhw4UyARMy4O4zFdtlrwZWENoL0mBex+
         a7sbgWxYL2JthL9pSsGc6kUdMEktREzyR3DEJzT0YLQ3fpzGySDLS64YVViU8avECten
         gaYTL07Rx8rcES0WteDJUxQW8diATe61Z71x30CuVv2fAaRjkQGG/LaNDnwLWejzHH1b
         ULu5Sb++qVF1jasirLtBZ0t1zzbsIV346AnaYdlU5hg5WyMwi4oduj/tBpH1FNbp85/9
         lppRoufWmWbv6+qnYV+IlmlKeUEdGdUef9MXOi7CAwO+XNe7lIWQIrdH6fGpYm+4vP5Z
         1oHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=jrcxqBgeBMFGKSHBxhc/jF2djg5DMvwK3R7ae1/jdEE=;
        b=d10bYdOgOVACbnIBnVndOvHooBO913ewNiLsbrUIzZ15RTYoyL4aI9ZfD/BCMuk1K4
         igh7m5fqpfxxiv7d3609gGGdTT8/6tTYUztBZlLy2PDJGpHlbJe8/QLP46JD8ShZugh8
         JmHzXpN+HhoDuGKpnkb6eS13zjE64fKN2w99w0Vf/hmHvc7JNyNyPXUVGif+DDUsHNN0
         4vP/clXueq4z1CaOMvMJrtCFzq5TL1MAtbc8E+q2rW3QMZTIQReTDliX+cUC+y06QwnJ
         FwNBIs+TVKvZLM4SZU4wGAJRKNzn1I1WHbkw3bAkpKmGO0fkJtw9O5ufO2CFO5ztezXg
         oWGw==
X-Gm-Message-State: AJIora8N5q9xiq9BclGzA0YfxwYDDIXwfU5dMctn2txBCnaXaVZ+zxLf
        MRs25xIpnvEQ2TwMsTHPMhI=
X-Google-Smtp-Source: ABdhPJysFg7dsulhlBTO2ydYJy4jLt+SJK6uYoJbhEQTvHNo2JeBBcdw98e2Ab2y/j2r5Ku4bg6A+A==
X-Received: by 2002:a17:907:2d92:b0:711:d229:4b7f with SMTP id gt18-20020a1709072d9200b00711d2294b7fmr8189816ejc.506.1655287848026;
        Wed, 15 Jun 2022 03:10:48 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id q8-20020a056402518800b0042dd022787esm9175399edd.6.2022.06.15.03.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 03:10:47 -0700 (PDT)
Message-ID: <62a9b027.1c69fb81.5ae2b.4f85@mx.google.com>
X-Google-Original-Message-ID: <Yqmk4Qv9KeT1T0ko@Ansuel-xps.>
Date:   Wed, 15 Jun 2022 11:22:41 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] PM / devfreq: Mute warning on governor PROBE_DEFER
References: <20220614230950.426-1-ansuelsmth@gmail.com>
 <20220614230950.426-5-ansuelsmth@gmail.com>
 <8dd8bfa2-0843-269b-2d55-e3cbdbf6a5e1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dd8bfa2-0843-269b-2d55-e3cbdbf6a5e1@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 03:56:31PM +0900, Chanwoo Choi wrote:
> On 22. 6. 15. 08:09, Christian 'Ansuel' Marangi wrote:
> > Don't print warning when a governor PROBE_DEFER as it's not a real
> > GOV_START fail.
> > 
> > Fixes: a03dacb0316f ("PM / devfreq: Add cpu based scaling support to passive governor")
> > Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/devfreq/devfreq.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index 2e2b3b414d67..6a39638ed064 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -931,8 +931,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
> >  	err = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_START,
> >  						NULL);
> >  	if (err) {
> > -		dev_err(dev, "%s: Unable to start governor for the device\n",
> > -			__func__);
> > +		dev_err_probe(dev, err,
> > +			      "%s: Unable to start governor for the device\n",
> > +			      __func__);
> >  		goto err_init;
> >  	}
> >  	create_sysfs_files(devfreq, devfreq->governor);
> 
> 
> In order to keep the left-align with above error log
> when try_then_request_governor() is failed,
> I recommend to use the tab without space indentation as following:
> 
> If you have no objection, I'll merge this change.
> 

Sure, good for me. Anyway I wonder if we can relax the hard limit for 80
for error print since we now can use 100, but your choice.

> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 01474daf4548..80a1235ef8fb 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -932,8 +932,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
>         err = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_START,
>                                                 NULL);
>         if (err) {
> -               dev_err(dev, "%s: Unable to start governor for the device\n",
> -                       __func__);
> +               dev_err_probe(dev, err,
> +                       "%s: Unable to start governor for the device\n",
> +                        __func__);
>                 goto err_init;
>         }
>         create_sysfs_files(devfreq, devfreq->governor);
> 
> 
> 
> 
> 
> -- 
> Best Regards,
> Samsung Electronics
> Chanwoo Choi

-- 
	Ansuel
