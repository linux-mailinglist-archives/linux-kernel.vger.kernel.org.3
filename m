Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA931523DFE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347291AbiEKTvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347223AbiEKTvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:51:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264295716B
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652298708; x=1683834708;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PWCSb4NhiQKxZ/rI2pj7f++Br5JH9wBBOHOhy4AXXKA=;
  b=c0ytaQO4UFmrRH8Cb7WzGQLYf+DvyEplmSRoJGTi0N2quCclMzKHQUvL
   QWPZ9DvkE+kFN5R8ueOcSW2UUEKPATZmV66jylDjzsS9W8na7/TNWhCa7
   kJyYmcQS1dUxDLQy/jRtrkTAXTRTl/z8ecrsCQYkkgXFhWZ7pxwx+9+R+
   UYGTcWYtOzssdjXyMIoyDkLbNCYMO+HE/42t50hvokACbNf3h3iWiRpFf
   tr2wO+H0GNADF3Hx/7LULkzQgYxERW6p1X4OSsRntf/6WlZ2v0MasjGGI
   r2i/lGe6OO5/Q9JiW8g7FKjYOqPvdKDihuhA2X6HFgvpgCVISmA3LgmIS
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="295043710"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="295043710"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 12:51:47 -0700
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="711624389"
Received: from tssurap-mobl1.amr.corp.intel.com (HELO [10.255.229.68]) ([10.255.229.68])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 12:51:47 -0700
Message-ID: <dfae72f1-0ee0-cf22-0fd7-5465209fb8b0@linux.intel.com>
Date:   Wed, 11 May 2022 14:51:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: kismet: WARNING: unmet direct dependencies detected for
 SND_SOC_MAX98357A when selected by SND_SOC_INTEL_SOF_CS42L42_MACH
Content-Language: en-US
To:     kernel test robot <yujie.liu@intel.com>,
        Brent Lu <brent.lu@intel.com>
Cc:     kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, paul@pgazz.com,
        fazilyildiran@gmail.com,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
References: <202205110550.80rLRw2L-lkp@intel.com>
 <cc9905dd-5b66-d01e-491c-64c18198d208@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <cc9905dd-5b66-d01e-491c-64c18198d208@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/22 22:36, kernel test robot wrote:
> tree:  
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   feb9c5e19e913b53cb536a7aa7c9f20107bb51ec
> commit: 5a7f27a624d9e33262767b328aa7a4baf7846c14 ASoC: Intel: add
> sof-cs42l42 machine driver
> date:   1 year ago
> config: (attached as .config)
> reproduce:
>         #
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5a7f27a624d9e33262767b328aa7a4baf7846c14
> 
>         git remote add linus
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 5a7f27a624d9e33262767b328aa7a4baf7846c14
>         # 1. reproduce by kismet
>            # install kmax per https://github.com/paulgazz/kmax/README.md
>            kismet --linux-ksrc=linux --selectees
> CONFIG_SND_SOC_MAX98357A --selectors
> CONFIG_SND_SOC_INTEL_SOF_CS42L42_MACH -a=x86_64
>         # 2. reproduce by make
>            # save the config file to linux source tree
>            cd linux
>            make ARCH=x86_64 olddefconfig
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <yujie.liu@intel.com>
> 
> 
> kismet warnings: (new ones prefixed by >>)
>>> kismet: WARNING: unmet direct dependencies detected for
> SND_SOC_MAX98357A when selected by SND_SOC_INTEL_SOF_CS42L42_MACH
> 
>    WARNING: unmet direct dependencies detected for SND_SOC_MAX98357A
>      Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] &&
> GPIOLIB [=n]
>      Selected by [y]:
>      - SND_SOC_INTEL_SOF_CS42L42_MACH [=y] && SOUND [=y] && !UML && SND
> [=y] && SND_SOC [=y] && SND_SOC_INTEL_MACH [=y] && (SND_SOC_SOF_HDA_LINK
> [=y] || SND_SOC_SOF_BAYTRAIL [=n]) && I2C [=y] && ACPI [=y] &&
> SND_HDA_CODEC_HDMI [=y] && SND_SOC_SOF_HDA_AUDIO_CODEC [=y] &&
> (MFD_INTEL_LPSS [=y] || COMPILE_TEST [=n])

I can reproduce this, but I question the hard dependency on GPIOLIB in
the amplifier Kconfig:

	max98357a->sdmode = devm_gpiod_get_optional(&pdev->dev,
				"sdmode", GPIOD_OUT_LOW);

If the gpio is optional, max98357a.c should build and compile without
GPIOLIB, no?


>    WARNING: unmet direct dependencies detected for SND_SOC_DMIC
>      Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] &&
> GPIOLIB [=n]
>      Selected by [y]:
>      - SND_SOC_INTEL_SOF_CS42L42_MACH [=y] && SOUND [=y] && !UML && SND
> [=y] && SND_SOC [=y] && SND_SOC_INTEL_MACH [=y] && (SND_SOC_SOF_HDA_LINK
> [=y] || SND_SOC_SOF_BAYTRAIL [=n]) && I2C [=y] && ACPI [=y] &&
> SND_HDA_CODEC_HDMI [=y] && SND_SOC_SOF_HDA_AUDIO_CODEC [=y] &&
> (MFD_INTEL_LPSS [=y] || COMPILE_TEST [=n])

I can't reproduce this one with Mark's for-next branch, this was fixed I
believe.
