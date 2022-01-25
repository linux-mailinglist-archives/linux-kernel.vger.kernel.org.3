Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2049749B783
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352409AbiAYPWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:22:00 -0500
Received: from mga14.intel.com ([192.55.52.115]:47275 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1581988AbiAYPTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:19:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643123951; x=1674659951;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=GPPxL2ZojwmxxJ1cd9il9G9ud58L+YhhLQwb2YFZf94=;
  b=B/dHkEd2PFgkpm2RaDL5kLTfw0Dtmh5l8v7y7ngNx7IAIJL4c8w5f4Cm
   8geA0jwV0Ew3EYAYZxxCyhkKSG/7HJedqxZkbUYbitSiWmpSXIDghRHSJ
   rMwHPxOUWTio1iXhZEwiGlKke99xvQ6BvczL61y6y6V8aSQSI/OdH6ym2
   oCG1AyBLfVkDtGflo5qPhksq+CJgya4DeA2uxT/bXwcBqcurR0oo2t/m4
   Yn9J+YoHdIS9vfXlNdPtnNvdOgjVNavabE/yLQfZkt2c5JP2/UYBEQEiF
   JGdqa4lpX0cv18Rvf6UT3/f1PVzP3w8V8wPSOEUxOpxBZSVo8hTfVnCLT
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="246539878"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="246539878"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 07:13:01 -0800
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="534763336"
Received: from jfink-mobl.amr.corp.intel.com (HELO [10.209.2.7]) ([10.209.2.7])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 07:13:01 -0800
Message-ID: <931f6d2a-9001-e736-e7e2-7f86f87539cc@intel.com>
Date:   Tue, 25 Jan 2022 07:12:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/8] Add hardware prefetch control driver for arm64 and
 x86
Content-Language: en-US
To:     Kohei Tarumizu <tarumizu.kohei@fujitsu.com>,
        catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220125071414.811344-1-tarumizu.kohei@fujitsu.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220125071414.811344-1-tarumizu.kohei@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 23:14, Kohei Tarumizu wrote:
> # cat /sys/devices/system/cpu/cpu1/cache/index2/prefetch_control
> 
> hardware_prefetcher_enable=enable
> adjacent_cache_line_prefetcher_enable=disable

Doesn't this break the one-value-per-file sysfs rules?

