Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06705196B0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 06:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237825AbiEDFBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 01:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237299AbiEDFBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 01:01:16 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132A62D1F1
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 21:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651640262; x=1683176262;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=c6TGBp/eCJ/T16P06gcvZyRZ8k6N443E//shrA5Ii+A=;
  b=iUNbKIjg2jBYREZrRDtVRwtJxzk8NQAt2BuIBuFIR9u2mGQ8+bDQFIdo
   KV/vvRAvuePr61hPUsTkPM7T2MtkvJIMqoteYzDOdiEyhDnG9hP7mU5rh
   46XVUj5JuXpSxy+cz3Zvs7I5jRxTwB3lJI79R6KbHfo7yQa3kj2s2NuSR
   pCTqmfYxT35HLRoex+xCeAupb0kELnG6/hknb978LyYhEFtKQ9h4IZUY/
   znWMJpP1IdvJ1c925TcpPCJoAV7pzM/OIfW42+eH8qFq/FKZg+j+A1gNv
   SCFksJKdIcNpqpvQ58K/prXYa5ihXlvc6iVqssbi0JO5MgsBAyW8cA5k6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="247572049"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="247572049"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 21:57:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="620648903"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 03 May 2022 21:57:40 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nm751-000B4q-WF;
        Wed, 04 May 2022 04:57:40 +0000
Date:   Wed, 4 May 2022 12:57:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [niks:has_ioport_v3 1/39] lib/Kconfig:497:error: recursive
 dependency detected!
Message-ID: <202205041240.icM5bvTC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git has_ioport_v3
head:   45df38c1492340a5c06ff7ad2966735c1f5c4d94
commit: c86b326079cfdb351982b26452fcea2561fc7b84 [1/39] Kconfig: introduce HAS_IOPORT option and select it as necessary
config: parisc-buildonly-randconfig-r004-20220501
compiler: hppa-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/commit/?id=c86b326079cfdb351982b26452fcea2561fc7b84
        git remote add niks https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git
        git fetch --no-tags niks has_ioport_v3
        git checkout c86b326079cfdb351982b26452fcea2561fc7b84
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 ARCH=parisc  buildonly-randconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 ARCH=parisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> lib/Kconfig:497:error: recursive dependency detected!
   lib/Kconfig:497: symbol HAS_IOPORT is selected by EISA
   drivers/eisa/Kconfig:10: symbol EISA depends on HAVE_EISA
   drivers/eisa/Kconfig:6: symbol HAVE_EISA depends on HAS_IOPORT
   For a resolution refer to Documentation/kbuild/kconfig-language.rst
   subsection "Kconfig recursive dependency limitations"


vim +497 lib/Kconfig

   346	
   347	#
   348	# These all provide a common interface (hence the apparent duplication with
   349	# ZLIB_INFLATE; DECOMPRESS_GZIP is just a wrapper.)
   350	#
   351	config DECOMPRESS_GZIP
   352		select ZLIB_INFLATE
   353		tristate
   354	
   355	config DECOMPRESS_BZIP2
   356		tristate
   357	
   358	config DECOMPRESS_LZMA
   359		tristate
   360	
   361	config DECOMPRESS_XZ
   362		select XZ_DEC
   363		tristate
   364	
   365	config DECOMPRESS_LZO
   366		select LZO_DECOMPRESS
   367		tristate
   368	
   369	config DECOMPRESS_LZ4
   370		select LZ4_DECOMPRESS
   371		tristate
   372	
   373	config DECOMPRESS_ZSTD
   374		select ZSTD_DECOMPRESS
   375		tristate
   376	
   377	#
   378	# Generic allocator support is selected if needed
   379	#
   380	config GENERIC_ALLOCATOR
   381		bool
   382	
   383	#
   384	# reed solomon support is select'ed if needed
   385	#
   386	config REED_SOLOMON
   387		tristate
   388		
   389	config REED_SOLOMON_ENC8
   390		bool
   391	
   392	config REED_SOLOMON_DEC8
   393		bool
   394	
   395	config REED_SOLOMON_ENC16
   396		bool
   397	
   398	config REED_SOLOMON_DEC16
   399		bool
   400	
   401	#
   402	# BCH support is selected if needed
   403	#
   404	config BCH
   405		tristate
   406	
   407	config BCH_CONST_PARAMS
   408		bool
   409		help
   410		  Drivers may select this option to force specific constant
   411		  values for parameters 'm' (Galois field order) and 't'
   412		  (error correction capability). Those specific values must
   413		  be set by declaring default values for symbols BCH_CONST_M
   414		  and BCH_CONST_T.
   415		  Doing so will enable extra compiler optimizations,
   416		  improving encoding and decoding performance up to 2x for
   417		  usual (m,t) values (typically such that m*t < 200).
   418		  When this option is selected, the BCH library supports
   419		  only a single (m,t) configuration. This is mainly useful
   420		  for NAND flash board drivers requiring known, fixed BCH
   421		  parameters.
   422	
   423	config BCH_CONST_M
   424		int
   425		range 5 15
   426		help
   427		  Constant value for Galois field order 'm'. If 'k' is the
   428		  number of data bits to protect, 'm' should be chosen such
   429		  that (k + m*t) <= 2**m - 1.
   430		  Drivers should declare a default value for this symbol if
   431		  they select option BCH_CONST_PARAMS.
   432	
   433	config BCH_CONST_T
   434		int
   435		help
   436		  Constant value for error correction capability in bits 't'.
   437		  Drivers should declare a default value for this symbol if
   438		  they select option BCH_CONST_PARAMS.
   439	
   440	#
   441	# Textsearch support is select'ed if needed
   442	#
   443	config TEXTSEARCH
   444		bool
   445	
   446	config TEXTSEARCH_KMP
   447		tristate
   448	
   449	config TEXTSEARCH_BM
   450		tristate
   451	
   452	config TEXTSEARCH_FSM
   453		tristate
   454	
   455	config BTREE
   456		bool
   457	
   458	config INTERVAL_TREE
   459		bool
   460		help
   461		  Simple, embeddable, interval-tree. Can find the start of an
   462		  overlapping range in log(n) time and then iterate over all
   463		  overlapping nodes. The algorithm is implemented as an
   464		  augmented rbtree.
   465	
   466		  See:
   467	
   468			Documentation/core-api/rbtree.rst
   469	
   470		  for more information.
   471	
   472	config XARRAY_MULTI
   473		bool
   474		help
   475		  Support entries which occupy multiple consecutive indices in the
   476		  XArray.
   477	
   478	config ASSOCIATIVE_ARRAY
   479		bool
   480		help
   481		  Generic associative array.  Can be searched and iterated over whilst
   482		  it is being modified.  It is also reasonably quick to search and
   483		  modify.  The algorithms are non-recursive, and the trees are highly
   484		  capacious.
   485	
   486		  See:
   487	
   488			Documentation/core-api/assoc_array.rst
   489	
   490		  for more information.
   491	
   492	config HAS_IOMEM
   493		bool
   494		depends on !NO_IOMEM
   495		default y
   496	
 > 497	config HAS_IOPORT
   498		bool
   499	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
