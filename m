Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74E04E5C58
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 01:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346798AbiCXAcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 20:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344517AbiCXAcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 20:32:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E52888F1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 17:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648081876; x=1679617876;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=xlvK4DX6ylW5tjqmJMuSxdNHOtsvnGEBK1Nxs66tSrQ=;
  b=ElNNTHYP2xTbP8ThXUwFMYbytOIum3zFMTPeO1F+wR/tul+knjsMCiwo
   zdB0zjCRl91MsfbQHBxIvizwU/BXogkBFaq/x+kmyWptfo7+MN6XqT6wl
   0aCrtbCQ8zjoMLfw0JgD7woCZE2O41jhmrMja0efe9QQDJcv4pEVXeVy9
   Qjx/0GIjURO7+QpXD7KUmUnP8BErCj0OUnb3NVNdkOILSmr19STHy+37W
   PiYjq1OTEZCiTCXFZoyuBDSNW/WS/czvlwA9JNH4gQqkRC1bd+NnSE2cT
   +DxStaFObIoMwceSBVUeR6ELwd0MkGOItifonjCrxGHAoXOw4CY+/y+ah
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="258444524"
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="258444524"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 17:31:16 -0700
X-IronPort-AV: E=Sophos;i="5.90,205,1643702400"; 
   d="scan'208";a="561150781"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.174.249]) ([10.249.174.249])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 17:31:14 -0700
Subject: Re: [kbuild-all] Re: [device-mapper-dm:dm-5.19 132/132]
 drivers/md/dm.c:1542:18: error: 'result' undeclared
To:     Mike Snitzer <snitzer@redhat.com>,
        kernel test robot <lkp@intel.com>
Cc:     Mike Snitzer <snitzer@kernel.org>, kbuild-all@lists.01.org,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
References: <202203240638.crXQjFY5-lkp@intel.com>
 <YjuoF88MzBALI+l8@redhat.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <2c10ed96-4558-3438-e889-f5b9ff4cea84@intel.com>
Date:   Thu, 24 Mar 2022 08:31:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YjuoF88MzBALI+l8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/2022 7:07 AM, Mike Snitzer wrote:
> On Wed, Mar 23 2022 at  6:57P -0400,
> kernel test robot <lkp@intel.com> wrote:
> 
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git dm-5.19
>> head:   7f8ac95a6464b895e3d2b6175f7ee64a4c10fcfe
>> commit: 7f8ac95a6464b895e3d2b6175f7ee64a4c10fcfe [132/132] dm: push error handling down to __split_and_process_bio
>> config: s390-buildonly-randconfig-r005-20220323 (https://download.01.org/0day-ci/archive/20220324/202203240638.crXQjFY5-lkp@intel.com/config)
>> compiler: s390-linux-gcc (GCC) 11.2.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?id=7f8ac95a6464b895e3d2b6175f7ee64a4c10fcfe
>>          git remote add device-mapper-dm https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
>>          git fetch --no-tags device-mapper-dm dm-5.19
>>          git checkout 7f8ac95a6464b895e3d2b6175f7ee64a4c10fcfe
>>          # save the config file to linux build tree
>>          mkdir build_dir
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash drivers/md/
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     drivers/md/dm.c: In function '__process_abnormal_io':
>>>> drivers/md/dm.c:1542:18: error: 'result' undeclared (first use in this function)
>>      1542 |                 *result = BLK_STS_NOTSUPP;
>>           |                  ^~~~~~
>>     drivers/md/dm.c:1542:18: note: each undeclared identifier is reported only once for each function it appears in
>>
> 
> Yeah, I pushed this too soon, fixed now.
> 
> But why are you even testing this branch? I didn't include dm-5.19 in
> linux-next yet.

Hi Mike,

The bot picks up all branches to test, do you want it to only test few 
branches?


> 
> Given that it seems strange for the bot to just pick up some branch,
> and then spam LKML, dm-devel, etc like it found a meaningful problem.

we also support sending reports privately, do you want this way?

Best Regards,
Rong Chen

> 
> Mike
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
