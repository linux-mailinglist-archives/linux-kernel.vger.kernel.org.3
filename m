Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0FD481A87
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237190AbhL3Hzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:55:48 -0500
Received: from mga18.intel.com ([134.134.136.126]:61851 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231688AbhL3Hzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640850947; x=1672386947;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AD0svqEQD95a1euVgIEmOxteoYAn+jzGxTBX3FYcr44=;
  b=mk0pdSAb0aTYe0BxXPrqNhFHtEz1u/tXioODG/4pEPsLgMYfdibyG7+H
   zngDQ/wl6Gaj7k2JUmV84sitXYC3I6EiI7NI7vUGF3C0JhJOT3E1iEvDP
   1U1vMFpHh5GnDvaH5C0G2pNUP0TOdvx7nMGs+yAvAfycLQuuukNz+IAea
   cOuAyHqfIQKnpoT3NL8Ig/qw35QEnMFXWKQT5PVkNAsNHIVcPO/WfkmTT
   zkyjx37nDx6Iwx5C6z6UOqhsNOxqRaF5GlAQY1q316OF1w5kkOPFI3EZa
   MbTs40/ytboZiDdT0l+4fsIOOzaeZblfKONIfq1zla7ynYpdrlO3z9ZfW
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="228461304"
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="228461304"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 23:55:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="525023148"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 29 Dec 2021 23:55:45 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2qHp-0009tV-3h; Thu, 30 Dec 2021 07:55:45 +0000
Date:   Thu, 30 Dec 2021 15:54:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [goldwynr:iomap 29/33] fs/btrfs/inode.c:8440:24: sparse: sparse:
 symbol 'btrfs_buffered_read_iomap_ops' was not declared. Should it be
 static?
Message-ID: <202112301510.SuWKl9nZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/goldwynr/linux iomap
head:   30c74a8c201365178cae26d0d7aefa120c3245ab
commit: 3f7d55b62cade444975e4452af7b623c78bc48ef [29/33] btrfs: iomap_begin() for buffered read
config: i386-randconfig-s001-20211228 (https://download.01.org/0day-ci/archive/20211230/202112301510.SuWKl9nZ-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/goldwynr/linux/commit/3f7d55b62cade444975e4452af7b623c78bc48ef
        git remote add goldwynr https://github.com/goldwynr/linux
        git fetch --no-tags goldwynr iomap
        git checkout 3f7d55b62cade444975e4452af7b623c78bc48ef
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash fs/btrfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> fs/btrfs/inode.c:8440:24: sparse: sparse: symbol 'btrfs_buffered_read_iomap_ops' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
