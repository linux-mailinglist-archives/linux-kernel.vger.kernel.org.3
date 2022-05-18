Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8845552B05F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 04:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbiERCCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 22:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbiERCCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 22:02:19 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25453DA48
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 19:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652839337; x=1684375337;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=almMh+rawZyDIurcC/W3RqRQ1DnO9aJ3BbcGwirhOhs=;
  b=Fl0ab+qoO9fDC996HltnnKTLVp/ZaXymXgOh/V/xUOyN/ysVUnGmfCB5
   WwuO+/6qfdFS/cOX+6xCHgZVrBBwY8dA0fDjL5IFVlLSQhyekUlTfYqbM
   moSrU/LtB6kR8dy1bB1qoljxgb0UwTrZG943Pt13mLW6Yu2VlsOmr5HBV
   0WuxiCWspq6F/3hrZkAySdLu5ySXb/X0mO4vJgJlQcshOi1ifDdcTr7Bp
   dWS3Acbe61BopKCMTyKUDQmeq+u1mmLAU2XUxclANHZnYIT/2KOA435ji
   /7XCyjzChoxtAqxoe99rtGVqImCNvcLgr6nYrz9m/7hrNsZXvsMWLkJ38
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="271122054"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="271122054"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 19:02:17 -0700
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="673153516"
Received: from sfilary-mobl.amr.corp.intel.com (HELO [10.209.67.235]) ([10.209.67.235])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 19:02:15 -0700
Message-ID: <00e58668-ca30-0048-6cd1-b2dd4ad66d7a@linux.intel.com>
Date:   Tue, 17 May 2022 21:02:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [v6] FROMLIST: ASoC: Intel: sof_cs42l42: adding support for ADL
 configuration and BT offload audio
Content-Language: en-US
To:     Terry Chen <terry_chen@wistron.corp-partner.google.com>,
        alsa-devel@alsa-project.org
Cc:     cezary.rojewski@intel.com, liam.r.girdwood@linux.intel.com,
        yang.jie@linux.intel.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, brent.lu@intel.com, cujomalainey@chromium.org,
        seanpaul@chromium.org, casey.g.bowman@intel.com,
        mark_hsieh@wistron.corp-partner.google.com,
        vamshi.krishna.gopal@intel.com, mac.chiang@intel.com,
        kai.vehmanen@linux.intel.com, linux-kernel@vger.kernel.org
References: <20220518013140.1467326-1-terry_chen@wistron.corp-partner.google.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220518013140.1467326-1-terry_chen@wistron.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/17/22 20:31, Terry Chen wrote:
> To be able to do  driver data for adl_mx98360a_cs4242 which supports
> two max98360a speaker amplifiers on SSP1 and cs42l42 headphone codec
> on SSP0 running on ADL platform. Also add the capability to machine driver
> of creating DAI Link for BT offload. Although BT offload always uses SSP2
> port but we reserve the flexibility to assign the port number in macro.
> 
> Signed-off-by: Terry Chen <terry_chen@wistron.corp-partner.google.com>
> (am from https://patchwork.kernel.org/patch/12845884/)
> (also found at https://lore.kernel.org/r/20220511075522.1764114-1-terry_chen@wistron.corp-partner.google.com)

not sure what this is about, what's the point of adding information on
the v5 in the v6 patch?

> 
> ---
>  sound/soc/intel/boards/sof_cs42l42.c          | 92 ++++++++++++++++++-
>  .../intel/common/soc-acpi-intel-adl-match.c   |  7 ++
>  2 files changed, 95 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/intel/boards/sof_cs42l42.c b/sound/soc/intel/boards/sof_cs42l42.c
> index ce78c18798876..2efffc7933479 100644
> --- a/sound/soc/intel/boards/sof_cs42l42.c
> +++ b/sound/soc/intel/boards/sof_cs42l42.c
> @@ -41,8 +41,13 @@
>  #define SOF_CS42L42_DAILINK_MASK		(GENMASK(24, 10))
>  #define SOF_CS42L42_DAILINK(link1, link2, link3, link4, link5) \
>  	((((link1) | ((link2) << 3) | ((link3) << 6) | ((link4) << 9) | ((link5) << 12)) << SOF_CS42L42_DAILINK_SHIFT) & SOF_CS42L42_DAILINK_MASK)
> -#define SOF_MAX98357A_SPEAKER_AMP_PRESENT	BIT(25)
> -#define SOF_MAX98360A_SPEAKER_AMP_PRESENT	BIT(26)
> +#define SOF_BT_OFFLOAD_PRESENT			BIT(25)
> +#define SOF_CS42L42_SSP_BT_SHIFT		26
> +#define SOF_CS42L42_SSP_BT_MASK			(GENMASK(28, 26))
> +#define SOF_CS42L42_SSP_BT(quirk)	\
> +	(((quirk) << SOF_CS42L42_SSP_BT_SHIFT) & SOF_CS42L42_SSP_BT_MASK)
> +#define SOF_MAX98357A_SPEAKER_AMP_PRESENT	BIT(29)
> +#define SOF_MAX98360A_SPEAKER_AMP_PRESENT	BIT(30)
>  
>  enum {
>  	LINK_NONE = 0,
> @@ -50,6 +55,7 @@ enum {
>  	LINK_SPK = 2,
>  	LINK_DMIC = 3,
>  	LINK_HDMI = 4,
> +	LINK_BT = 5,
>  };
>  
>  /* Default: SSP2 */
> @@ -278,6 +284,13 @@ static struct snd_soc_dai_link_component dmic_component[] = {
>  	}
>  };
>  
> +static struct snd_soc_dai_link_component dummy_component[] = {
> +	{
> +		.name = "snd-soc-dummy",
> +		.dai_name = "snd-soc-dummy-dai",
> +	}
> +};
> +
>  static int create_spk_amp_dai_links(struct device *dev,
>  				    struct snd_soc_dai_link *links,
>  				    struct snd_soc_dai_link_component *cpus,
> @@ -467,9 +480,56 @@ static int create_hdmi_dai_links(struct device *dev,
>  	return -ENOMEM;
>  }
>  
> +static int create_bt_offload_dai_links(struct device *dev,
> +				       struct snd_soc_dai_link *links,
> +				       struct snd_soc_dai_link_component *cpus,
> +				       int *id, int ssp_bt)
> +{
> +	int ret = 0;

either you remove this useless init...

> +
> +	/* bt offload */
> +	if (!(sof_cs42l42_quirk & SOF_BT_OFFLOAD_PRESENT))
> +		return 0;
> +
> +	links[*id].name = devm_kasprintf(dev, GFP_KERNEL, "SSP%d-BT",
> +					 ssp_bt);
> +	if (!links[*id].name) {
> +		ret = -ENOMEM;
> +		goto devm_err;
> +	}
> +
> +	links[*id].id = *id;
> +	links[*id].codecs = dummy_component;
> +	links[*id].num_codecs = ARRAY_SIZE(dummy_component);
> +	links[*id].platforms = platform_component;
> +	links[*id].num_platforms = ARRAY_SIZE(platform_component);
> +
> +	links[*id].dpcm_playback = 1;
> +	links[*id].dpcm_capture = 1;
> +	links[*id].no_pcm = 1;
> +	links[*id].cpus = &cpus[*id];
> +	links[*id].num_cpus = 1;
> +
> +	links[*id].cpus->dai_name = devm_kasprintf(dev, GFP_KERNEL,
> +						   "SSP%d Pin",
> +						   ssp_bt);
> +	if (!links[*id].cpus->dai_name) {
> +		ret = -ENOMEM;
> +		goto devm_err;
> +	}
> +
> +	(*id)++;
> +
> +	return 0;

... or you remove the return 0;

pick one.

> +
> +devm_err:
> +	return ret;
> +}
> +

>  	},
> +	{
> +		.id = "10134242",
> +		.drv_name = "adl_mx98360a_cs4242",
> +		.machine_quirk = snd_soc_acpi_codec_list,
> +		.quirk_data = &adl_max98360a_amp,
> +		.sof_tplg_filename = "sof-adl-max98360a-rt5682.tplg",

No, I've told this before in previous reviews: do not use a topology
name that was designed for a different platform, this is not
maintainable. If the topologies happen to be the same, either generate
them twice or use a symlink.
