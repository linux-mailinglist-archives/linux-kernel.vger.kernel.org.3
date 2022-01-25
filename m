Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53DA49AC46
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 07:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244644AbiAYGTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 01:19:47 -0500
Received: from mga12.intel.com ([192.55.52.136]:19009 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1391793AbiAYFKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 00:10:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643087439; x=1674623439;
  h=cc:subject:to:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=V9CYJ2kCUBsupqpOKFqBBwFqKIJsJUlTvgIb6c/puoE=;
  b=T7CiCInR6GEr1rc7oRsrGhQTgZGmqXUbbgK22Faz7/PYWgcNbIsxj0eV
   JrkD34/An/jqzKaIR3LX3YU1Swm5CyFjdTwoK5zgLkh48HuRL8l6u2Sx1
   +7dCi5jT+YnV58pl21+Cs2GZCRpQHdyvZPos/A8hmJkucaUkQ1YRg3+a9
   LWVultPjdpkJ5Xba9PG61XKzLz/MDaycRJQIbWy5wP1YQ5Z7ODQV1qjnm
   JE2tjuGeQFEPdIN7GuNjIrJkIN9XAha5nPp3jTmc6fVBRf6jy51LFtALk
   M1rq/JjlWBMT2Q3L8ewabqYpZVRs3Ix8lj1GnYZZUvY/9jI8CZ/eagVFe
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="226198648"
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="226198648"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 21:05:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,314,1635231600"; 
   d="scan'208";a="534564947"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga008.jf.intel.com with ESMTP; 24 Jan 2022 21:05:43 -0800
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
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
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-8-baolu.lu@linux.intel.com>
 <20220124175542.GA987164@nvidia.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <6fd81c95-6fd6-d678-b7df-f2f747e2b10c@linux.intel.com>
Date:   Tue, 25 Jan 2022 13:04:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220124175542.GA987164@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/22 1:55 AM, Jason Gunthorpe wrote:
> On Mon, Jan 24, 2022 at 03:11:02PM +0800, Lu Baolu wrote:
>> -	int (*enable_nesting)(struct iommu_domain *domain);
> 
> 
> Lu, there is an implementation in the Intel driver here, is it usable
> at all?

It's useless and I have cleaned it up in this series.

> 
> Jason
> 

Best regards,
baolu
