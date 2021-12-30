Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9CF482047
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 21:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242112AbhL3Uic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 15:38:32 -0500
Received: from mga04.intel.com ([192.55.52.120]:45394 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242088AbhL3Uib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 15:38:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640896711; x=1672432711;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gHdXfN1jkxy00D9dvyWw6ANnxvJHm9ol2k2+g3ilFyI=;
  b=SytwXUeyQwZzXCX1KAcYQevL613fmJY5kKNQBftG65ilA8F68ErwE9xt
   CBHMRYtiT0yNRa5ETLVstUQB81AZDkcHVLfquwN+TLvVOMqW6bywsF2Tj
   EdocTbfawavMVVOB5YTxJcchKPPczOaTAZqkjK38ujukhCJ6Rg9i/hfgA
   eJkYwRTcR2lOH6GJZvJ/wJIncHCNR/jg4bVexKyAppgHcvAd1lcA0E4P4
   RiIzBwKzg61fr9p8AGZZA/hrt5sLIad610DGTTNm+SdK5RVUaVCgd9h+f
   pKknVEpi7TNu6mwLSUk/cwg18WMRoLguSh9nEl3g92PhJXCexvKuUZVdH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="240515315"
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="240515315"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 12:38:30 -0800
X-IronPort-AV: E=Sophos;i="5.88,248,1635231600"; 
   d="scan'208";a="524508614"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2021 12:38:30 -0800
Date:   Thu, 30 Dec 2021 12:38:29 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     vishal.l.verma@intel.com, dan.j.williams@intel.com,
        dave.jiang@intel.com, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] nvdimm/btt: Fix btt_init() kernel-doc comment
Message-ID: <20211230203829.GA95811@iweiny-DESK2.sc.intel.com>
Mail-Followup-To: Yang Li <yang.lee@linux.alibaba.com>,
        vishal.l.verma@intel.com, dan.j.williams@intel.com,
        dave.jiang@intel.com, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20211230092520.115275-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211230092520.115275-1-yang.lee@linux.alibaba.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 05:25:20PM +0800, Yang Li wrote:
> Add the description of @nd_region and remove @maxlane in
> btt_init() kernel-doc comment to remove warnings found
> by running scripts/kernel-doc, which is caused by using 'make W=1'.
> drivers/nvdimm/btt.c:1584: warning: Function parameter or member
> 'nd_region' not described in 'btt_init'
> drivers/nvdimm/btt.c:1584: warning: Excess function parameter 'maxlane'
> description in 'btt_init'
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/nvdimm/btt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
> index da3f007a1211..293b8c107817 100644
> --- a/drivers/nvdimm/btt.c
> +++ b/drivers/nvdimm/btt.c
> @@ -1567,7 +1567,7 @@ static void btt_blk_cleanup(struct btt *btt)
>   * @rawsize:	raw size in bytes of the backing device
>   * @lbasize:	lba size of the backing device
>   * @uuid:	A uuid for the backing device - this is stored on media
> - * @maxlane:	maximum number of parallel requests the device can handle
> + * @nd_region:  region id and number of lanes possible
>   *
>   * Initialize a Block Translation Table on a backing device to provide
>   * single sector power fail atomicity.
> -- 
> 2.20.1.7.g153144c
> 
