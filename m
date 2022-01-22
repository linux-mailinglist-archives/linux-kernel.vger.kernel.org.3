Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B66F496B15
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 09:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbiAVIna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 03:43:30 -0500
Received: from mga07.intel.com ([134.134.136.100]:8135 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233568AbiAVIn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 03:43:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642841009; x=1674377009;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ha1x4IBwH8NNgU5EYpJkbx23jYd+R3OMmHVKQetOyQE=;
  b=MXnxgK+lmmfWO4XoBMc248IgaV35BZubUbz88GihUbp9eCCOiR8qx1uR
   aEPPHixnP9Uhw18YHx4W6H+UKXF0BNFUgqp9mUluHNhobpD4OcDbab/Rw
   DY8xIDFGufcluY9XkISIaKNV/urCi/5znxqOD8pv+KcAreRtKHaBebz1H
   v3XFVHhbWYhehThtGn0UhQ99wFssZXTnupATuEoKC1Mq/0MDBdgK0kBwC
   JFaektflChMAbY3HRD01xkkKacgGnKDi2JGN8/J1ld9L5KbFYyGlE7YjW
   EyxYlAaE+ul2U49aXosTYOWPhv1LqrmeDx2HMdLeklHpjJdu98xKYe9kQ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="309132749"
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="309132749"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2022 00:43:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,307,1635231600"; 
   d="scan'208";a="616759985"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jan 2022 00:43:27 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nBBza-000GDl-St; Sat, 22 Jan 2022 08:43:26 +0000
Date:   Sat, 22 Jan 2022 16:42:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander K <ak@tempesta-tech.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Subject: [cel:topic-rpc-with-tls 9991/9999]
 arch/x86/crypto/sha1_ssse3_glue.c:105:6: error: implicit declaration of
 function 'boot_cpu_has'
Message-ID: <202201221614.YmhmBHxe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

First bad commit (maybe != root cause):

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux topic-rpc-with-tls
head:   a72d5318846d67a7f3f5f2bcb4c0c09c4f8907d1
commit: a0a99a10f4f0e3e1e35e566687137669da78abcd [9991/9999] Port of Tempesta TLS handshakes to the Linux 5.10.68
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20220122/202201221614.YmhmBHxe-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=a0a99a10f4f0e3e1e35e566687137669da78abcd
        git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
        git fetch --no-tags cel topic-rpc-with-tls
        git checkout a0a99a10f4f0e3e1e35e566687137669da78abcd
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   cc1: warning: arch/um/include/uapi: No such file or directory [-Wmissing-include-dirs]
   arch/x86/crypto/sha1_ssse3_glue.c: In function 'register_sha1_ssse3':
>> arch/x86/crypto/sha1_ssse3_glue.c:105:6: error: implicit declaration of function 'boot_cpu_has' [-Werror=implicit-function-declaration]
     105 |  if (boot_cpu_has(X86_FEATURE_SSSE3))
         |      ^~~~~~~~~~~~
   arch/x86/crypto/sha1_ssse3_glue.c: In function 'avx_usable':
>> arch/x86/crypto/sha1_ssse3_glue.c:154:25: error: 'XFEATURE_MASK_SSE' undeclared (first use in this function)
     154 |  if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL)) {
         |                         ^~~~~~~~~~~~~~~~~
   arch/x86/crypto/sha1_ssse3_glue.c:154:25: note: each undeclared identifier is reported only once for each function it appears in
>> arch/x86/crypto/sha1_ssse3_glue.c:154:45: error: 'XFEATURE_MASK_YMM' undeclared (first use in this function)
     154 |  if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL)) {
         |                                             ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MFD_CORE
   Depends on HAS_IOMEM
   Selected by
   - MFD_HI6421_SPMI && STAGING && OF && SPMI
   WARNING: unmet direct dependencies detected for CRYPTO_SHA1_SSSE3
   Depends on CRYPTO && X86 && 64BIT
   Selected by
   - TLS_HANDSHAKE && NET && TLS


vim +/boot_cpu_has +105 arch/x86/crypto/sha1_ssse3_glue.c

66be895158886a Mathias Krause  2011-08-04  102  
85c66ecd6f2144 tim             2015-09-16  103  static int register_sha1_ssse3(void)
85c66ecd6f2144 tim             2015-09-16  104  {
85c66ecd6f2144 tim             2015-09-16 @105  	if (boot_cpu_has(X86_FEATURE_SSSE3))
85c66ecd6f2144 tim             2015-09-16  106  		return crypto_register_shash(&sha1_ssse3_alg);
85c66ecd6f2144 tim             2015-09-16  107  	return 0;
85c66ecd6f2144 tim             2015-09-16  108  }
85c66ecd6f2144 tim             2015-09-16  109  
85c66ecd6f2144 tim             2015-09-16  110  static void unregister_sha1_ssse3(void)
85c66ecd6f2144 tim             2015-09-16  111  {
85c66ecd6f2144 tim             2015-09-16  112  	if (boot_cpu_has(X86_FEATURE_SSSE3))
85c66ecd6f2144 tim             2015-09-16  113  		crypto_unregister_shash(&sha1_ssse3_alg);
85c66ecd6f2144 tim             2015-09-16  114  }
85c66ecd6f2144 tim             2015-09-16  115  
41419a28901083 Kees Cook       2020-01-14  116  asmlinkage void sha1_transform_avx(struct sha1_state *state,
41419a28901083 Kees Cook       2020-01-14  117  				   const u8 *data, int blocks);
85c66ecd6f2144 tim             2015-09-16  118  
85c66ecd6f2144 tim             2015-09-16  119  static int sha1_avx_update(struct shash_desc *desc, const u8 *data,
85c66ecd6f2144 tim             2015-09-16  120  			     unsigned int len)
85c66ecd6f2144 tim             2015-09-16  121  {
41419a28901083 Kees Cook       2020-01-14  122  	return sha1_update(desc, data, len, sha1_transform_avx);
85c66ecd6f2144 tim             2015-09-16  123  }
85c66ecd6f2144 tim             2015-09-16  124  
85c66ecd6f2144 tim             2015-09-16  125  static int sha1_avx_finup(struct shash_desc *desc, const u8 *data,
85c66ecd6f2144 tim             2015-09-16  126  			      unsigned int len, u8 *out)
85c66ecd6f2144 tim             2015-09-16  127  {
41419a28901083 Kees Cook       2020-01-14  128  	return sha1_finup(desc, data, len, out, sha1_transform_avx);
85c66ecd6f2144 tim             2015-09-16  129  }
85c66ecd6f2144 tim             2015-09-16  130  
85c66ecd6f2144 tim             2015-09-16  131  static int sha1_avx_final(struct shash_desc *desc, u8 *out)
85c66ecd6f2144 tim             2015-09-16  132  {
85c66ecd6f2144 tim             2015-09-16  133  	return sha1_avx_finup(desc, NULL, 0, out);
85c66ecd6f2144 tim             2015-09-16  134  }
85c66ecd6f2144 tim             2015-09-16  135  
85c66ecd6f2144 tim             2015-09-16  136  static struct shash_alg sha1_avx_alg = {
85c66ecd6f2144 tim             2015-09-16  137  	.digestsize	=	SHA1_DIGEST_SIZE,
85c66ecd6f2144 tim             2015-09-16  138  	.init		=	sha1_base_init,
85c66ecd6f2144 tim             2015-09-16  139  	.update		=	sha1_avx_update,
85c66ecd6f2144 tim             2015-09-16  140  	.final		=	sha1_avx_final,
85c66ecd6f2144 tim             2015-09-16  141  	.finup		=	sha1_avx_finup,
85c66ecd6f2144 tim             2015-09-16  142  	.descsize	=	sizeof(struct sha1_state),
85c66ecd6f2144 tim             2015-09-16  143  	.base		=	{
85c66ecd6f2144 tim             2015-09-16  144  		.cra_name	=	"sha1",
85c66ecd6f2144 tim             2015-09-16  145  		.cra_driver_name =	"sha1-avx",
85c66ecd6f2144 tim             2015-09-16  146  		.cra_priority	=	160,
85c66ecd6f2144 tim             2015-09-16  147  		.cra_blocksize	=	SHA1_BLOCK_SIZE,
85c66ecd6f2144 tim             2015-09-16  148  		.cra_module	=	THIS_MODULE,
85c66ecd6f2144 tim             2015-09-16  149  	}
85c66ecd6f2144 tim             2015-09-16  150  };
85c66ecd6f2144 tim             2015-09-16  151  
85c66ecd6f2144 tim             2015-09-16  152  static bool avx_usable(void)
66be895158886a Mathias Krause  2011-08-04  153  {
d91cab78133d33 Dave Hansen     2015-09-02 @154  	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM, NULL)) {
da154e82af4d0c Borislav Petkov 2016-04-04  155  		if (boot_cpu_has(X86_FEATURE_AVX))
66be895158886a Mathias Krause  2011-08-04  156  			pr_info("AVX detected but unusable.\n");
66be895158886a Mathias Krause  2011-08-04  157  		return false;
66be895158886a Mathias Krause  2011-08-04  158  	}
66be895158886a Mathias Krause  2011-08-04  159  
66be895158886a Mathias Krause  2011-08-04  160  	return true;
66be895158886a Mathias Krause  2011-08-04  161  }
6ca5afb8c26991 Mathias Krause  2014-03-24  162  

:::::: The code at line 105 was first introduced by commit
:::::: 85c66ecd6f2144c075044292359e179b20af1f2d crypto: x86/sha - Restructure x86 sha1 glue code to expose all the available sha1 transforms

:::::: TO: tim <tim.c.chen@linux.intel.com>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
