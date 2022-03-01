Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BCF4C7F00
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 01:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiCAAFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 19:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiCAAFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 19:05:18 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760AE5AA6F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 16:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646093079; x=1677629079;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fs16qROJziMdRMRTERy2lXxPgvaE31c12efp0vSyn+c=;
  b=TRnJbTf4mnfOqN22IxY3dt/y3RR5C0wSgQgpiBcg1p1/erDByNhwiR9o
   frfH7l0LTq63EGZnPi0If+XJ7oCx3HriJue+QtgmCJhf1yKFDry9uK0cM
   jY/IXVNDmSlULnAIlqfNzJdFafSnFjiJ2ZSrS4ICHTeb/X6ruHcHaDEMl
   O7AqKBf8dxoKlQRsr6xvMObqczaOOciIcMP0LI7xNmv1GaEJPW7RKl10X
   +kw3nl8bwBk1fwjqk4jIpQj0TGEVAvFxfCEW6khRU/gkneQSfzFbDg8qc
   V/W1fsvfty7jjCcXMIY7Xa9oWtIlSLFy+SKSOQsgifcCz6kUycMCV3n0I
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="277680134"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="277680134"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 16:04:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="492910902"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Feb 2022 16:04:37 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOq0K-0007v9-R2; Tue, 01 Mar 2022 00:04:36 +0000
Date:   Tue, 1 Mar 2022 08:04:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [amir73il:sb_iostats 6/8] fs/proc_namespace.c:243:9: error: 'struct
 super_block' has no member named 's_iostats'
Message-ID: <202203010741.SK3KjyE8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/amir73il/linux sb_iostats
head:   ecfdb413f2105083296e9cb45290eb1f01b0ef5c
commit: df9b63258be710a78278da75d11cfe0cbaa8ca74 [6/8] fs: report per-sb io stats
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220301/202203010741.SK3KjyE8-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/amir73il/linux/commit/df9b63258be710a78278da75d11cfe0cbaa8ca74
        git remote add amir73il https://github.com/amir73il/linux
        git fetch --no-tags amir73il sb_iostats
        git checkout df9b63258be710a78278da75d11cfe0cbaa8ca74
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/proc_namespace.c: In function 'show_vfsstat':
>> fs/proc_namespace.c:243:9: error: 'struct super_block' has no member named 's_iostats'
     243 |       sb->s_iostats.start_time, ktime_get_seconds(),
         |         ^~


vim +243 fs/proc_namespace.c

   196	
   197	static int show_vfsstat(struct seq_file *m, struct vfsmount *mnt)
   198	{
   199		struct proc_mounts *p = m->private;
   200		struct mount *r = real_mount(mnt);
   201		struct path mnt_path = { .dentry = mnt->mnt_root, .mnt = mnt };
   202		struct super_block *sb = mnt_path.dentry->d_sb;
   203		int err;
   204	
   205		/* device */
   206		if (sb->s_op->show_devname) {
   207			seq_puts(m, "device ");
   208			err = sb->s_op->show_devname(m, mnt_path.dentry);
   209			if (err)
   210				goto out;
   211		} else {
   212			if (r->mnt_devname) {
   213				seq_puts(m, "device ");
   214				mangle(m, r->mnt_devname);
   215			} else
   216				seq_puts(m, "no device");
   217		}
   218	
   219		/* mount point */
   220		seq_puts(m, " mounted on ");
   221		/* mountpoints outside of chroot jail will give SEQ_SKIP on this */
   222		err = seq_path_root(m, &mnt_path, &p->root, " \t\n\\");
   223		if (err)
   224			goto out;
   225		seq_putc(m, ' ');
   226	
   227		/* file system type */
   228		seq_puts(m, "with fstype ");
   229		show_type(m, sb);
   230	
   231		/* optional statistics */
   232		if (sb->s_op->show_stats) {
   233			seq_putc(m, ' ');
   234			err = sb->s_op->show_stats(m, mnt_path.dentry);
   235		} else if (sb_has_iostats(sb)) {
   236			/* Similar to /proc/<pid>/io */
   237			seq_printf(m, "\n"
   238				   "\ttimes: %lld %lld\n"
   239				   "\trchar: %lld\n"
   240				   "\twchar: %lld\n"
   241				   "\tsyscr: %lld\n"
   242				   "\tsyscw: %lld\n",
 > 243				   sb->s_iostats.start_time, ktime_get_seconds(),
   244				   sb_iostats_counter_read(sb, SB_IOSTATS_CHARS_RD),
   245				   sb_iostats_counter_read(sb, SB_IOSTATS_CHARS_WR),
   246				   sb_iostats_counter_read(sb, SB_IOSTATS_SYSCALLS_RD),
   247				   sb_iostats_counter_read(sb, SB_IOSTATS_SYSCALLS_WR));
   248		}
   249	
   250		seq_putc(m, '\n');
   251	out:
   252		return err;
   253	}
   254	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
