Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02627578F5A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbiGSAie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiGSAic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:38:32 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637A918B00
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658191111; x=1689727111;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Up7OuyzL1uxffaPEzCFfDpiH0h2YQ1ogda6kRT0730k=;
  b=Xxidg0gx28JMMeyVc9U4XK8jg9dRoiVNdlkxD+yxBCQOqe3IK+BnbKqR
   wKdDdVp4p2LZjEcDUIZn0RULuGw8VpAxmyq1VyrmLJKoWfLyoNArjh9FT
   5YPJEb6WpPYI/M48x8LHPxkXxOuXunR1QxcuorNr606WAcNTCAmqq2OVx
   NaPiR6UESwu7cZqcaIq2JASUrSQw88ZCEYZQeqzZI+O+l5485xEn56YJk
   DzTA1gAIGqCo9mzupJl4HPUqa6DyCvZan9XvVuKpIfh1WPQudUb7RHY2K
   yb9f95PR5UI2BvvZyDMjqzH4TGWAT8WqfuLPjgMJ87uSQEom27cHtswqw
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="312038819"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="312038819"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 17:38:31 -0700
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="624952914"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.29.121]) ([10.255.29.121])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 17:38:29 -0700
Subject: Re: [kbuild-all] Re:
 [ammarfaizi2-block:rostedt/linux-trace/ftrace/core 30/30]
 include/linux/cpumask.h:95:42: warning: function
 'trace_event_get_offsets_foo_bar' might be a candidate for 'gnu_printf'
 format attribute
To:     Steven Rostedt <rostedt@goodmis.org>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
References: <202207160905.GmOfByea-lkp@intel.com>
 <20220715230441.64c89d63@gandalf.local.home>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <a7692c5a-c432-8c51-413d-71072ab2153a@intel.com>
Date:   Tue, 19 Jul 2022 08:38:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220715230441.64c89d63@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/16/2022 11:04 AM, Steven Rostedt wrote:
> On Sat, 16 Jul 2022 09:09:15 +0800
> kernel test robot <lkp@intel.com> wrote:
> 
>> All warnings (new ones prefixed by >>):
>>
>>     In file included from include/trace/define_trace.h:102,
>>                      from samples/trace_events/trace-events-sample.h:608,
>>                      from samples/trace_events/trace-events-sample.c:12:
>>     samples/trace_events/./trace-events-sample.h: In function 'trace_event_get_offsets_foo_bar':
>>>> include/linux/cpumask.h:95:42: warning: function 'trace_event_get_offsets_foo_bar' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
>>        95 | #define cpu_possible_mask ((const struct cpumask *)&__cpu_possible_mask)
>>           |                                          ^~~~~~~
> 
> Please quiet the gnu_printf warning. I actually missed a real build issue
> from the kernel test robot in the last patch set because it was the needle
> in the gnu_printf haystack :-p
> 
> That is, after having 10 of these warnings, I missed the one that actually
> mattered.
> 
> -- Steve

Hi Steve,

Sorry for the noise, we didn't ignore gnu_printf warning in this file,
we will ignore all gnu_printf warnings.

Best Regards,
Rong Chen
