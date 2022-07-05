Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4F5566877
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiGEKtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiGEKtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:49:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4D36544;
        Tue,  5 Jul 2022 03:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657018141; x=1688554141;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QnsS4su8H/mLvQ9+z8N/c0onNmc9ZJSNjEmEX8UUb4g=;
  b=GMTcJFFmVwqt/LRB47SPq56SvzeD8SMrgIlWaOw65PW2KJviLywVNVzG
   tAxL3rEm4jTfO7EY8J/oQWRrr2H6bfGFyiQYNXsr6g32n2N2sKhSEyWSX
   phyL7/neeO2nPmEnKtIU05IEn8svojln4wY/7rdjHIcxZGybu4wkxlGxX
   WSU1KxF629IbqhDQ9BZHpwuoJZvuRPgaOlObPK3vv8jZ8UKuQO3ejEtv/
   pebb3UmUKzdcPpx4pQmvpT5J4BLMBzfrBx4lF9NHdDfH3hlm140kpF1cL
   frt3TlP6XcoytdeX3TcEG0pQgS3GyM0kQNtnxc02XsQdxO/+loWmrEdYD
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="266346749"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="266346749"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 03:49:01 -0700
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="919669342"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.241.103]) ([10.99.241.103])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 03:48:58 -0700
Message-ID: <6727e426-7135-3ecc-955f-e60487bfd963@linux.intel.com>
Date:   Tue, 5 Jul 2022 12:48:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] ASoC: Intel: avs: correct config reference for I2S test
 board
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20220705103238.7484-1-lukas.bulwahn@gmail.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20220705103238.7484-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/2022 12:32 PM, Lukas Bulwahn wrote:
> Commit e39acc4cfd92 ("ASoC: Intel: avs: Add I2S-test machine board") adds
> the config "SND_SOC_INTEL_AVS_MACH_I2S_TEST", but in the Makefile refers
> to  config "SND_SOC_INTEL_AVS_MACH_i2s_TEST" (notice the uppercase and
> lowercase difference).
> 
> Adjust the Makefile to refer to the actual existing config.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Amadeusz, Cezary, please ack.
> 
> Mark, please pick this minor build config fix.
> 
>   sound/soc/intel/avs/boards/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/avs/boards/Makefile b/sound/soc/intel/avs/boards/Makefile
> index 25e8c4bb07db..bc75376d58c2 100644
> --- a/sound/soc/intel/avs/boards/Makefile
> +++ b/sound/soc/intel/avs/boards/Makefile
> @@ -16,7 +16,7 @@ snd-soc-avs-ssm4567-objs := ssm4567.o
>   obj-$(CONFIG_SND_SOC_INTEL_AVS_MACH_DA7219) += snd-soc-avs-da7219.o
>   obj-$(CONFIG_SND_SOC_INTEL_AVS_MACH_DMIC) += snd-soc-avs-dmic.o
>   obj-$(CONFIG_SND_SOC_INTEL_AVS_MACH_HDAUDIO) += snd-soc-avs-hdaudio.o
> -obj-$(CONFIG_SND_SOC_INTEL_AVS_MACH_i2s_TEST) += snd-soc-avs-i2s-test.o
> +obj-$(CONFIG_SND_SOC_INTEL_AVS_MACH_I2S_TEST) += snd-soc-avs-i2s-test.o
>   obj-$(CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98357A) += snd-soc-avs-max98357a.o
>   obj-$(CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98373) += snd-soc-avs-max98373.o
>   obj-$(CONFIG_SND_SOC_INTEL_AVS_MACH_NAU8825) += snd-soc-avs-nau8825.o

Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
