Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175234FCEA4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 07:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347455AbiDLFQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 01:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiDLFP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 01:15:59 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC78344D3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 22:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649740422; x=1681276422;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7RIfU1Kze0Bl1IPpLchMd6X7VZcxVVzBh63sfL5BABQ=;
  b=UtNZ8139rifRRNF/0Y94Gy7yi+BqK+hhoI7uXzZVvNnucSvAtR6HP7iJ
   RZUbjSekbGCDDS8wmeq46y8VC16q0GKfRm5DTb60xVdVo3rtbv4bmkm5E
   W22MHywI6EMSDAkN6tooeqyJpDY3eVfhsvG64vre4e+CmMCNwtWbbl/lD
   x1YrxvShfUOymTktH1t6bdTSx89LrLfQ5PBvwmYYNDR4tPOiMCdWSfh1a
   6LBjnw6+ml2g7fqdeMY7lxY/vB3eMugNbIn3zrpDZsrSQmuO38WcF4NLE
   ZgnKA8mtflZTmTCszu9SOuSRqg+Uld+gVek5hUmdaqD6ZyOoOwyJkikl2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="242864621"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="242864621"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 22:13:42 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="572568841"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.210]) ([10.254.215.210])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 22:13:40 -0700
Message-ID: <d87918be-9ab8-ca6b-ea1f-b6e9fafb1d44@linux.intel.com>
Date:   Tue, 12 Apr 2022 13:13:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Change return type of
 dmar_insert_one_dev_info()
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
References: <20220409133006.3953129-1-baolu.lu@linux.intel.com>
 <YlQ6feP5Dd9Ux18Y@infradead.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <YlQ6feP5Dd9Ux18Y@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/11 22:26, Christoph Hellwig wrote:
> On Sat, Apr 09, 2022 at 09:30:06PM +0800, Lu Baolu wrote:
>> The dmar_insert_one_dev_info() returns the pass-in domain on success and
>> NULL on failure. This doesn't make much sense. Change it to an integer.
> 
> Looks sensibel.  Why not also merge it with domain_add_dev_info while
> you're at it?

It looks cleaner that way. Thanks a lot!

Best regards,
baolu
