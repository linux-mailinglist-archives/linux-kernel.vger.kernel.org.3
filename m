Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0ADD4C3B58
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbiBYB6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbiBYB6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:58:09 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6713E1728BC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 17:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645754259; x=1677290259;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v0JSbQfSFuoGQvNp0jnSnBhsEa8/XAvqCDK142/+K+U=;
  b=CIHWkpHq1j2lgY0NvUKJK4gKHLqftIafFGvctxdfY12byvmLf1+yhc2R
   eWR9yn4oHOrJubGSuoutjCrUUv94rbVQuUshY870iNaZxJujmpWY6w2LW
   2GrWm0OIB/14f5dxQp6x449Mq/ygGeAJLRh8iSghSjZlPuvLc+EotmhgQ
   OXa2r5O1LP9WAcKhi9/4XowlcXrxsZwQUMXrPZoEucrm3ahrzlbsIHFJQ
   ZuyMG6hgTH6aDFSMMSxsshyT+plmxwDwD7+kz4hHRgr+pGYuM7InVltpd
   hp4X6O4y15v10aPVp3EwQYwGgH4vBtrG5iD3nggbzSgAHEmBj20mej4kX
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="249979230"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="249979230"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 17:57:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="533385941"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga007.jf.intel.com with ESMTP; 24 Feb 2022 17:57:35 -0800
Message-ID: <0c261ae1-d1d4-d63d-19cf-e2417a6a38f9@linux.intel.com>
Date:   Fri, 25 Feb 2022 09:56:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/11] iommu/vt-d: Remove unnecessary includes
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
 <20220214025704.3184654-7-baolu.lu@linux.intel.com>
 <20220224130504.GI6413@nvidia.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220224130504.GI6413@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/22 9:05 PM, Jason Gunthorpe wrote:
> On Mon, Feb 14, 2022 at 10:56:59AM +0800, Lu Baolu wrote:
>> Remove unnecessary include files and sort the remaining alphabetically.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 34 +++++++---------------------------
>>   1 file changed, 7 insertions(+), 27 deletions(-)
> 
> Are we sorting includes alphabetically now?

I sorted them in this patch.

> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason

Best regards,
baolu
