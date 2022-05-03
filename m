Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B24E5184E0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 15:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235736AbiECNGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 09:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235690AbiECNGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 09:06:18 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76846CF2;
        Tue,  3 May 2022 06:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651582966; x=1683118966;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UCyDlB85rkoavp7KoFgYBF745HbRXl8o/+z3W4OKNAg=;
  b=kFqjZ8clsZrZ/4DCdmKmUR2IGDA6x1HIRJZmIzrDev1YzyIlMetknidf
   500+cBbDDsdDrD0BeF7PDowAQoGKY5tDwNDbC26XQtqGdEmWsPbdlpPwX
   4WMkQj1Hn4p4VFbcT0ycWIDzKjfu6EKAN1A/L44rajISw4+9oG6J9La8x
   oDZdKhVq2ohXcswx+WgMqoe5QNiSkt7yxNihyv8beOH8SnSUekhMa+96n
   jgi4Vt9M4B727KbJsqWbWx0kljItb/lzJRtPH5JoMtwX+MX+yxoNIPsy4
   BbB7xVHPzM63mkaqCVjhe1HN6TdjIq52JxEPv9a7uoURsDDrY3bnjNoNY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="254933666"
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="254933666"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 06:02:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="663966482"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 03 May 2022 06:02:43 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlsAs-000ATj-C9;
        Tue, 03 May 2022 13:02:42 +0000
Date:   Tue, 3 May 2022 21:01:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Masahiro Yamada <masahiroy@kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        Breno =?iso-8859-1?Q?Leit=E3o?= <leitao@debian.org>,
        Paulo Flabiano Smorigo <pfsmorigo@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] crypto: vmx - Align the short log with Makefile cleanups
Message-ID: <202205032046.GVMtYY1b-lkp@intel.com>
References: <20220501130749.1123387-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220501130749.1123387-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

I love your patch! Yet something to improve:

[auto build test ERROR on herbert-crypto-2.6/master]
[also build test ERROR on herbert-cryptodev-2.6/master powerpc/next v5.18-rc5 next-20220503]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Masahiro-Yamada/crypto-vmx-Align-the-short-log-with-Makefile-cleanups/20220501-211151
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git master
config: powerpc64-randconfig-c024-20220501 (https://download.01.org/0day-ci/archive/20220503/202205032046.GVMtYY1b-lkp@intel.com/config)
compiler: powerpc64le-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ee5bc3b577c98befd8dfe65bbcd877e2f246470d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Masahiro-Yamada/crypto-vmx-Align-the-short-log-with-Makefile-cleanups/20220501-211151
        git checkout ee5bc3b577c98befd8dfe65bbcd877e2f246470d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   /tmp/ccMTXCTj.s: Assembler messages:
>> /tmp/ccMTXCTj.s: Error: .size expression for aes_p8_set_encrypt_key does not evaluate to a constant
>> /tmp/ccMTXCTj.s: Error: .size expression for .aes_p8_set_encrypt_key does not evaluate to a constant
>> /tmp/ccMTXCTj.s: Error: .size expression for aes_p8_set_decrypt_key does not evaluate to a constant
>> /tmp/ccMTXCTj.s: Error: .size expression for .aes_p8_set_decrypt_key does not evaluate to a constant
>> /tmp/ccMTXCTj.s: Error: .size expression for aes_p8_encrypt does not evaluate to a constant
>> /tmp/ccMTXCTj.s: Error: .size expression for .aes_p8_encrypt does not evaluate to a constant
>> /tmp/ccMTXCTj.s: Error: .size expression for aes_p8_decrypt does not evaluate to a constant
>> /tmp/ccMTXCTj.s: Error: .size expression for .aes_p8_decrypt does not evaluate to a constant
>> /tmp/ccMTXCTj.s: Error: .size expression for aes_p8_cbc_encrypt does not evaluate to a constant
>> /tmp/ccMTXCTj.s: Error: .size expression for .aes_p8_cbc_encrypt does not evaluate to a constant
>> /tmp/ccMTXCTj.s: Error: .size expression for aes_p8_ctr32_encrypt_blocks does not evaluate to a constant
>> /tmp/ccMTXCTj.s: Error: .size expression for .aes_p8_ctr32_encrypt_blocks does not evaluate to a constant
>> /tmp/ccMTXCTj.s: Error: .size expression for aes_p8_xts_encrypt does not evaluate to a constant
>> /tmp/ccMTXCTj.s: Error: .size expression for .aes_p8_xts_encrypt does not evaluate to a constant
>> /tmp/ccMTXCTj.s: Error: .size expression for aes_p8_xts_decrypt does not evaluate to a constant
>> /tmp/ccMTXCTj.s: Error: .size expression for .aes_p8_xts_decrypt does not evaluate to a constant
--
   /tmp/cci7g2fQ.s: Assembler messages:
>> /tmp/cci7g2fQ.s: Error: .size expression for gcm_init_p8 does not evaluate to a constant
>> /tmp/cci7g2fQ.s: Error: .size expression for .gcm_init_p8 does not evaluate to a constant
>> /tmp/cci7g2fQ.s: Error: .size expression for gcm_gmult_p8 does not evaluate to a constant
>> /tmp/cci7g2fQ.s: Error: .size expression for .gcm_gmult_p8 does not evaluate to a constant
>> /tmp/cci7g2fQ.s: Error: .size expression for gcm_ghash_p8 does not evaluate to a constant
>> /tmp/cci7g2fQ.s: Error: .size expression for .gcm_ghash_p8 does not evaluate to a constant

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
