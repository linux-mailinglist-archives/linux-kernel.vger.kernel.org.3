Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BFE50E1D5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242109AbiDYNep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242078AbiDYNee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:34:34 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44EFBA5;
        Mon, 25 Apr 2022 06:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650893490; x=1682429490;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LeeHzvwWWIhoJET4Iby9NAsLpM72fA5MdvAHRDjBpqQ=;
  b=mRO0MNdsbOJI6HUbDPtpFlxZJSpWLWYEZQetSRdeJeA46CsInfy41C11
   wo2TVI5MiSoNsV/Wfs+K6O0o4tTK0psb6rfH5xu3gttldeBV5g1+7fx5B
   hdly0soWuDImL61DQQQFyDMjp7spVhVTwRS3slwm3rpA1ST0fX2QkwEWC
   JNrv0jSQbMlGfbtAnlzgdBVeSkO3ymngfFXT/s7igoX9ypx8e339uy0FY
   DgUwzGso//PuZmB13WQMY0xbYXSLkj9Fah/C3iBlOyMWkDVUxhpGkJPis
   pPH1gtU6VlN2pL5/v9v2wdI/EBxRe1HAEL2kP8YTi1iskx7UDRrvH89bY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="247174639"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="247174639"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 06:31:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="579286511"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga008.jf.intel.com with ESMTP; 25 Apr 2022 06:31:28 -0700
Date:   Mon, 25 Apr 2022 21:23:46 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: Re: [PATCH v6 1/5] fpga: zynq: Fix incorrect variable type
Message-ID: <20220425132346.GB367066@yilunxu-OptiPlex-7050>
References: <20220423170235.2115479-1-nava.manne@xilinx.com>
 <20220423170235.2115479-2-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423170235.2115479-2-nava.manne@xilinx.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 10:32:31PM +0530, Nava kishore Manne wrote:
> zynq_fpga_has_sync () API is expecting "u8 *" but the
> formal parameter that was passed is of type "const char *".
> fix this issue by changing the buf type to "const char *"
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> Acked-by: Xu Yilun <yilun.xu@intel.com>

Hi Nava:

There is a lkp bug report yet to be fixed. Please fix it.

Thanks,
Yilun

> ---
> Changes for v2:
>                 -None.
> Changes for v3:
>                - Changed arg buf type to "const char *" as suggested by Tom.
>                - update zynq_fpga_has_sync () API description to align with API
>                  functionality.
> Changes for v4:
>                - None.
> 
> Changes for v5:
>                - Dropped the irrelevant doc update changes.
> Changes for v6:
>                - None.
> 
>  drivers/fpga/zynq-fpga.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index 426aa34c6a0d..6beaba9dfe97 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -239,7 +239,7 @@ static irqreturn_t zynq_fpga_isr(int irq, void *data)
>   * the correct byte order, and be dword aligned. The input is a Xilinx .bin
>   * file with every 32 bit quantity swapped.
>   */
> -static bool zynq_fpga_has_sync(const u8 *buf, size_t count)
> +static bool zynq_fpga_has_sync(const char *buf, size_t count)
>  {
>  	for (; count >= 4; buf += 4, count -= 4)
>  		if (buf[0] == 0x66 && buf[1] == 0x55 && buf[2] == 0x99 &&
> -- 
> 2.25.1
