Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6557C4ED9D5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbiCaMu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbiCaMuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:50:20 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0829C69
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648730911; x=1680266911;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=U2ruxUQf1EnUWQl9Jspq/DeB3V4q9a9nqLBu8xipvOI=;
  b=SdvpTlKxm1OVXMQOmK4bGLHkWVQgF/f4iSsCsTETpZBysDHY3vmIEOVU
   7PMFpGZ+Hm/oJmC2NT0P797Do6EaUcCnF4DZIrEvzZtXkvofFRkKWnUyU
   Ypx2kLGbtCdDURhIVPwWulnbO0+3lkmBk0Ys9DNGvrqsEqsFfXTCLE/hl
   Z2Jwchmsmgb32Zz9Cr+HdMTo03RBRcuoKQDFTWV/xF+n2fmLngXKe8nDg
   3HH5vAG+Ydl9SaKvy/y9h4qh4kFKTAMJsboaKERnIz/dLyE8bbac1S1i7
   8b+nvd/KAHC7yRMJwLEKeXfIxJbYh2/0k82J6fUlZRZKZXQ6eNze8TjNM
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="257407624"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="257407624"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 05:48:27 -0700
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="566453621"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.30.238]) ([10.255.30.238])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 05:48:25 -0700
Subject: Re: [kbuild-all] Re: arch/x86/kernel/cpu/mce/amd.c:552:6: warning: no
 previous prototype for 'disable_err_thresholding'
To:     Borislav Petkov <bp@suse.de>, kernel test robot <lkp@intel.com>
Cc:     Shirish S <Shirish.S@amd.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
References: <202203301632.RmI9R5aU-lkp@intel.com> <YkRLUixkF7OEICBL@zn.tnic>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <a6617c2d-5bb7-8265-d587-83104f9420d7@intel.com>
Date:   Thu, 31 Mar 2022 20:48:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YkRLUixkF7OEICBL@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/30/2022 8:21 PM, Borislav Petkov wrote:
> On Wed, Mar 30, 2022 at 04:45:25PM +0800, kernel test robot wrote:
>> Hi Shirish,
>>
>> FYI, the error/warning still remains.
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   965181d7ef7e1a863477536dc328c23a7ebc8a1d
>> commit: 30aa3d26edb0f3d7992757287eec0ca588a5c259 x86/MCE/AMD: Carve out the MC4_MISC thresholding quirk
>> date:   3 years, 2 months ago
>> config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220330/202203301632.RmI9R5aU-lkp@intel.com/config)
>> compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
>> reproduce (this is a W=1 build):
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=30aa3d26edb0f3d7992757287eec0ca588a5c259
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout 30aa3d26edb0f3d7992757287eec0ca588a5c259
>>          # save the config file to linux build tree
>>          mkdir build_dir
>>          make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/cpu/mce/ drivers/gpu/drm/i915/
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> arch/x86/kernel/cpu/mce/amd.c:552:6: warning: no previous prototype for 'disable_err_thresholding' [-Wmissing-prototypes]
>>       552 | void disable_err_thresholding(struct cpuinfo_x86 *c)
>>           |      ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> I can't trigger this with gcc-9 (Debian 9.3.0-22) 9.3.0 on that commit
> with your .config.
> 
> Please drop this.
> 

Hi Boris,

Sorry about it, something goes wrong, we'll add it to the ignore list.

Best Regards,
Rong Chen
