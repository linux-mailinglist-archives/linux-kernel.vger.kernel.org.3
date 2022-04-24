Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6342550D612
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 02:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239955AbiDYACl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 20:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbiDYACj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 20:02:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7D711D20C
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 16:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650844776; x=1682380776;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=laDr2uiqyUAR4/gfAlZFHXLpyJAFwj7kFJ2/XHSb8vM=;
  b=R1nT/duDI2C45BotDhOTaX1YYionIUrnRpSNmUBTFVuk9JBvLuyEwxTw
   5sK512QvjBiavilchdRRhAKYJD9US/g+NtCPhe+M8vb8TTs/V/c2JHThF
   TxO+quHohxDcz3uIUuWz1dkPgB0zvfphQgZ8LfRmUJPofml8sjzMraXxD
   6TRlAJZ1dMg8QR0WjwYXLJKplOxJzzfl83JCHAKLSLKR00zLAkTXdRuVX
   Ejodkc7Pb4yALMunc+UXv7kCWFPL/4SOQEP61lIcSZAInEq09QdaJ1SLc
   DJ7SQIpOEW28Q9NJPoiWLUJ8xwUPDbxue6vuLzmV0RLhrQpU7V+pfe5tZ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="328031857"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="328031857"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 16:59:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="531841725"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 24 Apr 2022 16:59:33 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nim8a-0001yB-9U;
        Sun, 24 Apr 2022 23:59:32 +0000
Date:   Mon, 25 Apr 2022 07:59:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [esmil:visionfive 57/57] lib/string.c:622: warning: expecting
 prototype for memset(). Prototype was for __memset() instead
Message-ID: <202204250717.pDjra3UX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   a4609ecef3c07f3d2786a7f79992430e6bb72ad9
commit: a4609ecef3c07f3d2786a7f79992430e6bb72ad9 [57/57] lib/string: support CONFIG_KASAN=y
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220425/202204250717.pDjra3UX-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/esmil/linux/commit/a4609ecef3c07f3d2786a7f79992430e6bb72ad9
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout a4609ecef3c07f3d2786a7f79992430e6bb72ad9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> lib/string.c:622: warning: expecting prototype for memset(). Prototype was for __memset() instead
>> lib/string.c:712: warning: expecting prototype for memcpy(). Prototype was for __memcpy() instead
>> lib/string.c:736: warning: expecting prototype for memmove(). Prototype was for __memmove() instead


vim +622 lib/string.c

^1da177e4c3f41 Linus Torvalds       2005-04-16  611  
^1da177e4c3f41 Linus Torvalds       2005-04-16  612  #ifndef __HAVE_ARCH_MEMSET
^1da177e4c3f41 Linus Torvalds       2005-04-16  613  /**
^1da177e4c3f41 Linus Torvalds       2005-04-16  614   * memset - Fill a region of memory with the given value
^1da177e4c3f41 Linus Torvalds       2005-04-16  615   * @s: Pointer to the start of the area.
^1da177e4c3f41 Linus Torvalds       2005-04-16  616   * @c: The byte to fill the area with
^1da177e4c3f41 Linus Torvalds       2005-04-16  617   * @count: The size of the area.
^1da177e4c3f41 Linus Torvalds       2005-04-16  618   *
^1da177e4c3f41 Linus Torvalds       2005-04-16  619   * Do not use memset() to access IO space, use memset_io() instead.
^1da177e4c3f41 Linus Torvalds       2005-04-16  620   */
a4609ecef3c07f Emil Renner Berthing 2022-04-23  621  void *__memset(void *s, int c, size_t count)
^1da177e4c3f41 Linus Torvalds       2005-04-16 @622  {
850b9247926693 Jesper Juhl          2005-10-30  623  	char *xs = s;
^1da177e4c3f41 Linus Torvalds       2005-04-16  624  
^1da177e4c3f41 Linus Torvalds       2005-04-16  625  	while (count--)
^1da177e4c3f41 Linus Torvalds       2005-04-16  626  		*xs++ = c;
^1da177e4c3f41 Linus Torvalds       2005-04-16  627  	return s;
^1da177e4c3f41 Linus Torvalds       2005-04-16  628  }
a4609ecef3c07f Emil Renner Berthing 2022-04-23  629  EXPORT_SYMBOL(__memset);
a4609ecef3c07f Emil Renner Berthing 2022-04-23  630  
a4609ecef3c07f Emil Renner Berthing 2022-04-23  631  void *memset(void *s, int c, size_t count) __weak __alias(__memset);
^1da177e4c3f41 Linus Torvalds       2005-04-16  632  EXPORT_SYMBOL(memset);
^1da177e4c3f41 Linus Torvalds       2005-04-16  633  #endif
^1da177e4c3f41 Linus Torvalds       2005-04-16  634  
3b3c4babd89871 Matthew Wilcox       2017-09-08  635  #ifndef __HAVE_ARCH_MEMSET16
3b3c4babd89871 Matthew Wilcox       2017-09-08  636  /**
3b3c4babd89871 Matthew Wilcox       2017-09-08  637   * memset16() - Fill a memory area with a uint16_t
3b3c4babd89871 Matthew Wilcox       2017-09-08  638   * @s: Pointer to the start of the area.
3b3c4babd89871 Matthew Wilcox       2017-09-08  639   * @v: The value to fill the area with
3b3c4babd89871 Matthew Wilcox       2017-09-08  640   * @count: The number of values to store
3b3c4babd89871 Matthew Wilcox       2017-09-08  641   *
3b3c4babd89871 Matthew Wilcox       2017-09-08  642   * Differs from memset() in that it fills with a uint16_t instead
3b3c4babd89871 Matthew Wilcox       2017-09-08  643   * of a byte.  Remember that @count is the number of uint16_ts to
3b3c4babd89871 Matthew Wilcox       2017-09-08  644   * store, not the number of bytes.
3b3c4babd89871 Matthew Wilcox       2017-09-08  645   */
3b3c4babd89871 Matthew Wilcox       2017-09-08  646  void *memset16(uint16_t *s, uint16_t v, size_t count)
3b3c4babd89871 Matthew Wilcox       2017-09-08  647  {
3b3c4babd89871 Matthew Wilcox       2017-09-08  648  	uint16_t *xs = s;
3b3c4babd89871 Matthew Wilcox       2017-09-08  649  
3b3c4babd89871 Matthew Wilcox       2017-09-08  650  	while (count--)
3b3c4babd89871 Matthew Wilcox       2017-09-08  651  		*xs++ = v;
3b3c4babd89871 Matthew Wilcox       2017-09-08  652  	return s;
3b3c4babd89871 Matthew Wilcox       2017-09-08  653  }
3b3c4babd89871 Matthew Wilcox       2017-09-08  654  EXPORT_SYMBOL(memset16);
3b3c4babd89871 Matthew Wilcox       2017-09-08  655  #endif
3b3c4babd89871 Matthew Wilcox       2017-09-08  656  
3b3c4babd89871 Matthew Wilcox       2017-09-08  657  #ifndef __HAVE_ARCH_MEMSET32
3b3c4babd89871 Matthew Wilcox       2017-09-08  658  /**
3b3c4babd89871 Matthew Wilcox       2017-09-08  659   * memset32() - Fill a memory area with a uint32_t
3b3c4babd89871 Matthew Wilcox       2017-09-08  660   * @s: Pointer to the start of the area.
3b3c4babd89871 Matthew Wilcox       2017-09-08  661   * @v: The value to fill the area with
3b3c4babd89871 Matthew Wilcox       2017-09-08  662   * @count: The number of values to store
3b3c4babd89871 Matthew Wilcox       2017-09-08  663   *
3b3c4babd89871 Matthew Wilcox       2017-09-08  664   * Differs from memset() in that it fills with a uint32_t instead
3b3c4babd89871 Matthew Wilcox       2017-09-08  665   * of a byte.  Remember that @count is the number of uint32_ts to
3b3c4babd89871 Matthew Wilcox       2017-09-08  666   * store, not the number of bytes.
3b3c4babd89871 Matthew Wilcox       2017-09-08  667   */
3b3c4babd89871 Matthew Wilcox       2017-09-08  668  void *memset32(uint32_t *s, uint32_t v, size_t count)
3b3c4babd89871 Matthew Wilcox       2017-09-08  669  {
3b3c4babd89871 Matthew Wilcox       2017-09-08  670  	uint32_t *xs = s;
3b3c4babd89871 Matthew Wilcox       2017-09-08  671  
3b3c4babd89871 Matthew Wilcox       2017-09-08  672  	while (count--)
3b3c4babd89871 Matthew Wilcox       2017-09-08  673  		*xs++ = v;
3b3c4babd89871 Matthew Wilcox       2017-09-08  674  	return s;
3b3c4babd89871 Matthew Wilcox       2017-09-08  675  }
3b3c4babd89871 Matthew Wilcox       2017-09-08  676  EXPORT_SYMBOL(memset32);
3b3c4babd89871 Matthew Wilcox       2017-09-08  677  #endif
3b3c4babd89871 Matthew Wilcox       2017-09-08  678  
3b3c4babd89871 Matthew Wilcox       2017-09-08  679  #ifndef __HAVE_ARCH_MEMSET64
3b3c4babd89871 Matthew Wilcox       2017-09-08  680  /**
3b3c4babd89871 Matthew Wilcox       2017-09-08  681   * memset64() - Fill a memory area with a uint64_t
3b3c4babd89871 Matthew Wilcox       2017-09-08  682   * @s: Pointer to the start of the area.
3b3c4babd89871 Matthew Wilcox       2017-09-08  683   * @v: The value to fill the area with
3b3c4babd89871 Matthew Wilcox       2017-09-08  684   * @count: The number of values to store
3b3c4babd89871 Matthew Wilcox       2017-09-08  685   *
3b3c4babd89871 Matthew Wilcox       2017-09-08  686   * Differs from memset() in that it fills with a uint64_t instead
3b3c4babd89871 Matthew Wilcox       2017-09-08  687   * of a byte.  Remember that @count is the number of uint64_ts to
3b3c4babd89871 Matthew Wilcox       2017-09-08  688   * store, not the number of bytes.
3b3c4babd89871 Matthew Wilcox       2017-09-08  689   */
3b3c4babd89871 Matthew Wilcox       2017-09-08  690  void *memset64(uint64_t *s, uint64_t v, size_t count)
3b3c4babd89871 Matthew Wilcox       2017-09-08  691  {
3b3c4babd89871 Matthew Wilcox       2017-09-08  692  	uint64_t *xs = s;
3b3c4babd89871 Matthew Wilcox       2017-09-08  693  
3b3c4babd89871 Matthew Wilcox       2017-09-08  694  	while (count--)
3b3c4babd89871 Matthew Wilcox       2017-09-08  695  		*xs++ = v;
3b3c4babd89871 Matthew Wilcox       2017-09-08  696  	return s;
3b3c4babd89871 Matthew Wilcox       2017-09-08  697  }
3b3c4babd89871 Matthew Wilcox       2017-09-08  698  EXPORT_SYMBOL(memset64);
3b3c4babd89871 Matthew Wilcox       2017-09-08  699  #endif
3b3c4babd89871 Matthew Wilcox       2017-09-08  700  
^1da177e4c3f41 Linus Torvalds       2005-04-16  701  #ifndef __HAVE_ARCH_MEMCPY
^1da177e4c3f41 Linus Torvalds       2005-04-16  702  /**
^1da177e4c3f41 Linus Torvalds       2005-04-16  703   * memcpy - Copy one area of memory to another
^1da177e4c3f41 Linus Torvalds       2005-04-16  704   * @dest: Where to copy to
^1da177e4c3f41 Linus Torvalds       2005-04-16  705   * @src: Where to copy from
^1da177e4c3f41 Linus Torvalds       2005-04-16  706   * @count: The size of the area.
^1da177e4c3f41 Linus Torvalds       2005-04-16  707   *
^1da177e4c3f41 Linus Torvalds       2005-04-16  708   * You should not use this function to access IO space, use memcpy_toio()
^1da177e4c3f41 Linus Torvalds       2005-04-16  709   * or memcpy_fromio() instead.
^1da177e4c3f41 Linus Torvalds       2005-04-16  710   */
a4609ecef3c07f Emil Renner Berthing 2022-04-23  711  void *__memcpy(void *dest, const void *src, size_t count)
^1da177e4c3f41 Linus Torvalds       2005-04-16 @712  {
850b9247926693 Jesper Juhl          2005-10-30  713  	char *tmp = dest;
4c416ab71164dc Jan-Benedict Glaw    2006-04-10  714  	const char *s = src;
^1da177e4c3f41 Linus Torvalds       2005-04-16  715  
^1da177e4c3f41 Linus Torvalds       2005-04-16  716  	while (count--)
^1da177e4c3f41 Linus Torvalds       2005-04-16  717  		*tmp++ = *s++;
^1da177e4c3f41 Linus Torvalds       2005-04-16  718  	return dest;
^1da177e4c3f41 Linus Torvalds       2005-04-16  719  }
a4609ecef3c07f Emil Renner Berthing 2022-04-23  720  EXPORT_SYMBOL(__memcpy);
a4609ecef3c07f Emil Renner Berthing 2022-04-23  721  
a4609ecef3c07f Emil Renner Berthing 2022-04-23  722  void *memcpy(void *dest, const void *src, size_t count) __weak __alias(__memcpy);
^1da177e4c3f41 Linus Torvalds       2005-04-16  723  EXPORT_SYMBOL(memcpy);
^1da177e4c3f41 Linus Torvalds       2005-04-16  724  #endif
^1da177e4c3f41 Linus Torvalds       2005-04-16  725  
^1da177e4c3f41 Linus Torvalds       2005-04-16  726  #ifndef __HAVE_ARCH_MEMMOVE
^1da177e4c3f41 Linus Torvalds       2005-04-16  727  /**
^1da177e4c3f41 Linus Torvalds       2005-04-16  728   * memmove - Copy one area of memory to another
^1da177e4c3f41 Linus Torvalds       2005-04-16  729   * @dest: Where to copy to
^1da177e4c3f41 Linus Torvalds       2005-04-16  730   * @src: Where to copy from
^1da177e4c3f41 Linus Torvalds       2005-04-16  731   * @count: The size of the area.
^1da177e4c3f41 Linus Torvalds       2005-04-16  732   *
^1da177e4c3f41 Linus Torvalds       2005-04-16  733   * Unlike memcpy(), memmove() copes with overlapping areas.
^1da177e4c3f41 Linus Torvalds       2005-04-16  734   */
a4609ecef3c07f Emil Renner Berthing 2022-04-23  735  void *__memmove(void *dest, const void *src, size_t count)
^1da177e4c3f41 Linus Torvalds       2005-04-16 @736  {
82da2c372712c7 Paul Jackson         2005-10-30  737  	char *tmp;
82da2c372712c7 Paul Jackson         2005-10-30  738  	const char *s;
^1da177e4c3f41 Linus Torvalds       2005-04-16  739  
^1da177e4c3f41 Linus Torvalds       2005-04-16  740  	if (dest <= src) {
850b9247926693 Jesper Juhl          2005-10-30  741  		tmp = dest;
850b9247926693 Jesper Juhl          2005-10-30  742  		s = src;
^1da177e4c3f41 Linus Torvalds       2005-04-16  743  		while (count--)
^1da177e4c3f41 Linus Torvalds       2005-04-16  744  			*tmp++ = *s++;
51a0f0f658b0e7 Jesper Juhl          2005-10-30  745  	} else {
850b9247926693 Jesper Juhl          2005-10-30  746  		tmp = dest;
850b9247926693 Jesper Juhl          2005-10-30  747  		tmp += count;
850b9247926693 Jesper Juhl          2005-10-30  748  		s = src;
850b9247926693 Jesper Juhl          2005-10-30  749  		s += count;
^1da177e4c3f41 Linus Torvalds       2005-04-16  750  		while (count--)
^1da177e4c3f41 Linus Torvalds       2005-04-16  751  			*--tmp = *--s;
^1da177e4c3f41 Linus Torvalds       2005-04-16  752  	}
^1da177e4c3f41 Linus Torvalds       2005-04-16  753  	return dest;
^1da177e4c3f41 Linus Torvalds       2005-04-16  754  }
a4609ecef3c07f Emil Renner Berthing 2022-04-23  755  EXPORT_SYMBOL(__memmove);
a4609ecef3c07f Emil Renner Berthing 2022-04-23  756  

:::::: The code at line 622 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
