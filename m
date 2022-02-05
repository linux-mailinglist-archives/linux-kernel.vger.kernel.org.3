Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0048C4AA97A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 15:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380165AbiBEOjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 09:39:37 -0500
Received: from mga07.intel.com ([134.134.136.100]:6081 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232237AbiBEOjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 09:39:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644071976; x=1675607976;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZuHP55oHeCD9u+vcg1mVnXr+bJf+2J8ot3B/dgxjiqU=;
  b=FYILHmXsKB2evhZ1YwwnQ2/o362UNembpajkvlBODOSwRmqvZRPQXH9e
   cznn48AgpbFn5TqbK36YK3VZDERbjiyVEKBH2lhp5yOvJKY5gt+nAXQtA
   VY4i0+xvKv0nyj4O/Rkt8qonuSu9uQVw0644+XTfKg1CLAwbbi4Ryk09T
   9Us1Y6WRtgFPxgNIqvZ0LrGyEVvmE6zMGSuAdDrwXo/spAPZXtZzDsUSU
   Uk1nFDXCzpV4hgWQTnqv0xNEmoNxCHxwZhaQveYqKBWV0iLXOwKkJi2nV
   BeKUyhpUi/Sbs22XS9LyQTpZT0GKtTPNI5QWAZAs2riLrC+dAR/e98K34
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="311814397"
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="311814397"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 06:39:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="483913723"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 05 Feb 2022 06:39:35 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nGMDu-000Z9T-Co; Sat, 05 Feb 2022 14:39:34 +0000
Date:   Sat, 5 Feb 2022 22:38:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:smc/work 7/11] lib/vsprintf.c:1783:30: sparse: sparse:
 cast to restricted __le32
Message-ID: <202202052230.9Ehn5qnV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux smc/work
head:   fc848a39b71518ca1661de7057b87cb0e8cac9f9
commit: 0e3932a4e2deead01a96dd51a0b3676f55ea80f6 [7/11] lib/vsprintf: Add support for generic FOURCCs by extending %p4cc
config: arc-randconfig-s032-20220130 (https://download.01.org/0day-ci/archive/20220205/202202052230.9Ehn5qnV-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/AsahiLinux/linux/commit/0e3932a4e2deead01a96dd51a0b3676f55ea80f6
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux smc/work
        git checkout 0e3932a4e2deead01a96dd51a0b3676f55ea80f6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> lib/vsprintf.c:1783:30: sparse: sparse: cast to restricted __le32
>> lib/vsprintf.c:1783:30: sparse: sparse: cast to restricted __le32
>> lib/vsprintf.c:1783:30: sparse: sparse: cast to restricted __le32
>> lib/vsprintf.c:1783:30: sparse: sparse: cast to restricted __le32
>> lib/vsprintf.c:1783:30: sparse: sparse: cast to restricted __le32
>> lib/vsprintf.c:1783:30: sparse: sparse: cast to restricted __le32
>> lib/vsprintf.c:1786:30: sparse: sparse: cast to restricted __be32

vim +1783 lib/vsprintf.c

  1757	
  1758	static noinline_for_stack
  1759	char *fourcc_string(char *buf, char *end, const u32 *fourcc,
  1760			    struct printf_spec spec, const char *fmt)
  1761	{
  1762		char output[sizeof("0123 little-endian (0x01234567)")];
  1763		char *p = output;
  1764		unsigned int i;
  1765		bool pix_fmt = false;
  1766		u32 val = *fourcc;
  1767		u32 cval = *fourcc;
  1768	
  1769		if (fmt[1] != 'c')
  1770			return error_string(buf, end, "(%p4?)", spec);
  1771	
  1772		if (check_pointer(&buf, end, fourcc, spec))
  1773			return buf;
  1774	
  1775		switch (fmt[2]) {
  1776		case 'h':
  1777			cval = val = *fourcc;
  1778			break;
  1779		case 'r':
  1780			cval = val = swab32(*fourcc);
  1781			break;
  1782		case 'l':
> 1783			cval = val = le32_to_cpu(*fourcc);
  1784			break;
  1785		case 'b':
> 1786			cval = val = be32_to_cpu(*fourcc);
  1787			break;
  1788		case 'c':
  1789			val = *fourcc & ~BIT(31);
  1790			/* Pixel formats are printed LSB-first */
  1791			cval = swab32(val);
  1792			pix_fmt = true;
  1793			break;
  1794		default:
  1795			return error_string(buf, end, "(%p4?)", spec);
  1796		}
  1797	
  1798		for (i = 0; i < sizeof(*fourcc); i++) {
  1799			unsigned char c = cval >> ((3 - i) * 8);
  1800	
  1801			/* Print non-control ASCII characters as-is, dot otherwise */
  1802			*p++ = isascii(c) && isprint(c) ? c : '.';
  1803		}
  1804	
  1805		if (pix_fmt) {
  1806			strcpy(p, *fourcc & BIT(31) ? " big-endian" : " little-endian");
  1807			p += strlen(p);
  1808		}
  1809	
  1810		*p++ = ' ';
  1811		*p++ = '(';
  1812		p = special_hex_number(p, output + sizeof(output) - 2, val, sizeof(u32));
  1813		*p++ = ')';
  1814		*p = '\0';
  1815	
  1816		return string(buf, end, output, spec);
  1817	}
  1818	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
