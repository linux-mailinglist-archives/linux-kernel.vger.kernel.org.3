Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F49A596895
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 07:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbiHQFYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 01:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiHQFYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 01:24:20 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C3E5FAC;
        Tue, 16 Aug 2022 22:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660713858; x=1692249858;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RuOw0a+zfDrSKH3bQpTCct6nUD3o/er6utR/T/sgNW4=;
  b=i44bWr4SYMqooJj+0tczklLNYGRvSyLPkORK4eLX6Sxk/1WAw9ykYDAB
   zZyjeaTgn9kftaDVQSPyba4i8NuSUX7ic+vfoOFdhfdV0d2BtA4l12h1Z
   CMKj6pG6X9zXhlKo0BIj9y49nzQTbS2YzyMqHFkc2mx6cROdTdqlwUSOV
   GAE06eN2O9grMke0mjodTqN6SPocxPFogIXKra7QKY8Tha2r0Di37icoy
   dndiZqN6yHZQpyzLVZtyVL1VkmoNZTDzbHdoNG/unQRLg5Xn9rMGUwMuN
   GlTjt47ppSmV3UUYVsp4+skqH3Wz+GM5A5yopTmKbq9+ZiY7NmHsSYz79
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="318408352"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="318408352"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 22:24:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="667445041"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.49.3])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 22:24:14 -0700
Message-ID: <53428314-9dfc-288d-d109-79240fba82ac@intel.com>
Date:   Wed, 17 Aug 2022 08:24:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: perf tools man pages on the web
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <cecae74c-6bb2-d7da-bce3-35772b6e3f8c@intel.com>
 <CAP-5=fXJtRVKuPA_xpa=jBzq66y5JMv+jmr1GFNzh-zQ-7j5QA@mail.gmail.com>
 <CAM9d7cgWXP2s25XUM90=b5Eaojutxi=LobkqrUkRoF5gek4DPQ@mail.gmail.com>
 <edd637d1-e85c-bc18-a8a2-8aa63d02146f@intel.com>
 <CAP-5=fWRNO+dmrnq_3a-L6Vdfd2i3oEB8y2+7F2ik7Lc35s5Pg@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fWRNO+dmrnq_3a-L6Vdfd2i3oEB8y2+7F2ik7Lc35s5Pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/22 16:25, Ian Rogers wrote:
> On Mon, Aug 15, 2022 at 11:05 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 16/08/22 08:07, Namhyung Kim wrote:
>>> Hi Ian and Adrian,
>>>
>>> On Mon, Aug 15, 2022 at 7:56 AM Ian Rogers <irogers@google.com> wrote:
>>>>
>>>> On Mon, Aug 15, 2022 at 5:05 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>>
>>>>> Hi
>>>>>
>>>>> I notice man pages on man7.org e.g.
>>>>>
>>>>>         https://www.man7.org/linux/man-pages/man1/perf.1.html
>>>>>
>>>>> do not get updated every release, and I wondered if the perf tools
>>>>> man pages should also be under:
>>>>>
>>>>>         https://docs.kernel.org/tools/index.html
>>>>>
>>>>> Thoughts?
>>>>
>>>> Sounds good to me. I'm assuming it would be some kind of build step
>>>> that would take the man pages and add them to what linux-doc needs?
>>>
>>> I guess it's the RST format.  I'm not sure if there's a converter
>>> from asciidoc to RST.
>>
>> Could use the html files that are already generated by:
>>
>>         make -C perf/tools html
> 
> A lot of the man page makefile code comes from git and wasn't in great
> shape the last I looked [1]. I believe that would be true for the HTML
> output. As there are existing dependencies on rst2man for BPF [2], I
> think it'd be cleaner to migrate all the man pages to rst format with
> new man page build rules using rst2man. Wdyt?

That seems like a larger job.  For now, I am just suggesting copying the
html files onto kernel.org.

+ Mauro

Mauro, do you know if that is feasible?

> 
> Thanks,
> Ian
> 
> [1] https://lore.kernel.org/all/20210715013343.2286699-1-irogers@google.com/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/include/uapi/linux/bpf.h#n1538
> 
>>>                        Anyway having the perf man pages in the
>>> tools section looks good.
>>>
>>>>
>>>> Fwiw, there has been some effort to try to improve the wiki:
>>>> https://perf.wiki.kernel.org/index.php/Main_Page
>>>> For example, the useful links are now broken apart and have more
>>>> links, there is a work-in-progress glossary. Perhaps there can be some
>>>> guidance on what to capture and where.
>>>
>>> Thanks for working on this.  I really need to take a look...
>>>
>>> Thanks,
>>> Namhyung
>>

