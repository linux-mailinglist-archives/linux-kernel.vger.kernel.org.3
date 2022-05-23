Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29002531C43
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243327AbiEWSOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242566AbiEWRto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 13:49:44 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF2F50022;
        Mon, 23 May 2022 10:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653327468; x=1684863468;
  h=message-id:subject:from:to:date:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=JCT/nWHZYeziogLc8GS1LhNamHaEPr2iY6hb4qHut3E=;
  b=OYj1fOjfZxwaG4TTKwdjspwC2oIqqEUKjGpvA6rgeXnu4DMJtOyYfH87
   MX3kb5/yctlU9yPJeiwh6gTH5qOr9ulV+K0nRd7nNruGNQ3e5Np+4dJoD
   16JyfqtAaPCm44jMKJvfp4Nze8EN3FJzeQosemkuI3S9Qs58xqWVLD7ny
   UWTUus8x8c+6FRvuTvMd1De4DrTdyWrLjDJ6bzpUUGUDo+YQ5RIZY1/mZ
   F1oaJ+7G8DS4A5wyed5QlWv92bGqUio8GoKKk6rGYi3bHskd6lsQmNhRZ
   ylZnADc4jWo9hgBPhizrn6YC8EXS+2/RNXx0CCLXXTC+dh3iSwkTEbwxG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="255365583"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="255365583"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 10:35:05 -0700
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="577512790"
Received: from ijgarcia-mobl.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.212.152.3])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 10:35:04 -0700
Message-ID: <1cbb92bc48793177b24abcb13352c17a3b759542.camel@linux.intel.com>
Subject: Re: [PATCH] ACPI: DPTF: Support Meteor Lake
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>, rafael@kernel.org,
        lenb@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 23 May 2022 10:35:04 -0700
In-Reply-To: <20220523172724.30556-1-sumeet.r.pawnikar@intel.com>
References: <20220523172724.30556-1-sumeet.r.pawnikar@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-05-23 at 22:57 +0530, Sumeet Pawnikar wrote:
> Add Meteor Lake ACPI IDs for DPTF devices.
> 
> Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> Signed-off-by: Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com>
Replace Signed-off-by 
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>


> ---
>  drivers/acpi/dptf/dptf_pch_fivr.c                       | 1 +
>  drivers/acpi/dptf/dptf_power.c                          | 2 ++
>  drivers/acpi/dptf/int340x_thermal.c                     | 6 ++++++
>  drivers/acpi/fan.h                                      | 1 +
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 1 +
>  drivers/thermal/intel/int340x_thermal/int3403_thermal.c | 1 +
>  6 files changed, 12 insertions(+)
> 
> diff --git a/drivers/acpi/dptf/dptf_pch_fivr.c
> b/drivers/acpi/dptf/dptf_pch_fivr.c
> index c0da24c9f8c3..4919e7abe93f 100644
> --- a/drivers/acpi/dptf/dptf_pch_fivr.c
> +++ b/drivers/acpi/dptf/dptf_pch_fivr.c
> @@ -151,6 +151,7 @@ static int pch_fivr_remove(struct platform_device
> *pdev)
>  static const struct acpi_device_id pch_fivr_device_ids[] = {
>         {"INTC1045", 0},
>         {"INTC1049", 0},
> +       {"INTC1064", 0},
>         {"INTC10A3", 0},
>         {"", 0},
>  };
> diff --git a/drivers/acpi/dptf/dptf_power.c
> b/drivers/acpi/dptf/dptf_power.c
> index dc1f52a5b3f4..a5f29d061b37 100644
> --- a/drivers/acpi/dptf/dptf_power.c
> +++ b/drivers/acpi/dptf/dptf_power.c
> @@ -231,6 +231,8 @@ static const struct acpi_device_id
> int3407_device_ids[] = {
>         {"INTC1050", 0},
>         {"INTC1060", 0},
>         {"INTC1061", 0},
> +       {"INTC1065", 0},
> +       {"INTC1066", 0},
>         {"INTC10A4", 0},
>         {"INTC10A5", 0},
>         {"", 0},
> diff --git a/drivers/acpi/dptf/int340x_thermal.c
> b/drivers/acpi/dptf/int340x_thermal.c
> index 42a556346548..b7113fa92fa6 100644
> --- a/drivers/acpi/dptf/int340x_thermal.c
> +++ b/drivers/acpi/dptf/int340x_thermal.c
> @@ -27,6 +27,7 @@ static const struct acpi_device_id
> int340x_thermal_device_ids[] = {
>         {"INT3532"},
>         {"INTC1040"},
>         {"INTC1041"},
> +       {"INTC1042"},
>         {"INTC1043"},
>         {"INTC1044"},
>         {"INTC1045"},
> @@ -37,6 +38,11 @@ static const struct acpi_device_id
> int340x_thermal_device_ids[] = {
>         {"INTC1050"},
>         {"INTC1060"},
>         {"INTC1061"},
> +       {"INTC1062"},
> +       {"INTC1063"},
> +       {"INTC1064"},
> +       {"INTC1065"},
> +       {"INTC1066"},
>         {"INTC10A0"},
>         {"INTC10A1"},
>         {"INTC10A2"},
> diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
> index 44728529a5b6..e7b4b4e4a55e 100644
> --- a/drivers/acpi/fan.h
> +++ b/drivers/acpi/fan.h
> @@ -14,6 +14,7 @@
>         {"INT3404", }, /* Fan */ \
>         {"INTC1044", }, /* Fan for Tiger Lake generation */ \
>         {"INTC1048", }, /* Fan for Alder Lake generation */ \
> +       {"INTC1063", }, /* Fan for Meteor Lake generation */ \
>         {"INTC10A2", }, /* Fan for Raptor Lake generation */ \
>         {"PNP0C0B", } /* Generic ACPI fan */
>  
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index 79931ddc582a..1ea861473cba 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -669,6 +669,7 @@ static const struct acpi_device_id
> int3400_thermal_match[] = {
>         {"INT3400", 0},
>         {"INTC1040", 0},
>         {"INTC1041", 0},
> +       {"INTC1042", 0},
>         {"INTC10A0", 0},
>         {}
>  };
> diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> index 07e25321dfe3..71d084c4c456 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> @@ -285,6 +285,7 @@ static const struct acpi_device_id
> int3403_device_ids[] = {
>         {"INT3403", 0},
>         {"INTC1043", 0},
>         {"INTC1046", 0},
> +       {"INTC1062", 0},
>         {"INTC10A1", 0},
>         {"", 0},
>  };

