Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6EB5430D3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239756AbiFHMu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239732AbiFHMt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:49:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F63119EC18;
        Wed,  8 Jun 2022 05:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654692595; x=1686228595;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2qiqbShlAjmZQPFhGeQzPf5Qtr1YDsIAej0EOKyS+XQ=;
  b=Ui/+RtvwFuocJRq6Ugz+kM7l1hvBoaSP6LxaFJSfsLprZIgyU6bUaViF
   CBqxv/Cl8dz83nf1c3PHtoupP09CKejut2/EB9awLVaAzv6+aTNuVjJwR
   w6mr9Fro3EaXqBhWyXupSmPGIMD/Km5bGhkv2Z9PVhMXdIzb222wp7YFM
   byOr5cx9fip5euHAFO3UWicLY+4y1RU3MeBCHMbzp5IrivxXr7QQGIqZB
   lFbkWHcF8YWjFI0dZUx9+OnLvPKkwiNISiCyp3OjXGU458LQfQUBjbHkI
   MrrAeE9q7q4DJtHGXbNR+QjxKj4POffkVP1pwdFxH3TYf5ODZk9N85AZ9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="257315562"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="257315562"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 05:49:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="826958435"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 08 Jun 2022 05:49:48 -0700
Received: from [10.252.211.65] (kliang2-MOBL.ccr.corp.intel.com [10.252.211.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id EE749580B9E;
        Wed,  8 Jun 2022 05:49:46 -0700 (PDT)
Message-ID: <59b85c65-198c-5147-bbc6-818ce2234b6c@linux.intel.com>
Date:   Wed, 8 Jun 2022 08:49:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] perf vendor events intel: Update event list for
 Snowridgex
Content-Language: en-US
To:     zhengjun.xing@linux.intel.com, acme@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, adrian.hunter@intel.com, ak@linux.intel.com
References: <20220608063439.1997394-1-zhengjun.xing@linux.intel.com>
 <20220608063439.1997394-2-zhengjun.xing@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20220608063439.1997394-2-zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/2022 2:34 AM, zhengjun.xing@linux.intel.com wrote:
>       {
> -        "BriefDescription": "write requests to memory controller. Derived from unc_m_cas_count.wr",
> +        "BriefDescription": "All DRAM write CAS commands issued",
>           "Counter": "0,1,2,3",
>           "CounterType": "PGMABLE",
>           "EventCode": "0x04",
> -        "EventName": "LLC_MISSES.MEM_WRITE",

The old convertor tool creates many alias to replace the event in the 
event list. The LLC_MISSES.MEM_WRITE event is one of them.
There is no problem to add the original event name. But I think we 
should keep both alias and the original name, in case someone already 
used the alias in their script.


> +        "EventName": "UNC_M_CAS_COUNT.WR",
>           "PerPkg": "1",
> -        "ScaleUnit": "64Bytes",
>           "UMask": "0x30",
>           "Unit": "iMC"
>       },

Thanks,
Kan
