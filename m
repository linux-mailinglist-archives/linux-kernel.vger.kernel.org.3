Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235A6549F24
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiFMUbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351417AbiFMUa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:30:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3901D10F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655148093; x=1686684093;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pVQTfp5IU2YdV+5jfNxCHCOaYYaOvPBvgBMV8BSutKI=;
  b=k0sxJENowsNkKMkbUjmUO8CtSRDypwV5Zd0jWr8vClhr8GdwPBCFpVH2
   hpZtp+ZGjIwXjvpWdq3l7iaQS1ZI/2PBJ0t4KHkoOvbEVict+i3MFw6+J
   JVGHltfHPAY7k6aSgn3JD3GD17ZdPpZ17iyxSgn/fr6cOyuN4FgZyyTJC
   iRMSnumf07l8hzyPOht/tcTxAhGEQl6uOiwXjrP5FmPXtGOyxsvW5L7jy
   40bqOue+G8+f7x+YOyQr4sYHrgdABgeuO9XLQZ4hp2Fnoaa1XrIux+FTe
   ddxdUPWf9jw8Xy+LNcHRC8HMk+sfhlzMb/oIWRZxutRV98UjcUyVqJQUL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="340058361"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="340058361"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 12:21:32 -0700
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="726419999"
Received: from kyogendr-mobl.amr.corp.intel.com (HELO [10.212.95.68]) ([10.212.95.68])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 12:21:31 -0700
Message-ID: <15ef4ec4-14ae-27fc-919d-b0933454455f@linux.intel.com>
Date:   Mon, 13 Jun 2022 14:21:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] soundwire: intel: uniquify debug message
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org, vinod.koul@linaro.org, tiwai@suse.de,
        linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, sanyog.r.kale@intel.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        bard.liao@intel.com
References: <20220610023537.27223-1-yung-chuan.liao@linux.intel.com>
 <20220610023537.27223-2-yung-chuan.liao@linux.intel.com>
 <YqLVwqx9/Pos8T06@kroah.com>
 <b86e6cbd-3488-a239-d765-cf01bf0d4f70@linux.intel.com>
 <YqRCKtLGYlRQQ+DU@kroah.com>
 <7328fbb2-06af-99c8-5e7f-9d22f8c4e4f6@linux.intel.com>
 <YqdyErIYYk85NV41@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <YqdyErIYYk85NV41@kroah.com>
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


>>>>>> @@ -1549,8 +1549,8 @@ static int __maybe_unused intel_pm_prepare(struct device *dev)
>>>>>>  	int ret;
>>>>>>  
>>>>>>  	if (bus->prop.hw_disabled || !sdw->startup_done) {
>>>>>> -		dev_dbg(dev, "SoundWire master %d is disabled or not-started, ignoring\n",
>>>>>> -			bus->link_id);
>>>>>> +		dev_dbg(dev, "%s: SoundWire master %d is disabled or not-started, ignoring\n",
>>>>>> +			__func__, bus->link_id);
>>>>>
>>>>> Not needed, it is provided automatically if you ask the kernel for this.
>>>>> Same for all other instances in this patch.
>>>>
>>>> provided how? Your comment is a bit cryptic here.
>>>
>>> the dynamic debug code in the kernel already adds the function name
>>> where the message was sent from, if you want to know this in userspace.
>>> Please read the documentation for details (I think the key is the 'f'
>>> flag to be enabled in userspace).
>>>
>>> So adding __func__ to dev_dbg() calls are redundant and never needed.
>>
>> Oh wow, I had no idea - and I am not the only one :-)
>>
>> Here's what I get with a grep on the kernel code
>>
>> git grep __func__ | grep dev_dbg | wc -l
>>
>> 3122
>>
>>
>> Doing this for sound/ gives me 356, and that's for single-line logs only.
>>
>> There's clearly something that was missed by tons of people.
> 
> Yes, it's not commonly known so cleanups are always welcome.  Perhaps
> some of those usages predate the feature being added as well.

Yep, looks like no one in our team knew about this. We've changed our
scripts and I started cleaning this up, changes will be posted upstream
soon.

https://github.com/thesofproject/linux/pull/3695

This patch will be reverted in our tree, completely unnecessary indeed.
