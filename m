Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D453F596B3D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 10:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbiHQIO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 04:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiHQIOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 04:14:24 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B663137B
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 01:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660724058; x=1692260058;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nNjN1SzuJ/QDv978B188fk9TC8dj2JKxjvy6ZW0+g64=;
  b=fjUx9mwB9SiTT18kpcH4K9ZytMxDvLAsOq0Br0WRmiDS7PfWcKXtgwmW
   6X11NLKfa07DqfquKclSFV33ZFgJAenm7nCo2osn5eXsApUuEp0PEk31X
   Ont/QeG6JvsJZShgLewZgkH1KklkR3FF0+1Umy6rGhx60s6j1OdotypIV
   TJuA8Ma4E6VpF/ySZdKoThT01sJ0S2ERH7k7Z968aic8MCMT9rStpHzq0
   9lfiEttjVRdgRtZBU+DKD2u64/Tt+T82tEPMkDO6SOKXlDuX9XQv5L4tM
   v6MBeE/QJL8Ao+/ntN9hI9UrDrKmPPEyPd3dNFTJX0ka9qdVDKX7Ep3NM
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="293710750"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="293710750"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 01:14:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="636268577"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 17 Aug 2022 01:14:14 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOEBq-0000iq-0j;
        Wed, 17 Aug 2022 08:14:14 +0000
Date:   Wed, 17 Aug 2022 16:13:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:guest-unaccepted-memory 11/14] kexec_file.c:undefined
 reference to `arch_kexec_load'
Message-ID: <202208171452.AKZhcBTE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-unaccepted-memory
head:   86fb61d5824802e1b7c4c8eb1b34029024f52ee6
commit: 820c5c338451079677510d4183ba5d5dc314c030 [11/14] x86: Disable kexec if system has unaccepted memory
config: x86_64-randconfig-a003-20220815 (https://download.01.org/0day-ci/archive/20220817/202208171452.AKZhcBTE-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/820c5c338451079677510d4183ba5d5dc314c030
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-unaccepted-memory
        git checkout 820c5c338451079677510d4183ba5d5dc314c030
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `__do_sys_kexec_file_load':
>> kexec_file.c:(.text+0x1e567d): undefined reference to `arch_kexec_load'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
