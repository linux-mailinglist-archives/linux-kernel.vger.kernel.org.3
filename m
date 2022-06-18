Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D28550561
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 16:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbiFROCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 10:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245318AbiFRN6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 09:58:13 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F09E0ED;
        Sat, 18 Jun 2022 06:58:05 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id i15so6075745plr.1;
        Sat, 18 Jun 2022 06:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5CAlQJNUufB+kpcq0N4hle+0i5XGq2vnYLflWk9l1FI=;
        b=KJB06d3PJ0frpQ9pDRi2KT+huyz1moZoXUBi8sLswr0CD0QZl9c9glsrsur22YIF9t
         ik27LFbiNMCXlnhDhIMYQFQHstWALWQj5TkTciHCjZvPYHSzPjUWiEopkxOYe0DDtCDS
         6ZZHyR3G8AychjSWKvrg8FIRWTlK8L2qMuNi4BtKCrNiSXFy147wgT15DkGx6mTIx+78
         lsfnO1RVE97npgpigal+mfojzCsjPqiRvONNAJ3+Ey77ssE9B4Y6rAX+sYBZ66wipwEz
         oQDRF6xUf+/Jw2RnSQUF6NdBezKAvAk0fDhdY1pU+IiVfelkkveJ5odtOGS/eV1S52QF
         j6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5CAlQJNUufB+kpcq0N4hle+0i5XGq2vnYLflWk9l1FI=;
        b=UgZhXUedzRqkRssjWF4SWI0SLsPqpQYVAs/ws2+u1hFYl0rKpWqhi/x9URRu/58qrS
         Y1xJQGdxg3pw117/8y3rf/F2/O0wbdn1Vz0QRCLj+nKp4cw+p0fUc8YRjmzZRKUNN3o7
         lvgvANOiEYBoJdD47c3xLe2pyHZxIxk7VQr18y7MOeya4SzssIVjdXR8EqU6LVliKjUn
         HdlOKcnTSG8z0Leybrbb6ySzkHS0jEOPkT8YA8SveuK4KvF/roUY+S/muaB07ntg+EzT
         phqGsHXctwmeA4mVazi0Fx4VhNEyekR/qTBNMawxSoeUGPxNXewXEts/6r4KZ501bkbN
         netQ==
X-Gm-Message-State: AJIora/llnkp53iZ+42iqicn8xPZQqriHohGHH652t9qdguJ+5tK9ch+
        IvlkXrI3H8BOcXSYf7giV1+bYUBUvoY=
X-Google-Smtp-Source: AGRyM1uBp7qRZY1pBBIoM+U/Bez2iqHB/PJijR9iVIrJWbIQ+qheyl5EkkoBV/omJQRUmQOVfzXfmg==
X-Received: by 2002:a17:90b:38c1:b0:1e8:5df7:cfd8 with SMTP id nn1-20020a17090b38c100b001e85df7cfd8mr27100551pjb.79.1655560684699;
        Sat, 18 Jun 2022 06:58:04 -0700 (PDT)
Received: from [172.30.1.37] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id p15-20020a170903248f00b00163c6ac211fsm3137672plw.111.2022.06.18.06.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jun 2022 06:58:04 -0700 (PDT)
Message-ID: <32ca5cc0-b7e0-a798-629a-9012b20de1bd@gmail.com>
Date:   Sat, 18 Jun 2022 22:57:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 3/4] PM / devfreq: Rework freq_table to be local to
 devfreq struct
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220614230950.426-1-ansuelsmth@gmail.com>
 <20220614230950.426-4-ansuelsmth@gmail.com>
 <02753520-ad02-7658-c117-a4c2febb059b@gmail.com>
 <62acd820.1c69fb81.22357.4496@mx.google.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <62acd820.1c69fb81.22357.4496@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 6. 18. 04:38, Christian Marangi wrote:
> On Sat, Jun 18, 2022 at 04:33:19AM +0900, Chanwoo Choi wrote:
>> Hi,
>>
>> Thanks for the good catch. 
>>
>>
>> I think that this patch fixes issue of commit 0ec09ac2cebe
>> ("PM / devfreq: Set the freq_table of devfreq device").
>>
> 
> Should I add this to the Fixes list?

Replace fixes commit information with commit 0ec09ac2cebe.
I'd like you to make the patch separated from this series
and then send them to linux-stable mailling list tool
because I think this patch should be maintained by linux stable patches.

> 
>> When some devfreq driver without using passive governor
>> faces on the all errors including PROBE_DEFER
>> after executing devfreq_add_device, this issue will happen.
>>
>> Also need to check the devfreq device driver using freq_table
>> which was allocated dynamically. In case of devfreq/drivers/exynos-bus.c
>> used the devfreq->profile->freq_table after devfreq_add_device.
>>
>> On 22. 6. 15. 08:09, Christian 'Ansuel' Marangi wrote:
>>> Currently we reference the freq_table to the profile defined one and we
>>> make changes on it. Devfreq never supported PROBE_DEFER before the cpu
>>> based scaling support to the passive governor and assumed that a devfreq
>>> device could only had error and be done with it.
>>> Now that a device can PROBE_DEFER a rework to the freq_table logic is
>>> required.
>>>
>>> If a device PROBE_DEFER on the GOV_START, the freq_table is already set
>>> in the device profile struct and its init is skipped. This is due to the
>>> fact that it's common for devs to declare this kind of struct static.
>>> This cause the devfreq logic to find a freq table declared (freq_table
>>> not NULL) with random data and poiting to the old addrs freed by devm.
>>  > This problem CAN be solved by devs by clearing the freq_table in their
>>> profile struct on driver exit path but it should not be trusted and it
>>> looks to use a flawed logic.
>>>
>>> A better solution is to move the freq_table and max_state to the
>>> devfreq struct and never change the profile struct.
>>> This permit to correctly handle PROBE_DEFER since the devfreq struct is
>>> reallocated and contains new values.
>>> Also the profile struct should only be used to init the driver and should
>>> not be used by the devfreq to write the freq_table if it's not provided
>>> by the driver.
>>>
>>
>> If possible, could you explain the patch description more simply?
>> Maybe, just focus on the 'freq_table' issue by device managed functions (devs).
>>
> 
> Sure!

Thanks.

> 
>>
>>> Fixes: a03dacb0316f ("PM / devfreq: Add cpu based scaling support to passive governor")
>>> Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
>>> ---
>>>  drivers/devfreq/devfreq.c          | 71 ++++++++++++++----------------
>>>  drivers/devfreq/governor_passive.c | 14 +++---
>>>  include/linux/devfreq.h            |  4 ++
>>>  3 files changed, 45 insertions(+), 44 deletions(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index 01474daf4548..2e2b3b414d67 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -123,7 +123,7 @@ void devfreq_get_freq_range(struct devfreq *devfreq,
>>>  			    unsigned long *min_freq,
>>>  			    unsigned long *max_freq)
>>>  {
>>> -	unsigned long *freq_table = devfreq->profile->freq_table;
>>> +	unsigned long *freq_table = devfreq->freq_table;
>>>  	s32 qos_min_freq, qos_max_freq;
>>>  
>>>  	lockdep_assert_held(&devfreq->lock);
>>> @@ -133,11 +133,11 @@ void devfreq_get_freq_range(struct devfreq *devfreq,
>>>  	 * The devfreq drivers can initialize this in either ascending or
>>>  	 * descending order and devfreq core supports both.
>>>  	 */
>>> -	if (freq_table[0] < freq_table[devfreq->profile->max_state - 1]) {
>>> +	if (freq_table[0] < freq_table[devfreq->max_state - 1]) {
>>>  		*min_freq = freq_table[0];
>>> -		*max_freq = freq_table[devfreq->profile->max_state - 1];
>>> +		*max_freq = freq_table[devfreq->max_state - 1];
>>>  	} else {
>>> -		*min_freq = freq_table[devfreq->profile->max_state - 1];
>>> +		*min_freq = freq_table[devfreq->max_state - 1];
>>>  		*max_freq = freq_table[0];
>>>  	}
>>>  
>>> @@ -169,8 +169,8 @@ static int devfreq_get_freq_level(struct devfreq *devfreq, unsigned long freq)
>>>  {
>>>  	int lev;
>>>  
>>> -	for (lev = 0; lev < devfreq->profile->max_state; lev++)
>>> -		if (freq == devfreq->profile->freq_table[lev])
>>> +	for (lev = 0; lev < devfreq->max_state; lev++)
>>> +		if (freq == devfreq->freq_table[lev])
>>>  			return lev;
>>>  
>>>  	return -EINVAL;
>>> @@ -178,7 +178,6 @@ static int devfreq_get_freq_level(struct devfreq *devfreq, unsigned long freq)
>>>  
>>>  static int set_freq_table(struct devfreq *devfreq)
>>>  {
>>> -	struct devfreq_dev_profile *profile = devfreq->profile;
>>>  	struct dev_pm_opp *opp;
>>>  	unsigned long freq;
>>>  	int i, count;
>>> @@ -188,25 +187,22 @@ static int set_freq_table(struct devfreq *devfreq)
>>>  	if (count <= 0)
>>>  		return -EINVAL;
>>>  
>>> -	profile->max_state = count;
>>> -	profile->freq_table = devm_kcalloc(devfreq->dev.parent,
>>> -					profile->max_state,
>>> -					sizeof(*profile->freq_table),
>>> -					GFP_KERNEL);
>>> -	if (!profile->freq_table) {
>>> -		profile->max_state = 0;
>>> +	devfreq->max_state = count;
>>> +	devfreq->freq_table = devm_kcalloc(devfreq->dev.parent,
>>> +					   devfreq->max_state,
>>> +					   sizeof(*devfreq->freq_table),
>>> +					   GFP_KERNEL);
>>> +	if (!devfreq->freq_table)
>>>  		return -ENOMEM;
>>> -	}
>>>  
>>> -	for (i = 0, freq = 0; i < profile->max_state; i++, freq++) {
>>> +	for (i = 0, freq = 0; i < devfreq->max_state; i++, freq++) {
>>>  		opp = dev_pm_opp_find_freq_ceil(devfreq->dev.parent, &freq);
>>>  		if (IS_ERR(opp)) {
>>> -			devm_kfree(devfreq->dev.parent, profile->freq_table);
>>> -			profile->max_state = 0;
>>> +			devm_kfree(devfreq->dev.parent, devfreq->freq_table);
>>>  			return PTR_ERR(opp);
>>>  		}
>>>  		dev_pm_opp_put(opp);
>>> -		profile->freq_table[i] = freq;
>>> +		devfreq->freq_table[i] = freq;
>>>  	}
>>>  
>>>  	return 0;
>>> @@ -246,7 +242,7 @@ int devfreq_update_status(struct devfreq *devfreq, unsigned long freq)
>>>  
>>>  	if (lev != prev_lev) {
>>>  		devfreq->stats.trans_table[
>>> -			(prev_lev * devfreq->profile->max_state) + lev]++;
>>> +			(prev_lev * devfreq->max_state) + lev]++;
>>>  		devfreq->stats.total_trans++;
>>>  	}
>>>  
>>> @@ -835,6 +831,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>  		if (err < 0)
>>>  			goto err_dev;
>>>  		mutex_lock(&devfreq->lock);
>>> +	} else {
>>> +		devfreq->freq_table = devfreq->profile->freq_table;
>>> +		devfreq->max_state = devfreq->profile->max_state;
>>>  	}
>>>  
>>>  	devfreq->scaling_min_freq = find_available_min_freq(devfreq);
>>> @@ -870,8 +869,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>  
>>>  	devfreq->stats.trans_table = devm_kzalloc(&devfreq->dev,
>>>  			array3_size(sizeof(unsigned int),
>>> -				    devfreq->profile->max_state,
>>> -				    devfreq->profile->max_state),
>>> +				    devfreq->max_state,
>>> +				    devfreq->max_state),
>>>  			GFP_KERNEL);
>>>  	if (!devfreq->stats.trans_table) {
>>>  		mutex_unlock(&devfreq->lock);
>>> @@ -880,7 +879,7 @@ struct devfreq *devfreq_add_device(struct device *dev,
>>>  	}
>>>  
>>>  	devfreq->stats.time_in_state = devm_kcalloc(&devfreq->dev,
>>> -			devfreq->profile->max_state,
>>> +			devfreq->max_state,
>>>  			sizeof(*devfreq->stats.time_in_state),
>>>  			GFP_KERNEL);
>>>  	if (!devfreq->stats.time_in_state) {
>>> @@ -1665,9 +1664,9 @@ static ssize_t available_frequencies_show(struct device *d,
>>>  
>>>  	mutex_lock(&df->lock);
>>>  
>>> -	for (i = 0; i < df->profile->max_state; i++)
>>> +	for (i = 0; i < df->max_state; i++)
>>>  		count += scnprintf(&buf[count], (PAGE_SIZE - count - 2),
>>> -				"%lu ", df->profile->freq_table[i]);
>>> +				"%lu ", df->freq_table[i]);
>>>  
>>>  	mutex_unlock(&df->lock);
>>>  	/* Truncate the trailing space */
>>> @@ -1690,7 +1689,7 @@ static ssize_t trans_stat_show(struct device *dev,
>>>  
>>>  	if (!df->profile)
>>>  		return -EINVAL;
>>> -	max_state = df->profile->max_state;
>>> +	max_state = df->max_state;
>>>  
>>>  	if (max_state == 0)
>>>  		return sprintf(buf, "Not Supported.\n");
>>> @@ -1707,19 +1706,17 @@ static ssize_t trans_stat_show(struct device *dev,
>>>  	len += sprintf(buf + len, "           :");
>>>  	for (i = 0; i < max_state; i++)
>>>  		len += sprintf(buf + len, "%10lu",
>>> -				df->profile->freq_table[i]);
>>> +				df->freq_table[i]);
>>>  
>>>  	len += sprintf(buf + len, "   time(ms)\n");
>>>  
>>>  	for (i = 0; i < max_state; i++) {
>>> -		if (df->profile->freq_table[i]
>>> -					== df->previous_freq) {
>>> +		if (df->freq_table[i] == df->previous_freq)
>>>  			len += sprintf(buf + len, "*");
>>> -		} else {
>>> +		else
>>>  			len += sprintf(buf + len, " ");
>>> -		}
>>> -		len += sprintf(buf + len, "%10lu:",
>>> -				df->profile->freq_table[i]);
>>> +
>>> +		len += sprintf(buf + len, "%10lu:", df->freq_table[i]);
>>>  		for (j = 0; j < max_state; j++)
>>>  			len += sprintf(buf + len, "%10u",
>>>  				df->stats.trans_table[(i * max_state) + j]);
>>> @@ -1743,7 +1740,7 @@ static ssize_t trans_stat_store(struct device *dev,
>>>  	if (!df->profile)
>>>  		return -EINVAL;
>>>  
>>> -	if (df->profile->max_state == 0)
>>> +	if (df->max_state == 0)
>>>  		return count;
>>>  
>>>  	err = kstrtoint(buf, 10, &value);
>>> @@ -1751,11 +1748,11 @@ static ssize_t trans_stat_store(struct device *dev,
>>>  		return -EINVAL;
>>>  
>>>  	mutex_lock(&df->lock);
>>> -	memset(df->stats.time_in_state, 0, (df->profile->max_state *
>>> +	memset(df->stats.time_in_state, 0, (df->max_state *
>>>  					sizeof(*df->stats.time_in_state)));
>>>  	memset(df->stats.trans_table, 0, array3_size(sizeof(unsigned int),
>>> -					df->profile->max_state,
>>> -					df->profile->max_state));
>>> +					df->max_state,
>>> +					df->max_state));
>>>  	df->stats.total_trans = 0;
>>>  	df->stats.last_update = get_jiffies_64();
>>>  	mutex_unlock(&df->lock);
>>> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
>>> index dcc9dd518197..1810966fd61d 100644
>>> --- a/drivers/devfreq/governor_passive.c
>>> +++ b/drivers/devfreq/governor_passive.c
>>> @@ -145,18 +145,18 @@ static int get_target_freq_with_devfreq(struct devfreq *devfreq,
>>>  		goto out;
>>>  
>>>  	/* Use interpolation if required opps is not available */
>>> -	for (i = 0; i < parent_devfreq->profile->max_state; i++)
>>> -		if (parent_devfreq->profile->freq_table[i] == *freq)
>>> +	for (i = 0; i < parent_devfreq->max_state; i++)
>>> +		if (parent_devfreq->freq_table[i] == *freq)
>>>  			break;
>>>  
>>> -	if (i == parent_devfreq->profile->max_state)
>>> +	if (i == parent_devfreq->max_state)
>>>  		return -EINVAL;
>>>  
>>> -	if (i < devfreq->profile->max_state) {
>>> -		child_freq = devfreq->profile->freq_table[i];
>>> +	if (i < devfreq->max_state) {
>>> +		child_freq = devfreq->freq_table[i];
>>>  	} else {
>>> -		count = devfreq->profile->max_state;
>>> -		child_freq = devfreq->profile->freq_table[count - 1];
>>> +		count = devfreq->max_state;
>>> +		child_freq = devfreq->freq_table[count - 1];
>>>  	}
>>>  
>>>  out:
>>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>>> index dc10bee75a72..770a7532655c 100644
>>> --- a/include/linux/devfreq.h
>>> +++ b/include/linux/devfreq.h
>>> @@ -185,6 +185,10 @@ struct devfreq {
>>>  	struct notifier_block nb;
>>>  	struct delayed_work work;
>>>  
>>> +	/* devfreq local freq_table */

This comment is not necessary. Please remove it.

>>> +	unsigned long *freq_table;
>>> +	unsigned int max_state;

And need to add the description of newly added variables
to 'struct devfreq' structure description.


>>> +
>>>  	unsigned long previous_freq;
>>>  	struct devfreq_dev_status last_status;
>>>  
>>
>>
>> -- 
>> Best Regards,
>> Samsung Electronics
>> Chanwoo Choi
> 


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
