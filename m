Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2726F557600
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiFWIzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiFWIzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:55:32 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4042836B42;
        Thu, 23 Jun 2022 01:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655974531; x=1687510531;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5e5LpSrE1tJXHTXV3wUUQLHgxzGmhBA+V4BYztZBrKg=;
  b=Sfub/Y76N7+xhee7W5Yu6CL+UaFiGwcRYJYOZeoaAGfifs+PSELg7iH8
   JJl+xRW02g2ygoMw6PPSu+6JaeKu7hlqnEPCunjV/E67xv5I69rxIjkcU
   kFVluoV8vfA5cVVUGtCi5b6X8E2Z1KR6LFsw472dDgD2qiYdmY4gJvx5k
   6Fr4rGI3oknhT9fpyL2cFhGwgLGvSYWHS3pPpqrTi1cK9By6T0jdXuQkG
   oZ92pdMBUZc0DwBk7jAmYVQBnlh1J6DQbME7YhylEyQqzkYZeShb75U7s
   W5KcJacZvblIih0BCZggIgik1CZGr3Hql0aLHaDwpWC+1F05PSUSqP7C/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="344655811"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="344655811"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 01:55:30 -0700
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="644641277"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.61.96])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 01:55:29 -0700
Message-ID: <b6832fce-ee48-c4d8-e898-d9aab17345d1@intel.com>
Date:   Thu, 23 Jun 2022 11:55:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH] mmc: sdhci: drop unexpected word 'a' in comments
Content-Language: en-US
To:     Jiang Jian <jiangjian@cdjrlc.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220623071616.13873-1-jiangjian@cdjrlc.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220623071616.13873-1-jiangjian@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/22 10:16, Jiang Jian wrote:
> Remove the repeated word 'a' from comments
> 
> file - drivers/mmc/host/sdhci.h
> line - 348
> 
> /* Allow for a a command request and a data request at the same time */
> 
> changed to:
> 
> /* Allow for a command request and a data request at the same time */
> 
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 95a08f09df30..0abe4b428ed5 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -345,7 +345,7 @@ struct sdhci_adma2_64_desc {
>   */
>  #define SDHCI_MAX_SEGS		128
>  
> -/* Allow for a a command request and a data request at the same time */
> +/* Allow for a command request and a data request at the same time */
>  #define SDHCI_MAX_MRQS		2
>  
>  /*

