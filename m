Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99294B8157
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiBPHTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:19:07 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiBPHTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:19:02 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3793DD007A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644995926; x=1676531926;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Rtxj1UDHxt0cG+aH0MjVGov4YzjQBNtjm2W/22eZowE=;
  b=gMCjequZWMpq5/evJmRdimCoMAkaLWQto7rOWiKrhL5NL9JCs42czbJ6
   XVIO9LcAOh9sn/8IsoTOFGdQceyM14cBhLf26DhcBjiN6Ekh/VRzkvVwI
   1jF2kd8Kuch69LYPzB7pFAdpa0qlWNLpxmPEOalF+3n4SvOaiYVnLIGoU
   nSbQurqnJpapJ8Doo2yVVu7ViEOQiVmHmjTeJX9XOHRjhWxqOzCxEXQ/S
   kyuLcuF8pe2BB0SNbmJ+62DnOC+0OUqQY+QK5tmE84w7M5sz73ubkncRt
   cB9xGXWkSsz9Mr5gMpAcJJJyfA1scDeHIG8rD7it7VtdcS8iMafMU8Use
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="230502234"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="230502234"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 23:04:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="681387754"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 15 Feb 2022 23:04:43 -0800
Message-ID: <ae863355-3f44-5eae-4f35-90a62cb2d89f@linux.intel.com>
Date:   Wed, 16 Feb 2022 15:03:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Move intel_iommu_ops to header file
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20220207141240.8253-1-andriy.shevchenko@linux.intel.com>
 <YgpY1IIBkFIxxjbm@8bytes.org>
 <30e45a7e-088d-7479-a284-68effadf3cbe@linux.intel.com>
 <Ygt3jibBVRyCn909@smile.fi.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <Ygt3jibBVRyCn909@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/22 5:51 PM, Andy Shevchenko wrote:
> On Tue, Feb 15, 2022 at 09:31:37AM +0800, Lu Baolu wrote:
>> On 2/14/22 9:27 PM, Joerg Roedel wrote:
>>> On Mon, Feb 07, 2022 at 04:12:40PM +0200, Andy Shevchenko wrote:
> 
> ...
> 
>>>> +extern const struct iommu_ops intel_iommu_ops;
> 
>>> The intel_iommu_ops symbol is only used in drivers/iommu/intel, so I
>>> would prefer a header in that directory. But I leave that up to Baolu to
>>> decide.
>>
>> Agreed. I also have a plan to split them out into a internal header.
> 
> The above change is hanging for more than a year, can we apply it and then
> you can do a split?
> 

Yeah. This is my plan. The include/linux/intel-iommu.h also keeps other
internal only helpers. It worth a separated cleanup patch.

Best regards,
baolu
