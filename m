Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E503523E6F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 22:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345063AbiEKUHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 16:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237946AbiEKUHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 16:07:37 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF2D49693
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 13:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652299656; x=1683835656;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=p1YYXl+yTi1DWtmId54tKAQpdz8+AHZrDsEKCg5NNqI=;
  b=W2manKi2p6zrEBRto/Z95UjwscM1LIqObpkfvGn3OEUJTOSHM8XHGTBl
   fyOHrf16laxHcEd/GZzQu8M9mH4a8W22mqJ6VDmJMXEtrguQDXTiKke2N
   flMBkgBOf4hst9+G0BtEBf+8LRmuYZySIHWWE/b4d9PHOibI8XZ2Y3bpN
   T5jrVpEXjFad6nX4pJ4d1Twl5Os1YWkaUEyz0Vdh8O5cpwrwHY0C5gk21
   8ZKEq+ZrxbFI5Iz5xUqORp7GXbI7WAMb9a4ES6FIM5WetavGy8huZmvJB
   o8rKRNJx8M47F6lyOl7C2ceN2LkJ1K0/YgOebryOp2CBaMvNEFxpaGvME
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="330403515"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="330403515"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 13:07:36 -0700
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="711629310"
Received: from tssurap-mobl1.amr.corp.intel.com (HELO [10.255.229.68]) ([10.255.229.68])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 13:07:35 -0700
Message-ID: <69a3eaf4-0ad6-ffbf-f5be-d6fdc880276f@linux.intel.com>
Date:   Wed, 11 May 2022 15:07:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: kismet: WARNING: unmet direct dependencies detected for
 SND_SOC_MAX98357A when selected by SND_SOC_INTEL_SOF_CS42L42_MACH
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     kernel test robot <yujie.liu@intel.com>,
        Brent Lu <brent.lu@intel.com>
Cc:     ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        kbuild-all@lists.01.org, paul@pgazz.com, fazilyildiran@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
References: <202205110550.80rLRw2L-lkp@intel.com>
 <cc9905dd-5b66-d01e-491c-64c18198d208@intel.com>
 <dfae72f1-0ee0-cf22-0fd7-5465209fb8b0@linux.intel.com>
In-Reply-To: <dfae72f1-0ee0-cf22-0fd7-5465209fb8b0@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> kismet: WARNING: unmet direct dependencies detected for
>> SND_SOC_MAX98357A when selected by SND_SOC_INTEL_SOF_CS42L42_MACH
>>
>>    WARNING: unmet direct dependencies detected for SND_SOC_MAX98357A
>>      Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] &&
>> GPIOLIB [=n]
>>      Selected by [y]:
>>      - SND_SOC_INTEL_SOF_CS42L42_MACH [=y] && SOUND [=y] && !UML && SND
>> [=y] && SND_SOC [=y] && SND_SOC_INTEL_MACH [=y] && (SND_SOC_SOF_HDA_LINK
>> [=y] || SND_SOC_SOF_BAYTRAIL [=n]) && I2C [=y] && ACPI [=y] &&
>> SND_HDA_CODEC_HDMI [=y] && SND_SOC_SOF_HDA_AUDIO_CODEC [=y] &&
>> (MFD_INTEL_LPSS [=y] || COMPILE_TEST [=n])
> 
> I can reproduce this, but I question the hard dependency on GPIOLIB in
> the amplifier Kconfig:
> 
> 	max98357a->sdmode = devm_gpiod_get_optional(&pdev->dev,
> 				"sdmode", GPIOD_OUT_LOW);
> 
> If the gpio is optional, max98357a.c should build and compile without
> GPIOLIB, no?

The warning goes away with the patch suggested in
https://github.com/thesofproject/linux/pull/3646

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig

index b106e55170904..8536773548090 100644

--- a/sound/soc/codecs/Kconfig

+++ b/sound/soc/codecs/Kconfig

@@ -986,7 +986,6 @@ config SND_SOC_MAX98095



 config SND_SOC_MAX98357A

        tristate "Maxim MAX98357A CODEC"

-       depends on GPIOLIB



 config SND_SOC_MAX98371

        tristate

