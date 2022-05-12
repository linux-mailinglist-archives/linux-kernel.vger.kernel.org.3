Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987E5524F78
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355043AbiELOJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354927AbiELOJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:09:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F2B201C0D
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652364568; x=1683900568;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zi8Pic5CJM9KyS0pkVNYuX6w9wNDHDJL2ofCVifXfuM=;
  b=SrFlNR942A45tpBTL7DxVlfurPioWp8bW6JygWUkPKYo2t2M9qVGhui3
   p5MeaIeSI1fxPPqkEbuErwufGM6OrcF5OjnJTh6FDlBGJ+1OgWbr/yW//
   0gRcdmx/pEaLFxnrnNYneVozszmyCqs+SLMlZNsi+wwBB4vZoXTSi/DWv
   MN+r2JFtCrJd2IYfTa6X5zVn7a4Pq0Q3f+hC1rTCqRiqd2YIJ10qU8D+L
   0imIoMNbnSwinzFHe2uGjGviMjINMmy30+lUJvp9CigbS7anHUhSOCTEb
   faklO4TnGn/3SeEh70cKkxzllgvO5iZ6mJi5Cl9FK0VzCJ533Apn6x8M4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="257557371"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="257557371"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 07:09:27 -0700
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="566702128"
Received: from jainamit-mobl.amr.corp.intel.com (HELO [10.212.194.29]) ([10.212.194.29])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 07:09:26 -0700
Message-ID: <6a18ce53-c5c8-5ba9-fe7c-199bd9b4bff6@linux.intel.com>
Date:   Thu, 12 May 2022 08:13:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH -next] ASoC: SOF: amd: add missing
 platform_device_unregister in acp_pci_rn_probe
Content-Language: en-US
To:     Zheng Bin <zhengbin13@huawei.com>, lgirdwood@gmail.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, sound-open-firmware@alsa-project.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     gaochao49@huawei.com
References: <20220512013728.4128903-1-zhengbin13@huawei.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220512013728.4128903-1-zhengbin13@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/11/22 20:37, Zheng Bin wrote:
> acp_pci_rn_probe misses a call platform_device_unregister in error path,
> this patch fixes that.
> 
> Signed-off-by: Zheng Bin <zhengbin13@huawei.com>

Thanks for the patch, nice catch

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  sound/soc/sof/amd/pci-rn.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/sof/amd/pci-rn.c b/sound/soc/sof/amd/pci-rn.c
> index b8910bb7f27c..d5d9bcc2c997 100644
> --- a/sound/soc/sof/amd/pci-rn.c
> +++ b/sound/soc/sof/amd/pci-rn.c
> @@ -101,6 +101,7 @@ static int acp_pci_rn_probe(struct pci_dev *pci, const struct pci_device_id *pci
>  	res = devm_kzalloc(&pci->dev, sizeof(struct resource) * ARRAY_SIZE(renoir_res), GFP_KERNEL);
>  	if (!res) {
>  		sof_pci_remove(pci);
> +		platform_device_unregister(dmic_dev);
>  		return -ENOMEM;
>  	}
> 
> --
> 2.31.1
> 
