Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698044F747A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 06:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbiDGEUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 00:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbiDGEUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 00:20:18 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CE51DCCE3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 21:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649305100; x=1680841100;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JXIpZEtfZ3ETGsxQKbEC4iar4KhsaX1UU6lyiYC+0ik=;
  b=XN91x4OscOxj4VQlvmvwqPGJPMm9Sf/KOSO4KIghd5N+MWiz8ap/dbNW
   opVdIag8ilYbs4944j3PoPBBKIdtoaYka3mJsiJCW9X6+khrqj2STOItx
   Pj4HR4Yup+Qc4rdHDpsMVHiRgdxn3QNgF4SUscBJAQ+LXij2nAc7/hprn
   ZF71OsngytS0zD2Fv4qleJCwmB0kj+iUzvqGzNaSYMz6og+XngXTXp/Gr
   Cz0ajaSMUG5HYTqmitiDRFxnL02onqa8K/e6ko3AjeKbY1mMyFL2AWWqH
   GR92BSCIt+48podeF6DTvZFEFuR1PaFuiJrnBmUT7JvYnqWpq/vXmv7qh
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="260061389"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="260061389"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 21:18:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="505997205"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 06 Apr 2022 21:18:17 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncJb7-00053n-7l;
        Thu, 07 Apr 2022 04:18:17 +0000
Date:   Thu, 7 Apr 2022 12:17:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     kbuild-all@lists.01.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, David Teigland <teigland@redhat.com>
Subject: [teigland-dlm:next 13/23]
 include/uapi/linux/byteorder/little_endian.h:32:43: warning: cast from
 pointer to integer of different size
Message-ID: <202204071256.lLGswbZA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git next
head:   dc1acd5c94699389a9ed023e94dd860c846ea1f6
commit: 2f9dbeda8dc04b5b754e032000adf6bab03aa9be [13/23] dlm: use __le types for rcom messages
config: microblaze-randconfig-r024-20220406 (https://download.01.org/0day-ci/archive/20220407/202204071256.lLGswbZA-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git/commit/?id=2f9dbeda8dc04b5b754e032000adf6bab03aa9be
        git remote add teigland-dlm https://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git
        git fetch --no-tags teigland-dlm next
        git checkout 2f9dbeda8dc04b5b754e032000adf6bab03aa9be
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash fs/dlm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/byteorder/little_endian.h:5,
                    from arch/microblaze/include/uapi/asm/byteorder.h:6,
                    from include/asm-generic/bitops/le.h:6,
                    from include/asm-generic/bitops.h:35,
                    from ./arch/microblaze/include/generated/asm/bitops.h:1,
                    from include/linux/bitops.h:33,
                    from include/linux/log2.h:12,
                    from include/asm-generic/div64.h:55,
                    from ./arch/microblaze/include/generated/asm/div64.h:1,
                    from include/linux/math.h:6,
                    from include/linux/math64.h:6,
                    from include/linux/time64.h:5,
                    from include/linux/restart_block.h:10,
                    from include/linux/thread_info.h:14,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/microblaze/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from fs/dlm/dlm_internal.h:19,
                    from fs/dlm/rcom.c:12:
   fs/dlm/rcom.c: In function 'dlm_send_rcom_lock':
>> include/uapi/linux/byteorder/little_endian.h:32:43: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      32 | #define __cpu_to_le64(x) ((__force __le64)(__u64)(x))
         |                                           ^
   include/linux/byteorder/generic.h:86:21: note: in expansion of macro '__cpu_to_le64'
      86 | #define cpu_to_le64 __cpu_to_le64
         |                     ^~~~~~~~~~~~~
   fs/dlm/rcom.c:457:21: note: in expansion of macro 'cpu_to_le64'
     457 |         rc->rc_id = cpu_to_le64(r);
         |                     ^~~~~~~~~~~


vim +32 include/uapi/linux/byteorder/little_endian.h

5921e6f8809b16 David Howells 2012-10-13  15  
5921e6f8809b16 David Howells 2012-10-13  16  #define __constant_htonl(x) ((__force __be32)___constant_swab32((x)))
5921e6f8809b16 David Howells 2012-10-13  17  #define __constant_ntohl(x) ___constant_swab32((__force __be32)(x))
5921e6f8809b16 David Howells 2012-10-13  18  #define __constant_htons(x) ((__force __be16)___constant_swab16((x)))
5921e6f8809b16 David Howells 2012-10-13  19  #define __constant_ntohs(x) ___constant_swab16((__force __be16)(x))
5921e6f8809b16 David Howells 2012-10-13  20  #define __constant_cpu_to_le64(x) ((__force __le64)(__u64)(x))
5921e6f8809b16 David Howells 2012-10-13  21  #define __constant_le64_to_cpu(x) ((__force __u64)(__le64)(x))
5921e6f8809b16 David Howells 2012-10-13  22  #define __constant_cpu_to_le32(x) ((__force __le32)(__u32)(x))
5921e6f8809b16 David Howells 2012-10-13  23  #define __constant_le32_to_cpu(x) ((__force __u32)(__le32)(x))
5921e6f8809b16 David Howells 2012-10-13  24  #define __constant_cpu_to_le16(x) ((__force __le16)(__u16)(x))
5921e6f8809b16 David Howells 2012-10-13  25  #define __constant_le16_to_cpu(x) ((__force __u16)(__le16)(x))
5921e6f8809b16 David Howells 2012-10-13  26  #define __constant_cpu_to_be64(x) ((__force __be64)___constant_swab64((x)))
5921e6f8809b16 David Howells 2012-10-13  27  #define __constant_be64_to_cpu(x) ___constant_swab64((__force __u64)(__be64)(x))
5921e6f8809b16 David Howells 2012-10-13  28  #define __constant_cpu_to_be32(x) ((__force __be32)___constant_swab32((x)))
5921e6f8809b16 David Howells 2012-10-13  29  #define __constant_be32_to_cpu(x) ___constant_swab32((__force __u32)(__be32)(x))
5921e6f8809b16 David Howells 2012-10-13  30  #define __constant_cpu_to_be16(x) ((__force __be16)___constant_swab16((x)))
5921e6f8809b16 David Howells 2012-10-13  31  #define __constant_be16_to_cpu(x) ___constant_swab16((__force __u16)(__be16)(x))
5921e6f8809b16 David Howells 2012-10-13 @32  #define __cpu_to_le64(x) ((__force __le64)(__u64)(x))
5921e6f8809b16 David Howells 2012-10-13  33  #define __le64_to_cpu(x) ((__force __u64)(__le64)(x))
5921e6f8809b16 David Howells 2012-10-13  34  #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
5921e6f8809b16 David Howells 2012-10-13  35  #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
5921e6f8809b16 David Howells 2012-10-13  36  #define __cpu_to_le16(x) ((__force __le16)(__u16)(x))
5921e6f8809b16 David Howells 2012-10-13  37  #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
5921e6f8809b16 David Howells 2012-10-13  38  #define __cpu_to_be64(x) ((__force __be64)__swab64((x)))
5921e6f8809b16 David Howells 2012-10-13  39  #define __be64_to_cpu(x) __swab64((__force __u64)(__be64)(x))
5921e6f8809b16 David Howells 2012-10-13  40  #define __cpu_to_be32(x) ((__force __be32)__swab32((x)))
5921e6f8809b16 David Howells 2012-10-13  41  #define __be32_to_cpu(x) __swab32((__force __u32)(__be32)(x))
5921e6f8809b16 David Howells 2012-10-13  42  #define __cpu_to_be16(x) ((__force __be16)__swab16((x)))
5921e6f8809b16 David Howells 2012-10-13  43  #define __be16_to_cpu(x) __swab16((__force __u16)(__be16)(x))
5921e6f8809b16 David Howells 2012-10-13  44  

:::::: The code at line 32 was first introduced by commit
:::::: 5921e6f8809b1616932ca4afd40fe449faa8fd88 UAPI: (Scripted) Disintegrate include/linux/byteorder

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: David Howells <dhowells@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
