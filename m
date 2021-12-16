Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9646D476AAF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 07:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbhLPGzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 01:55:48 -0500
Received: from mga11.intel.com ([192.55.52.93]:45689 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234251AbhLPGzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 01:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639637747; x=1671173747;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NCCFUeCZXCh4TSA2XYhBNMAjOK61ZKRd23wYtFcvOCs=;
  b=Vwx/Hq06T9Aqok5ja5HHbIphTWjY2GazGlJymVZTQR1UweRLWsnCgNRd
   0j5faPHNChLN1+diz6l6RXIYLHJZLLajn6JPVO0ZijFFr3mVOKzWS5S8U
   F+O2okQXjdNaVEiNLEy12MGWWaK6PCbWohR2rysi0JM8PpqZLLZq4q19c
   YmzMP3pyHc+tzuhhh7HuW/yQwc6DpnerRZ4VgNdXU0lg+DfiQn75uqLcf
   s7l9iyjQ880/9bdc2hib7cd1FzwTzdc5dpaPhUnRfDU9EiKEGAAe/uxHt
   jExwqdXjFpOgkI+vA6BAeEhuvY5YfZtZosFYW4iQDAND1DxPlg2IZBVzQ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="236958444"
X-IronPort-AV: E=Sophos;i="5.88,210,1635231600"; 
   d="scan'208";a="236958444"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 22:55:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,210,1635231600"; 
   d="scan'208";a="464563320"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 15 Dec 2021 22:55:44 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxkg3-0002sA-PR; Thu, 16 Dec 2021 06:55:43 +0000
Date:   Thu, 16 Dec 2021 14:54:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:repair-symlink-swapext 321/325]
 fs/xfs/libxfs/xfs_symlink_remote.c:26:1: warning: no previous prototype for
 function 'xfs_symlink_blocks'
Message-ID: <202112161445.FSm8Pr8b-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git repair-symlink-swapext
head:   851df07d9599471df909c4ff0e3cf33f4b9619f0
commit: 515b3743bd3bfc67a91b56942181662cf55293ad [321/325] xfs: move xfs_symlink_remote.c declarations to xfs_symlink_remote.h
config: riscv-randconfig-r042-20211216 (https://download.01.org/0day-ci/archive/20211216/202112161445.FSm8Pr8b-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dd245bab9fbb364faa1581e4f92ba3119a872fba)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=515b3743bd3bfc67a91b56942181662cf55293ad
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs repair-symlink-swapext
        git checkout 515b3743bd3bfc67a91b56942181662cf55293ad
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash fs/xfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/xfs/libxfs/xfs_symlink_remote.c:26:1: warning: no previous prototype for function 'xfs_symlink_blocks' [-Wmissing-prototypes]
   xfs_symlink_blocks(
   ^
   fs/xfs/libxfs/xfs_symlink_remote.c:25:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int
   ^
   static 
>> fs/xfs/libxfs/xfs_symlink_remote.c:36:1: warning: no previous prototype for function 'xfs_symlink_hdr_set' [-Wmissing-prototypes]
   xfs_symlink_hdr_set(
   ^
   fs/xfs/libxfs/xfs_symlink_remote.c:35:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int
   ^
   static 
>> fs/xfs/libxfs/xfs_symlink_remote.c:66:1: warning: no previous prototype for function 'xfs_symlink_hdr_ok' [-Wmissing-prototypes]
   xfs_symlink_hdr_ok(
   ^
   fs/xfs/libxfs/xfs_symlink_remote.c:65:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool
   ^
   static 
>> fs/xfs/libxfs/xfs_symlink_remote.c:165:1: warning: no previous prototype for function 'xfs_symlink_local_to_remote' [-Wmissing-prototypes]
   xfs_symlink_local_to_remote(
   ^
   fs/xfs/libxfs/xfs_symlink_remote.c:164:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void
   ^
   static 
>> fs/xfs/libxfs/xfs_symlink_remote.c:204:1: warning: no previous prototype for function 'xfs_symlink_shortform_verify' [-Wmissing-prototypes]
   xfs_symlink_shortform_verify(
   ^
   fs/xfs/libxfs/xfs_symlink_remote.c:203:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   xfs_failaddr_t
   ^
   static 
   5 warnings generated.


vim +/xfs_symlink_blocks +26 fs/xfs/libxfs/xfs_symlink_remote.c

1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   19  
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   20  
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   21  /*
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   22   * Each contiguous block has a header, so it is not just a simple pathlen
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   23   * to FSB conversion.
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   24   */
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   25  int
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  @26  xfs_symlink_blocks(
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   27  	struct xfs_mount *mp,
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   28  	int		pathlen)
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   29  {
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   30  	int buflen = XFS_SYMLINK_BUF_SPACE(mp, mp->m_sb.sb_blocksize);
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   31  
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   32  	return (pathlen + buflen - 1) / buflen;
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   33  }
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   34  
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   35  int
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  @36  xfs_symlink_hdr_set(
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   37  	struct xfs_mount	*mp,
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   38  	xfs_ino_t		ino,
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   39  	uint32_t		offset,
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   40  	uint32_t		size,
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   41  	struct xfs_buf		*bp)
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   42  {
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   43  	struct xfs_dsymlink_hdr	*dsl = bp->b_addr;
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   44  
38c26bfd90e199 fs/xfs/libxfs/xfs_symlink_remote.c Dave Chinner      2021-08-18   45  	if (!xfs_has_crc(mp))
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   46  		return 0;
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   47  
a45086e27dfa21 fs/xfs/libxfs/xfs_symlink_remote.c Brian Foster      2015-10-12   48  	memset(dsl, 0, sizeof(struct xfs_dsymlink_hdr));
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   49  	dsl->sl_magic = cpu_to_be32(XFS_SYMLINK_MAGIC);
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   50  	dsl->sl_offset = cpu_to_be32(offset);
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   51  	dsl->sl_bytes = cpu_to_be32(size);
ce748eaa65f2e9 fs/xfs/libxfs/xfs_symlink_remote.c Eric Sandeen      2015-07-29   52  	uuid_copy(&dsl->sl_uuid, &mp->m_sb.sb_meta_uuid);
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   53  	dsl->sl_owner = cpu_to_be64(ino);
9343ee76909e3f fs/xfs/libxfs/xfs_symlink_remote.c Dave Chinner      2021-08-18   54  	dsl->sl_blkno = cpu_to_be64(xfs_buf_daddr(bp));
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   55  	bp->b_ops = &xfs_symlink_buf_ops;
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   56  
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   57  	return sizeof(struct xfs_dsymlink_hdr);
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   58  }
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   59  
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   60  /*
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   61   * Checking of the symlink header is split into two parts. the verifier does
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   62   * CRC, location and bounds checking, the unpacking function checks the path
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   63   * parameters and owner.
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   64   */
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   65  bool
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  @66  xfs_symlink_hdr_ok(
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   67  	xfs_ino_t		ino,
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   68  	uint32_t		offset,
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   69  	uint32_t		size,
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   70  	struct xfs_buf		*bp)
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   71  {
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   72  	struct xfs_dsymlink_hdr *dsl = bp->b_addr;
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   73  
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   74  	if (offset != be32_to_cpu(dsl->sl_offset))
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   75  		return false;
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   76  	if (size != be32_to_cpu(dsl->sl_bytes))
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   77  		return false;
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   78  	if (ino != be64_to_cpu(dsl->sl_owner))
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   79  		return false;
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   80  
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   81  	/* ok */
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   82  	return true;
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   83  }
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   84  
a6a781a58befcb fs/xfs/libxfs/xfs_symlink_remote.c Darrick J. Wong   2018-01-08   85  static xfs_failaddr_t
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   86  xfs_symlink_verify(
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   87  	struct xfs_buf		*bp)
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   88  {
dbd329f1e44ed4 fs/xfs/libxfs/xfs_symlink_remote.c Christoph Hellwig 2019-06-28   89  	struct xfs_mount	*mp = bp->b_mount;
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   90  	struct xfs_dsymlink_hdr	*dsl = bp->b_addr;
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12   91  
38c26bfd90e199 fs/xfs/libxfs/xfs_symlink_remote.c Dave Chinner      2021-08-18   92  	if (!xfs_has_crc(mp))
a6a781a58befcb fs/xfs/libxfs/xfs_symlink_remote.c Darrick J. Wong   2018-01-08   93  		return __this_address;
39708c20ab5133 fs/xfs/libxfs/xfs_symlink_remote.c Brian Foster      2019-02-07   94  	if (!xfs_verify_magic(bp, dsl->sl_magic))
a6a781a58befcb fs/xfs/libxfs/xfs_symlink_remote.c Darrick J. Wong   2018-01-08   95  		return __this_address;
ce748eaa65f2e9 fs/xfs/libxfs/xfs_symlink_remote.c Eric Sandeen      2015-07-29   96  	if (!uuid_equal(&dsl->sl_uuid, &mp->m_sb.sb_meta_uuid))
a6a781a58befcb fs/xfs/libxfs/xfs_symlink_remote.c Darrick J. Wong   2018-01-08   97  		return __this_address;
9343ee76909e3f fs/xfs/libxfs/xfs_symlink_remote.c Dave Chinner      2021-08-18   98  	if (xfs_buf_daddr(bp) != be64_to_cpu(dsl->sl_blkno))
a6a781a58befcb fs/xfs/libxfs/xfs_symlink_remote.c Darrick J. Wong   2018-01-08   99  		return __this_address;
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  100  	if (be32_to_cpu(dsl->sl_offset) +
6eb0b8df9f74f3 fs/xfs/libxfs/xfs_symlink_remote.c Darrick J. Wong   2017-07-07  101  				be32_to_cpu(dsl->sl_bytes) >= XFS_SYMLINK_MAXLEN)
a6a781a58befcb fs/xfs/libxfs/xfs_symlink_remote.c Darrick J. Wong   2018-01-08  102  		return __this_address;
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  103  	if (dsl->sl_owner == 0)
a6a781a58befcb fs/xfs/libxfs/xfs_symlink_remote.c Darrick J. Wong   2018-01-08  104  		return __this_address;
a45086e27dfa21 fs/xfs/libxfs/xfs_symlink_remote.c Brian Foster      2015-10-12  105  	if (!xfs_log_check_lsn(mp, be64_to_cpu(dsl->sl_lsn)))
a6a781a58befcb fs/xfs/libxfs/xfs_symlink_remote.c Darrick J. Wong   2018-01-08  106  		return __this_address;
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  107  
a6a781a58befcb fs/xfs/libxfs/xfs_symlink_remote.c Darrick J. Wong   2018-01-08  108  	return NULL;
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  109  }
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  110  
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  111  static void
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  112  xfs_symlink_read_verify(
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  113  	struct xfs_buf	*bp)
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  114  {
dbd329f1e44ed4 fs/xfs/libxfs/xfs_symlink_remote.c Christoph Hellwig 2019-06-28  115  	struct xfs_mount *mp = bp->b_mount;
bc1a09b8e334bf fs/xfs/libxfs/xfs_symlink_remote.c Darrick J. Wong   2018-01-08  116  	xfs_failaddr_t	fa;
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  117  
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  118  	/* no verification of non-crc buffers */
38c26bfd90e199 fs/xfs/libxfs/xfs_symlink_remote.c Dave Chinner      2021-08-18  119  	if (!xfs_has_crc(mp))
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  120  		return;
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  121  
ce5028cfe3ca48 fs/xfs/xfs_symlink_remote.c        Eric Sandeen      2014-02-27  122  	if (!xfs_buf_verify_cksum(bp, XFS_SYMLINK_CRC_OFF))
bc1a09b8e334bf fs/xfs/libxfs/xfs_symlink_remote.c Darrick J. Wong   2018-01-08  123  		xfs_verifier_error(bp, -EFSBADCRC, __this_address);
bc1a09b8e334bf fs/xfs/libxfs/xfs_symlink_remote.c Darrick J. Wong   2018-01-08  124  	else {
bc1a09b8e334bf fs/xfs/libxfs/xfs_symlink_remote.c Darrick J. Wong   2018-01-08  125  		fa = xfs_symlink_verify(bp);
bc1a09b8e334bf fs/xfs/libxfs/xfs_symlink_remote.c Darrick J. Wong   2018-01-08  126  		if (fa)
bc1a09b8e334bf fs/xfs/libxfs/xfs_symlink_remote.c Darrick J. Wong   2018-01-08  127  			xfs_verifier_error(bp, -EFSCORRUPTED, fa);
bc1a09b8e334bf fs/xfs/libxfs/xfs_symlink_remote.c Darrick J. Wong   2018-01-08  128  	}
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  129  }
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  130  
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  131  static void
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  132  xfs_symlink_write_verify(
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  133  	struct xfs_buf	*bp)
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  134  {
dbd329f1e44ed4 fs/xfs/libxfs/xfs_symlink_remote.c Christoph Hellwig 2019-06-28  135  	struct xfs_mount *mp = bp->b_mount;
fb1755a645972e fs/xfs/libxfs/xfs_symlink_remote.c Carlos Maiolino   2018-01-24  136  	struct xfs_buf_log_item	*bip = bp->b_log_item;
bc1a09b8e334bf fs/xfs/libxfs/xfs_symlink_remote.c Darrick J. Wong   2018-01-08  137  	xfs_failaddr_t		fa;
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  138  
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  139  	/* no verification of non-crc buffers */
38c26bfd90e199 fs/xfs/libxfs/xfs_symlink_remote.c Dave Chinner      2021-08-18  140  	if (!xfs_has_crc(mp))
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  141  		return;
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  142  
bc1a09b8e334bf fs/xfs/libxfs/xfs_symlink_remote.c Darrick J. Wong   2018-01-08  143  	fa = xfs_symlink_verify(bp);
bc1a09b8e334bf fs/xfs/libxfs/xfs_symlink_remote.c Darrick J. Wong   2018-01-08  144  	if (fa) {
bc1a09b8e334bf fs/xfs/libxfs/xfs_symlink_remote.c Darrick J. Wong   2018-01-08  145  		xfs_verifier_error(bp, -EFSCORRUPTED, fa);
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  146  		return;
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  147  	}
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  148  
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  149  	if (bip) {
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  150  		struct xfs_dsymlink_hdr *dsl = bp->b_addr;
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  151  		dsl->sl_lsn = cpu_to_be64(bip->bli_item.li_lsn);
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  152  	}
f1dbcd7e38c80c fs/xfs/xfs_symlink_remote.c        Eric Sandeen      2014-02-27  153  	xfs_buf_update_cksum(bp, XFS_SYMLINK_CRC_OFF);
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  154  }
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  155  
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  156  const struct xfs_buf_ops xfs_symlink_buf_ops = {
233135b763db7c fs/xfs/libxfs/xfs_symlink_remote.c Eric Sandeen      2016-01-04  157  	.name = "xfs_symlink",
39708c20ab5133 fs/xfs/libxfs/xfs_symlink_remote.c Brian Foster      2019-02-07  158  	.magic = { 0, cpu_to_be32(XFS_SYMLINK_MAGIC) },
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  159  	.verify_read = xfs_symlink_read_verify,
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  160  	.verify_write = xfs_symlink_write_verify,
b55725974c9d3a fs/xfs/libxfs/xfs_symlink_remote.c Darrick J. Wong   2018-01-08  161  	.verify_struct = xfs_symlink_verify,
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  162  };
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  163  
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  164  void
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12 @165  xfs_symlink_local_to_remote(
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  166  	struct xfs_trans	*tp,
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  167  	struct xfs_buf		*bp,
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  168  	struct xfs_inode	*ip,
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  169  	struct xfs_ifork	*ifp)
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  170  {
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  171  	struct xfs_mount	*mp = ip->i_mount;
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  172  	char			*buf;
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  173  
fe22d552b82d7c fs/xfs/libxfs/xfs_symlink_remote.c Dave Chinner      2015-01-22  174  	xfs_trans_buf_set_type(tp, bp, XFS_BLFT_SYMLINK_BUF);
fe22d552b82d7c fs/xfs/libxfs/xfs_symlink_remote.c Dave Chinner      2015-01-22  175  
38c26bfd90e199 fs/xfs/libxfs/xfs_symlink_remote.c Dave Chinner      2021-08-18  176  	if (!xfs_has_crc(mp)) {
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  177  		bp->b_ops = NULL;
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  178  		memcpy(bp->b_addr, ifp->if_u1.if_data, ifp->if_bytes);
b7cdc66be54b64 fs/xfs/libxfs/xfs_symlink_remote.c Brian Foster      2015-10-12  179  		xfs_trans_log_buf(tp, bp, 0, ifp->if_bytes - 1);
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  180  		return;
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  181  	}
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  182  
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  183  	/*
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  184  	 * As this symlink fits in an inode literal area, it must also fit in
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  185  	 * the smallest buffer the filesystem supports.
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  186  	 */
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  187  	ASSERT(BBTOB(bp->b_length) >=
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  188  			ifp->if_bytes + sizeof(struct xfs_dsymlink_hdr));
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  189  
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  190  	bp->b_ops = &xfs_symlink_buf_ops;
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  191  
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  192  	buf = bp->b_addr;
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  193  	buf += xfs_symlink_hdr_set(mp, ip->i_ino, 0, ifp->if_bytes, bp);
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  194  	memcpy(buf, ifp->if_u1.if_data, ifp->if_bytes);
b7cdc66be54b64 fs/xfs/libxfs/xfs_symlink_remote.c Brian Foster      2015-10-12  195  	xfs_trans_log_buf(tp, bp, 0, sizeof(struct xfs_dsymlink_hdr) +
b7cdc66be54b64 fs/xfs/libxfs/xfs_symlink_remote.c Brian Foster      2015-10-12  196  					ifp->if_bytes - 1);
1fb7e48db68100 fs/xfs/xfs_symlink_remote.c        Dave Chinner      2013-08-12  197  }
0795e004fd4f27 fs/xfs/libxfs/xfs_symlink_remote.c Darrick J. Wong   2018-01-08  198  
43feeea88c9cb2 fs/xfs/libxfs/xfs_symlink_remote.c Dave Chinner      2018-12-12  199  /*
43feeea88c9cb2 fs/xfs/libxfs/xfs_symlink_remote.c Dave Chinner      2018-12-12  200   * Verify the in-memory consistency of an inline symlink data fork. This
43feeea88c9cb2 fs/xfs/libxfs/xfs_symlink_remote.c Dave Chinner      2018-12-12  201   * does not do on-disk format checks.
43feeea88c9cb2 fs/xfs/libxfs/xfs_symlink_remote.c Dave Chinner      2018-12-12  202   */
0795e004fd4f27 fs/xfs/libxfs/xfs_symlink_remote.c Darrick J. Wong   2018-01-08  203  xfs_failaddr_t
0795e004fd4f27 fs/xfs/libxfs/xfs_symlink_remote.c Darrick J. Wong   2018-01-08 @204  xfs_symlink_shortform_verify(

:::::: The code at line 26 was first introduced by commit
:::::: 1fb7e48db6810093012873a652062648ace6b5bb xfs: split out the remote symlink handling

:::::: TO: Dave Chinner <dchinner@redhat.com>
:::::: CC: Ben Myers <bpm@sgi.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
