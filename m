Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411B75335A3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 05:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240996AbiEYDPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 23:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240132AbiEYDPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 23:15:07 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7654860D8E
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 20:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653448506; x=1684984506;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=k3FEYNB3FfU3vWZKvcZzscscvbXkF3GF8XTPhBKUTJw=;
  b=W9VKoR5/hgIWtqCCX9PA0q3FQqpSP0UmkHd3KcqGOsKyl+m2NAll3e6K
   cE8XAsfPW5UDjnvZu2Nl4QSs4sdj47D1eH9HgC9QjdjGh9jRoGmrWPgo0
   j5wRtHj/RW7jhJ8vDPXpXp12KK6mhVURytYFsiTquY0euY8e0as0pTt+0
   uOlIsxJBeksLU1d3Ua+KZ+jyBwHDApws2ZPWGwtQTcS89uXpMxIT5+xlF
   oGp/fS1ihub4ualo/SojH4DrdggqDpvp2hCIEJabXP7CM+AaKg256dQks
   PILglkKFBFAx2L46D8+28sJt3/8xL6x7aiy7FSI9IB7zcRDCVxqr6WGcf
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="272522245"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="272522245"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 20:15:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="703726171"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 24 May 2022 20:15:04 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nthUF-0002fu-T0;
        Wed, 25 May 2022 03:15:03 +0000
Date:   Wed, 25 May 2022 11:14:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/110-smc 1/15] lib/vsprintf.c:1802:30: sparse:
 sparse: cast to restricted __le32
Message-ID: <202205251129.tq3cLPZW-lkp@intel.com>
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

tree:   https://github.com/AsahiLinux/linux bits/110-smc
head:   0a0b49938a3205cb2b05078117b87673c37ed319
commit: c176ff25243d5b90752858715fa622f4c78f1cb2 [1/15] lib/vsprintf: Add support for generic FOURCCs by extending %p4cc
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220525/202205251129.tq3cLPZW-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-14-g5a0004b5-dirty
        # https://github.com/AsahiLinux/linux/commit/c176ff25243d5b90752858715fa622f4c78f1cb2
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/110-smc
        git checkout c176ff25243d5b90752858715fa622f4c78f1cb2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> lib/vsprintf.c:1802:30: sparse: sparse: cast to restricted __le32
>> lib/vsprintf.c:1805:30: sparse: sparse: cast to restricted __be32

vim +1802 lib/vsprintf.c

  1776	
  1777	static noinline_for_stack
  1778	char *fourcc_string(char *buf, char *end, const u32 *fourcc,
  1779			    struct printf_spec spec, const char *fmt)
  1780	{
  1781		char output[sizeof("0123 little-endian (0x01234567)")];
  1782		char *p = output;
  1783		unsigned int i;
  1784		bool pix_fmt = false;
  1785		u32 orig, val;
  1786	
  1787		if (fmt[1] != 'c')
  1788			return error_string(buf, end, "(%p4?)", spec);
  1789	
  1790		if (check_pointer(&buf, end, fourcc, spec))
  1791			return buf;
  1792	
  1793		orig = get_unaligned(fourcc);
  1794		switch (fmt[2]) {
  1795		case 'h':
  1796			val = orig;
  1797			break;
  1798		case 'r':
  1799			val = orig = swab32(orig);
  1800			break;
  1801		case 'l':
> 1802			val = orig = le32_to_cpu(orig);
  1803			break;
  1804		case 'b':
> 1805			val = orig = be32_to_cpu(orig);
  1806			break;
  1807		case 'c':
  1808			/* Pixel formats are printed LSB-first */
  1809			val = swab32(orig & ~BIT(31));
  1810			pix_fmt = true;
  1811			break;
  1812		default:
  1813			return error_string(buf, end, "(%p4?)", spec);
  1814		}
  1815	
  1816		for (i = 0; i < sizeof(u32); i++) {
  1817			unsigned char c = val >> ((3 - i) * 8);
  1818	
  1819			/* Print non-control ASCII characters as-is, dot otherwise */
  1820			*p++ = isascii(c) && isprint(c) ? c : '.';
  1821		}
  1822	
  1823		if (pix_fmt) {
  1824			*p++ = ' ';
  1825			strcpy(p, orig & BIT(31) ? "big-endian" : "little-endian");
  1826			p += strlen(p);
  1827		}
  1828	
  1829		*p++ = ' ';
  1830		*p++ = '(';
  1831		p = special_hex_number(p, output + sizeof(output) - 2, orig, sizeof(u32));
  1832		*p++ = ')';
  1833		*p = '\0';
  1834	
  1835		return string(buf, end, output, spec);
  1836	}
  1837	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
