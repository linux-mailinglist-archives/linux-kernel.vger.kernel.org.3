Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22D14AD0EE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 06:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbiBHFdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 00:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiBHFAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 00:00:02 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337BFC0401DC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 21:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644296402; x=1675832402;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8B0fvJxEJCgZ1XGBKcnyZvyWKeanluy4HXPYaaurdAY=;
  b=JnzxfgHHWc515WuFmsOabdiado6RNFiRU+QP9HWoD0rWdrlN3saLBIGP
   kxybuB3JR3Zf4F6k3fI2UhTmDSvXbPnbo4ztWxynirpjjTT8F4OhjJtsS
   BM1a0oi4GmeSsBDAFg6tFKBeZyOobLvX4LP+Gj6gyHkl18fZDRO29Z77B
   YkoSNHBVXB6etuiBmrjShCPwYb9qM/tL4RebAmd777SaemSSCmNm1lXSY
   Pmom+YwtllxjuWJlQrO8kc9B3xeaj0BppE1yC6ptAM2WUsjujtMUtD/T2
   MPk/LtOR5a6Jw3e57cGXKhSJj/LZtpc7IkXbpLpm/xu4YZf/MouYt1u7k
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="248820031"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="248820031"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 20:59:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="677989172"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2022 20:59:56 -0800
Message-ID: <5ed59b2d-8d19-fd15-6fad-3572beabe4c2@linux.intel.com>
Date:   Tue, 8 Feb 2022 12:58:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 10/10] iommu/vt-d: Some cleanups in iommu.c
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
References: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
 <20220207064142.1092846-11-baolu.lu@linux.intel.com>
 <20220207071544.GH23941@lst.de>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220207071544.GH23941@lst.de>
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

On 2/7/22 3:15 PM, Christoph Hellwig wrote:
> On Mon, Feb 07, 2022 at 02:41:42PM +0800, Lu Baolu wrote:
>> Move macros and inline helpers to the
>> header file.
> 
> Why?  This just means they get pulled into other source files and
> create overhead.

I supposed that they could also be used elsewhere. But no use cases so
better to keep them and avoid overhead. Thanks!

Best regards,
baolu
