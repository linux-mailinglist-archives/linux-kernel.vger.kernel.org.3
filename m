Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A8651C2DF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380765AbiEEOuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239738AbiEEOui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:50:38 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37A55A2DD;
        Thu,  5 May 2022 07:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651762018; x=1683298018;
  h=message-id:subject:from:to:date:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=+g0ZPiBRorA5mCXWj9Gt0w+UOvEWbHZUt6N/DvQ1VKI=;
  b=ByAczt4Y1QHTq506oCFStU8L3lETdI0F1/MLxOx/dgaDxtDaKdV2v88g
   9mSi1xPdlleTSaGDYwtxsGml8ddUNkzfnW6Ff8tqfzFVW3G1oZWF7r1XD
   qXFEn4zixMM38ErCheVFw30eZXkd5ayh2oklzQHRbRP0MyKPRpGzD927Z
   9CHVx1rdaFoG9AvZZPDh+oqS8P60ZYJLurW0RZLO/EntgBmcrillJo7KC
   Du+wfJMRruO/zQFBvXBRkgAweFbKY+9R5TeYlAS9tzIBMDPvx4MT+popM
   Q8yhXzqKQy+IOn/2A8H0ZN5AfxxY7VGg2xS7cNRm7WrqGTEQdNOelSTK1
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="248665508"
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="248665508"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 07:46:58 -0700
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="664991338"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 07:46:58 -0700
Message-ID: <305d709b037e2d56ac7eaaa66567c9a91afcf737.camel@linux.intel.com>
Subject: Re: [PATCH] ACPI: DPTF: Add support for high frequency impedance
 notification
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>, rafael@kernel.org,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 05 May 2022 07:46:57 -0700
In-Reply-To: <20220427155130.8023-1-sumeet.r.pawnikar@intel.com>
References: <20220427155130.8023-1-sumeet.r.pawnikar@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-27 at 21:21 +0530, Sumeet Pawnikar wrote:
> Add high frequency impedance notification support under DPTF.
> This returns high frequency impedance value that can be obtained
> from battery fuel gauge whenever there is change over a threshold.
> 
I think you should add
While here corrected spelling from IMPEDANCED_CHNGED to
IMPEDANCE_CHANGED.

Otherwise looks good to me.

Thanks,
Srinivas

> Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> ---
>  drivers/acpi/dptf/dptf_power.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/dptf/dptf_power.c
> b/drivers/acpi/dptf/dptf_power.c
> index dc1f52a5b3f4..2ef53ca88714 100644
> --- a/drivers/acpi/dptf/dptf_power.c
> +++ b/drivers/acpi/dptf/dptf_power.c
> @@ -117,7 +117,7 @@ static const struct attribute_group
> dptf_battery_attribute_group = {
>  #define POWER_STATE_CHANGED            0x81
>  #define STEADY_STATE_POWER_CHANGED     0x83
>  #define POWER_PROP_CHANGE_EVENT        0x84
> -#define IMPEDANCED_CHNGED              0x85
> +#define IMPEDANCE_CHANGED              0x85
>  #define VOLTAGE_CURRENT_CHANGED        0x86
>  
>  static long long dptf_participant_type(acpi_handle handle)
> @@ -150,6 +150,9 @@ static void dptf_power_notify(acpi_handle handle,
> u32 event, void *data)
>         case STEADY_STATE_POWER_CHANGED:
>                 attr = "max_steady_state_power_mw";
>                 break;
> +       case IMPEDANCE_CHANGED:
> +               attr = "high_freq_impedance_mohm";
> +               break;
>         case VOLTAGE_CURRENT_CHANGED:
>                 attr = "no_load_voltage_mv";
>                 break;


