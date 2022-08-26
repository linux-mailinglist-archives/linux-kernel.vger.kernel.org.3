Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EE35A2861
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 15:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344262AbiHZNRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 09:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344115AbiHZNRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 09:17:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36014CE49A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661519864; x=1693055864;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xFt+saYXe67DhydwBeTBOUbhbNkf0KyoQ2bPiDD8kE8=;
  b=edKykQDu8Qq+50SVDKJhjfxnJDNTVdbQBhYkGXpFoM5mr3B9yDBHKLHJ
   /WemNSdntDOK39kA0ky2iKukgfRwq+oahmz2t+xG44C1yxnbkZY31k7wD
   WMmUJ/R55LAfBgeTHDCInhPThpHTxnp9zXUo3WKWGX2oHUkm5W9w7Eo4w
   /6DTZ/s3Zt0TtvS8VPyh9McXEel9TXJniepnA2qsCzOQ7KY+g9pwdiSP1
   3VrPks9fb2egkOtoX3VXWncA847rjrYsqHocFcUxJVDKpRdT2dZ7wqWLc
   O74Pjaxo/DHyRgsBrbasuYHPHFhR51mT9xzKkGvClk7MJaO4NMWKppU8h
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="294507227"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="294507227"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 06:17:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="938750350"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 26 Aug 2022 06:17:42 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRZDR-00049a-2Y;
        Fri, 26 Aug 2022 13:17:41 +0000
Date:   Fri, 26 Aug 2022 21:17:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [alobakin:ip_tunnel 4/12] include/linux/bitmap.h:581:33: warning:
 excess elements in array initializer
Message-ID: <202208262141.rsfLmktB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/alobakin/linux ip_tunnel
head:   161f62c9d5cafdbc3216f026a7b7ca32d004b46b
commit: f5876d635ecb78e9ab3bcf7a73e0e08638524fc8 [4/12] netlink: add 'bitmap' attribute type (%NL_ATTR_TYPE_BITMAP / %NLA_BITMAP)
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220826/202208262141.rsfLmktB-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/alobakin/linux/commit/f5876d635ecb78e9ab3bcf7a73e0e08638524fc8
        git remote add alobakin https://github.com/alobakin/linux
        git fetch --no-tags alobakin ip_tunnel
        git checkout f5876d635ecb78e9ab3bcf7a73e0e08638524fc8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/net/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/ethtool.h:16,
                    from drivers/net/can/m_can/m_can.c:12:
   include/net/netlink.h: In function 'nla_put_bigint_s8':
>> include/linux/bitmap.h:581:33: warning: excess elements in array initializer
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1907:1: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1907 | NLA_BUILD_BIGINT_TYPE(s8);
         | ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitmap.h:581:33: note: (near initialization for 'bigint')
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1907:1: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1907 | NLA_BUILD_BIGINT_TYPE(s8);
         | ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h: In function 'nla_put_bigint_u8':
>> include/linux/bitmap.h:581:33: warning: excess elements in array initializer
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1908:1: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1908 | NLA_BUILD_BIGINT_TYPE(u8);
         | ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitmap.h:581:33: note: (near initialization for 'bigint')
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1908:1: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1908 | NLA_BUILD_BIGINT_TYPE(u8);
         | ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h: In function 'nla_put_bigint_s16':
>> include/linux/bitmap.h:581:33: warning: excess elements in array initializer
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1903:9: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1903 |         NLA_BUILD_BIGINT_TYPE(order##16);                                \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h:1910:1: note: in expansion of macro 'NLA_BUILD_BIGINT_ORDER'
    1910 | NLA_BUILD_BIGINT_ORDER(s);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitmap.h:581:33: note: (near initialization for 'bigint')
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1903:9: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1903 |         NLA_BUILD_BIGINT_TYPE(order##16);                                \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h:1910:1: note: in expansion of macro 'NLA_BUILD_BIGINT_ORDER'
    1910 | NLA_BUILD_BIGINT_ORDER(s);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h: In function 'nla_put_bigint_s32':
>> include/linux/bitmap.h:581:33: warning: excess elements in array initializer
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1904:9: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1904 |         NLA_BUILD_BIGINT_TYPE(order##32);                                \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h:1910:1: note: in expansion of macro 'NLA_BUILD_BIGINT_ORDER'
    1910 | NLA_BUILD_BIGINT_ORDER(s);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitmap.h:581:33: note: (near initialization for 'bigint')
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1904:9: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1904 |         NLA_BUILD_BIGINT_TYPE(order##32);                                \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h:1910:1: note: in expansion of macro 'NLA_BUILD_BIGINT_ORDER'
    1910 | NLA_BUILD_BIGINT_ORDER(s);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h: In function 'nla_put_bigint_u16':
>> include/linux/bitmap.h:581:33: warning: excess elements in array initializer
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1903:9: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1903 |         NLA_BUILD_BIGINT_TYPE(order##16);                                \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h:1911:1: note: in expansion of macro 'NLA_BUILD_BIGINT_ORDER'
    1911 | NLA_BUILD_BIGINT_ORDER(u);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitmap.h:581:33: note: (near initialization for 'bigint')
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1903:9: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1903 |         NLA_BUILD_BIGINT_TYPE(order##16);                                \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h:1911:1: note: in expansion of macro 'NLA_BUILD_BIGINT_ORDER'
    1911 | NLA_BUILD_BIGINT_ORDER(u);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h: In function 'nla_put_bigint_u32':
>> include/linux/bitmap.h:581:33: warning: excess elements in array initializer
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1904:9: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1904 |         NLA_BUILD_BIGINT_TYPE(order##32);                                \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h:1911:1: note: in expansion of macro 'NLA_BUILD_BIGINT_ORDER'
    1911 | NLA_BUILD_BIGINT_ORDER(u);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitmap.h:581:33: note: (near initialization for 'bigint')
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1904:9: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1904 |         NLA_BUILD_BIGINT_TYPE(order##32);                                \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h:1911:1: note: in expansion of macro 'NLA_BUILD_BIGINT_ORDER'
    1911 | NLA_BUILD_BIGINT_ORDER(u);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h: In function 'nla_put_bigint_be16':
>> include/linux/bitmap.h:581:33: warning: excess elements in array initializer
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1903:9: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1903 |         NLA_BUILD_BIGINT_TYPE(order##16);                                \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h:1912:1: note: in expansion of macro 'NLA_BUILD_BIGINT_ORDER'
    1912 | NLA_BUILD_BIGINT_ORDER(be);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitmap.h:581:33: note: (near initialization for 'bigint')
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1903:9: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1903 |         NLA_BUILD_BIGINT_TYPE(order##16);                                \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h:1912:1: note: in expansion of macro 'NLA_BUILD_BIGINT_ORDER'
    1912 | NLA_BUILD_BIGINT_ORDER(be);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h: In function 'nla_put_bigint_be32':
>> include/linux/bitmap.h:581:33: warning: excess elements in array initializer
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1904:9: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1904 |         NLA_BUILD_BIGINT_TYPE(order##32);                                \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h:1912:1: note: in expansion of macro 'NLA_BUILD_BIGINT_ORDER'
    1912 | NLA_BUILD_BIGINT_ORDER(be);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitmap.h:581:33: note: (near initialization for 'bigint')
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1904:9: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1904 |         NLA_BUILD_BIGINT_TYPE(order##32);                                \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h:1912:1: note: in expansion of macro 'NLA_BUILD_BIGINT_ORDER'
    1912 | NLA_BUILD_BIGINT_ORDER(be);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h: In function 'nla_put_bigint_le16':
>> include/linux/bitmap.h:581:33: warning: excess elements in array initializer
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1903:9: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1903 |         NLA_BUILD_BIGINT_TYPE(order##16);                                \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h:1913:1: note: in expansion of macro 'NLA_BUILD_BIGINT_ORDER'
    1913 | NLA_BUILD_BIGINT_ORDER(le);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitmap.h:581:33: note: (near initialization for 'bigint')
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1903:9: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1903 |         NLA_BUILD_BIGINT_TYPE(order##16);                                \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h:1913:1: note: in expansion of macro 'NLA_BUILD_BIGINT_ORDER'
    1913 | NLA_BUILD_BIGINT_ORDER(le);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h: In function 'nla_put_bigint_le32':
>> include/linux/bitmap.h:581:33: warning: excess elements in array initializer
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1904:9: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1904 |         NLA_BUILD_BIGINT_TYPE(order##32);                                \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h:1913:1: note: in expansion of macro 'NLA_BUILD_BIGINT_ORDER'
    1913 | NLA_BUILD_BIGINT_ORDER(le);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitmap.h:581:33: note: (near initialization for 'bigint')
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1904:9: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1904 |         NLA_BUILD_BIGINT_TYPE(order##32);                                \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h:1913:1: note: in expansion of macro 'NLA_BUILD_BIGINT_ORDER'
    1913 | NLA_BUILD_BIGINT_ORDER(le);
         | ^~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/cpumask.h:12,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/mutex.h:17,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from drivers/net/ethernet/apm/xgene-v2/main.h:13,
                    from drivers/net/ethernet/apm/xgene-v2/main.c:10:
   include/net/netlink.h: In function 'nla_put_bigint_s8':
>> include/linux/bitmap.h:581:33: warning: excess elements in array initializer
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1907:1: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1907 | NLA_BUILD_BIGINT_TYPE(s8);
         | ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitmap.h:581:33: note: (near initialization for 'bigint')
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1907:1: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1907 | NLA_BUILD_BIGINT_TYPE(s8);
         | ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h: In function 'nla_put_bigint_u8':
>> include/linux/bitmap.h:581:33: warning: excess elements in array initializer
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1908:1: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1908 | NLA_BUILD_BIGINT_TYPE(u8);
         | ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bitmap.h:581:33: note: (near initialization for 'bigint')
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1908:1: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1908 | NLA_BUILD_BIGINT_TYPE(u8);
         | ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h: In function 'nla_put_bigint_s16':
>> include/linux/bitmap.h:581:33: warning: excess elements in array initializer
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1903:9: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1903 |         NLA_BUILD_BIGINT_TYPE(order##16);                                \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h:1910:1: note: in expansion of macro 'NLA_BUILD_BIGINT_ORDER'
    1910 | NLA_BUILD_BIGINT_ORDER(s);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitmap.h:581:33: note: (near initialization for 'bigint')
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1903:9: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1903 |         NLA_BUILD_BIGINT_TYPE(order##16);                                \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h:1910:1: note: in expansion of macro 'NLA_BUILD_BIGINT_ORDER'
    1910 | NLA_BUILD_BIGINT_ORDER(s);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h: In function 'nla_put_bigint_s32':
>> include/linux/bitmap.h:581:33: warning: excess elements in array initializer
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1904:9: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1904 |         NLA_BUILD_BIGINT_TYPE(order##32);                                \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h:1910:1: note: in expansion of macro 'NLA_BUILD_BIGINT_ORDER'
    1910 | NLA_BUILD_BIGINT_ORDER(s);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitmap.h:581:33: note: (near initialization for 'bigint')
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1904:9: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1904 |         NLA_BUILD_BIGINT_TYPE(order##32);                                \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h:1910:1: note: in expansion of macro 'NLA_BUILD_BIGINT_ORDER'
    1910 | NLA_BUILD_BIGINT_ORDER(s);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h: In function 'nla_put_bigint_u16':
>> include/linux/bitmap.h:581:33: warning: excess elements in array initializer
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1903:9: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1903 |         NLA_BUILD_BIGINT_TYPE(order##16);                                \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h:1911:1: note: in expansion of macro 'NLA_BUILD_BIGINT_ORDER'
    1911 | NLA_BUILD_BIGINT_ORDER(u);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitmap.h:581:33: note: (near initialization for 'bigint')
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1903:9: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1903 |         NLA_BUILD_BIGINT_TYPE(order##16);                                \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h:1911:1: note: in expansion of macro 'NLA_BUILD_BIGINT_ORDER'
    1911 | NLA_BUILD_BIGINT_ORDER(u);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h: In function 'nla_put_bigint_u32':
>> include/linux/bitmap.h:581:33: warning: excess elements in array initializer
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1904:9: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1904 |         NLA_BUILD_BIGINT_TYPE(order##32);                                \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h:1911:1: note: in expansion of macro 'NLA_BUILD_BIGINT_ORDER'
    1911 | NLA_BUILD_BIGINT_ORDER(u);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitmap.h:581:33: note: (near initialization for 'bigint')
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1904:9: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1904 |         NLA_BUILD_BIGINT_TYPE(order##32);                                \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h:1911:1: note: in expansion of macro 'NLA_BUILD_BIGINT_ORDER'
    1911 | NLA_BUILD_BIGINT_ORDER(u);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h: In function 'nla_put_bigint_be16':
>> include/linux/bitmap.h:581:33: warning: excess elements in array initializer
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1903:9: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1903 |         NLA_BUILD_BIGINT_TYPE(order##16);                                \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h:1912:1: note: in expansion of macro 'NLA_BUILD_BIGINT_ORDER'
    1912 | NLA_BUILD_BIGINT_ORDER(be);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitmap.h:581:33: note: (near initialization for 'bigint')
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1903:9: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1903 |         NLA_BUILD_BIGINT_TYPE(order##16);                                \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h:1912:1: note: in expansion of macro 'NLA_BUILD_BIGINT_ORDER'
    1912 | NLA_BUILD_BIGINT_ORDER(be);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h: In function 'nla_put_bigint_be32':
>> include/linux/bitmap.h:581:33: warning: excess elements in array initializer
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1904:9: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1904 |         NLA_BUILD_BIGINT_TYPE(order##32);                                \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h:1912:1: note: in expansion of macro 'NLA_BUILD_BIGINT_ORDER'
    1912 | NLA_BUILD_BIGINT_ORDER(be);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitmap.h:581:33: note: (near initialization for 'bigint')
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1904:9: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1904 |         NLA_BUILD_BIGINT_TYPE(order##32);                                \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h:1912:1: note: in expansion of macro 'NLA_BUILD_BIGINT_ORDER'
    1912 | NLA_BUILD_BIGINT_ORDER(be);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h: In function 'nla_put_bigint_le16':
>> include/linux/bitmap.h:581:33: warning: excess elements in array initializer
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1903:9: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1903 |         NLA_BUILD_BIGINT_TYPE(order##16);                                \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h:1913:1: note: in expansion of macro 'NLA_BUILD_BIGINT_ORDER'
    1913 | NLA_BUILD_BIGINT_ORDER(le);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitmap.h:581:33: note: (near initialization for 'bigint')
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1903:9: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1903 |         NLA_BUILD_BIGINT_TYPE(order##16);                                \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h:1913:1: note: in expansion of macro 'NLA_BUILD_BIGINT_ORDER'
    1913 | NLA_BUILD_BIGINT_ORDER(le);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h: In function 'nla_put_bigint_le32':
>> include/linux/bitmap.h:581:33: warning: excess elements in array initializer
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1904:9: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1904 |         NLA_BUILD_BIGINT_TYPE(order##32);                                \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h:1913:1: note: in expansion of macro 'NLA_BUILD_BIGINT_ORDER'
    1913 | NLA_BUILD_BIGINT_ORDER(le);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitmap.h:581:33: note: (near initialization for 'bigint')
     581 |                                 ((unsigned long) ((u64)(n) >> 32))
         |                                 ^
   include/net/netlink.h:1869:17: note: in expansion of macro 'BITMAP_FROM_U64'
    1869 |                 BITMAP_FROM_U64((u64)value),                             \
         |                 ^~~~~~~~~~~~~~~
   include/net/netlink.h:1904:9: note: in expansion of macro 'NLA_BUILD_BIGINT_TYPE'
    1904 |         NLA_BUILD_BIGINT_TYPE(order##32);                                \
         |         ^~~~~~~~~~~~~~~~~~~~~
   include/net/netlink.h:1913:1: note: in expansion of macro 'NLA_BUILD_BIGINT_ORDER'
    1913 | NLA_BUILD_BIGINT_ORDER(le);
         | ^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/apm/xgene-v2/main.c: At top level:
   drivers/net/ethernet/apm/xgene-v2/main.c:727:36: warning: 'xge_acpi_match' defined but not used [-Wunused-const-variable=]
     727 | static const struct acpi_device_id xge_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~~


vim +581 include/linux/bitmap.h

e837dfde15a49c Dennis Zhou       2019-12-13  549  
404376af788a76 Randy Dunlap      2017-09-17  550  /**
60ef690018b262 Yury Norov        2017-09-08  551   * BITMAP_FROM_U64() - Represent u64 value in the format suitable for bitmap.
404376af788a76 Randy Dunlap      2017-09-17  552   * @n: u64 value
60ef690018b262 Yury Norov        2017-09-08  553   *
60ef690018b262 Yury Norov        2017-09-08  554   * Linux bitmaps are internally arrays of unsigned longs, i.e. 32-bit
60ef690018b262 Yury Norov        2017-09-08  555   * integers in 32-bit environment, and 64-bit integers in 64-bit one.
60ef690018b262 Yury Norov        2017-09-08  556   *
60ef690018b262 Yury Norov        2017-09-08  557   * There are four combinations of endianness and length of the word in linux
60ef690018b262 Yury Norov        2017-09-08  558   * ABIs: LE64, BE64, LE32 and BE32.
60ef690018b262 Yury Norov        2017-09-08  559   *
60ef690018b262 Yury Norov        2017-09-08  560   * On 64-bit kernels 64-bit LE and BE numbers are naturally ordered in
60ef690018b262 Yury Norov        2017-09-08  561   * bitmaps and therefore don't require any special handling.
60ef690018b262 Yury Norov        2017-09-08  562   *
60ef690018b262 Yury Norov        2017-09-08  563   * On 32-bit kernels 32-bit LE ABI orders lo word of 64-bit number in memory
60ef690018b262 Yury Norov        2017-09-08  564   * prior to hi, and 32-bit BE orders hi word prior to lo. The bitmap on the
60ef690018b262 Yury Norov        2017-09-08  565   * other hand is represented as an array of 32-bit words and the position of
60ef690018b262 Yury Norov        2017-09-08  566   * bit N may therefore be calculated as: word #(N/32) and bit #(N%32) in that
60ef690018b262 Yury Norov        2017-09-08  567   * word.  For example, bit #42 is located at 10th position of 2nd word.
60ef690018b262 Yury Norov        2017-09-08  568   * It matches 32-bit LE ABI, and we can simply let the compiler store 64-bit
60ef690018b262 Yury Norov        2017-09-08  569   * values in memory as it usually does. But for BE we need to swap hi and lo
60ef690018b262 Yury Norov        2017-09-08  570   * words manually.
60ef690018b262 Yury Norov        2017-09-08  571   *
60ef690018b262 Yury Norov        2017-09-08  572   * With all that, the macro BITMAP_FROM_U64() does explicit reordering of hi and
60ef690018b262 Yury Norov        2017-09-08  573   * lo parts of u64.  For LE32 it does nothing, and for BE environment it swaps
60ef690018b262 Yury Norov        2017-09-08  574   * hi and lo words, as is expected by bitmap.
60ef690018b262 Yury Norov        2017-09-08  575   */
60ef690018b262 Yury Norov        2017-09-08  576  #if __BITS_PER_LONG == 64
60ef690018b262 Yury Norov        2017-09-08  577  #define BITMAP_FROM_U64(n) (n)
7aa9a321144b6a Alexander Lobakin 2022-08-26  578  #define BITMAP_TO_U64(map) ((u64)(map)[0])
60ef690018b262 Yury Norov        2017-09-08  579  #else
60ef690018b262 Yury Norov        2017-09-08  580  #define BITMAP_FROM_U64(n) ((unsigned long) ((u64)(n) & ULONG_MAX)), \
60ef690018b262 Yury Norov        2017-09-08 @581  				((unsigned long) ((u64)(n) >> 32))
7aa9a321144b6a Alexander Lobakin 2022-08-26  582  #define BITMAP_TO_U64(map) (((u64)(map)[1] << 32) | (u64)(map)[0])
60ef690018b262 Yury Norov        2017-09-08  583  #endif
60ef690018b262 Yury Norov        2017-09-08  584  

:::::: The code at line 581 was first introduced by commit
:::::: 60ef690018b262ddcd0d51edf10e40710deb9c9f bitmap: introduce BITMAP_FROM_U64()

:::::: TO: Yury Norov <ynorov@caviumnetworks.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
