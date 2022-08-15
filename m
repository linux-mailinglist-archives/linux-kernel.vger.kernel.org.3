Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B928592EA9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 14:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbiHOMFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 08:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiHOMFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:05:02 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1D8255AB;
        Mon, 15 Aug 2022 05:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660565102; x=1692101102;
  h=message-id:date:mime-version:to:from:subject:cc:
   content-transfer-encoding;
  bh=VBX263V+zvk7b3GYwEzp8zXhpQeIy96QkAOJXVDEb0w=;
  b=CVftYBoFO83SRIcEvMU4hDrRZorLtAc9SyZxOesv3LVmGUWNahZtsBLz
   71DQOg4zzRcqh+nkL8UbLWUrCQUXYjTK5huw+LggbD+hV21H+JPVDn5ox
   HRRB4fzAwE3BKzLynFiano84InondMRe4dzTusp7N04jR64ep4uHlAEDQ
   /iZtj67T1gXeZLCtGH2ANUT0qFw9PBoHFkSwSobuXyYhJiAYlau3/b9Y7
   PABkHq34JzVd4war2U1vkoSq+Ch9sSFfH/ptkP1/uer1UswvN9zdTPQYY
   kYCRz+LPUkdGsl0lX9AQqRxeq/kJOKa29IzjGa7sFIgu41mKFX4Qmz+GP
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="289512745"
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="289512745"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 05:05:01 -0700
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="635454008"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.50.166])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 05:04:57 -0700
Message-ID: <cecae74c-6bb2-d7da-bce3-35772b6e3f8c@intel.com>
Date:   Mon, 15 Aug 2022 15:04:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: perf tools man pages on the web
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I notice man pages on man7.org e.g.

	https://www.man7.org/linux/man-pages/man1/perf.1.html

do not get updated every release, and I wondered if the perf tools
man pages should also be under:

	https://docs.kernel.org/tools/index.html

Thoughts?

Regards
Adrian
