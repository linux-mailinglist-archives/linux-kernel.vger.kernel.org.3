Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E2B4EC661
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346732AbiC3OWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346726AbiC3OWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:22:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1A5DFD72;
        Wed, 30 Mar 2022 07:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648650062; x=1680186062;
  h=message-id:date:mime-version:to:references:from:subject:
   in-reply-to:content-transfer-encoding;
  bh=FiqZAxLNLSA3q+0iMDyStSVs9TexPD0XlwioqNQSJ74=;
  b=XRwHNfOcj1wkt79zUBZ06TAdzT8+RKN4d+NqJDK7I7tPKG6H58VJZgeY
   EDOlPEKVN2hlrq01uQ44xENVwMusWuww8Z82+SH0MdMZ0HjGxQaSqh73U
   vF7fqLLxAuDSLfaSodO5QraIzlrUEr+D/aGsC0V1A1nRljppl+zv65pXF
   jMKnxCEQtqqV2lR/f7bZ3ArWYJXCgD2ie+4GKL0VUW0KnZx8Bc/wg+Qqc
   nXZ8nQmNGV3Z9zzkdGig4BgcgC/o+p0YyzeTSImIlNER78VzvV/xHfian
   VA2rtJr35TrkNqOEScauQQubqK1Y2s8hotNXovcGM0qqEtyp1ZekZnon4
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="322733928"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="322733928"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 07:20:44 -0700
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="586015679"
Received: from amahade1-mobl2.amr.corp.intel.com (HELO [10.209.45.250]) ([10.209.45.250])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 07:20:44 -0700
Message-ID: <79bde999-cf8d-796b-1ddf-3cf612d28375@intel.com>
Date:   Wed, 30 Mar 2022 07:20:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "will@kernel.org" <will@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "Hegde, Vasant" <Vasant.Hegde@amd.com>
References: <20220328172829.718235-1-alexander.deucher@amd.com>
 <20220328172829.718235-2-alexander.deucher@amd.com>
 <b3998af9-24bc-6191-a8ed-de747e895799@intel.com>
 <BL1PR12MB5144C7172FCB8ED2C1AB013AF71F9@BL1PR12MB5144.namprd12.prod.outlook.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH V3 1/2] Documentation: x86: Add documentation for AMD
 IOMMU
In-Reply-To: <BL1PR12MB5144C7172FCB8ED2C1AB013AF71F9@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/22 07:01, Deucher, Alexander wrote:
>> Just scanning this, it looks *awfully* generic.  Is anything in
>> here AMD- specific?  Should this be in an AMD-specific file?
> There is some information about the ACPI tables used to enumerate the
> IOMMUs and a link to the AMD IOMMU programming documentation.  Would
> you prefer I just create a combined x86 IOMMU document?

Yeah, I think that would make a lot of sense.  Let's just have one
document with an AMD section and an Intel section.  Maybe just rename
the existing one to intel-iommu => x86-iommu.rst.
