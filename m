Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3F754BE08
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 01:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357377AbiFNXAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 19:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiFNXAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 19:00:52 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231C652E63;
        Tue, 14 Jun 2022 16:00:51 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id c130-20020a1c3588000000b0039c6fd897b4so180842wma.4;
        Tue, 14 Jun 2022 16:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=vJbJE6skXfdjpDBexkt9pOCoXBa0ZvUKkaoAQ2sW6PQ=;
        b=JBLaQZKUv/hKG//oIMOtGegGNRAjJP2nI9Ja+8KmrT5ShvIc8wqO+E8OHwFT8FUdra
         nYEEv4bQZG5EQSzGbvl5XTG+J8Yzx/XYqlyrQ4iW+7TwEEFcmPlCtQvFAe55WrSy6PAm
         E3v9W4Za0nXL1rFqQy4tRhqFWwDMN3HpdKl062Gpreg3rBup08J44rxATgMCIebwSyU9
         rnDLXxvxO/mjd1I1rVU3K8EyAA8r7Z7V7vgEyShYYguY9u5ODxxj4HJJiiB7PNd/ARMp
         k4dBM7IMwkZLqacIpsDsHFoiub7UCXm8EnufZ/3UT/B9MRlL0NWBtrv2rQHe8z4Ih2zL
         YCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=vJbJE6skXfdjpDBexkt9pOCoXBa0ZvUKkaoAQ2sW6PQ=;
        b=7573dwk+7UMfmwCNMhO23XMyBLheVQBJ+aauuVtpfd95q8Zde/3oDVl2T+t2tJ960v
         Nhjps2zFmcZ/1Klowg0VTsGqC1qJbH8xDwhlrLdh7/DKbiXdFdu3hhUxtYtGRVbKZUay
         L2ONQSZn6n+7zmGGQ6/7cIDJbSaDcGOTNaQAioYSfeLSZfjPboVRDFaRhlFGRvkmxc1Y
         W6f10sO/jJcb5LzkxF7fUyL9Jh53lOoTQ1V8/BAHY5s0QufS0cYYq2ZXDwXs2DkFjhhv
         xaRFcE/W4Y9fY2LSJ+748Xf53ca7HRbJrJhuVHpWsbfH7SrumruY0aisws9OF9vynt9s
         pw2A==
X-Gm-Message-State: AOAM5324re7gcsYogezeRQ/izW4pMqbJ6xlLhxfpHhNBjcqN13S6Lqk1
        VqMAmxpHiK8Gpud/pkLLX5x03WB5mMw=
X-Google-Smtp-Source: ABdhPJx381pU549Qi/yK1BvFnU3NUNEt7pDrIBvv9lGyXsP6bM1VT9t7XuN50b4O8AQZ74anslX3dQ==
X-Received: by 2002:a05:600c:348d:b0:39c:652b:5153 with SMTP id a13-20020a05600c348d00b0039c652b5153mr6587918wmq.24.1655247649368;
        Tue, 14 Jun 2022 16:00:49 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d50c7000000b0021031c894d3sm13222790wrt.94.2022.06.14.16.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 16:00:48 -0700 (PDT)
Message-ID: <62a91320.1c69fb81.7fba4.8c25@mx.google.com>
X-Google-Original-Message-ID: <YqkGi5xPks0Y4R6C@Ansuel-xps.>
Date:   Wed, 15 Jun 2022 00:07:07 +0200
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] PM / devfreq: Fix cpufreq passive unregister
 erroring on PROBE_DEFER
References: <20220614110701.31240-1-ansuelsmth@gmail.com>
 <20220614110701.31240-2-ansuelsmth@gmail.com>
 <7f00333d-40f9-34d5-fd84-54c10d7a243d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f00333d-40f9-34d5-fd84-54c10d7a243d@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 07:58:16AM +0900, Chanwoo Choi wrote:
> On 22. 6. 14. 20:06, Christian 'Ansuel' Marangi wrote:
> > With the passive governor, the cpu based scaling can PROBE_DEFER due to
> > the fact that CPU policy are not ready.
> > The cpufreq passive unregister notifier is called both from the
> > GOV_START errors and for the GOV_STOP and assume the notifier is
> > successfully registred every time. With GOV_START failing it's wrong to
> > loop over each possible CPU since the register path has failed for
> > some CPU policy not ready. Change the logic and unregister the notifer
> > based on the current allocated parent_cpu_data list to correctly handle
> > errors and the governor unregister path.
> > 
> > Fixes: a03dacb0316f ("PM / devfreq: Add cpu based scaling support to passive governor")
> > Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/devfreq/governor_passive.c | 23 ++++++-----------------
> >  1 file changed, 6 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> > index 72c67979ebe1..0188c32f5198 100644
> > --- a/drivers/devfreq/governor_passive.c
> > +++ b/drivers/devfreq/governor_passive.c
> > @@ -222,8 +222,8 @@ static int cpufreq_passive_unregister_notifier(struct devfreq *devfreq)
> >  {
> >  	struct devfreq_passive_data *p_data
> >  			= (struct devfreq_passive_data *)devfreq->data;
> > -	struct devfreq_cpu_data *parent_cpu_data;
> > -	int cpu, ret = 0;
> > +	struct devfreq_cpu_data *parent_cpu_data, *tmp;
> > +	int ret;
> >  
> >  	if (p_data->nb.notifier_call) {
> >  		ret = cpufreq_unregister_notifier(&p_data->nb,
> > @@ -232,27 +232,16 @@ static int cpufreq_passive_unregister_notifier(struct devfreq *devfreq)
> >  			return ret;
> >  	}
> >  
> > -	for_each_possible_cpu(cpu) {
> > -		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> > -		if (!policy) {
> > -			ret = -EINVAL;
> > -			continue;
> > -		}
> > -
> > -		parent_cpu_data = get_parent_cpu_data(p_data, policy);
> > -		if (!parent_cpu_data) {
> > -			cpufreq_cpu_put(policy);
> > -			continue;
> > -		}
> > -
> > +	list_for_each_entry_safe(parent_cpu_data, tmp, &p_data->cpu_data_list, node) {
> >  		list_del(&parent_cpu_data->node);
> > +
> >  		if (parent_cpu_data->opp_table)
> >  			dev_pm_opp_put_opp_table(parent_cpu_data->opp_table);
> > +
> >  		kfree(parent_cpu_data);
> > -		cpufreq_cpu_put(policy);
> >  	}
> 
> I agree this patch. Just, I'd like to make the separate function
> to handle the removing of parent_cpu_data.
> 
> Please add new delete_parent_cpu_data() function under get_parent_cpu_data()
> implementation and then call delete_parent_cpu_data()
> in cpufreq_passive_unregister_notifier().
>

Ok just to make sure I understand this correctly.
A dedicated function with just the list_for_each_entry_safe function
correct?

> >  
> > -	return ret;
> > +	return 0;
> >  }
> >  
> >  static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
> 
> 
> -- 
> Best Regards,
> Samsung Electronics
> Chanwoo Choi

-- 
	Ansuel
