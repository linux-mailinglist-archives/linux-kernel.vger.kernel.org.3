Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7CB4E73F5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 14:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359252AbiCYNJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 09:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345586AbiCYNJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 09:09:15 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC7BCC511
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 06:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648213659; x=1679749659;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=fzVMhp7e/Ge3em6NSiINd7rvzyurVsbQFQAPqNNDaAE=;
  b=ldLc6K5J0eZUOxw9khXb+y1KmmerH0BlHBrIuQrzJfkgdNkavZ2nqtwN
   xGqNG4FQfl1Sl/87q7o8F5ZtQQWudyeFNmii1H7ulAOMRUkDAL/JAqzD5
   lq+zaBgglKEFlo9jyS1un5BKXl8fgYWHgo/SmUfzDdBlVRlGvp3PHFuJp
   RGMlK5i97DGnMOMSBOOKYEAle0onHYGl2Yi3nV8Y6FLC2DGlH0Dp2gp0f
   tG+utWf7i9+yPyx4plZA5xxoTGee2nusL8KkRp4kL5PusZszyyA80Xir6
   ifNj1TcjG49ua2cVuMf9h7z6i7+3OjECqwSYdWX7FTmgjV/25Hdb3J697
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="283499976"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="283499976"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 06:07:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="561830808"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.29.177]) ([10.255.29.177])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 06:07:37 -0700
Subject: Re: [tip:sched/core] BUILD SUCCESS
 3387ce4d8a5f2956fab827edf499fe6780e83faa
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        kernel test robot <lkp@intel.com>, x86-ml <x86@kernel.org>,
        linux-kernel@vger.kernel.org
References: <6238fde0.Qe5umewxqwiDe2GE%lkp@intel.com>
 <YjkHkb7joeu5GCto@dev-arch.thelio-3990X>
 <24dd031a-8ea7-5f01-4d80-3fb30d212c8a@intel.com>
 <20220324175801.GJ8939@worktop.programming.kicks-ass.net>
 <2d37183b-e0d5-dd37-11c7-9b0e415daaf4@intel.com>
 <20220325115446.GP8939@worktop.programming.kicks-ass.net>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <513584ee-5247-fae1-4e5b-02f270d139f9@intel.com>
Date:   Fri, 25 Mar 2022 21:07:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220325115446.GP8939@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/25/2022 7:54 PM, Peter Zijlstra wrote:
> On Fri, Mar 25, 2022 at 06:45:24PM +0800, Chen, Rong A wrote:
> 
>>> Oh *PLEASE* never report a branch as building if there's errors.
>>> It could be I (force) push a branch multiple times before I get any
>>> 0day reports back (0day has gotten *soooo* slow) so I only ever look at
>>> the latest report -- possibly days later.
>>
>> Hi Peter,
>>
>> Sorry for the bad experience, I'm not sure the meaning of "a branch as
>> building", is there a way to know the branch is not ready, or we can
>> postpone the test for a branch by a day?
> 
> I was just commenting in general; never send a mail with "SUCCESS" in
> the subject (as per this thread) when there are errors/warns with it,
> supressed or otherwise.
> 
> If you do want to supress warnings (I'm not sure why; a few more emails
> in my inbox really aren't going to make a difference) then please state
> so explicitly with a link to the email with the report.
> 
> The thing I worry about is that I often wait for a SUCCESS mail from
> 0day robot before I push code to tip. If the SUCCESS is unreliable, this
> is not good.
> 

Hi Peter,

Thanks for your advice, we will fix the problem in the near future.

Best Regards,
Rong Chen
