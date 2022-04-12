Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35D24FE79E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 20:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358593AbiDLSI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 14:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239431AbiDLSI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 14:08:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E85E4CD5C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 11:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649786798; x=1681322798;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IeaSKSuXPhVpXFM/OGOekdHqEQjfF86SwDcNvu0ysGk=;
  b=nggviThdHYwy2EYrznEuH+LirmSCGdvzQWuh9LdWXX2dDajsy+lUNYgS
   kMErNyHoIR90U0JLjDvRdHVl5G3CzUxx6Y5u6/51M7aY89H8YebASj/+6
   yYW+pMgyy2N0je3SZkWwG8mLzBwIw2/8XMVUpvYostnb2xM34WYyvddVK
   D98cpNkUWaz4Jfc1UJb4As1/T5iBSi4ATs8c1brkvwAKex20liBxqvuIt
   Tnn2lPXjKmhf4BvfwZeZHT7yMHsC37kcuync3BvPHqWi+4O6kE7howvqY
   3Nc7FEvGYuVHkIcVEUu2h8FQp3VIFMb40OQMdwPNKeM1gbNKsQT/lydLf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="244347985"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="244347985"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 10:57:25 -0700
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="724563522"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 10:57:23 -0700
Date:   Tue, 12 Apr 2022 10:59:17 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Bruno Moreira-Guedes <codeagain@codeagain.dev>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Bruno's Patch Watchbox <patch-reply@codeagain.dev>
Subject: Re: [PATCH v2 1/3] staging: vme: Adjusted VME_USER in Kconfig
Message-ID: <20220412175917.GA1236898@alison-desk>
References: <cover.1649721450.git.codeagain@codeagain.dev>
 <cfd7014e7f70cb928aa957f56bb31d8f514c2446.1649721450.git.codeagain@codeagain.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfd7014e7f70cb928aa957f56bb31d8f514c2446.1649721450.git.codeagain@codeagain.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 03:55:21AM -0300, Bruno Moreira-Guedes wrote:

'Adjusted' is unecessarily vague. In the commit msg try to say
exactly what the patch did. Write in the imperative tense, like
you are issuing commands.

Something like 'Move VME staging driver to staging Kconfig' , or
'Source vme driver from staging Kconfig'.  

> Currently, the VME_USER driver is in the staging tree Kconfig, unlike
> other VME drivers already moved to the main portions of the kernel tree.
> Its configuration is, however, nested into the VME_BUS config option,
> which might be misleading.
> 
> Since the staging tree "[...] is used to hold stand-alone[1] drivers and
> filesystem that are not ready to be merged into the main portion of the
> Linux kernel tree [...]"[1], IMHO all staging drivers should appear

Skip the 'IMHO'. It's all your HO and if you state anything incorrectly,
your reviewers should catch it. If you are truly making a wild guess
about something, either look into it further, or not it in a question
below the '---'.

This commit message is otherwise very well written. It explains the
why of this patch nicely. 

Again, for this set, perhaps the changelog in the cover letter only.

> nested into the Main Menu -> Device Drivers -> Staging Drivers to make
> sure the user don't pick it without being fully aware of its staging
> status as it could be the case in Menu -> Device Drivers -> VME bridge
> support (the current location).
> 
> With this change menuconfig users will clearly know this is not a driver
> in the main portion of the kernel tree and decide whether to build it or
> not with that clearly in mind.
> 
> This change goes into the same direction of commit 4b4cdf3979c3
> ("STAGING: Move staging drivers back to staging-specific menu")
> 
> CHANGELOG
> v1:
>  - Sourced "drivers/staging/vme/devices/Kconfig" in
>    "drivers/staging/Kconfig" and unsourced in "drivers/vme/Kconfig".
> 
> v2:
> - Turned into a patchset to (1) fix missing "depends on" missing entry
>   in config VME_USER at "drivers/staging/vme/devices/Kconfig",
>   affecting the behavior of this patch, and (2) fix unnecessary
>   remaining files from the time the whole vme subtree was in staging.
> 
> REFERENCES
> [1] https://lkml.org/lkml/2009/3/18/314
> 
> Signed-off-by: Bruno Moreira-Guedes <codeagain@codeagain.dev>
> ---
>  drivers/staging/Kconfig | 2 ++
>  drivers/vme/Kconfig     | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
> index 932acb4e8cbc..0545850eb2ff 100644
> --- a/drivers/staging/Kconfig
> +++ b/drivers/staging/Kconfig
> @@ -88,4 +88,6 @@ source "drivers/staging/qlge/Kconfig"
>  
>  source "drivers/staging/wfx/Kconfig"
>  
> +source "drivers/staging/vme/devices/Kconfig"
> +
>  endif # STAGING
> diff --git a/drivers/vme/Kconfig b/drivers/vme/Kconfig
> index 936392ca3c8c..c13dd9d2a604 100644
> --- a/drivers/vme/Kconfig
> +++ b/drivers/vme/Kconfig
> @@ -15,6 +15,4 @@ source "drivers/vme/bridges/Kconfig"
>  
>  source "drivers/vme/boards/Kconfig"
>  
> -source "drivers/staging/vme/devices/Kconfig"
> -
>  endif # VME
> -- 
> 2.35.1
> 


