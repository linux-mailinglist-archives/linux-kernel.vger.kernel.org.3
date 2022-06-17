Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2231F54F516
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381725AbiFQKOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381719AbiFQKOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:14:36 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580E669716
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 03:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655460875; x=1686996875;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lwtGDgL2YUQVqHYSSjpLd7IM+/rgncZqOiGGX7isCDU=;
  b=LL++V2SFXvR8Er1Hy9/KJeu0zuWJoU9NOh1iQKBpSusbtIpXBVgopiYL
   Shf7sxbPstp9s1hs6DUB5n95nPozuEfOTxQEcUWHpMkphcXf97y55cD68
   agEnrsKd0epZk8Nax54skMfJKp3moBEmeXsaukSshWpNypLI15x7gH9DC
   +L7Z08mtYE5cJvZ42xwk5Bdw0S68OY9sxdKSdpAUNkyCp4qcuiJgW5Mse
   YGownnNYGVtOlRm+4l8u88gtejcNtNDq1sbRRTF4ztaEHW6Thti8It3ov
   5Hw+m8/9UZo6lOZJqR/OzKFuTj7jcE3UxMNDFggBg5/4qDG2vkEXZP833
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="268162410"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="268162410"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 03:11:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="675440956"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jun 2022 03:11:38 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o28x0-000PLv-47;
        Fri, 17 Jun 2022 10:11:38 +0000
Date:   Fri, 17 Jun 2022 18:11:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matthew Auld <matthew.auld@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Dominik Behr <dbehr@chromium.org>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>
Subject: [jsarha:topic/cros-sof-v4.14 721/9354] mm/shmem.c:4284:14: warning:
 no previous declaration for 'shmem_file_setup_with_mnt'
Message-ID: <202206171849.CWMWuyjV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

FYI, the error/warning still remains.

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.14
head:   6f750b16c322c9191168a3a97c427c90581d9144
commit: e29409586a0344a13ac2258d76df738f10772cff [721/9354] UPSTREAM: mm/shmem: introduce shmem_file_setup_with_mnt
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20220617/202206171849.CWMWuyjV-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://github.com/jsarha/linux/commit/e29409586a0344a13ac2258d76df738f10772cff
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/cros-sof-v4.14
        git checkout e29409586a0344a13ac2258d76df738f10772cff
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   mm/shmem.c:4133:12: warning: no previous declaration for 'shmem_init' [-Wmissing-declarations]
    int __init shmem_init(void)
               ^~~~~~~~~~
   mm/shmem.c:4143:5: warning: no previous declaration for 'shmem_unuse' [-Wmissing-declarations]
    int shmem_unuse(swp_entry_t swap, struct page *page)
        ^~~~~~~~~~~
   mm/shmem.c:4148:5: warning: no previous declaration for 'shmem_lock' [-Wmissing-declarations]
    int shmem_lock(struct file *file, int lock, struct user_struct *user)
        ^~~~~~~~~~
   mm/shmem.c:4153:6: warning: no previous declaration for 'shmem_unlock_mapping' [-Wmissing-declarations]
    void shmem_unlock_mapping(struct address_space *mapping)
         ^~~~~~~~~~~~~~~~~~~~
   mm/shmem.c:4158:15: warning: no previous declaration for 'shmem_get_unmapped_area' [-Wmissing-declarations]
    unsigned long shmem_get_unmapped_area(struct file *file,
                  ^~~~~~~~~~~~~~~~~~~~~~~
   mm/shmem.c:4166:6: warning: no previous declaration for 'shmem_truncate_range' [-Wmissing-declarations]
    void shmem_truncate_range(struct inode *inode, loff_t lstart, loff_t lend)
         ^~~~~~~~~~~~~~~~~~~~
   mm/shmem.c:4252:14: warning: no previous declaration for 'shmem_kernel_file_setup' [-Wmissing-declarations]
    struct file *shmem_kernel_file_setup(const char *name, loff_t size, unsigned long flags)
                 ^~~~~~~~~~~~~~~~~~~~~~~
   mm/shmem.c:4263:14: warning: no previous declaration for 'shmem_file_setup' [-Wmissing-declarations]
    struct file *shmem_file_setup(const char *name, loff_t size, unsigned long flags)
                 ^~~~~~~~~~~~~~~~
>> mm/shmem.c:4284:14: warning: no previous declaration for 'shmem_file_setup_with_mnt' [-Wmissing-declarations]
    struct file *shmem_file_setup_with_mnt(struct vfsmount *mnt, const char *name,
                 ^~~~~~~~~~~~~~~~~~~~~~~~~
   mm/shmem.c:4295:5: warning: no previous declaration for 'shmem_zero_setup' [-Wmissing-declarations]
    int shmem_zero_setup(struct vm_area_struct *vma)
        ^~~~~~~~~~~~~~~~
   mm/shmem.c:4336:14: warning: no previous declaration for 'shmem_read_mapping_page_gfp' [-Wmissing-declarations]
    struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/shmem_file_setup_with_mnt +4284 mm/shmem.c

  4165	
> 4166	void shmem_truncate_range(struct inode *inode, loff_t lstart, loff_t lend)
  4167	{
  4168		truncate_inode_pages_range(inode->i_mapping, lstart, lend);
  4169	}
  4170	EXPORT_SYMBOL_GPL(shmem_truncate_range);
  4171	
  4172	#define shmem_vm_ops				generic_file_vm_ops
  4173	#define shmem_file_operations			ramfs_file_operations
  4174	#define shmem_get_inode(sb, dir, mode, dev, flags)	ramfs_get_inode(sb, dir, mode, dev)
  4175	#define shmem_acct_size(flags, size)		0
  4176	#define shmem_unacct_size(flags, size)		do {} while (0)
  4177	
  4178	#endif /* CONFIG_SHMEM */
  4179	
  4180	/* common code */
  4181	
  4182	static const struct dentry_operations anon_ops = {
  4183		.d_dname = simple_dname
  4184	};
  4185	
  4186	static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name, loff_t size,
  4187					       unsigned long flags, unsigned int i_flags)
  4188	{
  4189		struct file *res;
  4190		struct inode *inode;
  4191		struct path path;
  4192		struct super_block *sb;
  4193		struct qstr this;
  4194	
  4195		if (IS_ERR(mnt))
  4196			return ERR_CAST(mnt);
  4197	
  4198		if (size < 0 || size > MAX_LFS_FILESIZE)
  4199			return ERR_PTR(-EINVAL);
  4200	
  4201		if (shmem_acct_size(flags, size))
  4202			return ERR_PTR(-ENOMEM);
  4203	
  4204		res = ERR_PTR(-ENOMEM);
  4205		this.name = name;
  4206		this.len = strlen(name);
  4207		this.hash = 0; /* will go */
  4208		sb = mnt->mnt_sb;
  4209		path.mnt = mntget(mnt);
  4210		path.dentry = d_alloc_pseudo(sb, &this);
  4211		if (!path.dentry)
  4212			goto put_memory;
  4213		d_set_d_op(path.dentry, &anon_ops);
  4214	
  4215		res = ERR_PTR(-ENOSPC);
  4216		inode = shmem_get_inode(sb, NULL, S_IFREG | S_IRWXUGO, 0, flags);
  4217		if (!inode)
  4218			goto put_memory;
  4219	
  4220		inode->i_flags |= i_flags;
  4221		d_instantiate(path.dentry, inode);
  4222		inode->i_size = size;
  4223		clear_nlink(inode);	/* It is unlinked */
  4224		res = ERR_PTR(ramfs_nommu_expand_for_mapping(inode, size));
  4225		if (IS_ERR(res))
  4226			goto put_path;
  4227	
  4228		res = alloc_file(&path, FMODE_WRITE | FMODE_READ,
  4229			  &shmem_file_operations);
  4230		if (IS_ERR(res))
  4231			goto put_path;
  4232	
  4233		return res;
  4234	
  4235	put_memory:
  4236		shmem_unacct_size(flags, size);
  4237	put_path:
  4238		path_put(&path);
  4239		return res;
  4240	}
  4241	
  4242	/**
  4243	 * shmem_kernel_file_setup - get an unlinked file living in tmpfs which must be
  4244	 * 	kernel internal.  There will be NO LSM permission checks against the
  4245	 * 	underlying inode.  So users of this interface must do LSM checks at a
  4246	 *	higher layer.  The users are the big_key and shm implementations.  LSM
  4247	 *	checks are provided at the key or shm level rather than the inode.
  4248	 * @name: name for dentry (to be seen in /proc/<pid>/maps
  4249	 * @size: size to be set for the file
  4250	 * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size
  4251	 */
  4252	struct file *shmem_kernel_file_setup(const char *name, loff_t size, unsigned long flags)
  4253	{
  4254		return __shmem_file_setup(shm_mnt, name, size, flags, S_PRIVATE);
  4255	}
  4256	
  4257	/**
  4258	 * shmem_file_setup - get an unlinked file living in tmpfs
  4259	 * @name: name for dentry (to be seen in /proc/<pid>/maps
  4260	 * @size: size to be set for the file
  4261	 * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size
  4262	 */
  4263	struct file *shmem_file_setup(const char *name, loff_t size, unsigned long flags)
  4264	{
  4265		return __shmem_file_setup(shm_mnt, name, size, flags, 0);
  4266	}
  4267	EXPORT_SYMBOL_GPL(shmem_file_setup);
  4268	
  4269	void shmem_set_file(struct vm_area_struct *vma, struct file *file)
  4270	{
  4271		if (vma->vm_file)
  4272			fput(vma->vm_file);
  4273		vma->vm_file = file;
  4274		vma->vm_ops = &shmem_vm_ops;
  4275	}
  4276	
  4277	/**
  4278	 * shmem_file_setup_with_mnt - get an unlinked file living in tmpfs
  4279	 * @mnt: the tmpfs mount where the file will be created
  4280	 * @name: name for dentry (to be seen in /proc/<pid>/maps
  4281	 * @size: size to be set for the file
  4282	 * @flags: VM_NORESERVE suppresses pre-accounting of the entire object size
  4283	 */
> 4284	struct file *shmem_file_setup_with_mnt(struct vfsmount *mnt, const char *name,
  4285					       loff_t size, unsigned long flags)
  4286	{
  4287		return __shmem_file_setup(mnt, name, size, flags, 0);
  4288	}
  4289	EXPORT_SYMBOL_GPL(shmem_file_setup_with_mnt);
  4290	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
