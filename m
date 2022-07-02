Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCFB563EEF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 09:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbiGBHco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 03:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiGBHcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 03:32:43 -0400
Received: from mga04.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905431A81F
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 00:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656747163; x=1688283163;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=//jnsheF+vgfl2gRCvaj79cBlgMZl3DNIMMr9h6hj1s=;
  b=T9LyqdRCjXp46+aZVyhqUpvxw7E3zNm8ykA8z0A6fXtJx0Jw8Xkf+W0E
   7/nV9c1c/Ruhw/ro95EV+Z9Ayv8DRMKmzkKxOIzFNXcPPInzebp2aSI4S
   WmyoVziqSZz0X4gdFmy826OluK+UHMr3r72SkUE2Pjch/Sp401wsj6VNZ
   FDmTjyWZSvUAU/63dWGwwI/V4hKYotb1GI3miFF4fhss8Mci5i/kJDNVa
   Zh5VrOEO8Dwcv8UB6QA8cBD6y4Kp9vs/tEsdGh6TtF6orpZLz08CiWeGq
   deyc/qxPaAlCji6TO0vtSUlAIJab94HuSnknZXHu7QLbWWMY+oNaphUvs
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="281563496"
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="281563496"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 00:32:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,239,1650956400"; 
   d="scan'208";a="734293994"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 02 Jul 2022 00:32:40 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7XcN-000Ewm-SX;
        Sat, 02 Jul 2022 07:32:39 +0000
Date:   Sat, 2 Jul 2022 15:31:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-linked-list 56/61]
 fs/afs/inode.c:927:23: warning: variable 'i_size' is uninitialized when used
 here
Message-ID: <202207021522.2iDOXk9X-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RDNS_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-linked-list
head:   ce4670495468b797b0c5927fcb661bc0da48b9ab
commit: b0af788660145c19754695953b240c9eaa311df8 [56/61] netfs: Implement truncation
config: riscv-randconfig-r001-20220629 (https://download.01.org/0day-ci/archive/20220702/202207021522.2iDOXk9X-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bcd153485ebf07fe79e2b843ed5f1cb74997df1b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/b0af788660145c19754695953b240c9eaa311df8
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-linked-list
        git checkout b0af788660145c19754695953b240c9eaa311df8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash fs/afs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/afs/inode.c:927:23: warning: variable 'i_size' is uninitialized when used here [-Wuninitialized]
                       attr->ia_size < i_size &&
                                       ^~~~~~
   fs/afs/inode.c:892:15: note: initialize the variable 'i_size' to silence this warning
           loff_t i_size;
                        ^
                         = 0
   1 warning generated.


vim +/i_size +927 fs/afs/inode.c

e49c7b2f6de7ff David Howells     2020-04-10  878  
31143d5d515ece David Howells     2007-05-09  879  /*
31143d5d515ece David Howells     2007-05-09  880   * set the attributes of an inode
31143d5d515ece David Howells     2007-05-09  881   */
549c7297717c32 Christian Brauner 2021-01-21  882  int afs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
549c7297717c32 Christian Brauner 2021-01-21  883  		struct iattr *attr)
31143d5d515ece David Howells     2007-05-09  884  {
0770bd4187c555 David Howells     2020-07-22  885  	const unsigned int supported =
0770bd4187c555 David Howells     2020-07-22  886  		ATTR_SIZE | ATTR_MODE | ATTR_UID | ATTR_GID |
0770bd4187c555 David Howells     2020-07-22  887  		ATTR_MTIME | ATTR_MTIME_SET | ATTR_TIMES_SET | ATTR_TOUCH;
b0af788660145c David Howells     2021-09-30  888  	struct netfs_io_request *treq = NULL;
e49c7b2f6de7ff David Howells     2020-04-10  889  	struct afs_operation *op;
2b0143b5c986be David Howells     2015-03-17  890  	struct afs_vnode *vnode = AFS_FS_I(d_inode(dentry));
874c8ca1e60b2c David Howells     2022-06-09  891  	struct inode *inode = &vnode->netfs.inode;
0770bd4187c555 David Howells     2020-07-22  892  	loff_t i_size;
793fe82ee33aab David Howells     2020-06-12  893  	int ret;
31143d5d515ece David Howells     2007-05-09  894  
3b6492df4153b8 David Howells     2018-10-20  895  	_enter("{%llx:%llu},{n=%pd},%x",
a455589f181e60 Al Viro           2014-10-21  896  	       vnode->fid.vid, vnode->fid.vnode, dentry,
31143d5d515ece David Howells     2007-05-09  897  	       attr->ia_valid);
31143d5d515ece David Howells     2007-05-09  898  
0770bd4187c555 David Howells     2020-07-22  899  	if (!(attr->ia_valid & supported)) {
31143d5d515ece David Howells     2007-05-09  900  		_leave(" = 0 [unsupported]");
31143d5d515ece David Howells     2007-05-09  901  		return 0;
31143d5d515ece David Howells     2007-05-09  902  	}
31143d5d515ece David Howells     2007-05-09  903  
523d27cda149cf David Howells     2020-02-06  904  	fscache_use_cookie(afs_vnode_cache(vnode), true);
523d27cda149cf David Howells     2020-02-06  905  
b0af788660145c David Howells     2021-09-30  906  	treq = netfs_prepare_to_truncate(dentry, attr);
b0af788660145c David Howells     2021-09-30  907  	if (IS_ERR(treq))
b0af788660145c David Howells     2021-09-30  908  		return PTR_ERR(treq);
b0af788660145c David Howells     2021-09-30  909  
ec0fa0b659144d David Howells     2020-10-07  910  	/* Prevent any new writebacks from starting whilst we do this. */
ec0fa0b659144d David Howells     2020-10-07  911  	down_write(&vnode->validate_lock);
ec0fa0b659144d David Howells     2020-10-07  912  
0770bd4187c555 David Howells     2020-07-22  913  	if ((attr->ia_valid & ATTR_SIZE) && S_ISREG(inode->i_mode)) {
0770bd4187c555 David Howells     2020-07-22  914  		loff_t size = attr->ia_size;
0770bd4187c555 David Howells     2020-07-22  915  
0770bd4187c555 David Howells     2020-07-22  916  		/* Wait for any outstanding writes to the server to complete */
0770bd4187c555 David Howells     2020-07-22  917  		loff_t from = min(size, i_size);
0770bd4187c555 David Howells     2020-07-22  918  		loff_t to = max(size, i_size);
0770bd4187c555 David Howells     2020-07-22  919  		ret = filemap_fdatawait_range(inode->i_mapping, from, to);
0770bd4187c555 David Howells     2020-07-22  920  		if (ret < 0)
0770bd4187c555 David Howells     2020-07-22  921  			goto out_unlock;
0770bd4187c555 David Howells     2020-07-22  922  
0770bd4187c555 David Howells     2020-07-22  923  		/* Don't talk to the server if we're just shortening in-memory
0770bd4187c555 David Howells     2020-07-22  924  		 * writes that haven't gone to the server yet.
0770bd4187c555 David Howells     2020-07-22  925  		 */
0770bd4187c555 David Howells     2020-07-22  926  		if (!(attr->ia_valid & (supported & ~ATTR_SIZE & ~ATTR_MTIME)) &&
0770bd4187c555 David Howells     2020-07-22 @927  		    attr->ia_size < i_size &&

:::::: The code at line 927 was first introduced by commit
:::::: 0770bd4187c555e6df087f7abc252eeacb0842ec afs: Skip truncation on the server of data we haven't written yet

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: David Howells <dhowells@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
