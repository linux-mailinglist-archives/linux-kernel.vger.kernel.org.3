Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6238A54510B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344546AbiFIPjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbiFIPjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:39:42 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F4C2D29CB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 08:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654789181; x=1686325181;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=CkhFu+0fJMswsoDKiILJAXd3k8ep/ipGRYH4uQLu3rc=;
  b=YZOA3weBQw2hdCMe29mrk2fXuzzCY7y4bPwBItNSOfA6S5QRIsWOEypA
   hB9dJPJZGxP9VxrOF0zFAwFKIytvHUNNBl0/kORtEphgEHlh2yek6uY+X
   i6Rn77E2XG12v3yjJ3IjaVySNQ793C1x9OwXAl0d69NPQX5FlRenodI95
   AvzoBS7LjBa8AZXhF6xkpOjvPAiYAmv57qg8kXXcQfYxs3HO9j1UiROa7
   8oQ+ANQDa88PfrcczOK4+jnfSymY7EhH+6+9cfKjTlhQ9hboUAB2mWIoq
   OGMdY1wR0rL23JY6CuREFi4IIk45y88PM+vT9CN4BBJ7Iois5JrAeu3Tk
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="266099859"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="266099859"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 08:39:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="671368319"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jun 2022 08:39:39 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzKG2-000G7V-Fj;
        Thu, 09 Jun 2022 15:39:38 +0000
Date:   Thu, 9 Jun 2022 23:39:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Kari Argillander <kari.argillander@gmail.com>
Subject: [linux-stable-rc:queue/5.15 1/112] fs/ntfs3/xattr.c:684:12: error:
 redefinition of 'ntfs_xattr_get_acl'
Message-ID: <202206092357.sMCUOMZm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/5.15
head:   160dcf43b181822e124054c0ec05acb0e1c473e4
commit: fde9576bccfe1dcaf4b0ed729570a74d9bd485f7 [1/112] fs/ntfs3: Restore ntfs_xattr_get_acl and ntfs_xattr_set_acl functions
config: arm64-randconfig-r012-20220609 (https://download.01.org/0day-ci/archive/20220609/202206092357.sMCUOMZm-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 971e13d69e3e7b687213fef22952be6a328c426c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=fde9576bccfe1dcaf4b0ed729570a74d9bd485f7
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/5.15
        git checkout fde9576bccfe1dcaf4b0ed729570a74d9bd485f7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash fs/ntfs3/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/ntfs3/xattr.c:684:12: error: redefinition of 'ntfs_xattr_get_acl'
   static int ntfs_xattr_get_acl(struct user_namespace *mnt_userns,
              ^
   fs/ntfs3/xattr.c:623:12: note: previous definition is here
   static int ntfs_xattr_get_acl(struct user_namespace *mnt_userns,
              ^
>> fs/ntfs3/xattr.c:709:12: error: redefinition of 'ntfs_xattr_set_acl'
   static int ntfs_xattr_set_acl(struct user_namespace *mnt_userns,
              ^
   fs/ntfs3/xattr.c:648:12: note: previous definition is here
   static int ntfs_xattr_set_acl(struct user_namespace *mnt_userns,
              ^
   2 errors generated.


vim +/ntfs_xattr_get_acl +684 fs/ntfs3/xattr.c

   683	
 > 684	static int ntfs_xattr_get_acl(struct user_namespace *mnt_userns,
   685				      struct inode *inode, int type, void *buffer,
   686				      size_t size)
   687	{
   688		struct posix_acl *acl;
   689		int err;
   690	
   691		if (!(inode->i_sb->s_flags & SB_POSIXACL)) {
   692			ntfs_inode_warn(inode, "add mount option \"acl\" to use acl");
   693			return -EOPNOTSUPP;
   694		}
   695	
   696		acl = ntfs_get_acl(inode, type, false);
   697		if (IS_ERR(acl))
   698			return PTR_ERR(acl);
   699	
   700		if (!acl)
   701			return -ENODATA;
   702	
   703		err = posix_acl_to_xattr(mnt_userns, acl, buffer, size);
   704		posix_acl_release(acl);
   705	
   706		return err;
   707	}
   708	
 > 709	static int ntfs_xattr_set_acl(struct user_namespace *mnt_userns,
   710				      struct inode *inode, int type, const void *value,
   711				      size_t size)
   712	{
   713		struct posix_acl *acl;
   714		int err;
   715	
   716		if (!(inode->i_sb->s_flags & SB_POSIXACL)) {
   717			ntfs_inode_warn(inode, "add mount option \"acl\" to use acl");
   718			return -EOPNOTSUPP;
   719		}
   720	
   721		if (!inode_owner_or_capable(mnt_userns, inode))
   722			return -EPERM;
   723	
   724		if (!value) {
   725			acl = NULL;
   726		} else {
   727			acl = posix_acl_from_xattr(mnt_userns, value, size);
   728			if (IS_ERR(acl))
   729				return PTR_ERR(acl);
   730	
   731			if (acl) {
   732				err = posix_acl_valid(mnt_userns, acl);
   733				if (err)
   734					goto release_and_out;
   735			}
   736		}
   737	
   738		err = ntfs_set_acl(mnt_userns, inode, acl, type);
   739	
   740	release_and_out:
   741		posix_acl_release(acl);
   742		return err;
   743	}
   744	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
