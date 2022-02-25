Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B221E4C3B5B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236647AbiBYB7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236630AbiBYB7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:59:24 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768247DA86
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 17:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645754333; x=1677290333;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AiMLReOXdbxwCJYEkuxwFgwJdr/KRPlox84ap13k0a8=;
  b=aQbkLOajP2N7fOgLET6uTd9JC4oqVuZKNdkEI33MtXLDgTJfvScH5WY/
   QieC1V6wrTLMVyHoEiEMc89NggDF4z02okvpb6pDs5T4JFfH0bZio6Z0L
   jEtp2sw4nVj5nGz53msQ+ccDwBynjnlb0jUTuGZW9d2xXlnQUamy1h6N1
   dMsmlR4d+ugKDZ3GyaIIU+vkGH6pYdzYIIDnUuzBRFMBKG3CC8Ru1L1QE
   YYo8q6T9StpKloHW2wJ2gEEyXd+ULrlJo4grWzcBk+mFBjHKLGAsAMuAJ
   jTH00opBNzXwTiLLsBYpYxkfYqdToYjlIq7+vROQAxW9sIHXpgTH1N5zM
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="315617120"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="315617120"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 17:58:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="533386135"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga007.jf.intel.com with ESMTP; 24 Feb 2022 17:58:50 -0800
Message-ID: <1e320de0-3dd7-936f-a9d4-8686687b0675@linux.intel.com>
Date:   Fri, 25 Feb 2022 09:57:20 +0800
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
Subject: Re: [PATCH v2 08/11] iommu/vt-d: Fix indentation of goto labels
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
 <20220214025704.3184654-9-baolu.lu@linux.intel.com>
 <20220224130822.GK6413@nvidia.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220224130822.GK6413@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/22 9:08 PM, Jason Gunthorpe wrote:
> On Mon, Feb 14, 2022 at 10:57:01AM +0800, Lu Baolu wrote:
>> Remove blanks before goto labels.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>   drivers/iommu/intel/iommu.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> It would be better to rework this function to not have the goto
> spaghetti in the first place.. Looks like putting the
> 'for_each_active_dev_scope' into another function would do the trick.

Good idea. Let me revisit this later.

> 
> Anyhow, this is more consistent with kernel style:
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason

Best regards,
baolu
