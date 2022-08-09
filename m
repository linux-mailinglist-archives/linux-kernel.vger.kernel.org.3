Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A96E58D75B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 12:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiHIKX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 06:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbiHIKXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 06:23:25 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B3918360
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 03:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660040605; x=1691576605;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=EPYnAUfjYb96gXY6+8JJ3sFiLBxcSud8g/qim46UvP8=;
  b=MDDyp1WpAY0rzcWIW6Ktt8rEQ7Wx8uw78pF2TCTR7aLnz7YR+O/FZcZF
   LEGBewfKhvuyhErrYy3e3agjXzdUw/xdeC9N0EIg/8XWYx7bEkdSd80Ee
   /eH2mn3CxzYV8qEyrHYSeQbfw1diR64yfkqvxM9ptH08FJeXMQOdOzGez
   M5zwWcZFzt7lLVz3sU6Evxa5PwjpdKvjBUtkik+jgLWYQ+53OUzqRHZYl
   6yaj8WSOqdac/b+q9XFcUnCxvhoaZLnKzUIS2sD3e130ghoRL7fYNSDnA
   a3eECiikbs956ZPSKQPqj4A5eN9VeNnaKCWdZvGfo92F00AV2CqwKlMra
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="316731060"
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="316731060"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 03:23:24 -0700
X-IronPort-AV: E=Sophos;i="5.93,224,1654585200"; 
   d="scan'208";a="633278227"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.254.208.171]) ([10.254.208.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 03:23:23 -0700
Subject: Re: [kbuild-all] Re: drivers/md/raid10.c:2647:60: sparse: sparse:
 incorrect type in argument 5 (different base types)
To:     Bart Van Assche <bvanassche@acm.org>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <202208061258.jAwlaAXe-lkp@intel.com>
 <dc0dbf3d-d524-7edc-6fbf-0067c75c3d03@acm.org>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <bd67a6dd-4d43-28f6-e2bb-a283f581a7a9@intel.com>
Date:   Tue, 9 Aug 2022 18:23:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <dc0dbf3d-d524-7edc-6fbf-0067c75c3d03@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/6/2022 11:21 PM, Bart Van Assche wrote:
> On 8/5/22 21:44, kernel test robot wrote:
>>     drivers/md/raid10.c:1139:30: sparse: sparse: incorrect type in 
>> initializer (different base types) @@     expected int const op @@     
>> got restricted blk_opf_t enum req_op @@
>>     drivers/md/raid10.c:1139:30: sparse:     expected int const op
>>     drivers/md/raid10.c:1139:30: sparse:     got restricted blk_opf_t 
>> enum req_op
>>     drivers/md/raid10.c:1140:52: sparse: sparse: incorrect type in 
>> initializer (different base types) @@     expected unsigned long const 
>> do_sync @@     got restricted blk_opf_t @@
>>     drivers/md/raid10.c:1140:52: sparse:     expected unsigned long 
>> const do_sync
>>     drivers/md/raid10.c:1140:52: sparse:     got restricted blk_opf_t
> 
> I can't reproduce this with Linus' master branch. It seems like the 
> kernel test robot picked a commit somewhere halfway my patch series?
> 
> Bart.

Hi Bart,

Only the warning prefixed by '>>' is related to this commit 4ce4c73f662b:

 >> drivers/md/raid10.c:2647:60: sparse: sparse: incorrect type in 
argument 5 (different base types) @@     expected restricted blk_opf_t 
[usertype] opf @@     got int rw @@

and I can reproduce it in my system.

Best Regards,
Rong Chen
