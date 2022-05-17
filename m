Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F4152AA36
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351969AbiEQSMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351978AbiEQSM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:12:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748A518E3F;
        Tue, 17 May 2022 11:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Jb8A305OMLCpRcD0sT7krxesvTDTlCQWzCF6nIM8tMs=; b=EFbXcB47+R/URUg1IvwHrkdVfm
        No/V0ytUcUnson+PrqXrbEtLzEsyaXrk2bSzN4jvIAITSdayleey7+qr1w0hzTTBOF8MR3FgCEBrX
        X1J0ojEvlwr82JCZpWia0g3MhVxm/jnzIHfjlaLXypyDrhVUimtgj7cZDXDLZHnPqbnGionB1jfXu
        sx5cds0X3TBvbfe96N6Gtfxgkc3GplIRwPKvhjTlkE3jB2OAW+VxFQrAxiV9yOy2e+yH+RUSSA33f
        K8mb/ax+51bGPHnUj2gE3p9NQ157P3p6AGKi/YTkuu8oekICu/Oor43I0BqmEsFIz5HqhhbtpdIHD
        xD8ucdTg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nr1g0-00B3ta-90; Tue, 17 May 2022 18:12:08 +0000
Message-ID: <ca123561-071a-bd75-71cb-bb66084ad38e@infradead.org>
Date:   Tue, 17 May 2022 11:12:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: linux-next: Tree for May 16 (drm/i915/gt/intel_gt_sysfs_pm.c)
Content-Language: en-US
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
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
 <d7310d85-4e8e-6b3b-2ec5-3a56bb9babeb@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <d7310d85-4e8e-6b3b-2ec5-3a56bb9babeb@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/22 00:35, Tvrtko Ursulin wrote:
> 
> Hi,
> 
> On 16/05/2022 22:22, Randy Dunlap wrote:
>>
>>
>> On 5/16/22 03:57, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Changes since 20220513:
>>>
>>
>> on i386:
>>
>>    CC      drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.o
>> ../drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c: In function ‘act_freq_mhz_show’:
>> ../drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:276:20: error: implicit declaration of function ‘sysfs_gt_attribute_r_max_func’ [-Werror=implicit-function-declaration]
>>    u32 actual_freq = sysfs_gt_attribute_r_max_func(dev, attr,
>>                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> ../drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c: In function ‘boost_freq_mhz_store’:
>> ../drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:327:9: error: implicit declaration of function ‘sysfs_gt_attribute_w_func’ [-Werror=implicit-function-declaration]
>>    return sysfs_gt_attribute_w_func(dev, attr,
>>           ^~~~~~~~~~~~~~~~~~~~~~~~~
>> ../drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c: In function ‘min_freq_mhz_show’:
>> ../drivers/gpu/drm/i915/gt/intel_gt_sysfs_pm.c:416:17: error: implicit declaration of function ‘sysfs_gt_attribute_r_min_func’ [-Werror=implicit-function-declaration]
>>    u32 min_freq = sysfs_gt_attribute_r_min_func(dev, attr,
>>                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> cc1: some warnings being treated as errors
>>
>>
>> Full randconfig file is attached.
> 
> There is a fix for this in 09708b6d82ef ("drm/i915/gt: Fix build error without CONFIG_PM") queued up, waiting for the next pull request, which the plan was to send out next week or so. Is that okay?

When will it be in linux-next?

thanks.
-- 
~Randy
