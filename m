Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B8049AB6C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 06:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S254923AbiAYExg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 23:53:36 -0500
Received: from mga06.intel.com ([134.134.136.31]:17064 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1326106AbiAYEoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 23:44:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643085878; x=1674621878;
  h=cc:subject:to:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=RHEqwCKoay/aJcjfpJzwezonfNdiVpJz/c7HuPxDFXQ=;
  b=DOJSn57aMVvUcI8Ou5RowefsFtuyxujYPNMB1XLJuXKOB5Y6sbDezjqr
   M35Ly93xomaymRNCYnelqbvR+weMUELo3z8Ucke+3dyNqao9xIsiY/MCz
   fuoRn1hHodQgAR6QZvrGt+Ta7nd7umHbUgEkXSe5W6DugnXWsce8UR8Us
   /wZb2HMX1TSY5Fxdrj0lL3SPLIHNepshyz943QLBQRxSzWvfQ4oOO/DbT
   MB/7iZgb5EKUh+8AyfbL1VAZsVAHpDoqTG2mi133hjGJpk3WXIKG8H557
   E9cOLP/D4ic6yPCkCqUVGeDh6lsGMDpUWIbJ8hETKYVlH7Yo7XRaXSb9Q
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="306932970"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="306932970"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 20:44:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="534559345"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga008.jf.intel.com with ESMTP; 24 Jan 2022 20:44:28 -0800
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] iommu: Add iommu_domain::domain_ops
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-8-baolu.lu@linux.intel.com>
 <Ye5zUapC/YcZs7kl@infradead.org> <20220124172418.GE966497@nvidia.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <256b0ae8-47c5-24ac-0ca9-8f0936505656@linux.intel.com>
Date:   Tue, 25 Jan 2022 12:43:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220124172418.GE966497@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/22 1:24 AM, Jason Gunthorpe wrote:
> On Mon, Jan 24, 2022 at 01:37:21AM -0800, Christoph Hellwig wrote:
>> On Mon, Jan 24, 2022 at 03:11:02PM +0800, Lu Baolu wrote:
>>> Add a domain specific callback set, domain_ops, for vendor iommu driver
>>> to provide domain specific operations. Move domain-specific callbacks
>>> from iommu_ops to the domain_ops and hook them when a domain is allocated.
>>
>> Ah, that's what I meant earlier.  Perfect!
>>
>> Nit:  I don't think vendor is the right term here.
> 
> +1 please don't use the confusing 'vendor' in the kernel, if you feel
> you want to write 'vendor' writing 'device driver' is usually a good
> choice..

Sure!

> 
> This whole series is nice, the few small notes aside, thanks for
> making it!

Thank you!

> 
> Jason
> 

Best regards,
baolu
