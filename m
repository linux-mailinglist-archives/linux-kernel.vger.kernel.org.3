Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498F94AD062
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 05:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345305AbiBHEcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 23:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239870AbiBHEco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 23:32:44 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEAFC0401DC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 20:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644294764; x=1675830764;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MaA6fWv9eHIr5rZu+J4Ln334/itdZkGgcCnY/wetP3I=;
  b=VPWM/FFLtRK/m4YUpjcJ76cHpYbKwJESrHGhumykieWD3ssfRpPE0Ht7
   3gK72XDB9HitWn/Mms9Qhw9K7Cnqdbj2ulM6wEC4+jjZMR/m9jvGUWMAU
   AgnPt9xPrzc+6NQpgDVDD6tCRUrCzUfbMCvbUJqBxkExyNS11IxqPBbIy
   omdzDIC0XsZp+kF50tfX9X1q/axrNwoAumCzYVVH50escRWLUUPD6h1tz
   IV7oETOwynTV2cwc55V230yHP0Iy1Npr5CK9DVKNWsaC9aGGOpPG6VX0V
   KBBNjxP0b/rlMEE+DnttOFQglWzbNoVSXYLJvrHABpx+W9DnTxDLh9jjI
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="248633490"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="248633490"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 20:32:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="677985804"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2022 20:32:41 -0800
Message-ID: <3d3b34a8-4f23-133a-9619-25c834f95cf5@linux.intel.com>
Date:   Tue, 8 Feb 2022 12:31:30 +0800
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
Subject: Re: [PATCH v1 06/10] iommu/vt-d: Remove DEFER_DEVICE_DOMAIN_INFO
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
References: <20220207064142.1092846-1-baolu.lu@linux.intel.com>
 <20220207064142.1092846-7-baolu.lu@linux.intel.com>
 <20220207071209.GF23941@lst.de>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220207071209.GF23941@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/22 3:12 PM, Christoph Hellwig wrote:
>>   struct device_domain_info *get_domain_info(struct device *dev)
>>   {
>> +	return dev_iommu_priv_get(dev);
>>   }
> 
> I'd remove this now pointles wrapper entirely.

Yes. Will do it.

Best regards,
baolu
