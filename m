Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA4354FDC6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 21:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242202AbiFQTiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 15:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237459AbiFQTiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 15:38:12 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EAF2B1A8;
        Fri, 17 Jun 2022 12:38:11 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o37-20020a05600c512500b0039c4ba4c64dso4837173wms.2;
        Fri, 17 Jun 2022 12:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=dqyWkwE3Rn4LVgqovyGpHRDiydwTAyP8mdXE/UxlCvs=;
        b=ATk+zBNATYCoJw0MRkPoDb9uAH4W/SFp8HcItRa2TP7rTMwjmY2LDtovgtFq35YB3F
         PtashNPjjjFRpgF7f0DWTRdaijkgyPdR7WBz3m961Hw1NgtpZd/MoFRssg/lU2/lSgDJ
         shmU1uDLQ/9eWkVsUfPwM+NBI2RIvTpG0HvTZuR3J/3VrBlgFk9DwufcpYOoLFno8gAG
         1NVB+VffhW1lBKeIW6rOemdlBOyw1eOmRg/Jygjmuqow09Y1NdPUXhXvGxcqJWwnWyqP
         uqdqtmbeqEK8xYDMACQbBm3BZVrNJ767Zzn2Iu7YVohS4wyhx+uxg1OiQUUJ5j6B01wu
         oxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=dqyWkwE3Rn4LVgqovyGpHRDiydwTAyP8mdXE/UxlCvs=;
        b=78wrclJXu7aPJFOpah9x8aoK66RNk0NBbCKjJUiCwwIoAQt5I59qcTo/cHM2uNXnK/
         ZC4/Z76s7OQAJVOBF6pmmgzSlRQN/3GRfs6RZsDURe57yXkBBEdopUSU/puzYkwX4AqP
         rvZTskSzF3MDCg2dRfaFc6Rzct2qwSoVIvz+SM72zYhXPTtsQex6Zewq0ZR7KfkCysi5
         2W7D+yP+nWwJhchEB19ZYOG4wA5XhI4dhXKcuLSh0hdu4pIpDN49THRCokLVqNSkE6WQ
         /I1/pnzL8SI8Wl+EkCs0OZ/CvnVdUoGGPtEn1DZylzdS9vWVl1yDtILKYvRdGKDyUwK1
         teMA==
X-Gm-Message-State: AOAM533Xmqccy5rzWP9ooMhM+LDhoO0jlxgNLKw1kKj2orLawNzDsxdC
        EKukXE9LaiBpLenug2dTo0jmhuYsWEA=
X-Google-Smtp-Source: ABdhPJz56+SffL5YhYvHnTqhix2r0qQKUUTvYeQD4u4f7QVPGW13Xd+l3pBOQYxYqjHTb0U9vGaycw==
X-Received: by 2002:a05:600c:4f95:b0:39c:9897:5290 with SMTP id n21-20020a05600c4f9500b0039c98975290mr22476435wmq.149.1655494689143;
        Fri, 17 Jun 2022 12:38:09 -0700 (PDT)
Received: from Ansuel-xps. (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b0039751bb8c62sm10530739wmq.24.2022.06.17.12.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 12:38:08 -0700 (PDT)
Message-ID: <62acd820.1c69fb81.22357.4496@mx.google.com>
X-Google-Original-Message-ID: <YqzYHlSJbTMspk0r@Ansuel-xps.>
Date:   Fri, 17 Jun 2022 21:38:06 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] PM / devfreq: Rework freq_table to be local to
 devfreq struct
References: <20220614230950.426-1-ansuelsmth@gmail.com>
 <20220614230950.426-4-ansuelsmth@gmail.com>
 <02753520-ad02-7658-c117-a4c2febb059b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02753520-ad02-7658-c117-a4c2febb059b@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 18, 2022 at 04:33:19AM +0900, Chanwoo Choi wrote:
> Hi,
> 
> Thanks for the good catch. 
> 
> 
> I think that this patch fixes issue of commit 0ec09ac2cebe
> ("PM / devfreq: Set the freq_table of devfreq device").
>

Should I add this to the Fixes list?

> When some devfreq driver without using passive governor
> faces on the all errors including PROBE_DEFER
> after executing devfreq_add_device, this issue will happen.
> 
> Also need to check the devfreq device driver using freq_table
> which was allocated dynamically. In case of devfreq/drivers/exynos-bus.c
> used the devfreq->profile->freq_table after devfreq_add_device.
> 
> On 22. 6. 15. 08:09, Christian 'Ansuel' Marangi wrote:
> > Currently we reference the freq_table to the profile defined one and we
> > make changes on it. Devfreq never supported PROBE_DEFER before the cpu
> > based scaling support to the passive governor and assumed that a devfreq
> > device could only had error and be done with it.
> > Now that a device can PROBE_DEFER a rework to the freq_table logic is
> > required.
> > 
> > If a device PROBE_DEFER on the GOV_START, the freq_table is already set
> > in the device profile struct and its init is skipped. This is due to the
> > fact that it's common for devs to declare this kind of struct static.
> > This cause the devfreq logic to find a freq table declared (freq_table
> > not NULL) with random data and poiting to the old addrs freed by devm.
>  > This problem CAN be solved by devs by clearing the freq_table in their
> > profile struct on driver exit path but it should not be trusted and it
> > looks to use a flawed logic.
> > 
> > A better solution is to move the freq_table and max_state to the
> > devfreq struct and never change the profile struct.
> > This permit to correctly handle PROBE_DEFER since the devfreq struct is
> > reallocated and contains new values.
> > Also the profile struct should only be used to init the driver and should
> > not be used by the devfreq to write the freq_table if it's not provided
> > by the driver.
> > 
> 
> If possible, could you explain the patch description more simply?
> Maybe, just focus on the 'freq_table' issue by device managed functions (devs).
>

Sure!

> 
> > Fixes: a03dacb0316f ("PM / devfreq: Add cpu based scaling support to passive governor")
> > Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/devfreq/devfreq.c          | 71 ++++++++++++++----------------
> >  drivers/devfreq/governor_passive.c | 14 +++---
> >  include/linux/devfreq.h            |  4 ++
> >  3 files changed, 45 insertions(+), 44 deletions(-)
> > 
> > diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> > index 01474daf4548..2e2b3b414d67 100644
> > --- a/drivers/devfreq/devfreq.c
> > +++ b/drivers/devfreq/devfreq.c
> > @@ -123,7 +123,7 @@ void devfreq_get_freq_range(struct devfreq *devfreq,
> >  			    unsigned long *min_freq,
> >  			    unsigned long *max_freq)
> >  {
> > -	unsigned long *freq_table = devfreq->profile->freq_table;
> > +	unsigned long *freq_table = devfreq->freq_table;
> >  	s32 qos_min_freq, qos_max_freq;
> >  
> >  	lockdep_assert_held(&devfreq->lock);
> > @@ -133,11 +133,11 @@ void devfreq_get_freq_range(struct devfreq *devfreq,
> >  	 * The devfreq drivers can initialize this in either ascending or
> >  	 * descending order and devfreq core supports both.
> >  	 */
> > -	if (freq_table[0] < freq_table[devfreq->profile->max_state - 1]) {
> > +	if (freq_table[0] < freq_table[devfreq->max_state - 1]) {
> >  		*min_freq = freq_table[0];
> > -		*max_freq = freq_table[devfreq->profile->max_state - 1];
> > +		*max_freq = freq_table[devfreq->max_state - 1];
> >  	} else {
> > -		*min_freq = freq_table[devfreq->profile->max_state - 1];
> > +		*min_freq = freq_table[devfreq->max_state - 1];
> >  		*max_freq = freq_table[0];
> >  	}
> >  
> > @@ -169,8 +169,8 @@ static int devfreq_get_freq_level(struct devfreq *devfreq, unsigned long freq)
> >  {
> >  	int lev;
> >  
> > -	for (lev = 0; lev < devfreq->profile->max_state; lev++)
> > -		if (freq == devfreq->profile->freq_table[lev])
> > +	for (lev = 0; lev < devfreq->max_state; lev++)
> > +		if (freq == devfreq->freq_table[lev])
> >  			return lev;
> >  
> >  	return -EINVAL;
> > @@ -178,7 +178,6 @@ static int devfreq_get_freq_level(struct devfreq *devfreq, unsigned long freq)
> >  
> >  static int set_freq_table(struct devfreq *devfreq)
> >  {
> > -	struct devfreq_dev_profile *profile = devfreq->profile;
> >  	struct dev_pm_opp *opp;
> >  	unsigned long freq;
> >  	int i, count;
> > @@ -188,25 +187,22 @@ static int set_freq_table(struct devfreq *devfreq)
> >  	if (count <= 0)
> >  		return -EINVAL;
> >  
> > -	profile->max_state = count;
> > -	profile->freq_table = devm_kcalloc(devfreq->dev.parent,
> > -					profile->max_state,
> > -					sizeof(*profile->freq_table),
> > -					GFP_KERNEL);
> > -	if (!profile->freq_table) {
> > -		profile->max_state = 0;
> > +	devfreq->max_state = count;
> > +	devfreq->freq_table = devm_kcalloc(devfreq->dev.parent,
> > +					   devfreq->max_state,
> > +					   sizeof(*devfreq->freq_table),
> > +					   GFP_KERNEL);
> > +	if (!devfreq->freq_table)
> >  		return -ENOMEM;
> > -	}
> >  
> > -	for (i = 0, freq = 0; i < profile->max_state; i++, freq++) {
> > +	for (i = 0, freq = 0; i < devfreq->max_state; i++, freq++) {
> >  		opp = dev_pm_opp_find_freq_ceil(devfreq->dev.parent, &freq);
> >  		if (IS_ERR(opp)) {
> > -			devm_kfree(devfreq->dev.parent, profile->freq_table);
> > -			profile->max_state = 0;
> > +			devm_kfree(devfreq->dev.parent, devfreq->freq_table);
> >  			return PTR_ERR(opp);
> >  		}
> >  		dev_pm_opp_put(opp);
> > -		profile->freq_table[i] = freq;
> > +		devfreq->freq_table[i] = freq;
> >  	}
> >  
> >  	return 0;
> > @@ -246,7 +242,7 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
> >  
> >  	if (lev != prev_lev) {
> >  		devfreq->stats.trans_table[
> > -			(prev_lev * devfreq->profile->max_state) + lev]++;
> > +			(prev_lev * devfreq->max_state) + lev]++;
> >  		devfreq->stats.total_trans++;
> >  	}
> >  
> > @@ -835,6 +831,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
> >  		if (err < 0)
> >  			goto err_dev;
> >  		mutex_lock(&devfreq->lock);
> > +	} else {
> > +		devfreq->freq_table = devfreq->profile->freq_table;
> > +		devfreq->max_state = devfreq->profile->max_state;
> >  	}
> >  
> >  	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
> > @@ -870,8 +869,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
> >  
> >  	devfreq->stats.trans_table = devm_kzalloc(&devfreq->dev,
> >  			array3_size(sizeof(unsigned int),
> > -				    devfreq->profile->max_state,
> > -				    devfreq->profile->max_state),
> > +				    devfreq->max_state,
> > +				    devfreq->max_state),
> >  			GFP_KERNEL);
> >  	if (!devfreq->stats.trans_table) {
> >  		mutex_unlock(&devfreq->lock);
> > @@ -880,7 +879,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
> >  	}
> >  
> >  	devfreq->stats.time_in_state = devm_kcalloc(&devfreq->dev,
> > -			devfreq->profile->max_state,
> > +			devfreq->max_state,
> >  			sizeof(*devfreq->stats.time_in_state),
> >  			GFP_KERNEL);
> >  	if (!devfreq->stats.time_in_state) {
> > @@ -1665,9 +1664,9 @@ static ssize_t available_frequencies_show(struct device *d,
> >  
> >  	mutex_lock(&df->lock);
> >  
> > -	for (i = 0; i < df->profile->max_state; i++)
> > +	for (i = 0; i < df->max_state; i++)
> >  		count += scnprintf(&buf[count], (PAGE_SIZE - count - 2),
> > -				"%lu ", df->profile->freq_table[i]);
> > +				"%lu ", df->freq_table[i]);
> >  
> >  	mutex_unlock(&df->lock);
> >  	/* Truncate the trailing space */
> > @@ -1690,7 +1689,7 @@ static ssize_t trans_stat_show(struct device *dev,
> >  
> >  	if (!df->profile)
> >  		return -EINVAL;
> > -	max_state = df->profile->max_state;
> > +	max_state = df->max_state;
> >  
> >  	if (max_state == 0)
> >  		return sprintf(buf, "Not Supported.\n");
> > @@ -1707,19 +1706,17 @@ static ssize_t trans_stat_show(struct device *dev,
> >  	len += sprintf(buf + len, "           :");
> >  	for (i = 0; i < max_state; i++)
> >  		len += sprintf(buf + len, "%10lu",
> > -				df->profile->freq_table[i]);
> > +				df->freq_table[i]);
> >  
> >  	len += sprintf(buf + len, "   time(ms)\n");
> >  
> >  	for (i = 0; i < max_state; i++) {
> > -		if (df->profile->freq_table[i]
> > -					== df->previous_freq) {
> > +		if (df->freq_table[i] == df->previous_freq)
> >  			len += sprintf(buf + len, "*");
> > -		} else {
> > +		else
> >  			len += sprintf(buf + len, " ");
> > -		}
> > -		len += sprintf(buf + len, "%10lu:",
> > -				df->profile->freq_table[i]);
> > +
> > +		len += sprintf(buf + len, "%10lu:", df->freq_table[i]);
> >  		for (j = 0; j < max_state; j++)
> >  			len += sprintf(buf + len, "%10u",
> >  				df->stats.trans_table[(i * max_state) + j]);
> > @@ -1743,7 +1740,7 @@ static ssize_t trans_stat_store(struct device *dev,
> >  	if (!df->profile)
> >  		return -EINVAL;
> >  
> > -	if (df->profile->max_state == 0)
> > +	if (df->max_state == 0)
> >  		return count;
> >  
> >  	err = kstrtoint(buf, 10, &value);
> > @@ -1751,11 +1748,11 @@ static ssize_t trans_stat_store(struct device *dev,
> >  		return -EINVAL;
> >  
> >  	mutex_lock(&df->lock);
> > -	memset(df->stats.time_in_state, 0, (df->profile->max_state *
> > +	memset(df->stats.time_in_state, 0, (df->max_state *
> >  					sizeof(*df->stats.time_in_state)));
> >  	memset(df->stats.trans_table, 0, array3_size(sizeof(unsigned int),
> > -					df->profile->max_state,
> > -					df->profile->max_state));
> > +					df->max_state,
> > +					df->max_state));
> >  	df->stats.total_trans = 0;
> >  	df->stats.last_update = get_jiffies_64();
> >  	mutex_unlock(&df->lock);
> > diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
> > index dcc9dd518197..1810966fd61d 100644
> > --- a/drivers/devfreq/governor_passive.c
> > +++ b/drivers/devfreq/governor_passive.c
> > @@ -145,18 +145,18 @@ static int get_target_freq_with_devfreq(struct devfreq *devfreq,
> >  		goto out;
> >  
> >  	/* Use interpolation if required opps is not available */
> > -	for (i = 0; i < parent_devfreq->profile->max_state; i++)
> > -		if (parent_devfreq->profile->freq_table[i] == *freq)
> > +	for (i = 0; i < parent_devfreq->max_state; i++)
> > +		if (parent_devfreq->freq_table[i] == *freq)
> >  			break;
> >  
> > -	if (i == parent_devfreq->profile->max_state)
> > +	if (i == parent_devfreq->max_state)
> >  		return -EINVAL;
> >  
> > -	if (i < devfreq->profile->max_state) {
> > -		child_freq = devfreq->profile->freq_table[i];
> > +	if (i < devfreq->max_state) {
> > +		child_freq = devfreq->freq_table[i];
> >  	} else {
> > -		count = devfreq->profile->max_state;
> > -		child_freq = devfreq->profile->freq_table[count - 1];
> > +		count = devfreq->max_state;
> > +		child_freq = devfreq->freq_table[count - 1];
> >  	}
> >  
> >  out:
> > diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> > index dc10bee75a72..770a7532655c 100644
> > --- a/include/linux/devfreq.h
> > +++ b/include/linux/devfreq.h
> > @@ -185,6 +185,10 @@ struct devfreq {
> >  	struct notifier_block nb;
> >  	struct delayed_work work;
> >  
> > +	/* devfreq local freq_table */
> > +	unsigned long *freq_table;
> > +	unsigned int max_state;
> > +
> >  	unsigned long previous_freq;
> >  	struct devfreq_dev_status last_status;
> >  
> 
> 
> -- 
> Best Regards,
> Samsung Electronics
> Chanwoo Choi

-- 
	Ansuel
