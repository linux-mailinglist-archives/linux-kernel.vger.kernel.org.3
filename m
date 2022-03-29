Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368624EB1A6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239522AbiC2QRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237751AbiC2QRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:17:19 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D84D4D60F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648570536; x=1680106536;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V7I1wdGG6eu8VtqmUYmFQ80cpXVRC0RQdim1swUODT4=;
  b=fLivWg6g/ELS7ghvMEw7iV47oS2Liocljy/fFD1+gm/bWHVsfQtjvjTA
   ZOnBeZei8i5CQhdwTOCQPzqYVdIEPhCjxteZiv/taOk5pM2U3U+VIs9G7
   YhwzAw3CAWYkTMu1RxXhmPPs034WPGoebScI+3E09+sttbXm/WMC1ovtW
   q0IO2FJyhuuJ9ibnZYUsvafP7XH/mogdHARx8Yr4sfDKvfgJDige+2Z9g
   O6ib8GU8Rq7dMt52Brkb4bmoc1YLyXdcfToBHFou/KX1h09aPBh0nOimM
   YgP+hvYSMknZIPR+ZFIXmtVEON4mslC28QfLCrN9T2eu+PoLcKIoFqp86
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="284189452"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="284189452"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 09:14:07 -0700
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="564742695"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 09:14:06 -0700
Date:   Tue, 29 Mar 2022 09:16:32 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Rebecca Mckeever <remckee0@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: r8188eu: fix suspect code indent for
 conditional statements
Message-ID: <20220329161632.GA1169956@alison-desk>
References: <YkK7ABTVt0TCbd18@bertie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkK7ABTVt0TCbd18@bertie>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 02:53:36AM -0500, Rebecca Mckeever wrote:
> Align the if and else if branches of the conditional statement
> to improve readability. Prevent bugs that could be introduced
> if developers misread the code. Issue found by checkpatch.

Thanks for the patch Rebecca!

Lots of stuff done right - passes chkp, compiles, patch is sent to
correct recipients, the commit message follows the format of the file.

Let's set a pattern here for all checkpatch related cleanups,
for you and others that follow.(Thanks for being the first ;))

Commit msg says 'what'. Commit log says 'why'. Acknowledge that
it was found using checkpatch in the commit log also. (In the future
you may be acknowledging use of other tools like sparse, coccinelle.)

Note that the 'why' is never that a tool reported an error. The 'why'
for these checkpatch reports is usually to follow the Linux Kernel
Coding Style.

'Fix' in the commit message is needlessly generic. Perhaps:
[PATCH] staging: r8188eu: align both branches of a conditional statement

Commit log: (what you have is fine in the log)
I usually paste in the checkpatch error explicitly so it can be grep'd
for. Something like:

Issue found by checkpatch:
WARNING: suspect code indent for conditional statements

Thanks,
Alison

> 
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_cmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> index 6eca30124ee8..ccc43c0ba433 100644
> --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> @@ -1408,7 +1408,7 @@ void rtw_survey_cmd_callback(struct adapter *padapter,  struct cmd_obj *pcmd)
>  		/* TODO: cancel timer and do timeout handler directly... */
>  		/* need to make timeout handlerOS independent */
>  		_set_timer(&pmlmepriv->scan_to_timer, 1);
> -		} else if (pcmd->res != H2C_SUCCESS) {
> +	} else if (pcmd->res != H2C_SUCCESS) {
>  		_set_timer(&pmlmepriv->scan_to_timer, 1);
>  	}
>  
> -- 
> 2.32.0
> 
> 
