Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537DC52592B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 03:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376268AbiEMBB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 21:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376259AbiEMBBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 21:01:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740EF2CDDF
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 18:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652403657; x=1683939657;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EHcERrF0j/OvQc+pqRKI7/bHYA2rsQ4m4GRL6qj0iQU=;
  b=e+aGAY2Jfq7D0eLwnIWQWpQifU5WDbKXfG5ptEWhx3L66oZXjDkM1P/i
   lRoIvEL+EW+DLuoEreHDchyTJEK9nIt+eVeJ9DtCAslo0F2qczovrRybK
   3ivFqdnwB+nTq0NmzHrDwts6EV5ih80hherYh9y+N1OVkgkDGawzaJZm0
   yGJhF8r+ELL1Mjgz6QZ1ccgX+uOiQcYRV+qWyeoezGY7L2gQFsAqXVDSI
   aL/jf7RC4t6hhrFbi2P4Kpym1a1yv7o0txNpFEBR1F6wQFRB4/3UW7nub
   hIStEW7dsnYyoB21xNY9zyTl+TfvbKT+4njk4KI2ctXVY/R5QkPNeDHuc
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="295436727"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="295436727"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 18:00:53 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="566956523"
Received: from jainamit-mobl.amr.corp.intel.com (HELO [10.212.194.29]) ([10.212.194.29])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 18:00:52 -0700
Message-ID: <54dc371f-27ed-1b24-1e16-d80c01322f4a@linux.intel.com>
Date:   Thu, 12 May 2022 20:00:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: kismet: WARNING: unmet direct dependencies detected for
 SND_SOC_RT1015P when selected by SND_SOC_INTEL_SOF_RT5682_MACH
Content-Language: en-US
To:     kernel test robot <yujie.liu@intel.com>
Cc:     kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        paul@pgazz.com, fazilyildiran@gmail.com,
        Mark Brown <broonie@kernel.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
References: <202205112305.8RPNXfIy-lkp@intel.com>
 <d637dacd-4afc-81b7-7776-c298c87c94ac@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <d637dacd-4afc-81b7-7776-c298c87c94ac@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/12/22 11:57, kernel test robot wrote:
> tree:  
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   feb9c5e19e913b53cb536a7aa7c9f20107bb51ec
> commit: 32666b866f55a224d2f07f83594fcf37a922b6c9 ASoC: Intel: boards:
> remove explicit dependency on GPIOLIB when DMIC is used"
> date:   9 weeks ago
> config: (attached as .config)
> reproduce:
>         #
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=32666b866f55a224d2f07f83594fcf37a922b6c9
> 
>         git remote add linus
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 32666b866f55a224d2f07f83594fcf37a922b6c9
>         # 1. reproduce by kismet
>            # install kmax per https://github.com/paulgazz/kmax/README.md
>            kismet --linux-ksrc=linux --selectees CONFIG_SND_SOC_RT1015P
> --selectors CONFIG_SND_SOC_INTEL_SOF_RT5682_MACH -a=x86_64
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
> SND_SOC_RT1015P when selected by SND_SOC_INTEL_SOF_RT5682_MACH
> 
>    WARNING: unmet direct dependencies detected for SND_SOC_RT1015P
>      Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] &&
> GPIOLIB [=n]
>      Selected by [y]:
>      - SND_SOC_INTEL_SOF_RT5682_MACH [=y] && SOUND [=y] && !UML && SND
> [=y] && SND_SOC [=y] && SND_SOC_INTEL_MACH [=y] && (SND_SOC_SOF_HDA_LINK
> [=y] || SND_SOC_SOF_BAYTRAIL [=n]) && I2C [=y] && ACPI [=y] &&
> (SND_HDA_CODEC_HDMI [=y] && SND_SOC_SOF_HDA_AUDIO_CODEC [=y] &&
> (MFD_INTEL_LPSS [=y] || COMPILE_TEST [=y]) || SND_SOC_SOF_BAYTRAIL [=n]
> && (X86_INTEL_LPSS [=n] || COMPILE_TEST [=y]))


This seems to be a generic problem in codecs to use 'depends on GPIOLIB'
even when the gpio is optional

I'll send another patch for this.
