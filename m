Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3B84F987F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237154AbiDHOrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237173AbiDHOr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:47:28 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CEB2AF2
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 07:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649429124; x=1680965124;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=s0xQVHcXqt291wYBTnsPsLSAxpkK+NWZ6kF95fk9sTs=;
  b=lGwMuO2M8/Qb2cO78gXFZo9X5Dq6B6Dbdakz3bcdP6+L5sEl/ksqs3J1
   9DRHiPjk04RJIrZS/JsZs3j8gc9kOmsvw/fHwBLivkPvWwAWv4cLc9Rff
   pDyo/veXtqVS147xWt/kk8gvW41pOLiIyL5583XBy7e7C4y+sWRBNp5JE
   WK9V1vrzYxSfZ5K9jUitORkf4TL/4Z4auyftF+mKGIwBPRX3IOSfTFK7Q
   ctIcPKccjPzYk8nuJD5Y7liwN2upnUr6f9du+2lGAz0io6wDGxKUm+pSp
   xCz0atC19hGJVuikOJCs6rnuste6mCCsxmqmmIqMb7VIX7Nmo+GXzQQKG
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="259205971"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="259205971"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 07:45:24 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="525398560"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.249.168.85]) ([10.249.168.85])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 07:45:19 -0700
Message-ID: <70411972-e31a-27a1-acbf-26f5ab471a6a@linux.intel.com>
Date:   Fri, 8 Apr 2022 22:45:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] perf: Add missing newline at end of file
Content-Language: en-US
To:     "Liang, Kan" <kan.liang@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
References: <20190617144725.6415-1-geert+renesas@glider.be>
 <20190617160011.GB3927@kernel.org>
 <CAMuHMdWPDMhz9YdEs-=iCLa6w--iS-Ug9SMUa=UG0bW2mMYyxA@mail.gmail.com>
 <CO1PR11MB4803640A785DF199D0496017E8E49@CO1PR11MB4803.namprd11.prod.outlook.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
In-Reply-To: <CO1PR11MB4803640A785DF199D0496017E8E49@CO1PR11MB4803.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/5/2022 9:59 PM, Liang, Kan wrote:
>
>> On Mon, Jun 17, 2019 at 6:00 PM Arnaldo Carvalho de Melo
>> <arnaldo.melo@gmail.com> wrote:
>>> Em Mon, Jun 17, 2019 at 04:47:25PM +0200, Geert Uytterhoeven escreveu:
>>>> "git diff" says:
>>>>
>>>>      \ No newline at end of file
>>>>
>>>> after modifying the files.
>>> Auto generated files, IIRC, Andi, Kan, Sukadev?
>> The auto-generated files have been updated, the issue still exists.
>>
> It seems like a converter tool issue.
>
> + Zhengjun
>
> Zhengjun, could you please take a look?
>
> Thanks,
> Kan
It only happened for perf core event files. Add "\n" at the end of the 
perf core event file, then the issue is fixed.
I have updated the event convert tool 
https://github.com/intel/event-converter-for-linux-perf , then the next 
time uses the convert tool to generate perf events, the issue will be 
disappeared.

-- 
Zhengjun Xing

