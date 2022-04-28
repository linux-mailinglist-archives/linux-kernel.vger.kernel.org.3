Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E59151398D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349661AbiD1QUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236350AbiD1QUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:20:43 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB1C3EBBF
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651162648; x=1682698648;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vebxYnf7INN7pEbjK0bBU6XAyt/+YjQwfCwAbd8efsM=;
  b=heBeRSQfUtVJE85u9YUPygzLO2577DZI9pMC24wLDdNtk/lSMZX4JhA6
   TlPS+S7DltRtv3JZaTCB7ZUYyoQiqAMffdhe9V/MdzOHhj8+oKDgy+qr0
   FawabNudcbzRr0eqGWNPM8NFE3AVT9+rrxThHRkfL1AKIsT2dub9MmyUv
   G7z+5XaO2lmhrms2o9bpzddi/z3Pt75s4O1+og01G0PXLZBz54sPCoZEu
   6b2gJCiprrh21fD767EDMSwsN0WORde/xaEcZBzIn7E9i49hN83B2kYqv
   FNTkhFVSUy1jcr5i4fF1PSwWiu0y/HPiPXNhHubCLrV0efkrAn7wAZZj2
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="246896011"
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="246896011"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 09:15:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="541450892"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 28 Apr 2022 09:15:45 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nk6nw-0005WH-Th;
        Thu, 28 Apr 2022 16:15:44 +0000
Date:   Fri, 29 Apr 2022 00:15:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:pr/22 95/189] lib/vsprintf.c:1804:30: sparse: sparse:
 cast to restricted __le32
Message-ID: <202204290013.olXBPppO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux pr/22
head:   7ee315306d1a3b0da8cf2a53e7f55889d0e7f034
commit: 87176f64712bb42092a6c89189f8b788f36eb70b [95/189] lib/vsprintf: Add support for generic FOURCCs by extending %p4cc
config: powerpc-randconfig-s031-20220427 (https://download.01.org/0day-ci/archive/20220429/202204290013.olXBPppO-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/AsahiLinux/linux/commit/87176f64712bb42092a6c89189f8b788f36eb70b
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux pr/22
        git checkout 87176f64712bb42092a6c89189f8b788f36eb70b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> lib/vsprintf.c:1804:30: sparse: sparse: cast to restricted __le32
>> lib/vsprintf.c:1807:30: sparse: sparse: cast to restricted __be32

vim +1804 lib/vsprintf.c

  1778	
  1779	static noinline_for_stack
  1780	char *fourcc_string(char *buf, char *end, const u32 *fourcc,
  1781			    struct printf_spec spec, const char *fmt)
  1782	{
  1783		char output[sizeof("0123 little-endian (0x01234567)")];
  1784		char *p = output;
  1785		unsigned int i;
  1786		bool pix_fmt = false;
  1787		u32 orig, val;
  1788	
  1789		if (fmt[1] != 'c')
  1790			return error_string(buf, end, "(%p4?)", spec);
  1791	
  1792		if (check_pointer(&buf, end, fourcc, spec))
  1793			return buf;
  1794	
  1795		orig = get_unaligned(fourcc);
  1796		switch (fmt[2]) {
  1797		case 'h':
  1798			val = orig;
  1799			break;
  1800		case 'r':
  1801			val = orig = swab32(orig);
  1802			break;
  1803		case 'l':
> 1804			val = orig = le32_to_cpu(orig);
  1805			break;
  1806		case 'b':
> 1807			val = orig = be32_to_cpu(orig);
  1808			break;
  1809		case 'c':
  1810			/* Pixel formats are printed LSB-first */
  1811			val = swab32(orig & ~BIT(31));
  1812			pix_fmt = true;
  1813			break;
  1814		default:
  1815			return error_string(buf, end, "(%p4?)", spec);
  1816		}
  1817	
  1818		for (i = 0; i < sizeof(u32); i++) {
  1819			unsigned char c = val >> ((3 - i) * 8);
  1820	
  1821			/* Print non-control ASCII characters as-is, dot otherwise */
  1822			*p++ = isascii(c) && isprint(c) ? c : '.';
  1823		}
  1824	
  1825		if (pix_fmt) {
  1826			*p++ = ' ';
  1827			strcpy(p, orig & BIT(31) ? "big-endian" : "little-endian");
  1828			p += strlen(p);
  1829		}
  1830	
  1831		*p++ = ' ';
  1832		*p++ = '(';
  1833		p = special_hex_number(p, output + sizeof(output) - 2, orig, sizeof(u32));
  1834		*p++ = ')';
  1835		*p = '\0';
  1836	
  1837		return string(buf, end, output, spec);
  1838	}
  1839	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
