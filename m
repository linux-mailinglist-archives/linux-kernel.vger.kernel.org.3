Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C9458260B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbiG0MDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiG0MDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:03:23 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B7B4B0C9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 05:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658923401; x=1690459401;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0NFJAdx7A5kbyjjfMNTIpqGBY3FUHRh14WFEM1lag0s=;
  b=gW5BadQFxnSm4oC/4/PcLmXBaYvkf2ZFvYoHRwcZSAMO4nYTBnazIMUR
   hsJwnsUny6HUIyFEdlu+XVzZy5Xch7joj+rp7Dw4VlKArqnN5UvOyHYbK
   oegW4xBSPbWbSJ6UjL689t/8yvj5Fyr8kz3+2IWLchQcz+KPuYXVONgI2
   lPK6wTRPPpKGHkUNSe3Cb4mgWfTt2IQR6y7WXLBMUePokuUQqiXHzxK+s
   TN2GsconWOTYB3hhI/QbfEixuaNn8/0gDxoXc7WqSuu5NRl1MkMZHF6W0
   Sj5DanWDJjijtDVLJYnLCpUubiEj7z1xW5SoFkj4Slv4Oa0R95cd5H5OI
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="289409042"
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="289409042"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 05:03:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="659169939"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 27 Jul 2022 05:03:19 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGfl1-0008hC-01;
        Wed, 27 Jul 2022 12:03:19 +0000
Date:   Wed, 27 Jul 2022 20:02:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Sterba <dsterba@suse.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kdave-btrfs-devel:dev/async-discard-on 164/164]
 fs/btrfs/super.c:918:41: error: 'fs_info' undeclared; did you mean
 'qc_info'?
Message-ID: <202207271931.UabOC5c3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/kdave/btrfs-devel.git dev/async-discard-on
head:   3ee5caaf11a2ab543b93da9bf106e7ba9d9cd530
commit: 3ee5caaf11a2ab543b93da9bf106e7ba9d9cd530 [164/164] auto enable discard=async
config: arc-randconfig-r043-20220724 (https://download.01.org/0day-ci/archive/20220727/202207271931.UabOC5c3-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/kdave/btrfs-devel/commit/3ee5caaf11a2ab543b93da9bf106e7ba9d9cd530
        git remote add kdave-btrfs-devel https://github.com/kdave/btrfs-devel.git
        git fetch --no-tags kdave-btrfs-devel dev/async-discard-on
        git checkout 3ee5caaf11a2ab543b93da9bf106e7ba9d9cd530
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from fs/btrfs/delayed-inode.h:17,
                    from fs/btrfs/super.c:29:
   fs/btrfs/super.c: In function 'btrfs_parse_options':
>> fs/btrfs/super.c:918:41: error: 'fs_info' undeclared (first use in this function); did you mean 'qc_info'?
     918 |                         btrfs_clear_opt(fs_info->mount_opt, NODISCARD);
         |                                         ^~~~~~~
   fs/btrfs/ctree.h:1512:43: note: in definition of macro 'btrfs_clear_opt'
    1512 | #define btrfs_clear_opt(o, opt)         ((o) &= ~BTRFS_MOUNT_##opt)
         |                                           ^
   fs/btrfs/super.c:918:41: note: each undeclared identifier is reported only once for each function it appears in
     918 |                         btrfs_clear_opt(fs_info->mount_opt, NODISCARD);
         |                                         ^~~~~~~
   fs/btrfs/ctree.h:1512:43: note: in definition of macro 'btrfs_clear_opt'
    1512 | #define btrfs_clear_opt(o, opt)         ((o) &= ~BTRFS_MOUNT_##opt)
         |                                           ^
--
   In file included from fs/btrfs/disk-io.c:22:
   fs/btrfs/disk-io.c: In function 'open_ctree':
>> fs/btrfs/disk-io.c:3777:15: error: implicit declaration of function 'btrfs_test_opt' [-Werror=implicit-function-declaration]
    3777 |               btrfs_test_opt(fs_info, NODISCARD))) &&
         |               ^~~~~~~~~~~~~~
   fs/btrfs/ctree.h:1516:56: note: in definition of macro 'btrfs_test_opt'
    1516 |                                          BTRFS_MOUNT_##opt)
         |                                                        ^~~
>> fs/btrfs/disk-io.c:3777:39: error: 'NODISCARD' undeclared (first use in this function); did you mean 'BLKDISCARD'?
    3777 |               btrfs_test_opt(fs_info, NODISCARD))) &&
         |                                       ^~~~~~~~~
   fs/btrfs/ctree.h:1516:56: note: in definition of macro 'btrfs_test_opt'
    1516 |                                          BTRFS_MOUNT_##opt)
         |                                                        ^~~
   fs/btrfs/disk-io.c:3777:39: note: each undeclared identifier is reported only once for each function it appears in
    3777 |               btrfs_test_opt(fs_info, NODISCARD))) &&
         |                                       ^~~~~~~~~
   fs/btrfs/ctree.h:1516:56: note: in definition of macro 'btrfs_test_opt'
    1516 |                                          BTRFS_MOUNT_##opt)
         |                                                        ^~~
>> fs/btrfs/ctree.h:1512:46: error: invalid operands to binary & (have 'struct btrfs_fs_info *' and 'unsigned int')
    1512 | #define btrfs_clear_opt(o, opt)         ((o) &= ~BTRFS_MOUNT_##opt)
         |                                              ^~
   fs/btrfs/disk-io.c:3781:15: note: in expansion of macro 'btrfs_clear_opt'
    3781 |               btrfs_clear_opt(fs_info, NODISCARD);
         |               ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +918 fs/btrfs/super.c

   610	
   611	/*
   612	 * Regular mount options parser.  Everything that is needed only when
   613	 * reading in a new superblock is parsed here.
   614	 * XXX JDM: This needs to be cleaned up for remount.
   615	 */
   616	int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
   617				unsigned long new_flags)
   618	{
   619		substring_t args[MAX_OPT_ARGS];
   620		char *p, *num;
   621		int intarg;
   622		int ret = 0;
   623		char *compress_type;
   624		bool compress_force = false;
   625		enum btrfs_compression_type saved_compress_type;
   626		int saved_compress_level;
   627		bool saved_compress_force;
   628		int no_compress = 0;
   629	
   630		if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE))
   631			btrfs_set_opt(info->mount_opt, FREE_SPACE_TREE);
   632		else if (btrfs_free_space_cache_v1_active(info)) {
   633			if (btrfs_is_zoned(info)) {
   634				btrfs_info(info,
   635				"zoned: clearing existing space cache");
   636				btrfs_set_super_cache_generation(info->super_copy, 0);
   637			} else {
   638				btrfs_set_opt(info->mount_opt, SPACE_CACHE);
   639			}
   640		}
   641	
   642		/*
   643		 * Even the options are empty, we still need to do extra check
   644		 * against new flags
   645		 */
   646		if (!options)
   647			goto check;
   648	
   649		while ((p = strsep(&options, ",")) != NULL) {
   650			int token;
   651			if (!*p)
   652				continue;
   653	
   654			token = match_token(p, tokens, args);
   655			switch (token) {
   656			case Opt_degraded:
   657				btrfs_info(info, "allowing degraded mounts");
   658				btrfs_set_opt(info->mount_opt, DEGRADED);
   659				break;
   660			case Opt_subvol:
   661			case Opt_subvol_empty:
   662			case Opt_subvolid:
   663			case Opt_device:
   664				/*
   665				 * These are parsed by btrfs_parse_subvol_options or
   666				 * btrfs_parse_device_options and can be ignored here.
   667				 */
   668				break;
   669			case Opt_nodatasum:
   670				btrfs_set_and_info(info, NODATASUM,
   671						   "setting nodatasum");
   672				break;
   673			case Opt_datasum:
   674				if (btrfs_test_opt(info, NODATASUM)) {
   675					if (btrfs_test_opt(info, NODATACOW))
   676						btrfs_info(info,
   677							   "setting datasum, datacow enabled");
   678					else
   679						btrfs_info(info, "setting datasum");
   680				}
   681				btrfs_clear_opt(info->mount_opt, NODATACOW);
   682				btrfs_clear_opt(info->mount_opt, NODATASUM);
   683				break;
   684			case Opt_nodatacow:
   685				if (!btrfs_test_opt(info, NODATACOW)) {
   686					if (!btrfs_test_opt(info, COMPRESS) ||
   687					    !btrfs_test_opt(info, FORCE_COMPRESS)) {
   688						btrfs_info(info,
   689							   "setting nodatacow, compression disabled");
   690					} else {
   691						btrfs_info(info, "setting nodatacow");
   692					}
   693				}
   694				btrfs_clear_opt(info->mount_opt, COMPRESS);
   695				btrfs_clear_opt(info->mount_opt, FORCE_COMPRESS);
   696				btrfs_set_opt(info->mount_opt, NODATACOW);
   697				btrfs_set_opt(info->mount_opt, NODATASUM);
   698				break;
   699			case Opt_datacow:
   700				btrfs_clear_and_info(info, NODATACOW,
   701						     "setting datacow");
   702				break;
   703			case Opt_compress_force:
   704			case Opt_compress_force_type:
   705				compress_force = true;
   706				fallthrough;
   707			case Opt_compress:
   708			case Opt_compress_type:
   709				saved_compress_type = btrfs_test_opt(info,
   710								     COMPRESS) ?
   711					info->compress_type : BTRFS_COMPRESS_NONE;
   712				saved_compress_force =
   713					btrfs_test_opt(info, FORCE_COMPRESS);
   714				saved_compress_level = info->compress_level;
   715				if (token == Opt_compress ||
   716				    token == Opt_compress_force ||
   717				    strncmp(args[0].from, "zlib", 4) == 0) {
   718					compress_type = "zlib";
   719	
   720					info->compress_type = BTRFS_COMPRESS_ZLIB;
   721					info->compress_level = BTRFS_ZLIB_DEFAULT_LEVEL;
   722					/*
   723					 * args[0] contains uninitialized data since
   724					 * for these tokens we don't expect any
   725					 * parameter.
   726					 */
   727					if (token != Opt_compress &&
   728					    token != Opt_compress_force)
   729						info->compress_level =
   730						  btrfs_compress_str2level(
   731								BTRFS_COMPRESS_ZLIB,
   732								args[0].from + 4);
   733					btrfs_set_opt(info->mount_opt, COMPRESS);
   734					btrfs_clear_opt(info->mount_opt, NODATACOW);
   735					btrfs_clear_opt(info->mount_opt, NODATASUM);
   736					no_compress = 0;
   737				} else if (strncmp(args[0].from, "lzo", 3) == 0) {
   738					compress_type = "lzo";
   739					info->compress_type = BTRFS_COMPRESS_LZO;
   740					info->compress_level = 0;
   741					btrfs_set_opt(info->mount_opt, COMPRESS);
   742					btrfs_clear_opt(info->mount_opt, NODATACOW);
   743					btrfs_clear_opt(info->mount_opt, NODATASUM);
   744					btrfs_set_fs_incompat(info, COMPRESS_LZO);
   745					no_compress = 0;
   746				} else if (strncmp(args[0].from, "zstd", 4) == 0) {
   747					compress_type = "zstd";
   748					info->compress_type = BTRFS_COMPRESS_ZSTD;
   749					info->compress_level =
   750						btrfs_compress_str2level(
   751								 BTRFS_COMPRESS_ZSTD,
   752								 args[0].from + 4);
   753					btrfs_set_opt(info->mount_opt, COMPRESS);
   754					btrfs_clear_opt(info->mount_opt, NODATACOW);
   755					btrfs_clear_opt(info->mount_opt, NODATASUM);
   756					btrfs_set_fs_incompat(info, COMPRESS_ZSTD);
   757					no_compress = 0;
   758				} else if (strncmp(args[0].from, "no", 2) == 0) {
   759					compress_type = "no";
   760					info->compress_level = 0;
   761					info->compress_type = 0;
   762					btrfs_clear_opt(info->mount_opt, COMPRESS);
   763					btrfs_clear_opt(info->mount_opt, FORCE_COMPRESS);
   764					compress_force = false;
   765					no_compress++;
   766				} else {
   767					btrfs_err(info, "unrecognized compression value %s",
   768						  args[0].from);
   769					ret = -EINVAL;
   770					goto out;
   771				}
   772	
   773				if (compress_force) {
   774					btrfs_set_opt(info->mount_opt, FORCE_COMPRESS);
   775				} else {
   776					/*
   777					 * If we remount from compress-force=xxx to
   778					 * compress=xxx, we need clear FORCE_COMPRESS
   779					 * flag, otherwise, there is no way for users
   780					 * to disable forcible compression separately.
   781					 */
   782					btrfs_clear_opt(info->mount_opt, FORCE_COMPRESS);
   783				}
   784				if (no_compress == 1) {
   785					btrfs_info(info, "use no compression");
   786				} else if ((info->compress_type != saved_compress_type) ||
   787					   (compress_force != saved_compress_force) ||
   788					   (info->compress_level != saved_compress_level)) {
   789					btrfs_info(info, "%s %s compression, level %d",
   790						   (compress_force) ? "force" : "use",
   791						   compress_type, info->compress_level);
   792				}
   793				compress_force = false;
   794				break;
   795			case Opt_ssd:
   796				btrfs_set_and_info(info, SSD,
   797						   "enabling ssd optimizations");
   798				btrfs_clear_opt(info->mount_opt, NOSSD);
   799				break;
   800			case Opt_ssd_spread:
   801				btrfs_set_and_info(info, SSD,
   802						   "enabling ssd optimizations");
   803				btrfs_set_and_info(info, SSD_SPREAD,
   804						   "using spread ssd allocation scheme");
   805				btrfs_clear_opt(info->mount_opt, NOSSD);
   806				break;
   807			case Opt_nossd:
   808				btrfs_set_opt(info->mount_opt, NOSSD);
   809				btrfs_clear_and_info(info, SSD,
   810						     "not using ssd optimizations");
   811				fallthrough;
   812			case Opt_nossd_spread:
   813				btrfs_clear_and_info(info, SSD_SPREAD,
   814						     "not using spread ssd allocation scheme");
   815				break;
   816			case Opt_barrier:
   817				btrfs_clear_and_info(info, NOBARRIER,
   818						     "turning on barriers");
   819				break;
   820			case Opt_nobarrier:
   821				btrfs_set_and_info(info, NOBARRIER,
   822						   "turning off barriers");
   823				break;
   824			case Opt_thread_pool:
   825				ret = match_int(&args[0], &intarg);
   826				if (ret) {
   827					btrfs_err(info, "unrecognized thread_pool value %s",
   828						  args[0].from);
   829					goto out;
   830				} else if (intarg == 0) {
   831					btrfs_err(info, "invalid value 0 for thread_pool");
   832					ret = -EINVAL;
   833					goto out;
   834				}
   835				info->thread_pool_size = intarg;
   836				break;
   837			case Opt_max_inline:
   838				num = match_strdup(&args[0]);
   839				if (num) {
   840					info->max_inline = memparse(num, NULL);
   841					kfree(num);
   842	
   843					if (info->max_inline) {
   844						info->max_inline = min_t(u64,
   845							info->max_inline,
   846							info->sectorsize);
   847					}
   848					btrfs_info(info, "max_inline at %llu",
   849						   info->max_inline);
   850				} else {
   851					ret = -ENOMEM;
   852					goto out;
   853				}
   854				break;
   855			case Opt_acl:
   856	#ifdef CONFIG_BTRFS_FS_POSIX_ACL
   857				info->sb->s_flags |= SB_POSIXACL;
   858				break;
   859	#else
   860				btrfs_err(info, "support for ACL not compiled in!");
   861				ret = -EINVAL;
   862				goto out;
   863	#endif
   864			case Opt_noacl:
   865				info->sb->s_flags &= ~SB_POSIXACL;
   866				break;
   867			case Opt_notreelog:
   868				btrfs_set_and_info(info, NOTREELOG,
   869						   "disabling tree log");
   870				break;
   871			case Opt_treelog:
   872				btrfs_clear_and_info(info, NOTREELOG,
   873						     "enabling tree log");
   874				break;
   875			case Opt_norecovery:
   876			case Opt_nologreplay:
   877				btrfs_warn(info,
   878			"'nologreplay' is deprecated, use 'rescue=nologreplay' instead");
   879				btrfs_set_and_info(info, NOLOGREPLAY,
   880						   "disabling log replay at mount time");
   881				break;
   882			case Opt_flushoncommit:
   883				btrfs_set_and_info(info, FLUSHONCOMMIT,
   884						   "turning on flush-on-commit");
   885				break;
   886			case Opt_noflushoncommit:
   887				btrfs_clear_and_info(info, FLUSHONCOMMIT,
   888						     "turning off flush-on-commit");
   889				break;
   890			case Opt_ratio:
   891				ret = match_int(&args[0], &intarg);
   892				if (ret) {
   893					btrfs_err(info, "unrecognized metadata_ratio value %s",
   894						  args[0].from);
   895					goto out;
   896				}
   897				info->metadata_ratio = intarg;
   898				btrfs_info(info, "metadata ratio %u",
   899					   info->metadata_ratio);
   900				break;
   901			case Opt_discard:
   902			case Opt_discard_mode:
   903				if (token == Opt_discard ||
   904				    strcmp(args[0].from, "sync") == 0) {
   905					btrfs_clear_opt(info->mount_opt, DISCARD_ASYNC);
   906					btrfs_set_and_info(info, DISCARD_SYNC,
   907							   "turning on sync discard");
   908				} else if (strcmp(args[0].from, "async") == 0) {
   909					btrfs_clear_opt(info->mount_opt, DISCARD_SYNC);
   910					btrfs_set_and_info(info, DISCARD_ASYNC,
   911							   "turning on async discard");
   912				} else {
   913					btrfs_err(info, "unrecognized discard mode value %s",
   914						  args[0].from);
   915					ret = -EINVAL;
   916					goto out;
   917				}
 > 918				btrfs_clear_opt(fs_info->mount_opt, NODISCARD);
   919				break;
   920			case Opt_nodiscard:
   921				btrfs_clear_and_info(info, DISCARD_SYNC,
   922						     "turning off discard");
   923				btrfs_clear_and_info(info, DISCARD_ASYNC,
   924						     "turning off async discard");
   925				btrfs_set_opt(fs_info->mount_opt, NODISCARD);
   926				break;
   927			case Opt_space_cache:
   928			case Opt_space_cache_version:
   929				/*
   930				 * We already set FREE_SPACE_TREE above because we have
   931				 * compat_ro(FREE_SPACE_TREE) set, and we aren't going
   932				 * to allow v1 to be set for extent tree v2, simply
   933				 * ignore this setting if we're extent tree v2.
   934				 */
   935				if (btrfs_fs_incompat(info, EXTENT_TREE_V2))
   936					break;
   937				if (token == Opt_space_cache ||
   938				    strcmp(args[0].from, "v1") == 0) {
   939					btrfs_clear_opt(info->mount_opt,
   940							FREE_SPACE_TREE);
   941					btrfs_set_and_info(info, SPACE_CACHE,
   942						   "enabling disk space caching");
   943				} else if (strcmp(args[0].from, "v2") == 0) {
   944					btrfs_clear_opt(info->mount_opt,
   945							SPACE_CACHE);
   946					btrfs_set_and_info(info, FREE_SPACE_TREE,
   947							   "enabling free space tree");
   948				} else {
   949					btrfs_err(info, "unrecognized space_cache value %s",
   950						  args[0].from);
   951					ret = -EINVAL;
   952					goto out;
   953				}
   954				break;
   955			case Opt_rescan_uuid_tree:
   956				btrfs_set_opt(info->mount_opt, RESCAN_UUID_TREE);
   957				break;
   958			case Opt_no_space_cache:
   959				/*
   960				 * We cannot operate without the free space tree with
   961				 * extent tree v2, ignore this option.
   962				 */
   963				if (btrfs_fs_incompat(info, EXTENT_TREE_V2))
   964					break;
   965				if (btrfs_test_opt(info, SPACE_CACHE)) {
   966					btrfs_clear_and_info(info, SPACE_CACHE,
   967						     "disabling disk space caching");
   968				}
   969				if (btrfs_test_opt(info, FREE_SPACE_TREE)) {
   970					btrfs_clear_and_info(info, FREE_SPACE_TREE,
   971						     "disabling free space tree");
   972				}
   973				break;
   974			case Opt_inode_cache:
   975			case Opt_noinode_cache:
   976				btrfs_warn(info,
   977		"the 'inode_cache' option is deprecated and has no effect since 5.11");
   978				break;
   979			case Opt_clear_cache:
   980				/*
   981				 * We cannot clear the free space tree with extent tree
   982				 * v2, ignore this option.
   983				 */
   984				if (btrfs_fs_incompat(info, EXTENT_TREE_V2))
   985					break;
   986				btrfs_set_and_info(info, CLEAR_CACHE,
   987						   "force clearing of disk cache");
   988				break;
   989			case Opt_user_subvol_rm_allowed:
   990				btrfs_set_opt(info->mount_opt, USER_SUBVOL_RM_ALLOWED);
   991				break;
   992			case Opt_enospc_debug:
   993				btrfs_set_opt(info->mount_opt, ENOSPC_DEBUG);
   994				break;
   995			case Opt_noenospc_debug:
   996				btrfs_clear_opt(info->mount_opt, ENOSPC_DEBUG);
   997				break;
   998			case Opt_defrag:
   999				btrfs_set_and_info(info, AUTO_DEFRAG,
  1000						   "enabling auto defrag");
  1001				break;
  1002			case Opt_nodefrag:
  1003				btrfs_clear_and_info(info, AUTO_DEFRAG,
  1004						     "disabling auto defrag");
  1005				break;
  1006			case Opt_recovery:
  1007			case Opt_usebackuproot:
  1008				btrfs_warn(info,
  1009				"'%s' is deprecated, use 'rescue=usebackuproot' instead",
  1010					   token == Opt_recovery ? "recovery" :
  1011					   "usebackuproot");
  1012				btrfs_info(info,
  1013					   "trying to use backup root at mount time");
  1014				btrfs_set_opt(info->mount_opt, USEBACKUPROOT);
  1015				break;
  1016			case Opt_skip_balance:
  1017				btrfs_set_opt(info->mount_opt, SKIP_BALANCE);
  1018				break;
  1019	#ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
  1020			case Opt_check_integrity_including_extent_data:
  1021				btrfs_info(info,
  1022					   "enabling check integrity including extent data");
  1023				btrfs_set_opt(info->mount_opt, CHECK_INTEGRITY_DATA);
  1024				btrfs_set_opt(info->mount_opt, CHECK_INTEGRITY);
  1025				break;
  1026			case Opt_check_integrity:
  1027				btrfs_info(info, "enabling check integrity");
  1028				btrfs_set_opt(info->mount_opt, CHECK_INTEGRITY);
  1029				break;
  1030			case Opt_check_integrity_print_mask:
  1031				ret = match_int(&args[0], &intarg);
  1032				if (ret) {
  1033					btrfs_err(info,
  1034					"unrecognized check_integrity_print_mask value %s",
  1035						args[0].from);
  1036					goto out;
  1037				}
  1038				info->check_integrity_print_mask = intarg;
  1039				btrfs_info(info, "check_integrity_print_mask 0x%x",
  1040					   info->check_integrity_print_mask);
  1041				break;
  1042	#else
  1043			case Opt_check_integrity_including_extent_data:
  1044			case Opt_check_integrity:
  1045			case Opt_check_integrity_print_mask:
  1046				btrfs_err(info,
  1047					  "support for check_integrity* not compiled in!");
  1048				ret = -EINVAL;
  1049				goto out;
  1050	#endif
  1051			case Opt_fatal_errors:
  1052				if (strcmp(args[0].from, "panic") == 0) {
  1053					btrfs_set_opt(info->mount_opt,
  1054						      PANIC_ON_FATAL_ERROR);
  1055				} else if (strcmp(args[0].from, "bug") == 0) {
  1056					btrfs_clear_opt(info->mount_opt,
  1057						      PANIC_ON_FATAL_ERROR);
  1058				} else {
  1059					btrfs_err(info, "unrecognized fatal_errors value %s",
  1060						  args[0].from);
  1061					ret = -EINVAL;
  1062					goto out;
  1063				}
  1064				break;
  1065			case Opt_commit_interval:
  1066				intarg = 0;
  1067				ret = match_int(&args[0], &intarg);
  1068				if (ret) {
  1069					btrfs_err(info, "unrecognized commit_interval value %s",
  1070						  args[0].from);
  1071					ret = -EINVAL;
  1072					goto out;
  1073				}
  1074				if (intarg == 0) {
  1075					btrfs_info(info,
  1076						   "using default commit interval %us",
  1077						   BTRFS_DEFAULT_COMMIT_INTERVAL);
  1078					intarg = BTRFS_DEFAULT_COMMIT_INTERVAL;
  1079				} else if (intarg > 300) {
  1080					btrfs_warn(info, "excessive commit interval %d",
  1081						   intarg);
  1082				}
  1083				info->commit_interval = intarg;
  1084				break;
  1085			case Opt_rescue:
  1086				ret = parse_rescue_options(info, args[0].from);
  1087				if (ret < 0) {
  1088					btrfs_err(info, "unrecognized rescue value %s",
  1089						  args[0].from);
  1090					goto out;
  1091				}
  1092				break;
  1093	#ifdef CONFIG_BTRFS_DEBUG
  1094			case Opt_fragment_all:
  1095				btrfs_info(info, "fragmenting all space");
  1096				btrfs_set_opt(info->mount_opt, FRAGMENT_DATA);
  1097				btrfs_set_opt(info->mount_opt, FRAGMENT_METADATA);
  1098				break;
  1099			case Opt_fragment_metadata:
  1100				btrfs_info(info, "fragmenting metadata");
  1101				btrfs_set_opt(info->mount_opt,
  1102					      FRAGMENT_METADATA);
  1103				break;
  1104			case Opt_fragment_data:
  1105				btrfs_info(info, "fragmenting data");
  1106				btrfs_set_opt(info->mount_opt, FRAGMENT_DATA);
  1107				break;
  1108	#endif
  1109	#ifdef CONFIG_BTRFS_FS_REF_VERIFY
  1110			case Opt_ref_verify:
  1111				btrfs_info(info, "doing ref verification");
  1112				btrfs_set_opt(info->mount_opt, REF_VERIFY);
  1113				break;
  1114	#endif
  1115			case Opt_err:
  1116				btrfs_err(info, "unrecognized mount option '%s'", p);
  1117				ret = -EINVAL;
  1118				goto out;
  1119			default:
  1120				break;
  1121			}
  1122		}
  1123	check:
  1124		/* We're read-only, don't have to check. */
  1125		if (new_flags & SB_RDONLY)
  1126			goto out;
  1127	
  1128		if (check_ro_option(info, BTRFS_MOUNT_NOLOGREPLAY, "nologreplay") ||
  1129		    check_ro_option(info, BTRFS_MOUNT_IGNOREBADROOTS, "ignorebadroots") ||
  1130		    check_ro_option(info, BTRFS_MOUNT_IGNOREDATACSUMS, "ignoredatacsums"))
  1131			ret = -EINVAL;
  1132	out:
  1133		if (btrfs_fs_compat_ro(info, FREE_SPACE_TREE) &&
  1134		    !btrfs_test_opt(info, FREE_SPACE_TREE) &&
  1135		    !btrfs_test_opt(info, CLEAR_CACHE)) {
  1136			btrfs_err(info, "cannot disable free space tree");
  1137			ret = -EINVAL;
  1138	
  1139		}
  1140		if (!ret)
  1141			ret = btrfs_check_mountopts_zoned(info);
  1142		if (!ret && btrfs_test_opt(info, SPACE_CACHE))
  1143			btrfs_info(info, "disk space caching is enabled");
  1144		if (!ret && btrfs_test_opt(info, FREE_SPACE_TREE))
  1145			btrfs_info(info, "using free space tree");
  1146		return ret;
  1147	}
  1148	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
