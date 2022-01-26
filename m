Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8244649BFCF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 01:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbiAZAB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 19:01:29 -0500
Received: from mga12.intel.com ([192.55.52.136]:37165 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235042AbiAZAB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 19:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643155287; x=1674691287;
  h=cc:subject:to:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=SpDhNbUZcRauXonP/+d7u6so8MOKDyCHLSxBXrM0t8M=;
  b=BR6WRvdV0xpX1wwmkHhMSWj9Ea5Sl9tt5qgJh7ElWeSCCX/6okDVTw1J
   55hIQSiND32+wJVPqa6kQGoQkIRZallTWr7Abb2OF/OHsKadSOv0smhSr
   VeAqmOU2OmIX4rcvFkNjnQu+LGiR5C+J6QnWO21pilFnfNuBmI2hs7Tpt
   GNHXE7EJch0jPeVOy1dcErcfbD6jJCUDmICyH4wKFhLdjhUErgQltSY3K
   WA/mOcDtyrdGbcYjKblhEO0o6Hh06SP3XgFiJPS13zxAwydizTmbKPslb
   IXW/NvpUxEPP14209w4Y0jTIahL1xcm7D/E3mnRp0PThKUJBD9GBfJmNs
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="226421475"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="226421475"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 16:01:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="534956436"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga008.jf.intel.com with ESMTP; 25 Jan 2022 16:01:25 -0800
Cc:     baolu.lu@linux.intel.com,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Raj Ashok <ashok.raj@intel.com>
Subject: Re: [PATCH v2] iommu/vt-d: Fix PCI bus rescan device hot add
To:     Jacob Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>
References: <1642148470-11949-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <20220125105704.2375daed@jacob-builder>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e83922c1-59af-6e65-abc5-802400ecb4e3@linux.intel.com>
Date:   Wed, 26 Jan 2022 08:00:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220125105704.2375daed@jacob-builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 1/26/22 2:57 AM, Jacob Pan wrote:
> Hi all,
> 
> Just wondering if there are any other comments? This fixes a
> regression that can cause system hang.

This looks fine to me. I will queue it for v5.17 if there's no further
comments.

Best regards,
baolu
