Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8C1578D1F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 23:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236356AbiGRV4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 17:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbiGRV4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 17:56:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EC0286E2;
        Mon, 18 Jul 2022 14:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658181400; x=1689717400;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jtelwOkBsZ1rw2rAM+GRVZOZu4hLir8ReE56NKel1wU=;
  b=j4OCPBzt4oOiiHyTd+v71Y3b78fY8LAcghhUBt4HI74MDAIxbHtGRk0o
   Z6lYZhkPchpNbcIpumdcKzTKDidLkWr5tAAWyXVzSQ/51vb02XvkXGnNV
   ehWFgWGALTpphWCL4qO/ePccynS907XwZVaHWO/K3fEpjog+HmoCkKuJZ
   yxSnDFDxtAuGTyUP7auidkdjYmrbIbL2a+0d5hmYWKVRyeU2sobM4AlSJ
   +Kib2anverinW433vcBKZj+PCuOj+KUXippoZDIUyAFIOfyZJgbhjGudp
   JEUQJWD6O/HM6Yli1yFacXWCmWz9rT8OgcZ0Var00X656GP6Je1VaRuop
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="285086813"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="285086813"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 14:56:40 -0700
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="739625187"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 14:56:39 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 4728120282;
        Tue, 19 Jul 2022 00:56:37 +0300 (EEST)
Date:   Mon, 18 Jul 2022 21:56:37 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     mchehab@kernel.org, laurent.pinchart@ideasonboard.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: mc-request.c: Fix comment typo
Message-ID: <YtXXFZzMnL5IJZoZ@paasikivi.fi.intel.com>
References: <20220715051646.30195-1-wangborong@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715051646.30195-1-wangborong@cdjrlc.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Fri, Jul 15, 2022 at 01:16:46PM +0800, Jason Wang wrote:
> The double `that' is duplicated in line 162, remove one.
> 
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  drivers/media/mc/mc-request.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/mc/mc-request.c b/drivers/media/mc/mc-request.c
> index addb8f2d8939..752ea0bc804b 100644
> --- a/drivers/media/mc/mc-request.c
> +++ b/drivers/media/mc/mc-request.c
> @@ -159,7 +159,7 @@ static long media_request_ioctl_queue(struct media_request *req)
>  	 * state can only happen if either the driver changes the state or if
>  	 * the user cancels the vb2 queue. The driver can only change the state
>  	 * after each object is queued through the req_queue op (and note that
> -	 * that op cannot fail), so setting the state to QUEUED up front is

In this case, the second "that" is there for a reason.

> +	 * op cannot fail), so setting the state to QUEUED up front is
>  	 * safe.
>  	 *
>  	 * The other reason for changing the state is if the vb2 queue is

-- 
Sakari Ailus
