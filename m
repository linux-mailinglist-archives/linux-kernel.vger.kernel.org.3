Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900875A88EE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 00:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiHaWUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 18:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiHaWU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 18:20:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3A96B669;
        Wed, 31 Aug 2022 15:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661984424; x=1693520424;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vfc7ji1iF9dB6iNGPTPIhT6lU2S7gK6PEzb1TQ4te3w=;
  b=kJw4AlXj8qGbrKisahMUr8JGhJKF4qBMK5+9nm0QFi3u4p7CmQNbLNNC
   aKZFAWMEN9ncZM14ncPeC6PUfvZSLpG9sUcrhdaZR4KTZFRaM0VZX7QMj
   OEePraZUfS2c2TH9UsLT6XRfFuv568gI5T57bCQG6526IV9Ck7nC98LMv
   gZhtgDdgzZCCmQanHIMdgnNIxLUAEyGD5EWzORkTWjemcvBJOYExuI8QM
   0Cwdu5DFwmzToxgrwhPB8u4+V9RR9RrlCqBgCbu9za2fVtEoTnQbaARaC
   gNC6vPeoyeSWBO5bFk6x6zPEdJLMYZfnnJEHYg63dTwFYFSzCjObEqLw5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="296838376"
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="296838376"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 15:20:23 -0700
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="642053857"
Received: from gkammela-mobl.amr.corp.intel.com (HELO [10.209.116.177]) ([10.209.116.177])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 15:20:22 -0700
Message-ID: <60f04869-5d68-f833-5f81-a0b79abba457@linux.intel.com>
Date:   Wed, 31 Aug 2022 15:20:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v1] platform/x86/intel: pmc/core: Add Raptor Lake support
 to pmc core driver
Content-Language: en-US
To:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Box <david.e.box@intel.com>
References: <20220830182001.3693030-1-gayatri.kammela@linux.intel.com>
 <CAE2upjQCzrFQF0B9hGMHb2LejrKJyJNNdYDjizQW2Yw=8pYMQA@mail.gmail.com>
From:   "Kammela, Gayatri" <gayatri.kammela@linux.intel.com>
In-Reply-To: <CAE2upjQCzrFQF0B9hGMHb2LejrKJyJNNdYDjizQW2Yw=8pYMQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/30/2022 4:09 PM, Rajneesh Bhardwaj wrote:
> Acked-by: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Thank you Rajneesh!
>
> On Tue, Aug 30, 2022 at 2:20 PM Gayatri Kammela
> <gayatri.kammela@linux.intel.com> wrote:
>> Add Raptor Lake client parts (both RPL and RPL_S) support to pmc core
>> driver. Raptor Lake client parts reuse all the Alder Lake PCH IPs.
>>
>> Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Cc: David Box <david.e.box@intel.com>
>> Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>
>> ---
>>   drivers/platform/x86/intel/pmc/core.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
>> index a1fe1e0dcf4a..17ec5825d13d 100644
>> --- a/drivers/platform/x86/intel/pmc/core.c
>> +++ b/drivers/platform/x86/intel/pmc/core.c
>> @@ -1914,6 +1914,8 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
>>          X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,         &tgl_reg_map),
>>          X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,           &adl_reg_map),
>>          X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &tgl_reg_map),
>> +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,          &adl_reg_map),
>> +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,        &adl_reg_map),
>>          {}
>>   };
>>
>>
>> base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
>> --
>> 2.25.1
>>
>
