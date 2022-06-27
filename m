Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167F355B753
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 07:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbiF0FEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 01:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbiF0FEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 01:04:01 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3886D60D5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 22:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656306107; x=1687842107;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=wnEGGoffUXHTptd3QB7RLIQ4tVTfa7uOXq4q8O+qUiU=;
  b=Ffq34aNujqKhh/GnEzYaaPHRXuvPGn17CM1Ez3Nfpwcl7V8qap1eQhcK
   O6dHLUbY6GbmGAu6v+S3YUQmbjA/NwmlQN1apsTf+GxIUHgzmrLSF1ipU
   mk6cVmLLr3wCJoW++AJparWTkVt272GuUSAI2qQkhNWMzUS10lTcPTPr9
   qJeoRxdUiiijuJFcWbdE3K/9JqpMmv9Ukv9CI3kkz7CImx3oMSeoz6HiD
   Ru1MfHJrvnEyRe7dXBLPWOK9Gha0PWfZmuxBe7GaNe0VDbaI2iCLvSTrQ
   QxmBm3knsOr90Qgo4c6lOoOJpIIx7D6i0/4DuxkUFoijBbRcMU20BXf7E
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="282446877"
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="282446877"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 22:01:46 -0700
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="646247486"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.30.178]) ([10.255.30.178])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 22:01:43 -0700
Subject: Re: [kbuild-all] Re: [norov:fns 7/19]
 include/linux/compiler_types.h:352:45: error: call to
 '__compiletime_assert_600' declared with attribute error: BUILD_BUG_ON
 failed: !__builtin_constant_p(res)
To:     Yury Norov <yury.norov@gmail.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <202206230121.wlBiPZcR-lkp@intel.com>
 <20220623110820.1017185-1-alexandr.lobakin@intel.com>
 <YrSccxLBlrJ3DyTx@yury-laptop>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <0b0027a2-797f-4e59-5d3c-820223075536@intel.com>
Date:   Mon, 27 Jun 2022 13:01:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YrSccxLBlrJ3DyTx@yury-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/24/2022 1:01 AM, Yury Norov wrote:
> On Thu, Jun 23, 2022 at 01:08:20PM +0200, Alexander Lobakin wrote:
>> From: kernel test robot <lkp@intel.com>
>> Date: Thu, 23 Jun 2022 01:16:29 +0800
>>
>> Hi Yury,
>>
>>> tree:   https://github.com/norov/linux fns
>>> head:   dc85542660535a9072c3b98819f4b80ff182b92a
>>> commit: 2f52f0373b1a1bcf54a4aedc202518f6bed4c74f [7/19] lib: test_bitmap: add compile-time optimization/evaluations assertions
>>> config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220623/202206230121.wlBiPZcR-lkp@intel.com/config)
>>> compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
>>> reproduce (this is a W=1 build):
>>>          # https://github.com/norov/linux/commit/2f52f0373b1a1bcf54a4aedc202518f6bed4c74f
>>>          git remote add norov https://github.com/norov/linux
>>>          git fetch --no-tags norov fns
>>>          git checkout 2f52f0373b1a1bcf54a4aedc202518f6bed4c74f
>>>          # save the config file
>>>          mkdir build_dir && cp config build_dir/.config
>>>          make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
>>
>> Can't reproduce it at all on x86_64 with the attached config, were
>> there any other changes maybe that could cause this?
> 
> This is my working branch, and it shouldn't be that loud. But
> anyways...

Hi Yury,

Sorry for the inconvenience, we'll only send reports to you privately
in future.

Best Regards,
Rong Chen

> 
> There are some patches on top of your series. This is my
> work-in-progress. If you think it's not relevant, please ignore
> this.
> 
> Thanks,
> Yury
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
