Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDA64F4216
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381079AbiDEU3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457972AbiDERCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:02:24 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B412E9C6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 10:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649178025; x=1680714025;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=k7SeToO452mTi6XqawYJZEIVpub9vEr3cmiDJ4ugJ9I=;
  b=f7vTPay2okWsxMimb+yP4/jkpxyV0sT8PWTIon6rM8VRwvT1EMPpqILp
   epgj97wKB9K8f2uLHSlEG6D3nMdz3Q4rg1wXf3FYJF7BgcN5s+vO1Eu4e
   4C2ElS4BZviKaBiMaKAGvVgrSpJkDfZvlqgVSg12CyjjGiu9srQgLqPie
   uGvS7xXT9Lo1C6C1t2HH/ELJK9dijkW4rRkNFn2fLOQtlVpM4UNOnn30J
   gdRGUtwpBDlJIskyqHT9gLZisGcdc2lYByfUr/2clU7aQBQVWTeWNZXLK
   2NXRnXytq6zru8getxZ1EyWsD1qxiXwj1eMYPQqEFXo+p1oKv07Ru7mYR
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="240738095"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="240738095"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 10:00:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="587999497"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 05 Apr 2022 10:00:24 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbmXX-0003cA-CT;
        Tue, 05 Apr 2022 17:00:23 +0000
Date:   Wed, 6 Apr 2022 01:00:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [vsyrjala:vbt_panel_type_pnp_id_2 31/32]
 drivers/gpu/drm/i915/display/intel_bios.c:619:9: sparse: sparse: cast to
 restricted __be16
Message-ID: <202204060009.xXKxOfo4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/vsyrjala/linux.git vbt_panel_type_pnp_id_2
head:   805ff25c9e3d368cf07b5ce3c36a37a7240185ff
commit: d7d51fb935143002f73468eee9fd1ed3bafa7b08 [31/32] drm/i915/bios: Dump PNPID and panel name
config: i386-randconfig-s001 (https://download.01.org/0day-ci/archive/20220406/202204060009.xXKxOfo4-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/vsyrjala/linux/commit/d7d51fb935143002f73468eee9fd1ed3bafa7b08
        git remote add vsyrjala https://github.com/vsyrjala/linux.git
        git fetch --no-tags vsyrjala vbt_panel_type_pnp_id_2
        git checkout d7d51fb935143002f73468eee9fd1ed3bafa7b08
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/i915/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/i915/display/intel_bios.c:619:9: sparse: sparse: cast to restricted __be16

vim +619 drivers/gpu/drm/i915/display/intel_bios.c

   612	
   613	static void dump_pnp_id(struct drm_i915_private *i915,
   614				const struct lvds_pnp_id *pnp_id,
   615				const char *name)
   616	{
   617		char vend[4];
   618	
 > 619		drm_dbg_kms(&i915->drm, "%s PNPID mfg: %s (0x%x), prod: %u, serial: %u, week: %d, year: %d\n",
   620			    name, drm_edid_decode_mfg_id(be16_to_cpu(pnp_id->mfg_name), vend),
   621			    pnp_id->mfg_name, pnp_id->product_code, pnp_id->serial,
   622			    pnp_id->mfg_week, pnp_id->mfg_year + 1990);
   623	}
   624	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
