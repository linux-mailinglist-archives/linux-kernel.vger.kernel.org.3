Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D08B4B8122
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiBPHNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:13:25 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiBPHNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:13:22 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C360C39B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644995583; x=1676531583;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f1SXQpu92IOX79PPCsU+PF8QzhMB5xnZr5Wm6Vd3XBk=;
  b=ATRrynpQMkQciG3aqfxrgimfjp+R5uWC/M5mHdXiIH0vlWvYsUCMmNJ8
   /bfrayBdxrqFG2URbs7AbTcEPwDtJdBCTS1LJimr/f60W0HzKFD7kjWXA
   H4DjAv4kQpagO7/wAHYRW38DvOJwBM4ulnovhA9oXm6ZBF+arRt8hPTdK
   VZhTlIFbU1ULPdoCBPeLELNIROAB4xhB+lO+s8Unpy0FdULxFIquqb9/Z
   pTeC9rfTzQvhaxH1QR8ERGmJHvc4idnhpJgn2HVB4gNghWr84o47fwSOT
   1J9PLffJDq2XUS0fB9xG/CB1lY7Z9gP9LkfOVMU+Lat0uZJ5x44rlDU0V
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="249371606"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="249371606"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 23:12:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="681390279"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 15 Feb 2022 23:12:35 -0800
Message-ID: <fad3abe8-f69f-1339-7bca-e0283f9182d5@linux.intel.com>
Date:   Wed, 16 Feb 2022 15:11:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 09/11] iommu/vt-d: Remove commented code
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20220214025704.3184654-1-baolu.lu@linux.intel.com>
 <20220214025704.3184654-10-baolu.lu@linux.intel.com>
 <20220214073424.GE17411@lst.de>
 <BN9PR11MB527698691A1DF10EEB514AA08C359@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527698691A1DF10EEB514AA08C359@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/22 11:45 AM, Tian, Kevin wrote:
>> From: Christoph Hellwig<hch@lst.de>
>> Sent: Monday, February 14, 2022 3:34 PM
>>
>> On Mon, Feb 14, 2022 at 10:57:02AM +0800, Lu Baolu wrote:
>>> This removes unnecessary commented code.
>> Removing dead code is always good:
>>
>> Reviewed-by: Christoph Hellwig<hch@lst.de>
>>
>> But someone might really want to take a look if draining makes sense here
>> or not.
> Looks that dead code has been there since intel-iommu driver was
> firstly introduced in 2007. I don't know whether we can dig out
> the reason (Baolu, can you have a check?) why it's only special
> cased for read draining but not write draining. I cannot find any
> such recommendation from VT-d spec.

Emm, I have no idea either. Let me check it with the architecture
experts.

> 
> Looking at VT-d spec it stated that since VT-d major version 2
> drain is conducted automatically by hardware and above flags
> are essentially ignored.
> 
> Given that possibly a safer option is to always set read/write
> draining flags before version 2 and skip it after.

Best regards,
baolu
