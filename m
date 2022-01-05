Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36AA1484D30
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 05:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237408AbiAEE5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 23:57:30 -0500
Received: from mga01.intel.com ([192.55.52.88]:13873 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237365AbiAEE51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 23:57:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641358647; x=1672894647;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8uyC2vch32X4Wc+eINYD3wir9dFmEKqRBh3GPaSZioI=;
  b=n5lPZTjpWgq7ru7bps7GTOhT41ZoRJ6NP6+jU0huKtCCTKTjKudNjLwi
   Gq1+ih0kePxW+iI/pAOEZbMrUbvAiRS9ynUW7DG2yDsrpxWjzs2i5M0I2
   7exz6l8dqsVvFrG9wV7S5Gu0z0zm5AI/7E6snMOnDmrNVH9b6n+CvlPt8
   wrk7wQc3qTc7/+Lus64+gy6nuuDxea79oU/iOiQhtUTErmTe5z9vrO4EU
   Hhp01JS/jBk+Pfcma+vRPxlL7wC80g8DcjuLPJ9AS2rgBBgN8fyOaZo5v
   hNNGGrelALTqEkKCZuiVvx1sccHXImwAyT0eLdKi7ebhupUNFUsZogJwH
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="266642139"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="266642139"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 20:57:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="688842182"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 04 Jan 2022 20:57:25 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n4yMW-000GFB-Qy; Wed, 05 Jan 2022 04:57:24 +0000
Date:   Wed, 5 Jan 2022 12:56:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [brauner:fs.idmapped.ceph.v1 2/13] fs/ceph/mds_client.c:867:17:
 error: implicit declaration of function 'put_user_ns'; did you mean
 'mnt_user_ns'?
Message-ID: <202201051208.bhHC5D02-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git fs.idmapped.ceph.v1
head:   30a5a5c4f340adfbb605745447b34b792289674e
commit: 8fa98c6cdae01551392c9fe50e02ff941b8cedec [2/13] ceph: stash idmapping in mdsc request
config: arm-randconfig-c002-20220105 (https://download.01.org/0day-ci/archive/20220105/202201051208.bhHC5D02-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/commit/?id=8fa98c6cdae01551392c9fe50e02ff941b8cedec
        git remote add brauner https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
        git fetch --no-tags brauner fs.idmapped.ceph.v1
        git checkout 8fa98c6cdae01551392c9fe50e02ff941b8cedec
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash fs/ceph/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/ceph/mds_client.c: In function 'ceph_mdsc_release_request':
>> fs/ceph/mds_client.c:867:17: error: implicit declaration of function 'put_user_ns'; did you mean 'mnt_user_ns'? [-Werror=implicit-function-declaration]
     867 |                 put_user_ns(req->mnt_userns);
         |                 ^~~~~~~~~~~
         |                 mnt_user_ns
   fs/ceph/mds_client.c: In function '__register_request':
>> fs/ceph/mds_client.c:927:17: error: implicit declaration of function 'get_user_ns'; did you mean 'seq_user_ns'? [-Werror=implicit-function-declaration]
     927 |                 get_user_ns(req->mnt_userns);
         |                 ^~~~~~~~~~~
         |                 seq_user_ns
   cc1: some warnings being treated as errors


vim +867 fs/ceph/mds_client.c

   827	
   828	void ceph_mdsc_release_request(struct kref *kref)
   829	{
   830		struct ceph_mds_request *req = container_of(kref,
   831							    struct ceph_mds_request,
   832							    r_kref);
   833		ceph_mdsc_release_dir_caps_no_check(req);
   834		destroy_reply_info(&req->r_reply_info);
   835		if (req->r_request)
   836			ceph_msg_put(req->r_request);
   837		if (req->r_reply)
   838			ceph_msg_put(req->r_reply);
   839		if (req->r_inode) {
   840			ceph_put_cap_refs(ceph_inode(req->r_inode), CEPH_CAP_PIN);
   841			iput(req->r_inode);
   842		}
   843		if (req->r_parent) {
   844			ceph_put_cap_refs(ceph_inode(req->r_parent), CEPH_CAP_PIN);
   845			iput(req->r_parent);
   846		}
   847		iput(req->r_target_inode);
   848		if (req->r_dentry)
   849			dput(req->r_dentry);
   850		if (req->r_old_dentry)
   851			dput(req->r_old_dentry);
   852		if (req->r_old_dentry_dir) {
   853			/*
   854			 * track (and drop pins for) r_old_dentry_dir
   855			 * separately, since r_old_dentry's d_parent may have
   856			 * changed between the dir mutex being dropped and
   857			 * this request being freed.
   858			 */
   859			ceph_put_cap_refs(ceph_inode(req->r_old_dentry_dir),
   860					  CEPH_CAP_PIN);
   861			iput(req->r_old_dentry_dir);
   862		}
   863		kfree(req->r_path1);
   864		kfree(req->r_path2);
   865		put_cred(req->r_cred);
   866		if (!initial_idmapping(req->mnt_userns))
 > 867			put_user_ns(req->mnt_userns);
   868		if (req->r_pagelist)
   869			ceph_pagelist_release(req->r_pagelist);
   870		put_request_session(req);
   871		ceph_unreserve_caps(req->r_mdsc, &req->r_caps_reservation);
   872		WARN_ON_ONCE(!list_empty(&req->r_wait));
   873		kmem_cache_free(ceph_mds_request_cachep, req);
   874	}
   875	
   876	DEFINE_RB_FUNCS(request, struct ceph_mds_request, r_tid, r_node)
   877	
   878	/*
   879	 * lookup session, bump ref if found.
   880	 *
   881	 * called under mdsc->mutex.
   882	 */
   883	static struct ceph_mds_request *
   884	lookup_get_request(struct ceph_mds_client *mdsc, u64 tid)
   885	{
   886		struct ceph_mds_request *req;
   887	
   888		req = lookup_request(&mdsc->request_tree, tid);
   889		if (req)
   890			ceph_mdsc_get_request(req);
   891	
   892		return req;
   893	}
   894	
   895	/*
   896	 * Register an in-flight request, and assign a tid.  Link to directory
   897	 * are modifying (if any).
   898	 *
   899	 * Called under mdsc->mutex.
   900	 */
   901	static void __register_request(struct ceph_mds_client *mdsc,
   902				       struct ceph_mds_request *req,
   903				       struct inode *dir)
   904	{
   905		int ret = 0;
   906	
   907		req->r_tid = ++mdsc->last_tid;
   908		if (req->r_num_caps) {
   909			ret = ceph_reserve_caps(mdsc, &req->r_caps_reservation,
   910						req->r_num_caps);
   911			if (ret < 0) {
   912				pr_err("__register_request %p "
   913				       "failed to reserve caps: %d\n", req, ret);
   914				/* set req->r_err to fail early from __do_request */
   915				req->r_err = ret;
   916				return;
   917			}
   918		}
   919		dout("__register_request %p tid %lld\n", req, req->r_tid);
   920		ceph_mdsc_get_request(req);
   921		insert_request(&mdsc->request_tree, req);
   922	
   923		req->r_cred = get_current_cred();
   924		if (!req->mnt_userns)
   925			req->mnt_userns = &init_user_ns;
   926		else
 > 927			get_user_ns(req->mnt_userns);
   928	
   929		if (mdsc->oldest_tid == 0 && req->r_op != CEPH_MDS_OP_SETFILELOCK)
   930			mdsc->oldest_tid = req->r_tid;
   931	
   932		if (dir) {
   933			struct ceph_inode_info *ci = ceph_inode(dir);
   934	
   935			ihold(dir);
   936			req->r_unsafe_dir = dir;
   937			spin_lock(&ci->i_unsafe_lock);
   938			list_add_tail(&req->r_unsafe_dir_item, &ci->i_unsafe_dirops);
   939			spin_unlock(&ci->i_unsafe_lock);
   940		}
   941	}
   942	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
