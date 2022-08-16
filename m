Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6781596BBD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbiHQIzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiHQIzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:55:05 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6314C78BCD;
        Wed, 17 Aug 2022 01:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660726504; x=1692262504;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CTKtDOyB60/QGOd7TsvIyNY16TNwoiQhsBzxyF3hBas=;
  b=OpLfnuGcvvDzpbmnETUMJ3+U2+hJCpZQSLy5taYbfZxBO/fGMrIl3iKR
   fplH8F6evRqnnE2pL67jFLTC4oA6xEdqdKHvCu24Ib8E5qjbRtxmLkJkA
   SvGYjT03AgSczj0fEX975zwDJ5XiZZKJvPewSzkGZguAMZOvC0/Jn2zgG
   Dks3JgvEkmGFECr+/23+V7MApWGW3Me/x0x6/o+X2FY1m/aN5w4/eeg6T
   XrxxqYWZJwvU0GSIlwNDqqlMM6aKCx3gNLOdC5oD5+RVhB9ERDCyNQ7py
   5P7szJw0JzY4FavbFE/n2xZ6t2CKs4f3mlzg5ZOYYw9ToD2eaw6rzEuiN
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="378734610"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="378734610"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 01:55:01 -0700
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="667519870"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.49.3])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 01:54:58 -0700
Message-ID: <b42344bc-86f6-9047-b015-88ef3b58a619@intel.com>
Date:   Tue, 16 Aug 2022 23:48:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: perf tools man pages on the web
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
References: <cecae74c-6bb2-d7da-bce3-35772b6e3f8c@intel.com>
 <CAP-5=fXJtRVKuPA_xpa=jBzq66y5JMv+jmr1GFNzh-zQ-7j5QA@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fXJtRVKuPA_xpa=jBzq66y5JMv+jmr1GFNzh-zQ-7j5QA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/22 17:56, Ian Rogers wrote:
> On Mon, Aug 15, 2022 at 5:05 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> Hi
>>
>> I notice man pages on man7.org e.g.
>>
>>         https://www.man7.org/linux/man-pages/man1/perf.1.html
>>
>> do not get updated every release, and I wondered if the perf tools
>> man pages should also be under:
>>
>>         https://docs.kernel.org/tools/index.html
>>
>> Thoughts?
> 
> Sounds good to me. I'm assuming it would be some kind of build step
> that would take the man pages and add them to what linux-doc needs?
> 
> Fwiw, there has been some effort to try to improve the wiki:
> https://perf.wiki.kernel.org/index.php/Main_Page
> For example, the useful links are now broken apart and have more
> links, there is a work-in-progress glossary. Perhaps there can be some
> guidance on what to capture and where.

Speaking of the wiki, anyone know how to change the
"Set $wgLogo to the URL path to your own logo image." image?
