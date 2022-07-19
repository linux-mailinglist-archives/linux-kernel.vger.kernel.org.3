Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B516B57A4C2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238492AbiGSRNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237984AbiGSRNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:13:35 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DEA599E3;
        Tue, 19 Jul 2022 10:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658250815; x=1689786815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b4S7Su5cqgEi/0Y7G+lQXHnfjnnB8JZzUZIXJCRaqzk=;
  b=X5JYsgGPcsT+q/VadXQjupag0QPXGe2vyHaCS9lO/eOujxLFynF+bKgY
   2gXr0o8SOY+6hSYkPP2/IX+uaFxYj7qGjH+9ENSeooQpVsLCe9CIi44bi
   37YvaDoZZMAmETB5r5RyrgPD+zM0WRfFpYLz8C3czGvahDBxBhFNawvFT
   r88z1jUwLZI3e0Fnw6FuATryqSOdOtmxQsLgwBqnvFGB3SWgwPA1JSNj+
   sSfEgblrt7uKnBT9bHr9pywoQNtEcHmjqM6YndiMfzipqITs3iLtHQP8T
   P9RZ5JSwxUM4+tqBvmC38Rl5sBKBHf5uZ09QUcTlzEjpH/+bpj6Pj49gN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="286559651"
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="286559651"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 10:13:31 -0700
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="700531439"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 10:13:31 -0700
Date:   Tue, 19 Jul 2022 10:13:30 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Qifu Zhang <zhangqifu@bytedance.com>
Cc:     rafael@kernel.org, lenb@kernel.org, jarkko@kernel.org,
        dave.hansen@linux.intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: ACPI: EINJ: Fix obsolete example
Message-ID: <YtbmOlaDdKCVBUFI@agluck-desk3.sc.intel.com>
References: <20220719115013.744751-1-zhangqifu@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719115013.744751-1-zhangqifu@bytedance.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 07:50:13PM +0800, Qifu Zhang wrote:
> Since commit 488dac0c9237 ("libfs: fix error cast of negative value in
> simple_attr_write()"), the EINJ debugfs interface no longer accepts
> negative values as input. Attempt to do so will result in EINVAL.
> 
> Signed-off-by: Qifu Zhang <zhangqifu@bytedance.com>

Reviewed-by: Tony Luck <tony.luck@intel.com>

> ---
>  Documentation/firmware-guide/acpi/apei/einj.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
> index 55e2331a6438..d6b61d22f525 100644
> --- a/Documentation/firmware-guide/acpi/apei/einj.rst
> +++ b/Documentation/firmware-guide/acpi/apei/einj.rst
> @@ -168,7 +168,7 @@ An error injection example::
>    0x00000008	Memory Correctable
>    0x00000010	Memory Uncorrectable non-fatal
>    # echo 0x12345000 > param1		# Set memory address for injection
> -  # echo $((-1 << 12)) > param2		# Mask 0xfffffffffffff000 - anywhere in this page
> +  # echo 0xfffffffffffff000 > param2		# Mask - anywhere in this page
>    # echo 0x8 > error_type			# Choose correctable memory error
>    # echo 1 > error_inject			# Inject now
>  
> -- 
> 2.20.1
> 
