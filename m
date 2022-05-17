Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E9D52A2F0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244710AbiEQNNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347403AbiEQNNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 09:13:22 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777AA419A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 06:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652793201; x=1684329201;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=aGHeyf0OgdG5HUBJgWMS4qMAAmT8DIlyW3zwg6qOhAk=;
  b=KtEOcCjLzmY1/yyK6kWJPpHHLqk/XMNyvLai17UZ0p6y4zdrGYbHZ5LT
   gTBDrICdmcCpZ24MhetWMjznfcRiO7/Qhvqx8Aj5azqqM+mat0hQp7zzq
   JFabEugk9Tijhk/0rkVS69i87zuzItHStGiIYR3CnFOU8FPzdDuXr5OzY
   lyBiXv2MBRn3k580ZnkdiQvrufvevUOb8ZXUCiqxj8b19DjIvpY1XnX8K
   rSD9S/VxoRytmUx2wD0Z337u+yoQBFmMZSk6msxSoBgobtWpq96yxehET
   9JD+nYriBrhmShBGwsDe53tg53SPgJ87gsh5DVe/pJvVjeTJI5j7A/s2F
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="258741238"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="258741238"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 06:13:21 -0700
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="597119167"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.52.217])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 06:13:19 -0700
Message-ID: <d9b6a2c0-2387-2c2e-eedb-9de8a36a2eb5@intel.com>
Date:   Tue, 17 May 2022 16:13:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH 0/3] perf intel-pt: Add support for emulated ptwrite
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
References: <20220509152400.376613-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220509152400.376613-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/05/22 18:23, Adrian Hunter wrote:
> Hi
> 
> Here are 3 patches (on top of "perf intel-pt: Add link to the perf wiki's
> Intel PT page") to add support for decoding emulated ptwrite i.e. for
> hardware that does not have the ptwrite instruction.

Is this OK?

> 
> 
> Adrian Hunter (3):
>       perf intel-pt: Add support for emulated ptwrite
>       perf script: Print Intel ptwrite value as a string if it is ASCII
>       perf scripts python: intel-pt-events.py: Print ptwrite value as a string if it is ASCII
> 
>  tools/perf/Documentation/perf-intel-pt.txt         | 88 +++++++++++++++++++
>  tools/perf/builtin-script.c                        | 32 ++++++-
>  tools/perf/scripts/python/intel-pt-events.py       |  8 +-
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 99 +++++++++++++++++++++-
>  .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |  1 +
>  .../util/intel-pt-decoder/intel-pt-insn-decoder.c  |  1 +
>  .../util/intel-pt-decoder/intel-pt-insn-decoder.h  |  1 +
>  tools/perf/util/intel-pt.c                         | 37 +++++++-
>  8 files changed, 261 insertions(+), 6 deletions(-)
> 
> 
> Regards
> Adrian

