Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FFD547911
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 08:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbiFLGKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 02:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiFLGKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 02:10:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8025F67
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 23:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655014198; x=1686550198;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oLbiUOZopeInA8S4lQs0z237IvCpPOLzuGPfGifNygg=;
  b=U+wrytYUvBSG1T6B+LJnjvsBD0DD/jK1f+ap3QPM6RoY/8xCHPfCaz+G
   42oz9Stb+sDna9DA2sUEAdaHSmCd1NO9KfegbWOayqWi/aGVmb0LTldlp
   Ji2re7sVF3g+ZeCSeEA12A1l06j4SOT3Rg40uks01IUtSztPlPLTdxONA
   9oi4290w1UUgGsiFV5WdoeboajD5BMW5W2+G6RBAeU/ybAcuxerlDbxSF
   RIsRa+Tq9EIqzio5QK596V4GNGrxrZ102EvgLPxAnXt+gl21GuHg1oyQf
   QENyWyVWWKTTycm3YBSjg8itxcDZVlYMi6Ffp1F2ynM6F6L28ZDiABMkl
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="276770410"
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="276770410"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 23:09:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="639048125"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jun 2022 23:09:57 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0GnM-000Jef-Np;
        Sun, 12 Jun 2022 06:09:56 +0000
Date:   Sun, 12 Jun 2022 14:09:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bits/110-smc 1/15] lib/vsprintf.c:1802:30: sparse:
 sparse: cast to restricted __le32
Message-ID: <202206121446.ZweYouna-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
config: h8300-randconfig-s031-20220612 (https://download.01.org/0day-ci/archive/20220612/202206121446.ZweYouna-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-30-g92122700-dirty
        # https://github.com/AsahiLinux/linux/commit/c176ff25243d5b90752858715fa622f4c78f1cb2
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/110-smc
        git checkout c176ff25243d5b90752858715fa622f4c78f1cb2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=h8300 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> lib/vsprintf.c:1802:30: sparse: sparse: cast to restricted __le32
>> lib/vsprintf.c:1802:30: sparse: sparse: cast to restricted __le32
>> lib/vsprintf.c:1802:30: sparse: sparse: cast to restricted __le32
>> lib/vsprintf.c:1802:30: sparse: sparse: cast to restricted __le32
>> lib/vsprintf.c:1802:30: sparse: sparse: cast to restricted __le32
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
