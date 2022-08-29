Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDE75A5272
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 19:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiH2RAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 13:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbiH2RAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 13:00:09 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AF34A811;
        Mon, 29 Aug 2022 10:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661792407; x=1693328407;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6nppHl6aPXqc0co9Epu68ExNtuFi/fpCELicTEOpI80=;
  b=Qjw3/7BFfbUa9vcgckOXu9Opxf/g/G5pfRyCOf49MTRw1zBbjffsuEjE
   Qx0C0jFPt2U/W5YCOWqLleRF09DtDymEztDQdn4sZUMcDuGI6ywtnKZ1v
   NXUV/8yFggHf+SV4e2rv5H4JDd8PA4qLstAfPcZA3pNYnpfauS5xdP8Es
   pilXT02Xkw8bIedF/AffvpXkp39K3ildMOmEB6F5DGtSWfHpkoOWgqLlp
   P5hEDPOsDyQi08Dizo1/ACmAe1LfesqMFsiaEvXgi3Ae3vkx/WacqQgc+
   wOaeoQbod8bXJj9AYGnLJ+hd5NldSckUYCVeVNQhAbbU1s9qNTKbrHQLP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="295724910"
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="295724910"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 10:00:05 -0700
X-IronPort-AV: E=Sophos;i="5.93,272,1654585200"; 
   d="scan'208";a="562295517"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 10:00:04 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oSi7F-005c6k-2I;
        Mon, 29 Aug 2022 20:00:01 +0300
Date:   Mon, 29 Aug 2022 20:00:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v1] ACPI: property: Use acpi_dev_parent()
Message-ID: <YwzwkdAZwNTBQ3gh@smile.fi.intel.com>
References: <4756666.GXAFRqVoOG@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4756666.GXAFRqVoOG@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 06:12:33PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After introducing acpi_dev_parent() in commit 62fcb99bdf10 ("ACPI: Drop
> parent field from struct acpi_device"), it is better to use it instead
> of accessing the dev.parent field in struct acpi_device directly.
> 
> Modify acpi_node_get_parent() accordingly.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/property.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> Index: linux-pm/drivers/acpi/property.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/property.c
> +++ linux-pm/drivers/acpi/property.c
> @@ -1269,10 +1269,11 @@ acpi_node_get_parent(const struct fwnode
>  		return to_acpi_data_node(fwnode)->parent;
>  	}
>  	if (is_acpi_device_node(fwnode)) {
> -		struct device *dev = to_acpi_device_node(fwnode)->dev.parent;
> +		struct acpi_device *parent;
>  
> -		if (dev)
> -			return acpi_fwnode_handle(to_acpi_device(dev));
> +		parent = acpi_dev_parent(to_acpi_device_node(fwnode));
> +		if (parent)
> +			return acpi_fwnode_handle(parent);
>  	}
>  
>  	return NULL;
> 
> 
> 

-- 
With Best Regards,
Andy Shevchenko


