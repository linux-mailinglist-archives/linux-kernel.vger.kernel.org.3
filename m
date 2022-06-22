Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0360555319
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 20:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377539AbiFVSPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 14:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377538AbiFVSPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 14:15:39 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FAF3CA49;
        Wed, 22 Jun 2022 11:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655921738; x=1687457738;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Bvi2Fi4g72vldwfmru+5RLOVadaATXQqAYLEbCWQM10=;
  b=KAtBLsGpYEcvZX/1LszWJgHiMNT08/5ZU80eZt4bvis3ZQJcFTxlLEsZ
   bv6aYF5xjaShXINSRUTGmgJfLmg+jEiDN/HysFux+Hc3xxIZ+s0BbPzDo
   Q2KN3oGHjQf/vpy4UyTuN2uh1CpfGPGxPVoQ5SYzt4QzhVjrb3WRYh786
   FpAbXnlaX0KqEt93XlirjGWQJVpVmMggAWqT/vtS49VSVB8BJ8wKEM/26
   5jH0r2BZf8Kxh3rVtHqyD/nHGo+RPWr7hRSBrpAXxDXSlFvcQK2j+7oWh
   g0WSjWbOxqWrsNGN/oOU8HalWAaqJVmeSuoJK1gIVVyaUVXzPZFIUwkKf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="342186114"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="342186114"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 10:55:14 -0700
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="592302383"
Received: from gkammela-mobl.amr.corp.intel.com (HELO [10.212.111.3]) ([10.212.111.3])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 10:55:14 -0700
Message-ID: <4e59ba7a-d751-5232-84f6-78d3979f5232@linux.intel.com>
Date:   Wed, 22 Jun 2022 10:55:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1] platform/x86: intel/pmc: Add Alder Lake N support to
 PMC core driver
Content-Language: en-US
To:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>
References: <20220615002751.3371730-1-gayatri.kammela@linux.intel.com>
 <CAE2upjTKF=rBympBM0sRUM1EWbFd7JASeyzkG1J-gic4co7fvw@mail.gmail.com>
From:   "Kammela, Gayatri" <gayatri.kammela@linux.intel.com>
In-Reply-To: <CAE2upjTKF=rBympBM0sRUM1EWbFd7JASeyzkG1J-gic4co7fvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/2022 6:42 PM, Rajneesh Bhardwaj wrote:

> Is RocketLake the same as Alder Lake N? Otherwise, it looks pretty
> straight forward.
>
> Reviewed-by: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Thank you Rajneesh! I fixed the typo and posted v2.
>
>
> On Tue, Jun 14, 2022 at 8:28 PM Gayatri Kammela
> <gayatri.kammela@linux.intel.com> wrote:
>> Add Alder Lake N (ADL-N) to the list of the platforms that Intel's
>> PMC core driver supports. RocketLake reuses all the TigerLake PCH IPs.
>>
>> Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Cc: David E. Box <david.e.box@linux.intel.com>
>> Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>
>> ---
>>   drivers/platform/x86/intel/pmc/core.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
>> index 40183bda7894..a1fe1e0dcf4a 100644
>> --- a/drivers/platform/x86/intel/pmc/core.c
>> +++ b/drivers/platform/x86/intel/pmc/core.c
>> @@ -1911,6 +1911,7 @@ static const struct x86_cpu_id intel_pmc_core_ids[] = {
>>          X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,      &icl_reg_map),
>>          X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,          &tgl_reg_map),
>>          X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,         &tgl_reg_map),
>> +       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,         &tgl_reg_map),
>>          X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,           &adl_reg_map),
>>          X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &tgl_reg_map),
>>          {}
>>
>> base-commit: b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
>> --
>> 2.25.1
>>
>
