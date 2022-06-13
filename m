Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED9D548B8D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243709AbiFMPZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 11:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357517AbiFMPXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 11:23:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E099162131
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 05:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655124539; x=1686660539;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F+Z/xKS8IJ6c8oqyWurA8RR/4fHWWhqaKxllGYROtwo=;
  b=ffeRtebDGvIawMNiIpBE77FlmSkEKfvVx1c06BMgF4/j7V7geS75DB9P
   q8gjBvrk62Gw6Esta9FKV8ztGHI46iPMZjXc4IL2mJVWLr+b6XVOEEaTV
   6fM5FYJdAtODK+hMxRY64rnhuRyqOdGpU3hAd+soLldP+nJu8N1G1Tpw6
   vTWFWNW9yNF14xwPmQZMYci8cxiYP3LZ0Az1bU9qDdw8ImpYYYVdqWY1B
   nmqB2ZajV3tVacIiCrZLzzGKOjQyP+FfSSX/wgKWMCaR7Jce9T4TJvQOn
   7+yN8IbpxXplwqjHY6ROVQiiDtF8PtUNeB/d6XNqxANiR9x6UAvb3TpKa
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="342242573"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="342242573"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 05:48:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="910369101"
Received: from tchuynh1-mobl1.amr.corp.intel.com (HELO [10.212.112.176]) ([10.212.112.176])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 05:48:33 -0700
Message-ID: <7328fbb2-06af-99c8-5e7f-9d22f8c4e4f6@linux.intel.com>
Date:   Mon, 13 Jun 2022 07:48:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] soundwire: intel: uniquify debug message
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        sanyog.r.kale@intel.com, bard.liao@intel.com
References: <20220610023537.27223-1-yung-chuan.liao@linux.intel.com>
 <20220610023537.27223-2-yung-chuan.liao@linux.intel.com>
 <YqLVwqx9/Pos8T06@kroah.com>
 <b86e6cbd-3488-a239-d765-cf01bf0d4f70@linux.intel.com>
 <YqRCKtLGYlRQQ+DU@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <YqRCKtLGYlRQQ+DU@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>>>> diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
>>>> index 505c5ef061e3..808e2f320052 100644
>>>> --- a/drivers/soundwire/intel.c
>>>> +++ b/drivers/soundwire/intel.c
>>>> @@ -1328,8 +1328,8 @@ int intel_link_startup(struct auxiliary_device *auxdev)
>>>>  
>>>>  	if (bus->prop.hw_disabled) {
>>>>  		dev_info(dev,
>>>> -			 "SoundWire master %d is disabled, ignoring\n",
>>>> -			 sdw->instance);
>>>> +			 "%s: SoundWire master %d is disabled, ignoring\n",
>>>> +			 __func__, sdw->instance);
>>>
>>> This is not a debug message, please make it such if you want to have
>>> __func__  And even then, it's not needed as you can get that from the
>>> kernel automatically.
>>
>> Sorry, I don't understand the feedback at all.
> 
> dev_info() is not a way to send debug messages.
> 
> If you want this to be only for debugging, use dev_dbg().  And when you
> use that, you get the __func__ location for free in the output already
> if you want that.
> 
>> This message was added precisely to figure out why the expected
>> programming sequence was not followed, only to discover that we have
>> devices with spurious PCI wakes handled below. Without this added
>> difference with __func__, we wouldn't know if the issue happened during
>> the expected/regular programming sequence or not.
> 
> Perhaps make the text unique then?  Why would an informational message
> need a function name.  Drivers should be quiet when all is going well.
> If something is not going well, dev_info() is not the kernel log level
> to be sending something out at.

This is not a debug message - unlike all the others. The BIOS and/or the
user may disable a specific link and it's useful to know.

The intent of __func__ was precisely to make the text unique across all
cases where we test for hw_disabled, but you have a point that this
specific info message should be clearer. The text was actually already
different from the 'disable or not-started' cases, I might have done one
too many edits in this file. Will fix.

>>>>  		return 0;
>>>>  	}
>>>>  
>>>> @@ -1489,8 +1489,8 @@ int intel_link_process_wakeen_event(struct auxiliary_device *auxdev)
>>>>  	bus = &sdw->cdns.bus;
>>>>  
>>>>  	if (bus->prop.hw_disabled || !sdw->startup_done) {
>>>> -		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
>>>> -			bus->link_id);
>>>> +		dev_dbg(dev, "%s: SoundWire master %d is disabled or not-started, ignoring\n",
>>>> +			__func__, bus->link_id);
>>>>  		return 0;
>>>>  	}
>>>>  
>>>> @@ -1549,8 +1549,8 @@ static int __maybe_unused intel_pm_prepare(struct device *dev)
>>>>  	int ret;
>>>>  
>>>>  	if (bus->prop.hw_disabled || !sdw->startup_done) {
>>>> -		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
>>>> -			bus->link_id);
>>>> +		dev_dbg(dev, "%s: SoundWire master %d is disabled or not-started, ignoring\n",
>>>> +			__func__, bus->link_id);
>>>
>>> Not needed, it is provided automatically if you ask the kernel for this.
>>> Same for all other instances in this patch.
>>
>> provided how? Your comment is a bit cryptic here.
> 
> the dynamic debug code in the kernel already adds the function name
> where the message was sent from, if you want to know this in userspace.
> Please read the documentation for details (I think the key is the 'f'
> flag to be enabled in userspace).
> 
> So adding __func__ to dev_dbg() calls are redundant and never needed.

Oh wow, I had no idea - and I am not the only one :-)

Here's what I get with a grep on the kernel code

git grep __func__ | grep dev_dbg | wc -l

3122


Doing this for sound/ gives me 356, and that's for single-line logs only.

There's clearly something that was missed by tons of people.

We use an 'sof-dyndbg.conf' file that we provide to users and our CI to
log what's needed for SOF debug, it's trivial to add a +f option.

options foo dyndbg=+pf

Thanks for the feedback, much appreciated.
-Pierre

