Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCB24E699F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 21:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353211AbiCXUIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 16:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344496AbiCXUH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 16:07:58 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A34B245A;
        Thu, 24 Mar 2022 13:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648152385; x=1679688385;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4b6Q5AeNUsXrQLS4CUq/v1V1fB0QTvyDrCfbOyN12s4=;
  b=nztQb8i7u5UjcDrI58ZfdirWxRQ+DO8VeuTx+nZeAQnH3rVQA0YNTPqq
   ZP1FeYBTOPFmlaoyDM44r8upQJpUCLnNx/L7wvgZ6ZjEF0fb7GJaDK0Sy
   8B7Jf0gIeyY6ny5jMs7EDirRAqF51UMtgx81VdUZT8W6XT2sO8hZfnZt0
   xpYs8vCr///fReX4muaeyVrpuWmdoJMh8ifR75PWkBBivBzxVMKRRkO11
   c8A4AMJ2cUmV0tG62QwSgb120zGJFpLjEUHkkp/psxXN7m6yBFsdsD2UV
   j+ApWbAaayTyrP9gLETLMMHoLBftTmyB0pB6MAr8LekQhB+14o1mubM1C
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="258431944"
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="258431944"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 13:06:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="601812139"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 24 Mar 2022 13:06:24 -0700
Received: from zgheewax-mobl1.amr.corp.intel.com (unknown [10.209.111.152])
        by linux.intel.com (Postfix) with ESMTP id 41819580A6C;
        Thu, 24 Mar 2022 13:06:24 -0700 (PDT)
Message-ID: <2dd0d607e5430262ae81a3eb3c2e95412d9f7ef8.camel@linux.intel.com>
Subject: Re: [PATCH 1/4] Documentation/ABI: sysfs-driver-intel_sdsi: Fix
 sphinx warnings
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Mark Pearson <markpearson@lenovo.com>,
        Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Date:   Thu, 24 Mar 2022 13:06:24 -0700
In-Reply-To: <20220324164737.21765-2-hdegoede@redhat.com>
References: <20220324164737.21765-1-hdegoede@redhat.com>
         <20220324164737.21765-2-hdegoede@redhat.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-03-24 at 17:47 +0100, Hans de Goede wrote:
> Fix the following warnings from "make htmldocs":
> 
> Documentation/ABI/testing/sysfs-driver-intel_sdsi:2:
>   WARNING: Unexpected indentation.
>   WARNING: Block quote ends without a blank line; unexpected unindent.
>   WARNING: Definition list ends without a blank line; unexpected unindent.
> 
> By turning the error-code table into a proper ReST table. While at it
> also fix the error-code table mixing tab and spaces for indentation
> (switch to all tabs).

Thanks for the fix and for clarifying how to reproduce.

David

> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  .../ABI/testing/sysfs-driver-intel_sdsi        | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-intel_sdsi
> b/Documentation/ABI/testing/sysfs-driver-intel_sdsi
> index ab122125ff9a..96b92c105ec4 100644
> --- a/Documentation/ABI/testing/sysfs-driver-intel_sdsi
> +++ b/Documentation/ABI/testing/sysfs-driver-intel_sdsi
> @@ -13,17 +13,19 @@ Description:
>  		Should the operation fail, one of the following error codes
>  		may be returned:
>  
> +		==========	=====
>  		Error Code	Cause
> -	        ----------	-----
> -	        EIO		General mailbox failure. Log may indicate
> cause.
> -	        EBUSY		Mailbox is owned by another agent.
> -	        EPERM		SDSI capability is not enabled in hardware.
> -	        EPROTO		Failure in mailbox protocol detected by
> driver.
> +		==========	=====
> +		EIO		General mailbox failure. Log may indicate
> cause.
> +		EBUSY		Mailbox is owned by another agent.
> +		EPERM		SDSI capability is not enabled in hardware.
> +		EPROTO		Failure in mailbox protocol detected by
> driver.
>  				See log for details.
> -	        EOVERFLOW	For provision commands, the size of the data
> +		EOVERFLOW	For provision commands, the size of the data
>  				exceeds what may be written.
> -	        ESPIPE		Seeking is not allowed.
> -	        ETIMEDOUT	Failure to complete mailbox transaction in time.
> +		ESPIPE		Seeking is not allowed.
> +		ETIMEDOUT	Failure to complete mailbox transaction in time.
> +		==========	=====
>  
>  What:		/sys/bus/auxiliary/devices/intel_vsec.sdsi.X/guid
>  Date:		Feb 2022

