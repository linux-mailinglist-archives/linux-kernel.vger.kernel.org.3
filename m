Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870C748FFE0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 02:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236464AbiAQBQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 20:16:34 -0500
Received: from mga05.intel.com ([192.55.52.43]:21400 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233954AbiAQBQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 20:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642382193; x=1673918193;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=hoK3fTeWhCyqNmt3Ie1Ok7THuuhISXUqxwf6Q5YCOKQ=;
  b=E/i35cycFsYq3tEv8+dsFSkBWCY31gArzJ3V+y5mwvV1vtZ5dVilUwkt
   2Ix6YiYPxDts3nLhAFuxEWfi6viMb7a0LBydm0G2BVcA7swFyxJ/0N6mR
   mmBtchOkdkRvPurgPD6Ju1tJGy8+orO3D+AZaeTW1Z7P4MSnyPhKKe9wT
   QdTb+4Tkqo4QVPHktFc/KjhHYDz9zE2lw1D99LmF7O1QogL9UfEPboRit
   ZujYEV3VJpakdb4GmOjVTc5o4Xiab0+PP8Y56nYjwP6wvze6bjbi80aRt
   E6ypClONukvP9IahrWS5PQq1c+FITlusldErYzJD8Thw+l/9f8dXD/EYr
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="330879763"
X-IronPort-AV: E=Sophos;i="5.88,294,1635231600"; 
   d="scan'208";a="330879763"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 17:16:33 -0800
X-IronPort-AV: E=Sophos;i="5.88,294,1635231600"; 
   d="scan'208";a="531133039"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.175.229]) ([10.249.175.229])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2022 17:16:30 -0800
Subject: Re: [kbuild-all] Re: drivers/firmware/efi/sysfb_efi.c:190:35:
 warning: unused variable 'efifb_dmi_system_table'
To:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Herrmann <dh.herrmann@gmail.com>
References: <202201041920.mOzzco4D-lkp@intel.com>
 <f9336852-d741-5483-a6f5-3cd05b233022@infradead.org>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <3731657b-a4d6-b7e3-007d-76e70a01628a@intel.com>
Date:   Mon, 17 Jan 2022 09:16:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <f9336852-d741-5483-a6f5-3cd05b233022@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/15/2022 8:06 AM, Randy Dunlap wrote:
> Hi lkp robot,
> 
> I have a metaquestion, please:
> 
> 
> On 1/4/22 03:52, kernel test robot wrote:
>> Hi Randy,
>>
>> FYI, the error/warning still remains.
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   c9e6606c7fe92b50a02ce51dda82586ebdf99b48
>> commit: 15d27b15de965043d6f8e23bc7f34386fcd1a772 efi: sysfb_efi: fix build when EFI is not set

>>
> 
> [snip]
> 
> Why is the patch committer (David Herrmann) not cc-ed on your original email?
> (I am adding him now.)
> 
> bu I have seen this multiple times, where the TO: person (below) is not cc-ed
> on the problem email.  I don't understand.

Hi Randy,

The lkp robot sent the report to the people mentioned in the first bad
commit (15d27b15de) from bisection, the below commit (2995e50627) is
from git blame (drivers/firmware/efi/sysfb_efi.c:190), sometimes the
commits are not the same.

Best Regards,
Rong Chen

> 
>>
>> :::::: The code at line 190 was first introduced by commit
>> :::::: 2995e506276bfdc7311eb02db8b2aa1a61a4b849 x86: sysfb: move EFI quirks from efifb to sysfb
>>
>> :::::: TO: David Herrmann <dh.herrmann@gmail.com>
>> :::::: CC: H. Peter Anvin <hpa@linux.intel.com>
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> thanks.
> 
