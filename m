Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAF7577DA9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 10:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbiGRIjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 04:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiGRIjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:39:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714F4643D;
        Mon, 18 Jul 2022 01:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658133578; x=1689669578;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kWWiZuOQESLiD7NGQ4Gd3K05y6A+bgzV19UwDrmVFI0=;
  b=MqSBUxHMNkujJWSfSADLSJGtsNP5PqJG75FzydF8nznyr3YE9/ssX9dU
   nx3TUTQImiULmp2xD61vABS47gtO1O6N5S0PZyWmVdBqNuxFtNUJzI3Yg
   4gKiEIiD3HkOfYYI9673PaVk2/aoFI/wi5Vb2Nj0GMN/dfm5inN0NynU3
   drZBHq2HG9XsxJIrlNXNgHZQpOayE/bL4OJ96yT7BCL21gvZpuFrK+iqD
   K3jm1HIzzzXzCHhiwNaxgi0cQkwTjmgu0GeqAmHXrlXPRs/PGnXTTSDpc
   M7LaTpC3vT2AujFNeoslKMiu7KHZSIt7sTCi5wWcsIqtd09R/AFKc3NjB
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="350130338"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="350130338"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 01:39:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="739385944"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 18 Jul 2022 01:39:34 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 18 Jul 2022 11:39:33 +0300
Date:   Mon, 18 Jul 2022 11:39:33 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb/typec/tcpm: fix repeated words in comments
Message-ID: <YtUcRZmQJgOeYSY0@kuha.fi.intel.com>
References: <20220716135642.52460-1-yuanjilin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220716135642.52460-1-yuanjilin@cdjrlc.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 09:56:42PM +0800, Jilin Yuan wrote:
>  Delete the redundant word 'to'.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 3bc2f4ebd1fe..2d80b5b17ea4 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4453,7 +4453,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		 * The specification suggests that dual mode ports in sink
>  		 * mode should transition to state PE_SRC_Transition_to_default.
>  		 * See USB power delivery specification chapter 8.3.3.6.1.3.
> -		 * This would mean to to
> +		 * This would mean to
>  		 * - turn off VCONN, reset power supply
>  		 * - request hardware reset
>  		 * - turn on VCONN
> -- 
> 2.36.1

-- 
heikki
