Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD31F596995
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 08:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbiHQGba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 02:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiHQGb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 02:31:27 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74DF79A4A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 23:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660717886; x=1692253886;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mwtulZ4Hp+CocMD8YRBKXqWk+VW7tePvSlvVSfMPzrE=;
  b=DxskV/mhaU4O21qxFb+/EWnxJSkvWzKJTUtHiPD0eV+2vPDcc+h9CKup
   AyEqhwdZ7AKZuY+GnO/fjA1UDjaO5bDuaKuxYzUUk7yWpCtW2EZUkwyXx
   1fWgNo6EVY8Mh2pYYVOgd6tKufeHbKiDqkUBYxRKdWmSlQ+f9S2/nCOxY
   FJbc1BX3Sfpx5idbZTanfTtCQko5Sqxu1WHPPjKR3I1QrXyp/lX2tPe0a
   fKrG68EjdEbpYqwXVpSS3JnErMW20Jt7ojnLiSKcYwKTQ8O5c/rnqS6Pp
   oIzGLffuG0CtkaHUc9RFbfd1LFE4LvAzn0zF23UuagS6EMkBT29T/NFPw
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="378707458"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="378707458"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 23:31:26 -0700
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="675518280"
Received: from rdegreef-mobl1.ger.corp.intel.com (HELO [10.252.49.182]) ([10.252.49.182])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 23:31:23 -0700
Message-ID: <a92f5041-9630-66ee-1757-4b58bdaabe90@linux.intel.com>
Date:   Wed, 17 Aug 2022 08:31:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 linux-next] Remove Unnecessary TODO
Content-Language: en-US
To:     Khalid Masum <khalid.masum.92@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20220816175954.5259-1-khalid.masum.92@gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220816175954.5259-1-khalid.masum.92@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/16/22 19:59, Khalid Masum wrote:
> The capabilities enabled for multi-link are required as part of the
> programming sequences, even when a stream uses a single link we still
> use the syncArm/syncGo sequences. Therefore the TODO is no longer
> necessary.
> 
> Suggested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>

the title of your patch should be something like

soundwire: intel: remove unnecessary TODO

so that the patch scope and context is clearly identified.
> ---
> Previous discussions:
> - v1 Link: https://lore.kernel.org/lkml/20220814080416.7531-1-khalid.masum.92@gmail.com/
> 
> Changes since v1:
> - Remove the todo, leave rest of the code as is
> - Update commit message
> 
>  drivers/soundwire/bus.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 8d4000664fa3..18158825a6d8 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -75,7 +75,6 @@ int sdw_bus_master_add(struct sdw_bus *bus, struct device *parent,
>  
>  	/*
>  	 * Initialize multi_link flag
> -	 * TODO: populate this flag by reading property from FW node
>  	 */
>  	bus->multi_link = false;
>  	if (bus->ops->read_prop) {
