Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DF45037B0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 19:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbiDPRNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 13:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiDPRND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 13:13:03 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB4C8C7F1;
        Sat, 16 Apr 2022 10:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650129031; x=1681665031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=unCoICu+tR6XjB3V0LBDQueMtp5vDCI6pFAj0TG4Zsc=;
  b=C/4o06qkJVWDl3tNXcqtHV3GaFGGcfzp574xaB6z3GGMycP+8xxT/wPL
   eJmZzf1CDaZdMxTOadkpLje+dkBwmp8KxLtMKAhmrC9Q7leBZFK37veSb
   KamZsHyLvj+XExdelPBpUKxDnNmYoYqarDfzRj3UpxHIjPQtIF2OYIkg8
   TcigR7AS4f1M7QccXG/lHSgO5OHVgedFExTwCpD4SX1aZSS/LCAk78WIq
   89XxHzosgDUCYjtEfJhLDr+Cs8/vygcwcVAazPg0EvjA6BiApf83xOV5v
   14/okRFUJ2S8Gm+xxfAJWOzrDJh3ZNNHEXd9dJft9Bq82oBbW1Oca3gHn
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="323751016"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="323751016"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2022 10:10:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="553608605"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by orsmga007.jf.intel.com with ESMTP; 16 Apr 2022 10:10:28 -0700
Date:   Sun, 17 Apr 2022 01:02:57 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com
Subject: Re: [PATCH v4 2/5] fpga: fix for coding style issues
Message-ID: <20220416170257.GA302575@yilunxu-OptiPlex-7050>
References: <20220416133719.3382895-1-nava.manne@xilinx.com>
 <20220416133719.3382895-3-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220416133719.3382895-3-nava.manne@xilinx.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 16, 2022 at 07:07:16PM +0530, Nava kishore Manne wrote:
> fixes the below checks reported by checkpatch.pl
> Lines should not end with a '('
> Alignment should match open parenthesis

Please help format the commit log, like:

fixes the below checks reported by checkpatch.pl:

- Lines should not end with a '('
- Alignment should match open parenthesis

> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>

With the minor fixes, please add my Acked-by.

Acked-by: Xu Yilun <yilun.xu@intel.com>

> ---
> Changes for v2:
>                 -None.
> Changes for v3:
>                -Fixed similar issue exists in "drivers/fpga/*".
> Changes for v4:
>                -None.
> 
>  drivers/fpga/fpga-mgr.c    | 4 ++--
>  drivers/fpga/fpga-region.c | 7 ++++---
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index d49a9ce34568..a699cc8e2fa6 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -151,8 +151,8 @@ static int fpga_mgr_write_init_buf(struct fpga_manager *mgr,
>  	if (!mgr->mops->initial_header_size)
>  		ret = fpga_mgr_write_init(mgr, info, NULL, 0);
>  	else
> -		ret = fpga_mgr_write_init(
> -		    mgr, info, buf, min(mgr->mops->initial_header_size, count));
> +		ret = fpga_mgr_write_init(mgr, info, buf,
> +					  min(mgr->mops->initial_header_size, count));
>  
>  	if (ret) {
>  		dev_err(&mgr->dev, "Error preparing FPGA for writing\n");
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index b0ac18de4885..3864bf4f8920 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -18,9 +18,10 @@
>  static DEFINE_IDA(fpga_region_ida);
>  static struct class *fpga_region_class;
>  
> -struct fpga_region *fpga_region_class_find(
> -	struct device *start, const void *data,
> -	int (*match)(struct device *, const void *))
> +struct fpga_region *fpga_region_class_find(struct device *start,
> +					   const void *data,
> +					   int (*match)(struct device *,
> +							const void *))
>  {
>  	struct device *dev;
>  
> -- 
> 2.25.1
