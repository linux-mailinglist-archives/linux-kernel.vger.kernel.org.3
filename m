Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916B157874F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 18:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbiGRQZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 12:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiGRQYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 12:24:38 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83192FD11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 09:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658161477; x=1689697477;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zocwXvw+pBV624et2QOvpDfBJlbPa2su8++4TbEBxL4=;
  b=J1iwhoiHMiYGwW0Imj7SNIkG5Hgbv6OCB4MMK64U7eaNP/BIFR7TAxA2
   QMLxE9fwXrGhmHUlrZ4npGuZVe3i6IgZkfM7hlFC/M5kyres2+j68rLDc
   Qc4m9uHYT9mpmozxhVh3YeDjAHPvRL7BAtdqpALvrFxBenI9NV/tnLoui
   OGNMQoOg5tL+YPvrTWSYFTw2k0XGY/h4zrl0VjJiONxT3zXlYvbZKAlEv
   T8wWdnngQAYiIoKPo+YBobz51JB+JnwjWixx1SEeun07Po/rIGRpkTb9v
   3LairHDqgLGqK6STLWk1BIfkiw5NULbfYv6P5ZoxuKpPaIXbH4JQym3gQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="311947926"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="311947926"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 09:23:53 -0700
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="773793615"
Received: from astephax-mobl.amr.corp.intel.com (HELO [10.209.134.250]) ([10.209.134.250])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 09:23:52 -0700
Message-ID: <443016ec-d597-3f30-874d-c522f457eca0@linux.intel.com>
Date:   Mon, 18 Jul 2022 09:10:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: sound/soc/intel/boards/sof_ssp_amp.c:97:6: warning: variable 'i'
 set but not used
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, Brent Lu <brent.lu@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
References: <202207180841.Bkm8xoh8-lkp@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <202207180841.Bkm8xoh8-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/22 19:53, kernel test robot wrote:
> Hi Brent,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   ff6992735ade75aae3e35d16b17da1008d753d28
> commit: 2fe14ff61bd6d4fabe313435dd378b5a38eb6102 ASoC: Intel: sof_ssp_amp: rename driver and support cs35l41 amplifier
> date:   5 months ago
> config: i386-randconfig-a006-20220718 (https://download.01.org/0day-ci/archive/20220718/202207180841.Bkm8xoh8-lkp@intel.com/config)
> compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 45067f8fbf61284839c739807c2da2e2505661eb)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2fe14ff61bd6d4fabe313435dd378b5a38eb6102
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 2fe14ff61bd6d4fabe313435dd378b5a38eb6102
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash sound/soc/intel/boards/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> sound/soc/intel/boards/sof_ssp_amp.c:97:6: warning: variable 'i' set but not used [-Wunused-but-set-variable]
>            int i = 0;
>                ^
>    1 warning generated.

Already fixed by aa4c06e02b41 ("ASoC: Intel: sof_ssp_amp: remove
'set-but-not-used' warning
")


> 
> 
> vim +/i +97 sound/soc/intel/boards/sof_ssp_amp.c
> 
>     89	
>     90	static int sof_card_late_probe(struct snd_soc_card *card)
>     91	{
>     92		struct sof_card_private *ctx = snd_soc_card_get_drvdata(card);
>     93		struct snd_soc_component *component = NULL;
>     94		char jack_name[NAME_SIZE];
>     95		struct sof_hdmi_pcm *pcm;
>     96		int err;
>   > 97		int i = 0;
>     98	
>     99		if (!(sof_ssp_amp_quirk & SOF_HDMI_PLAYBACK_PRESENT))
>    100			return 0;
>    101	
>    102		/* HDMI is not supported by SOF on Baytrail/CherryTrail */
>    103		if (!ctx->idisp_codec)
>    104			return 0;
>    105	
>    106		if (list_empty(&ctx->hdmi_pcm_list))
>    107			return -EINVAL;
>    108	
>    109		if (ctx->common_hdmi_codec_drv) {
>    110			pcm = list_first_entry(&ctx->hdmi_pcm_list, struct sof_hdmi_pcm,
>    111					       head);
>    112			component = pcm->codec_dai->component;
>    113			return hda_dsp_hdmi_build_controls(card, component);
>    114		}
>    115	
>    116		list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
>    117			component = pcm->codec_dai->component;
>    118			snprintf(jack_name, sizeof(jack_name),
>    119				 "HDMI/DP, pcm=%d Jack", pcm->device);
>    120			err = snd_soc_card_jack_new(card, jack_name,
>    121						    SND_JACK_AVOUT, &pcm->sof_hdmi,
>    122						    NULL, 0);
>    123	
>    124			if (err)
>    125				return err;
>    126	
>    127			err = hdac_hdmi_jack_init(pcm->codec_dai, pcm->device,
>    128						  &pcm->sof_hdmi);
>    129			if (err < 0)
>    130				return err;
>    131	
>    132			i++;
>    133		}
>    134	
>    135		return hdac_hdmi_jack_port_init(component, &card->dapm);
>    136	}
>    137	
> 
