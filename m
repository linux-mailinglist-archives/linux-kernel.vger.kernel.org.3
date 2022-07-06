Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA78B569169
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbiGFSLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbiGFSLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:11:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5F629808;
        Wed,  6 Jul 2022 11:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657131091; x=1688667091;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0zWzCdVc4rRVUioOFiMduDaq3HrqzT/oA494L3FgPAA=;
  b=M5YmG2ziK6V3KL6QYP2iBCjAIJ13qmxfcwc7BoJu1CO33pXBaYMSFKhV
   MC7QRFbvbJZto7lU4/dwlXnE7Tr/qSye8UbKHtBwxh9Soej7A0uCFHdFj
   jphGPk0L0VPpyIOuw0oxldTVWnHEFa6vbBu5VgwvCzZmm6MtvMVzIPgxy
   5H15fIV71+DwGGrLfTKm+2HZTv4ZPrryqEErgKsa5+bmUKvUm89Z2oLZu
   m0Cr60pi7pvFc95SuUXFMuktvq3CJpAz2+OgD5VpikAfcIV07G5zu9sEZ
   e+mcwJgX1MJ1+GykuuPJX7JM56Ge4tsirw7DAEOPTA9J/wm41UJ4/2VNn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="281381358"
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="281381358"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 11:11:31 -0700
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="620436130"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.34.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 11:11:28 -0700
Message-ID: <51f6d094-22b8-ddca-4851-f07a7749af0a@intel.com>
Date:   Wed, 6 Jul 2022 21:11:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH v2] scsi: ufs: ufs-pci: Enable WriteBooster capability on
 ADL
Content-Language: en-US
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20220705165316.v2.1.Ib5ebec952d9a59f5c69c89b694777f517d22466d@changeid>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220705165316.v2.1.Ib5ebec952d9a59f5c69c89b694777f517d22466d@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/07/22 09:53, Daniil Lunev wrote:
> Sets the WriteBooster capability flag when ADL's UFS controller is used.
> 
> Signed-off-by: Daniil Lunev <dlunev@chromium.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> ---
> 
> Changes in v2:
> - Fixed typo in commit message
> 
>  drivers/scsi/ufs/ufshcd-pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/scsi/ufs/ufshcd-pci.c b/drivers/scsi/ufs/ufshcd-pci.c
> index e892b9feffb11..fb7285a756969 100644
> --- a/drivers/scsi/ufs/ufshcd-pci.c
> +++ b/drivers/scsi/ufs/ufshcd-pci.c
> @@ -425,6 +425,7 @@ static int ufs_intel_adl_init(struct ufs_hba *hba)
>  {
>  	hba->nop_out_timeout = 200;
>  	hba->quirks |= UFSHCD_QUIRK_BROKEN_AUTO_HIBERN8;
> +	hba->caps |= UFSHCD_CAP_WB_EN;
>  	return ufs_intel_common_init(hba);
>  }
>  

