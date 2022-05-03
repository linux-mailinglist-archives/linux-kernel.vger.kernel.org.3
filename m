Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DECD5181CB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 11:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbiECKA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbiECKAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:00:22 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A96377CA;
        Tue,  3 May 2022 02:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651571810; x=1683107810;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PUacBmRLtoeErgelcVZt5P+I5fws4ubK0fCTyWDi7Wg=;
  b=hV2thJmRw6jiwtjgl0frdLfSTP/kLQYyHSIjvytOLaGEAH3t7zxCgDMq
   VaLV/H5b9G4UYtzLpZeh4LIAa1R0BSIjyMHNX/0z466txzp/DpRVeW6jS
   gqCnpT0pZU8SuZX7GVfvI6cuzcv+X+rCK3+HUl/eCGzfy3IVh76G0rCBr
   nVczz9k0g1wc2cNB28lQf7Mjx24yy1IEL2OFT3dgegvkLmoD8Cinhqur3
   Z/3z1bsHxYiPfISuRKyjQAj4H3PkgyooHBdZwtb6HOIFQA0kelr7ZcU7u
   stCOb6N8oK3Q5zYU4fauyPqfKBaaiRS0BZN+vBvH+IsI1aQC8uiVamXNo
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="330430289"
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="330430289"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 02:56:49 -0700
X-IronPort-AV: E=Sophos;i="5.91,194,1647327600"; 
   d="scan'208";a="653202205"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 02:56:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nlpGu-00BOXO-F8;
        Tue, 03 May 2022 12:56:44 +0300
Date:   Tue, 3 May 2022 12:56:44 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] serial: 8250: core: Remove unneeded
 <linux/pm_runtime.h>
Message-ID: <YnD8XDP4bjzFvMBM@smile.fi.intel.com>
References: <2545eaa7fc552013a5d04c4df027255204e64834.1651494971.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2545eaa7fc552013a5d04c4df027255204e64834.1651494971.git.geert+renesas@glider.be>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 02:37:05PM +0200, Geert Uytterhoeven wrote:
> The last calls into Runtime PM were moved to 8250_port.c a long time
> ago.

Both
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: b6830f6df8914faa ("serial: 8250: Split base port operations from universal driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/tty/serial/8250/8250_core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
> index 01d30f6ed8fb5931..cfbd2de0ca6e4bcd 100644
> --- a/drivers/tty/serial/8250/8250_core.c
> +++ b/drivers/tty/serial/8250/8250_core.c
> @@ -32,7 +32,6 @@
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
> -#include <linux/pm_runtime.h>
>  #include <linux/io.h>
>  #ifdef CONFIG_SPARC
>  #include <linux/sunserialcore.h>
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


