Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B806A554096
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 04:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355898AbiFVChp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 22:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbiFVChn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 22:37:43 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D71831340
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 19:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655865463; x=1687401463;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=fIaPW9EydwDu0J9Dr9Y/O2l8kkF3T2/2aMlTVElF1Iw=;
  b=MDky9iUfBFfAioPH9FZEJO1E0sJwJOdXAda346u6Bc0qF+qp2v2ZFhRu
   QWUpjwOIq4gQAuoP8tHdwUz0LXWt9q7KqoSlRAngSbDTp6mEeZaz1igsd
   qY6bPDlBUl2lLRn0BYh7zGy+dhuDUP2a3SUv3LCXXdyNVNqO9p+Z1G71Y
   w7mlSHrjYcnXONABP6fwsvmSQdfXgXHKjTUArQU5VDASrMzCIFyE13oPP
   0NyT+wN/rPUz4pPMtb0Si1Rm3CqAvMWVUx8cZqQrKN6Lkt4ceWPnQXk4l
   jw5e2gGvWwojB4SFbtDlugbF9MIcjb1jcX9WXZNktTSowOSanFHNUz36B
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="260114706"
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="260114706"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 19:37:42 -0700
X-IronPort-AV: E=Sophos;i="5.92,211,1650956400"; 
   d="scan'208";a="591938680"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.173.196]) ([10.249.173.196])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 19:37:39 -0700
Subject: Re: [kbuild-all] Re: mm/madvise.c:1438:6: warning: Redundant
 assignment of 'ret' to itself. [selfAssignment]
To:     Michal Hocko <mhocko@suse.com>,
        Julia Lawall <julia.lawall@inria.fr>
Cc:     Charan Teja Kalla <quic_charante@quicinc.com>,
        kernel test robot <lkp@intel.com>,
        Minchan Kim <minchan@kernel.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <202206180617.UzO7ymnD-lkp@intel.com>
 <5ec7b561-551b-f02a-9b7b-65d05ccdabbc@quicinc.com>
 <YrCgcEGKxjN7mNu9@dhcp22.suse.cz>
 <alpine.DEB.2.22.394.2206201253480.2243@hadrien>
 <YrDHFJkwcn5Ga3yy@dhcp22.suse.cz>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <0a9d1c96-3a8d-70ee-1490-f65c1b4a6f00@intel.com>
Date:   Wed, 22 Jun 2022 10:37:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YrDHFJkwcn5Ga3yy@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/21/2022 3:14 AM, Michal Hocko wrote:
> On Mon 20-06-22 12:54:56, Julia Lawall wrote:
>>
>>
>> On Mon, 20 Jun 2022, Michal Hocko wrote:
>>
>>> On Sat 18-06-22 11:25:43, Charan Teja Kalla wrote:
>>>> Hello Andrew,
>>>>
[...]
>>>>> cppcheck warnings: (new ones prefixed by >>)
>>>>>>> mm/madvise.c:1438:6: warning: Redundant assignment of 'ret' to itself. [selfAssignment]
>>>>>      ret = (total_len - iov_iter_count(&iter)) ? : ret;
>>>>
>>>> Other way to avoid this warning is by creating another local variable
>>>> that holds the total bytes processed. Having another local variable to
>>>> get rid off some compilation warning doesn't seem proper to me. So,
>>>> leaving this warning unless you ask me to fix this.
>>>
>>> Is this a new warning? I do not see it supported by my gcc 10.x. Do we
>>
>> cppcheck is a static analysis tool.  It looks like it doesn't have a
>> proper understanding of ?:
> 
> Ohh, thanks for the clarification! I thought this was a gcc feature.
> Then I would suggest to report a bug report against the static checker
> rather than making any changes to the kernel to workaround it.
> 

Hi all,

Sorry for the inconvenience, we have added the warning to ignore list
to avoid reporting it again.

Best Regards,
Rong Chen
