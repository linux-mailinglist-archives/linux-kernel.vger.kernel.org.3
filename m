Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAC85977FD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 22:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241973AbiHQUek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 16:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241969AbiHQUei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:34:38 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AF9A98EA
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660768477; x=1692304477;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+nf3P+bzUfdWxBjUlNyOkWW74Iv39NOlsik1vxmpSJU=;
  b=f+klvo18FgZIMatZzvRA/CZPdgbPWtFrxsxFqhENneJW0n5yLQxRn20Z
   WFyfHxSfarxdx6Q+iHmogOEa1eGyaVavJaP7NcgB4bSeWJD1xcvQBXT/z
   MPMKJuYdixmOzmAcajoQhTm9LuiSxLsmOgorFuHwHWqi5GWuTxIzW8TNK
   9eno7kaumla7u0G5u77VgNfm6i9HPna1m4w+BuTisrsXJXJ1bpHzkYho8
   usdGstgyDLrxoiAXJScThjdlEqxg0PlOgRBfi8wc4Uy4NJhGjAzIrCRmL
   QYeHgbaNBFwPLVmNoZKOEbhbV9sKJ61DtvlzoLbuXpGZstHWHs9USqNEd
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="293873866"
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="293873866"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 13:34:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,244,1654585200"; 
   d="scan'208";a="636525478"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 17 Aug 2022 13:34:34 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOPkI-0001Jm-09;
        Wed, 17 Aug 2022 20:34:34 +0000
Date:   Thu, 18 Aug 2022 04:34:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jlayton:iversion 1/7] samples/vfs/test-statx.c:111:24: warning:
 more '%' conversions than data arguments
Message-ID: <202208180458.7a2l8vcX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git iversion
head:   f4cbc6a71997effae6392d95c1a68884142d9d21
commit: ab87f1864e9838a40a28f93e64b87a5ce9bfd3a7 [1/7] vfs: report change attribute in statx for IS_I_VERSION inodes
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220818/202208180458.7a2l8vcX-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project aed5e3bea138ce581d682158eb61c27b3cfdd6ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git/commit/?id=ab87f1864e9838a40a28f93e64b87a5ce9bfd3a7
        git remote add jlayton https://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux.git
        git fetch --no-tags jlayton iversion
        git checkout ab87f1864e9838a40a28f93e64b87a5ce9bfd3a7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash samples/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> samples/vfs/test-statx.c:111:24: warning: more '%' conversions than data arguments [-Wformat-insufficient-args]
                   printf(" MountId: %llx"), stx->stx_mnt_id;
                                     ~~~^
>> samples/vfs/test-statx.c:111:34: warning: expression result unused [-Wunused-value]
                   printf(" MountId: %llx"), stx->stx_mnt_id;
                                             ~~~  ^~~~~~~~~~
   2 warnings generated.


vim +111 samples/vfs/test-statx.c

    76	
    77	static void dump_statx(struct statx *stx)
    78	{
    79		char buffer[256], ft = '?';
    80	
    81		printf("results=%x\n", stx->stx_mask);
    82	
    83		printf(" ");
    84		if (stx->stx_mask & STATX_SIZE)
    85			printf(" Size: %-15llu", (unsigned long long)stx->stx_size);
    86		if (stx->stx_mask & STATX_BLOCKS)
    87			printf(" Blocks: %-10llu", (unsigned long long)stx->stx_blocks);
    88		printf(" IO Block: %-6llu", (unsigned long long)stx->stx_blksize);
    89		if (stx->stx_mask & STATX_TYPE) {
    90			switch (stx->stx_mode & S_IFMT) {
    91			case S_IFIFO:	printf("  FIFO\n");			ft = 'p'; break;
    92			case S_IFCHR:	printf("  character special file\n");	ft = 'c'; break;
    93			case S_IFDIR:	printf("  directory\n");		ft = 'd'; break;
    94			case S_IFBLK:	printf("  block special file\n");	ft = 'b'; break;
    95			case S_IFREG:	printf("  regular file\n");		ft = '-'; break;
    96			case S_IFLNK:	printf("  symbolic link\n");		ft = 'l'; break;
    97			case S_IFSOCK:	printf("  socket\n");			ft = 's'; break;
    98			default:
    99				printf(" unknown type (%o)\n", stx->stx_mode & S_IFMT);
   100				break;
   101			}
   102		} else {
   103			printf(" no type\n");
   104		}
   105	
   106		sprintf(buffer, "%02x:%02x", stx->stx_dev_major, stx->stx_dev_minor);
   107		printf("Device: %-15s", buffer);
   108		if (stx->stx_mask & STATX_INO)
   109			printf(" Inode: %-11llu", (unsigned long long) stx->stx_ino);
   110		if (stx->stx_mask & STATX_MNT_ID)
 > 111			printf(" MountId: %llx"), stx->stx_mnt_id;
   112		if (stx->stx_mask & STATX_NLINK)
   113			printf(" Links: %-5u", stx->stx_nlink);
   114		if (stx->stx_mask & STATX_TYPE) {
   115			switch (stx->stx_mode & S_IFMT) {
   116			case S_IFBLK:
   117			case S_IFCHR:
   118				printf(" Device type: %u,%u",
   119				       stx->stx_rdev_major, stx->stx_rdev_minor);
   120				break;
   121			}
   122		}
   123		printf("\n");
   124	
   125		if (stx->stx_mask & STATX_MODE)
   126			printf("Access: (%04o/%c%c%c%c%c%c%c%c%c%c)  ",
   127			       stx->stx_mode & 07777,
   128			       ft,
   129			       stx->stx_mode & S_IRUSR ? 'r' : '-',
   130			       stx->stx_mode & S_IWUSR ? 'w' : '-',
   131			       stx->stx_mode & S_IXUSR ? 'x' : '-',
   132			       stx->stx_mode & S_IRGRP ? 'r' : '-',
   133			       stx->stx_mode & S_IWGRP ? 'w' : '-',
   134			       stx->stx_mode & S_IXGRP ? 'x' : '-',
   135			       stx->stx_mode & S_IROTH ? 'r' : '-',
   136			       stx->stx_mode & S_IWOTH ? 'w' : '-',
   137			       stx->stx_mode & S_IXOTH ? 'x' : '-');
   138		if (stx->stx_mask & STATX_UID)
   139			printf("Uid: %5d   ", stx->stx_uid);
   140		if (stx->stx_mask & STATX_GID)
   141			printf("Gid: %5d\n", stx->stx_gid);
   142	
   143		if (stx->stx_mask & STATX_ATIME)
   144			print_time("Access: ", &stx->stx_atime);
   145		if (stx->stx_mask & STATX_MTIME)
   146			print_time("Modify: ", &stx->stx_mtime);
   147		if (stx->stx_mask & STATX_CTIME)
   148			print_time("Change: ", &stx->stx_ctime);
   149		if (stx->stx_mask & STATX_BTIME)
   150			print_time("Birth: ", &stx->stx_btime);
   151		if (stx->stx_mask & STATX_CHANGE_ATTR)
   152			printf("Change Attr: 0x%llx\n", stx->stx_change_attr);
   153	
   154		if (stx->stx_attributes_mask) {
   155			unsigned char bits, mbits;
   156			int loop, byte;
   157	
   158			static char attr_representation[64 + 1] =
   159				/* STATX_ATTR_ flags: */
   160				"????????"	/* 63-56 */
   161				"????????"	/* 55-48 */
   162				"????????"	/* 47-40 */
   163				"????????"	/* 39-32 */
   164				"????????"	/* 31-24	0x00000000-ff000000 */
   165				"????????"	/* 23-16	0x00000000-00ff0000 */
   166				"???me???"	/* 15- 8	0x00000000-0000ff00 */
   167				"?dai?c??"	/*  7- 0	0x00000000-000000ff */
   168				;
   169	
   170			printf("Attributes: %016llx (",
   171			       (unsigned long long)stx->stx_attributes);
   172			for (byte = 64 - 8; byte >= 0; byte -= 8) {
   173				bits = stx->stx_attributes >> byte;
   174				mbits = stx->stx_attributes_mask >> byte;
   175				for (loop = 7; loop >= 0; loop--) {
   176					int bit = byte + loop;
   177	
   178					if (!(mbits & 0x80))
   179						putchar('.');	/* Not supported */
   180					else if (bits & 0x80)
   181						putchar(attr_representation[63 - bit]);
   182					else
   183						putchar('-');	/* Not set */
   184					bits <<= 1;
   185					mbits <<= 1;
   186				}
   187				if (byte)
   188					putchar(' ');
   189			}
   190			printf(")\n");
   191		}
   192	}
   193	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
