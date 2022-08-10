Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1FE58F3C6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 23:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbiHJVYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 17:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiHJVYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 17:24:09 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B8010541
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 14:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660166649; x=1691702649;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qftdVsCU3LkGo5qbpg7jkh26LzLubTtG7x0gDcF2+f4=;
  b=JgAUO2ISI2cLlImc7gjwurzvWIKhhzvk9k74x6DDL/EMcos6WacDWQYI
   pbVV2uTFwJ182sV/qNHRKRdjnqdZWBzH4aVzxPZqTeOpAMU6RgX5F85I3
   XiwWTzGBJkfagLCo1GIrCnyYoJvQVkdy4rFCjQx5iQpPJQ+cDctDCxFqm
   hp72NYA/G/otKrWTNxZVzVjwXhCW7I/SOoww+087CAzN8eppRPICeDvNs
   +oE5rchF7IeefjEhyF5ClY0YGeoB81FqgUA4rbsnTYxYC0QbXTcitu7Pd
   UgJAhoia3+3ij/MKU6MqxpA3q0BmEktCMUaCCvyPjX1XAYc7G4awbyhcJ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="291197552"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="291197552"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 14:24:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="638254155"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 10 Aug 2022 14:24:07 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLtBO-0000j4-28;
        Wed, 10 Aug 2022 21:24:06 +0000
Date:   Thu, 11 Aug 2022 05:23:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: sound/core/control.c:390:11: sparse: sparse: incorrect type in
 assignment (different base types)
Message-ID: <202208110507.pZ5Q9mMb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f41445645ab5d172e6090d00c332c335d8dba337
commit: c27e1efb61c545f36c450ef60862df9251d239a4 ALSA: control: Use xarray for faster lookups
date:   8 weeks ago
config: i386-randconfig-s001 (https://download.01.org/0day-ci/archive/20220811/202208110507.pZ5Q9mMb-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c27e1efb61c545f36c450ef60862df9251d239a4
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c27e1efb61c545f36c450ef60862df9251d239a4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash sound/core/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> sound/core/control.c:390:11: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long h @@     got restricted snd_ctl_elem_iface_t const [usertype] iface @@
   sound/core/control.c:390:11: sparse:     expected unsigned long h
   sound/core/control.c:390:11: sparse:     got restricted snd_ctl_elem_iface_t const [usertype] iface
   sound/core/control.c:926:17: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:926:26: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:927:17: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:927:26: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:946:48: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer
   sound/core/control.c:1640:40: sparse: sparse: restricted snd_ctl_elem_type_t degrades to integer

vim +390 sound/core/control.c

   378	
   379	#ifdef CONFIG_SND_CTL_FAST_LOOKUP
   380	/* Compute a hash key for the corresponding ctl id
   381	 * It's for the name lookup, hence the numid is excluded.
   382	 * The hash key is bound in LONG_MAX to be used for Xarray key.
   383	 */
   384	#define MULTIPLIER	37
   385	static unsigned long get_ctl_id_hash(const struct snd_ctl_elem_id *id)
   386	{
   387		unsigned long h;
   388		const unsigned char *p;
   389	
 > 390		h = id->iface;
   391		h = MULTIPLIER * h + id->device;
   392		h = MULTIPLIER * h + id->subdevice;
   393		for (p = id->name; *p; p++)
   394			h = MULTIPLIER * h + *p;
   395		h = MULTIPLIER * h + id->index;
   396		h &= LONG_MAX;
   397		return h;
   398	}
   399	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
