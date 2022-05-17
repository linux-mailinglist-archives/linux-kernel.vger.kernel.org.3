Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB590529B10
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 09:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241939AbiEQHia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 03:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241958AbiEQHgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 03:36:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DD249F02;
        Tue, 17 May 2022 00:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652772935; x=1684308935;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d6imrCBiGBbVz2D/NUzP92KgMzg0Fvwm4TsGR5xbZNw=;
  b=B2wTHYVaXkep9y+Q6rCJGt65EOVhVcTRagbVxERv8N5EtT1SfE0FId01
   skm2fYaXaRrLJlbvntOsLLg8BGiR6WuXgDavbSm7qdUJUTVx/821H5kUu
   1n7E11AVWFMdb0sYIjonu2y4fjhnqfsvzrFL5p24fdVcmxijjWGdvrGTi
   ruv/SlbRoJ1KTHtzLd3UvbE3tJq2/gRpubXxkAphQGMmaSyWMiyzc4poR
   ZWQhqme9RB8EvkrOL3fBKRjg6nBCyKo/7zo8h2LT6o5Bc6oYLC/5AQKz2
   X7wPBTLweWzU7VDl1H0s1I5UGYvQCEHN2vHdngWojue+PGjZMmDJymPc5
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="271041373"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="271041373"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 00:35:35 -0700
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="596991454"
Received: from aghafar-mobl1.ger.corp.intel.com (HELO [10.213.210.37]) ([10.213.210.37])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 00:35:33 -0700
Message-ID: <d7310d85-4e8e-6b3b-2ec5-3a56bb9babeb@linux.intel.com>
Date:   Tue, 17 May 2022 08:35:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: linux-next: Tree for May 16 (drm/i915/gt/intel_gt_sysfs_pm.c)
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <20220516205718.2c5a52f9@canb.auug.org.au>
 <1af2e702-2ea4-02ad-7682-e39cee20cc13@infradead.org>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <1af2e702-2ea4-02ad-7682-e39cee20cc13@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 16/05/2022 22:22, Randy Dunlap wrote:
> 
> 
> On 5/16/22 03:57, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20220513:
>>
> 
> on i386:
> 
>    CC      drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.o
> ../drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c: In function ‘act_freq_mhz_show’:
> ../drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:276:20: error: implicit declaration of function ‘sysfs_gt_attribute_r_max_func’ [-Werror=implicit-function-declaration]
>    u32 actual_freq = sysfs_gt_attribute_r_max_func(dev, attr,
>                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c: In function ‘boost_freq_mhz_store’:
> ../drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:327:9: error: implicit declaration of function ‘sysfs_gt_attribute_w_func’ [-Werror=implicit-function-declaration]
>    return sysfs_gt_attribute_w_func(dev, attr,
>           ^~~~~~~~~~~~~~~~~~~~~~~~~
> ../drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c: In function ‘min_freq_mhz_show’:
> ../drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:416:17: error: implicit declaration of function ‘sysfs_gt_attribute_r_min_func’ [-Werror=implicit-function-declaration]
>    u32 min_freq = sysfs_gt_attribute_r_min_func(dev, attr,
>                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
> 
> 
> Full randconfig file is attached.

There is a fix for this in 09708b6d82ef ("drm/i915/gt: Fix build error 
without CONFIG_PM") queued up, waiting for the next pull request, which 
the plan was to send out next week or so. Is that okay?

Regards,

Tvrtko
