Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED42595900
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbiHPKxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiHPKxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:53:23 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51444E842
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 02:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660643729; x=1692179729;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Qs5JcP0DyxdDr2M+TfNbeXHgZMZJ7UyRrbaQPUfUtUw=;
  b=G3syNGWH7XTVsW+Dfbw5P2o85olKoCqDYcF6A7Ro8g7tJyZKWA+Gaoxy
   D7WibQiKXC5uePe9IwygX3FumpnJuuOjKxPFZgW+20lqGdkDYIVdy33Dt
   uWbl30VZEIyMgo9yuogCnoU+BPCrVdiZdoFenFWzvgPAiwjLcmuk9W2Bz
   rif4NN3AIEV9nAnDm43NqVpdq6M7HvKD/PgcoZSMSVgXnUiALMlyATSDD
   RvySU3LNseJttDjIV+ZLANeRhwop5611RSBcvJ8V8mzFGUZ475Hu9XnOx
   bV2GWGxt244cwDgHBrZi0iI/UwiICwpD4lg2ctIHCl4yuVglpn6cOE6PN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="293449978"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="293449978"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 02:55:29 -0700
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="610208209"
Received: from kroegerb-mobl1.ger.corp.intel.com (HELO [10.252.51.43]) ([10.252.51.43])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 02:55:24 -0700
Message-ID: <f6baa98e-af46-7ca8-397a-2e762cd444c6@linux.intel.com>
Date:   Tue, 16 Aug 2022 11:55:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2] ASoC: Intel: sof_rt5682: Add support for
 jsl_rt5682_rt1019
Content-Language: en-US
To:     Sean Hong <sean.hong@quanta.corp-partner.google.com>,
        perex@perex.cz, tiwai@suse.com, brent.lu@intel.com
Cc:     cezary.rojewski@intel.com, kai.vehmanen@linux.intel.com,
        peter.ujfalusi@linux.intel.com, ranjani.sridharan@linux.intel.com,
        linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        yung-chuan.liao@linux.intel.com
References: <20220816075424.1245593-1-sean.hong@quanta.corp-partner.google.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220816075424.1245593-1-sean.hong@quanta.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/16/22 09:54, Sean Hong wrote:
> This patch adds the driver data for rt5682 support jsl_rt5682_rt1019.
> 
> Signed-off-by: Sean Hong <sean.hong@quanta.corp-partner.google.com>
> ---
>  sound/soc/intel/boards/sof_rt5682.c               |  9 +++++++++
>  sound/soc/intel/common/soc-acpi-intel-jsl-match.c | 12 ++++++++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
> index 045965312..3a840f3a9 100644
> --- a/sound/soc/intel/boards/sof_rt5682.c
> +++ b/sound/soc/intel/boards/sof_rt5682.c
> @@ -1100,6 +1100,15 @@ static const struct platform_device_id board_ids[] = {
>  					SOF_RT5682_SSP_AMP(1) |
>  					SOF_RT5682_NUM_HDMIDEV(4)),
>  	},
> +	{
> +		.name = "jsl_rt5682_rt1019",
> +		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
> +					SOF_RT5682_MCLK_24MHZ |

I see it's the same setting for all JSL devices but I am having doubts
on this MCLK.  Is this 24MHz value correct for JSL? It's derived from
ICL so in theory the MCLK should be a multiple of 19.2MHz if the root
frequency was the oscillator.

Is this intentional?

> +					SOF_RT5682_SSP_CODEC(0) |
> +					SOF_SPEAKER_AMP_PRESENT |
> +					SOF_RT1019_SPEAKER_AMP_PRESENT |
> +					SOF_RT5682_SSP_AMP(1)),
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(platform, board_ids);
> diff --git a/sound/soc/intel/common/soc-acpi-intel-jsl-match.c b/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
> index b95c4b2cd..e374bf163 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-jsl-match.c
> @@ -29,6 +29,11 @@ static const struct snd_soc_acpi_codecs rt1015p_spk = {
>  	.codecs = {"RTL1015"}
>  };
>  
> +static struct snd_soc_acpi_codecs rt1019p_spk = {
> +	.num_codecs = 1,
> +	.codecs = {"RTL1019"}
> +};
> +
>  static const struct snd_soc_acpi_codecs mx98360a_spk = {
>  	.num_codecs = 1,
>  	.codecs = {"MX98360A"}
> @@ -78,6 +83,13 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_jsl_machines[] = {
>  		.quirk_data = &mx98360a_spk,
>  		.sof_tplg_filename = "sof-jsl-rt5682-mx98360a.tplg",
>  	},
> +	{
> +		.comp_ids = &rt5682_rt5682s_hp,
> +		.drv_name = "jsl_rt5682_rt1019",
> +		.machine_quirk = snd_soc_acpi_codec_list,
> +		.quirk_data = &rt1019p_spk,
> +		.sof_tplg_filename = "sof-jsl-rt5682-rt1019.tplg",
> +	},
>  	{
>  		.id = "10134242",
>  		.drv_name = "jsl_cs4242_mx98360a",
