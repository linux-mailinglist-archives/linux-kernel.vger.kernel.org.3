Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A63D4D294D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiCIHNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiCIHM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:12:57 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614BF1081B3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 23:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646809919; x=1678345919;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=M48WQ1VdLf6ReFI/U9jDn3CFilIzAHEjcRYKH8tp1K0=;
  b=dYXlhNbwUOFRMsPbacXQo6gwuOxM3qMN4GQ60pelUO7Rcq8vUZ/4nwDk
   /V1UqbQcd8/1piRtnh8kLGqPTaWCkhgibmcTu9n+VdRkLAliTPllfPprW
   hATVvFin7RwPBMFKgI6ttWNiPAjhskVWIq0Dnv6Jz2rUvNgxg7amM9LOG
   Kns/GAOItoE+LXAI2rQWU+xNdfZEJHilLr/MpegEAUz6ulwevf1k0867I
   MkOZjxxukVMoXrmAOSFn2mklCo/YYclvKNJvQDSZ1MB+Y0ghbRAm4OTay
   k0nz8ReDNFjBDXc+zd2AZsxhC+QoYYHV9aJRzsg1u5yNlNtKNnmn2Gq4A
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="242351043"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="242351043"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 23:11:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="711842655"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 08 Mar 2022 23:11:57 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRqUG-0002ok-LT; Wed, 09 Mar 2022 07:11:56 +0000
Date:   Wed, 9 Mar 2022 15:11:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Lawrence <paullawrence@google.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android13-5.10
 9998/9999] fs/fuse/backing.c:955:27: warning: cast to pointer from integer
 of different size
Message-ID: <202203091504.1hJGsrgr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android13-5.10
head:   5da5b1871950c71755fa5a0b88c78e2f2623da24
commit: 8efdff35e3052e44d519ccfb9d50594f5df0240b [9998/9999] ANDROID: fuse-bpf: Move fd operations to be synchronous
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220309/202203091504.1hJGsrgr-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/8efdff35e3052e44d519ccfb9d50594f5df0240b
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android13-5.10
        git checkout 8efdff35e3052e44d519ccfb9d50594f5df0240b
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/fuse/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/fuse/backing.c: In function 'fuse_lookup_finalize':
>> fs/fuse/backing.c:955:27: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     955 |   struct file *bpf_file = (struct file*) febo->bpf_fd;
         |                           ^
   fs/fuse/backing.c:988:18: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     988 |   backing_file = (struct file *) febo->backing_fd;
         |                  ^
   fs/fuse/backing.c:984:21: warning: variable 'fc' set but not used [-Wunused-but-set-variable]
     984 |   struct fuse_conn *fc;
         |                     ^~
   fs/fuse/backing.c: In function 'fuse_statfs_initialize':
   fs/fuse/backing.c:1771:18: warning: initialized field overwritten [-Woverride-init]
    1771 |   .out_numargs = 1,
         |                  ^
   fs/fuse/backing.c:1771:18: note: (near initialization for '(anonymous).out_numargs')


vim +955 fs/fuse/backing.c

   911	
   912	struct dentry *fuse_lookup_finalize(struct fuse_args *fa, struct inode *dir,
   913				   struct dentry *entry, unsigned int flags)
   914	{
   915		struct fuse_dentry *fd;
   916		struct dentry *bd;
   917		struct inode *inode, *backing_inode;
   918		struct fuse_entry_out *feo = fa->out_args[0].value;
   919		struct fuse_entry_bpf_out *febo = fa->out_args[1].value;
   920	
   921		fd = get_fuse_dentry(entry);
   922		if (!fd)
   923			return ERR_PTR(-EIO);
   924		bd = fd->backing_path.dentry;
   925		if (!bd)
   926			return ERR_PTR(-ENOENT);
   927		backing_inode = bd->d_inode;
   928		if (!backing_inode)
   929			return 0;
   930	
   931		inode = fuse_iget_backing(dir->i_sb, backing_inode);
   932	
   933		if (IS_ERR(inode))
   934			return ERR_PTR(PTR_ERR(inode));
   935	
   936		/* TODO Make sure this handles invalid handles */
   937		/* TODO Do we need the same code in revalidate */
   938		if (get_fuse_inode(inode)->bpf) {
   939			bpf_prog_put(get_fuse_inode(inode)->bpf);
   940			get_fuse_inode(inode)->bpf = NULL;
   941		}
   942	
   943		switch (febo->bpf_action) {
   944		case FUSE_ACTION_KEEP:
   945			get_fuse_inode(inode)->bpf = get_fuse_inode(dir)->bpf;
   946			if (get_fuse_inode(inode)->bpf)
   947				bpf_prog_inc(get_fuse_inode(inode)->bpf);
   948			break;
   949	
   950		case FUSE_ACTION_REMOVE:
   951			get_fuse_inode(inode)->bpf = NULL;
   952			break;
   953	
   954		case FUSE_ACTION_REPLACE: {
 > 955			struct file *bpf_file = (struct file*) febo->bpf_fd;
   956			struct bpf_prog *bpf_prog = ERR_PTR(-EINVAL);
   957	
   958			if (bpf_file && !IS_ERR(bpf_file))
   959				bpf_prog = fuse_get_bpf_prog(bpf_file);
   960	
   961			if (IS_ERR(bpf_prog))
   962				return ERR_PTR(PTR_ERR(bpf_prog));
   963	
   964			get_fuse_inode(inode)->bpf = bpf_prog;
   965			break;
   966		}
   967	
   968		default:
   969			return ERR_PTR(-EIO);
   970		}
   971	
   972		switch (febo->backing_action) {
   973		case FUSE_ACTION_KEEP:
   974			/* backing inode/path are added in fuse_lookup_backing */
   975			break;
   976	
   977		case FUSE_ACTION_REMOVE:
   978			iput(get_fuse_inode(inode)->backing_inode);
   979			get_fuse_inode(inode)->backing_inode = NULL;
   980			path_put_init(&get_fuse_dentry(entry)->backing_path);
   981			break;
   982	
   983		case FUSE_ACTION_REPLACE: {
   984			struct fuse_conn *fc;
   985			struct file *backing_file;
   986	
   987			fc = get_fuse_mount(dir)->fc;
   988			backing_file = (struct file *) febo->backing_fd;
   989			if (!backing_file || IS_ERR(backing_file))
   990				return ERR_PTR(-EIO);
   991	
   992			iput(get_fuse_inode(inode)->backing_inode);
   993			get_fuse_inode(inode)->backing_inode =
   994				backing_file->f_inode;
   995			ihold(get_fuse_inode(inode)->backing_inode);
   996	
   997			path_put(&get_fuse_dentry(entry)->backing_path);
   998			get_fuse_dentry(entry)->backing_path = backing_file->f_path;
   999			path_get(&get_fuse_dentry(entry)->backing_path);
  1000	
  1001			fput(backing_file);
  1002			break;
  1003		}
  1004	
  1005		default:
  1006			return ERR_PTR(-EIO);
  1007		}
  1008	
  1009		get_fuse_inode(inode)->nodeid = feo->nodeid;
  1010	
  1011		return d_splice_alias(inode, entry);
  1012	}
  1013	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
