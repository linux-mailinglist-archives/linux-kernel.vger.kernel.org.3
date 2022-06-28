Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E9F55DD7F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244499AbiF1GjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 02:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245573AbiF1GjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 02:39:13 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651D0643E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 23:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656398352; x=1687934352;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GAj10GC5cKmyodp4SYGSnnywAUIdTK7sBJzvdE/uR0M=;
  b=eJkzFw9rnGpM5/ibwc1Dv56yRhF3Z5rV+7aVw7mLZGNuVX5OtMrTe4iZ
   BMxETrbG6SdRBRgGHLv/CKqXSw70Cg682rCOlwSlsN8scG8H6K8ryQYHP
   p3ec0oGkYZtaXJJ2GdJyELvsYq+6tSn83tl4K8tH1TS9bfQxvcJ23byUY
   vl1mEgGO9nCcdrfK2PaN7XltxGPg//P8nKmh9raFOhASLNjstx7ewDPyH
   xa1+RA+YU9kmnZ3bfOOTWOwAQUl7mPRU+Zzzcx9pn8kRYz9yWWnrVO+ey
   c1XZjL2LMAh8QZMkSG3aavdr5Umv7CsbD6Lr2Cv+51q+d7w/2x3TpnT79
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="367963321"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="367963321"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 23:39:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="590199556"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 27 Jun 2022 23:39:10 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o64sP-0009dG-NY;
        Tue, 28 Jun 2022 06:39:09 +0000
Date:   Tue, 28 Jun 2022 14:38:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>
Subject: [hare-scsi-devel:auth.v15 6/11] drivers/nvme/common/auth.c:59:31:
 warning: address of array 'dhgroup_map[dhgroup_id].name' will always
 evaluate to 'true'
Message-ID: <202206281449.L1Gh7eYz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git auth.v15
head:   2a3a7d0493841ac5944dc0ba861b53d1c2b28014
commit: e0c48505224ab6f6e86eea90b254ae202ecd0bb6 [6/11] nvme: Implement In-Band authentication
config: riscv-randconfig-c006-20220627 (https://download.01.org/0day-ci/archive/20220628/202206281449.L1Gh7eYz-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 016342e319fd31e41cf5ed16a6140a8ea2de74dd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=e0c48505224ab6f6e86eea90b254ae202ecd0bb6
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel auth.v15
        git checkout e0c48505224ab6f6e86eea90b254ae202ecd0bb6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/nvme/common/ drivers/nvme/target/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/nvme/common/auth.c:59:31: warning: address of array 'dhgroup_map[dhgroup_id].name' will always evaluate to 'true' [-Wpointer-bool-conversion]
               !dhgroup_map[dhgroup_id].name ||
               ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
>> drivers/nvme/common/auth.c:69:31: warning: address of array 'dhgroup_map[dhgroup_id].kpp' will always evaluate to 'true' [-Wpointer-bool-conversion]
               !dhgroup_map[dhgroup_id].kpp ||
               ~~~~~~~~~~~~~~~~~~~~~~~~~^~~
>> drivers/nvme/common/auth.c:81:23: warning: address of array 'dhgroup_map[i].name' will always evaluate to 'true' [-Wpointer-bool-conversion]
                   if (!dhgroup_map[i].name ||
                       ~~~~~~~~~~~~~~~~^~~~
>> drivers/nvme/common/auth.c:117:25: warning: address of array 'hash_map[hmac_id].hmac' will always evaluate to 'true' [-Wpointer-bool-conversion]
               !hash_map[hmac_id].hmac ||
               ~~~~~~~~~~~~~~~~~~~^~~~
>> drivers/nvme/common/auth.c:127:25: warning: address of array 'hash_map[hmac_id].digest' will always evaluate to 'true' [-Wpointer-bool-conversion]
               !hash_map[hmac_id].digest ||
               ~~~~~~~~~~~~~~~~~~~^~~~~~
>> drivers/nvme/common/auth.c:139:20: warning: address of array 'hash_map[i].hmac' will always evaluate to 'true' [-Wpointer-bool-conversion]
                   if (!hash_map[i].hmac || !strlen(hash_map[i].hmac))
                       ~~~~~~~~~~~~~^~~~
   drivers/nvme/common/auth.c:152:25: warning: address of array 'hash_map[hmac_id].hmac' will always evaluate to 'true' [-Wpointer-bool-conversion]
               !hash_map[hmac_id].hmac ||
               ~~~~~~~~~~~~~~~~~~~^~~~
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   error: A dwo section may not contain relocations
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   7 warnings and 20 errors generated.


vim +59 drivers/nvme/common/auth.c

    55	
    56	const char *nvme_auth_dhgroup_name(u8 dhgroup_id)
    57	{
    58		if ((dhgroup_id > ARRAY_SIZE(dhgroup_map)) ||
  > 59		    !dhgroup_map[dhgroup_id].name ||
    60		    !strlen(dhgroup_map[dhgroup_id].name))
    61			return NULL;
    62		return dhgroup_map[dhgroup_id].name;
    63	}
    64	EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_name);
    65	
    66	const char *nvme_auth_dhgroup_kpp(u8 dhgroup_id)
    67	{
    68		if ((dhgroup_id > ARRAY_SIZE(dhgroup_map)) ||
  > 69		    !dhgroup_map[dhgroup_id].kpp ||
    70		    !strlen(dhgroup_map[dhgroup_id].kpp))
    71			return NULL;
    72		return dhgroup_map[dhgroup_id].kpp;
    73	}
    74	EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_kpp);
    75	
    76	u8 nvme_auth_dhgroup_id(const char *dhgroup_name)
    77	{
    78		int i;
    79	
    80		for (i = 0; i < ARRAY_SIZE(dhgroup_map); i++) {
  > 81			if (!dhgroup_map[i].name ||
    82			    !strlen(dhgroup_map[i].name))
    83				continue;
    84			if (!strncmp(dhgroup_map[i].name, dhgroup_name,
    85				     strlen(dhgroup_map[i].name)))
    86				return i;
    87		}
    88		return NVME_AUTH_DHGROUP_INVALID;
    89	}
    90	EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_id);
    91	
    92	static struct nvme_dhchap_hash_map {
    93		int len;
    94		const char hmac[15];
    95		const char digest[8];
    96	} hash_map[] = {
    97		[NVME_AUTH_HASH_SHA256] = {
    98			.len = 32,
    99			.hmac = "hmac(sha256)",
   100			.digest = "sha256",
   101		},
   102		[NVME_AUTH_HASH_SHA384] = {
   103			.len = 48,
   104			.hmac = "hmac(sha384)",
   105			.digest = "sha384",
   106		},
   107		[NVME_AUTH_HASH_SHA512] = {
   108			.len = 64,
   109			.hmac = "hmac(sha512)",
   110			.digest = "sha512",
   111		},
   112	};
   113	
   114	const char *nvme_auth_hmac_name(u8 hmac_id)
   115	{
   116		if ((hmac_id > ARRAY_SIZE(hash_map)) ||
 > 117		    !hash_map[hmac_id].hmac ||
   118		    !strlen(hash_map[hmac_id].hmac))
   119			return NULL;
   120		return hash_map[hmac_id].hmac;
   121	}
   122	EXPORT_SYMBOL_GPL(nvme_auth_hmac_name);
   123	
   124	const char *nvme_auth_digest_name(u8 hmac_id)
   125	{
   126		if ((hmac_id > ARRAY_SIZE(hash_map)) ||
 > 127		    !hash_map[hmac_id].digest ||
   128		    !strlen(hash_map[hmac_id].digest))
   129			return NULL;
   130		return hash_map[hmac_id].digest;
   131	}
   132	EXPORT_SYMBOL_GPL(nvme_auth_digest_name);
   133	
   134	u8 nvme_auth_hmac_id(const char *hmac_name)
   135	{
   136		int i;
   137	
   138		for (i = 0; i < ARRAY_SIZE(hash_map); i++) {
 > 139			if (!hash_map[i].hmac || !strlen(hash_map[i].hmac))
   140				continue;
   141			if (!strncmp(hash_map[i].hmac, hmac_name,
   142				     strlen(hash_map[i].hmac)))
   143				return i;
   144		}
   145		return NVME_AUTH_HASH_INVALID;
   146	}
   147	EXPORT_SYMBOL_GPL(nvme_auth_hmac_id);
   148	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
