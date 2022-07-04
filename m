Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E33565315
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbiGDLMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbiGDLMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:12:13 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0163E101CD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 04:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656933131; x=1688469131;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=itpFo4LeNA7hKE3gUcxho+kwZenWsvAmsftrpVYVxVQ=;
  b=n15LtlN0qnRby+XEPtidaWI/rz7Z0cYD7n/DfzV4E2QBLzfrsEkwFb+C
   CJFi3PRuLGJBHcUclAfWX0Qk1orgXsQWFNH8T2LhksSScN5044tXRlSAv
   DqSDUVgLYowOXZcDVozKNh8WZrivnHbXnj2BNcp8N0oJ8u5pn3FnZomyM
   gVZlN6xPzABadQ5sQC0AfDB2ejSWYH6V2k4AuUclayeoUiVJkxd3iWASG
   siGvUwK+k6VrDH9nwzOIsdN+3mn2e5qJhJowKgveWAQ6/4YlSvHHvyTaa
   CSXnjjzKUe6zAT/dTds99nMeE2Wg7S7a5RXPKsiLC8DhA7P4JvBPNqB3c
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="281861130"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="281861130"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 04:12:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="592473955"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 04 Jul 2022 04:12:09 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8Jzs-000HpA-T4;
        Mon, 04 Jul 2022 11:12:08 +0000
Date:   Mon, 4 Jul 2022 19:11:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 2/61]
 lib/iov_iter.c:1803:9: sparse: sparse: incorrect type in argument 2
 (different address spaces)
Message-ID: <202207041919.hbuajt5T-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-linked-list
head:   ce4670495468b797b0c5927fcb661bc0da48b9ab
commit: 0ac76aa3371bb25ad7921628f97c51a225ded090 [2/61] iov_iter: Add a general purpose iteration function
config: arc-randconfig-s032-20220703 (https://download.01.org/0day-ci/archive/20220704/202207041919.hbuajt5T-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/0ac76aa3371bb25ad7921628f97c51a225ded090
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-linked-list
        git checkout 0ac76aa3371bb25ad7921628f97c51a225ded090
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> lib/iov_iter.c:1803:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *p @@     got void [noderef] __user *[assigned] base @@
   lib/iov_iter.c:1803:9: sparse:     expected void const *p
   lib/iov_iter.c:1803:9: sparse:     got void [noderef] __user *[assigned] base
   lib/iov_iter.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/arc/include/asm/uaccess.h:590:33: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char *d_char @@     got void [noderef] __user *to @@
   arch/arc/include/asm/uaccess.h:590:33: sparse:     expected unsigned char *d_char
   arch/arc/include/asm/uaccess.h:590:33: sparse:     got void [noderef] __user *to
   lib/iov_iter.c: note: in included file:
   include/net/checksum.h:31:39: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int @@
   include/net/checksum.h:31:39: sparse:     expected restricted __wsum [usertype] sum
   include/net/checksum.h:31:39: sparse:     got unsigned int
   include/net/checksum.h:39:45: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected restricted __wsum [usertype] sum @@     got unsigned int @@
   include/net/checksum.h:39:45: sparse:     expected restricted __wsum [usertype] sum
   include/net/checksum.h:39:45: sparse:     got unsigned int

vim +1803 lib/iov_iter.c

  1779	
  1780	/**
  1781	 * iov_iter_scan - Scan a source iter
  1782	 * @i: The iterator to scan
  1783	 * @bytes: The amount of buffer/data to scan
  1784	 * @scanner: The function to call for each bit
  1785	 * @priv: Private data to pass to the scanner function
  1786	 *
  1787	 * Scan an iterator, passing each segment to the scanner function.  If the
  1788	 * scanner returns an error at any time, scanning stops and the error is
  1789	 * returned, otherwise the sum of the scanner results is returned.
  1790	 */
  1791	ssize_t iov_iter_scan(struct iov_iter *i, size_t bytes,
  1792			      ssize_t (*scanner)(struct iov_iter *i, const void *p,
  1793						 size_t len, size_t off, void *priv),
  1794			      void *priv)
  1795	{
  1796		ssize_t ret = 0, scanned = 0;
  1797	
  1798		if (!bytes)
  1799			return 0;
  1800		if (iter_is_iovec(i))
  1801			might_fault();
  1802	
> 1803		iterate_and_advance(
  1804			i, bytes, base, len, off, ({
  1805					ret = scanner(i, base, len, off, priv);
  1806					if (ret < 0)
  1807						break;
  1808					scanned += ret;
  1809				}), ({
  1810					ret = scanner(i, base, len, off, priv);
  1811					if (ret < 0)
  1812						break;
  1813					scanned += ret;
  1814				})
  1815		);
  1816		return ret < 0 ? ret : scanned;
  1817	}
  1818	EXPORT_SYMBOL(iov_iter_scan);
  1819	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
