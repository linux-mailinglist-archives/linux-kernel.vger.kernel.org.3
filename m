Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3220253AC22
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 19:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356411AbiFARnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 13:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356404AbiFARnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 13:43:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5837B9DF
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 10:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654105424; x=1685641424;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O76EMfv/RHibOpFDppwDuUPZWItQ/txbZlbLLYm8wfs=;
  b=ath2uj1djCA/2x730oTkMg2upvtuVcZcak6m7IK2+NJURDJYyEm+bad2
   rQ8ivdEPPs9vLPMR/wMgnaGPZ28FcGoyrymsgPTuIp0Bgh09kgzQ8/tz4
   4tjLqHHRuf4ZtyPixD9LPdn7Y00p24fFJktqcEdL5fK5B+l+PalEt5aLn
   TNLCFKJtoGUuhvFk17yAvdyvovmtTa/MkWROqOAvK2xJ+gpF87pmYg9EZ
   j1Tiomt98hL8Y0KKFnidIaqN4DjY0pd+N9kJ0/6t0k2hCb0LZB867Bg2c
   Np/50lL+/ytpzjH4DJni416d11+7eCJ71hcFj08eVQbPngj6pIPAMfTZJ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="256148007"
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="256148007"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 10:43:44 -0700
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="633638944"
Received: from aloney-mobl2.amr.corp.intel.com (HELO [10.209.25.15]) ([10.209.25.15])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 10:43:43 -0700
Message-ID: <66914bd5-8bed-adba-c7a7-6cbfe1ad3520@linux.intel.com>
Date:   Wed, 1 Jun 2022 12:17:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: soundwire: device drivers for PC based hardware
Content-Language: en-US
To:     Muni Sekhar <munisekharrms@gmail.com>, vkoul@kernel.org,
        sanyog.r.kale@intel.com, alsa-devel <alsa-devel@alsa-project.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <CAHhAz+gqRDh=CJseQEhAJcRVEguxQ5c4vdUX8dvzdPNT=Sy3iA@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <CAHhAz+gqRDh=CJseQEhAJcRVEguxQ5c4vdUX8dvzdPNT=Sy3iA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/31/22 10:17, Muni Sekhar wrote:
> Hi all,
> 
> I am looking for the soundwire device drivers which run on x86 CPU for
> PC based platforms.
> 
> linux/drivers/soundwire at master · torvalds/linux · GitHub
> 
> Can the above mentioned mainline tree drivers can be used for this purpose?
> 
> config SOUNDWIRE_INTEL
> depends on ACPI && SND_SOC
> 
> config SOUNDWIRE_QCOM
> depends on SND_SOC
> 
> As per the Kconfig file, both the Intel and Qualcomm SoundWire Master
> driver depend on SND_SOC, does it mean it is only possible to run on
> SoC CPU(Arm chipsets)?

Here's what you need in your .config to use SoundWire on x86-based
hardware. Today this includes mostly Dell platforms, HP x360 convertible
laptops and Intel 'bishop canyon' NUC laptops.

CONFIG_REGMAP_SOUNDWIRE=m

CONFIG_REGMAP_SOUNDWIRE_MBQ=m

CONFIG_SND_INTEL_SOUNDWIRE_ACPI=m

CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH=m

CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE=m

CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE=m

CONFIG_SOUNDWIRE=m

CONFIG_SOUNDWIRE_CADENCE=m

CONFIG_SOUNDWIRE_INTEL=m

# CONFIG_SOUNDWIRE_QCOM is not set

CONFIG_SOUNDWIRE_GENERIC_ALLOCATION=m


I think you can get everything if you select these 3 high-level ones:
CONFIG_SOUNDWIRE
CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE
CONFIG_SND_SOC_INTEL_SOUNDWIRE_SOF_MACH
