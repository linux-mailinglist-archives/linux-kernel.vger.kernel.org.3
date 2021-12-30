Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80AC4819E5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 07:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbhL3GXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 01:23:43 -0500
Received: from mga05.intel.com ([192.55.52.43]:20917 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236346AbhL3GXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 01:23:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640845422; x=1672381422;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mFdkGzu2R04RemsC2jcxSWBPpDqoYLYuq/x1Z7YiY1Y=;
  b=IT5ZOkbUBDWztdYVZ58nI0f1DEPLIJEtVGCbGcSW/AE+Fms2NrA7UcIR
   sOY6a86qOk0y/hk2VNuUqp9Jlaql1v4uxTa5zkYQm0RatcQul3W7yk0bf
   1P/il6mw/k3z756SySQDHfNFzYh6J8QWFfc1+64QM8FQQto8nFt00TRLw
   PFmy42Bxm2d+WMza1MQh3loHWoB9MLhAYCDRyao1r+kt3ucNC6fRskSqT
   XLE+hf76ZnXbVugkd1pZKHdMDNMLpwvgFeNiAaRDlu9ePsCmxS8UTznVN
   Y/bI/GD8iI8fjg1GevE2nTF8Z5JWVxDnLSf4DdLp4XYPgpVBCoznucT6u
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="327956748"
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="327956748"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 22:23:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="510787335"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 29 Dec 2021 22:23:41 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2oqi-0009qG-HA; Thu, 30 Dec 2021 06:23:40 +0000
Date:   Thu, 30 Dec 2021 14:22:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [goldwynr:iomap 25/33] fs/btrfs/file.c:1781:24: sparse: sparse:
 symbol 'btrfs_buffered_iomap_ops' was not declared. Should it be static?
Message-ID: <202112301434.DN0qgOT0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/goldwynr/linux iomap
head:   30c74a8c201365178cae26d0d7aefa120c3245ab
commit: f4ecee4435f363df5a0fc93124ddddae5f79d9d0 [25/33] btrfs: Switch to iomap_file_buffered_write()
config: i386-randconfig-s001-20211228 (https://download.01.org/0day-ci/archive/20211230/202112301434.DN0qgOT0-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/goldwynr/linux/commit/f4ecee4435f363df5a0fc93124ddddae5f79d9d0
        git remote add goldwynr https://github.com/goldwynr/linux
        git fetch --no-tags goldwynr iomap
        git checkout f4ecee4435f363df5a0fc93124ddddae5f79d9d0
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash fs/btrfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/btrfs/file.c:1781:24: sparse: sparse: symbol 'btrfs_buffered_iomap_ops' was not declared. Should it be static?

vim +/btrfs_buffered_iomap_ops +1781 fs/btrfs/file.c

  1780	
> 1781	const struct iomap_ops btrfs_buffered_iomap_ops = {
  1782		.iomap_begin = btrfs_buffered_iomap_begin,
  1783		.iomap_end = btrfs_buffered_iomap_end,
  1784	};
  1785	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
