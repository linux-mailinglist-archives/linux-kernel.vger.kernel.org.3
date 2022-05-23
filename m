Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B886F531D29
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245273AbiEWSM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244333AbiEWRne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 13:43:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E009E9FA;
        Mon, 23 May 2022 10:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653327319; x=1684863319;
  h=message-id:subject:from:to:date:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Bmuxda2WSsU89OIt8CXTOK0joD5GKCcKnL7zGiZtR0g=;
  b=ce0yjBbJZfpFyotEG9Bl8gXPka7WdaczdXvOp6di0JvzA35L5TYRgNcd
   zqypa5Tfq58dCjWwhMvpZuzjF43mAeZ9paNEEAK5xZUtpeDAAfgfgL8BY
   OEvk/7N/SyONY94EddsOBhDNh9sPaf/cDuBXT396EvabyHbRD2JsUt0wK
   FX0S9ilTyCxQa3mhmuDw9mqwG38hDVSJCHq/arL6+fX8QvU40PPVQmtRd
   sxleIL9QUumojnZATxd8iqWHPwHC0/wsVbuirtOgF4NjYPqvGsMqmwC9R
   66rGJwwdwt42GOG9inChc6mVcTSciIzIRn4Fqmih5bzN6MMxtvjeJFHzO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="298614058"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="298614058"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 10:34:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="744848043"
Received: from ijgarcia-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.152.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 10:34:34 -0700
Message-ID: <700214729a042ef80ea06b3f2c2b2399d63a84ae.camel@linux.intel.com>
Subject: Re: [PATCH] thermal: int340x: Add Meteor Lake PCI device id
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        atenart@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 23 May 2022 10:34:33 -0700
In-Reply-To: <20220523172242.30378-1-sumeet.r.pawnikar@intel.com>
References: <20220523172242.30378-1-sumeet.r.pawnikar@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-05-23 at 22:52 +0530, Sumeet Pawnikar wrote:
> Add Meteor Lake PCI ID for processor thermal device.
> 
> Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> Signed-off-by: Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com>
Replace Signed-off-by 
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/thermal/intel/int340x_thermal/processor_thermal_device.h | 1
> +
>  .../thermal/intel/int340x_thermal/processor_thermal_device_pci.c | 1
> +
>  2 files changed, 2 insertions(+)
> 
> diff --git
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> index 49932a68abac..7d52fcff4937 100644
> ---
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> +++
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.h
> @@ -24,6 +24,7 @@
>  #define PCI_DEVICE_ID_INTEL_HSB_THERMAL        0x0A03
>  #define PCI_DEVICE_ID_INTEL_ICL_THERMAL        0x8a03
>  #define PCI_DEVICE_ID_INTEL_JSL_THERMAL        0x4E03
> +#define PCI_DEVICE_ID_INTEL_MTLP_THERMAL       0x7D03
>  #define PCI_DEVICE_ID_INTEL_RPL_THERMAL        0xA71D
>  #define PCI_DEVICE_ID_INTEL_SKL_THERMAL        0x1903
>  #define PCI_DEVICE_ID_INTEL_TGL_THERMAL        0x9A03
> diff --git
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.
> c
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.
> c
> index ca40b0967cdd..c2dc4c158b9d 100644
> ---
> a/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.
> c
> +++
> b/drivers/thermal/intel/int340x_thermal/processor_thermal_device_pci.
> c
> @@ -358,6 +358,7 @@ static SIMPLE_DEV_PM_OPS(proc_thermal_pci_pm,
> proc_thermal_pci_suspend,
>  
>  static const struct pci_device_id proc_thermal_pci_ids[] = {
>         { PCI_DEVICE_DATA(INTEL, ADL_THERMAL,
> PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR |
> PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_MBOX) },
> +       { PCI_DEVICE_DATA(INTEL, MTLP_THERMAL,
> PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR |
> PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_MBOX) },
>         { PCI_DEVICE_DATA(INTEL, RPL_THERMAL,
> PROC_THERMAL_FEATURE_RAPL | PROC_THERMAL_FEATURE_FIVR |
> PROC_THERMAL_FEATURE_DVFS | PROC_THERMAL_FEATURE_MBOX) },
>         { },
>  };

