Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5781850C45F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbiDVWvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbiDVWvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:51:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642531FE6C6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 15:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650665558; x=1682201558;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dDSBeP/lUlyAr949gMs0Q9rIp8ofm7cDToqyY7HRrkU=;
  b=dwUyEFA2Y09Bpnlp47mOznY1ziWmpY6A4iDy3JTBUlvUatStY8jCrCrI
   0cj1dK3sxT324lN+R16eNv8CqdgfG0WwNs2mTerYLBamHCq6JjYgzwsXO
   pF9CCuYhuCohWJZJ/Baax39orxgmjOnJCngitXV25kMuEhgf2xuXzGtxB
   /FBaj3c8/go1wPHQWTBH3Z3lY09+TvMWNDHZxq9zC84JQE37QuzCfW8DK
   q8Z89u9lxTc5BBxMS3IfJRbFocUDynLM/WCLVAFSUCHDe9IoFEFdxrC87
   E3K1OjykTcFMchAdBHswXI4siLE6KaLA4OBAoVK6iFCM77xK5RLzvnqfP
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264575344"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="264575344"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 15:11:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="868156020"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 22 Apr 2022 15:11:17 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ni1Ui-000Abm-WF;
        Fri, 22 Apr 2022 22:11:17 +0000
Date:   Sat, 23 Apr 2022 06:10:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: fs/nfsd/nfs4proc.c:1219:17: warning: 'strncpy' specified bound 63
 equals destination size
Message-ID: <202204230647.SqpJiwKQ-lkp@intel.com>
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

Hi Dai,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   281b9d9a4b02229b602a14f7540206b0fbe4134f
commit: f4e44b393389c77958f7c58bf4415032b4cda15b NFSD: delay unmount source's export after inter-server copy completed.
date:   11 months ago
config: openrisc-allmodconfig (https://download.01.org/0day-ci/archive/20220423/202204230647.SqpJiwKQ-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f4e44b393389c77958f7c58bf4415032b4cda15b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f4e44b393389c77958f7c58bf4415032b4cda15b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/usb/renesas_usbhs/ fs/nfsd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/nfsd/nfs4proc.c: In function 'nfsd4_ssc_setup_dul.constprop':
>> fs/nfsd/nfs4proc.c:1219:17: warning: 'strncpy' specified bound 63 equals destination size [-Wstringop-truncation]
    1219 |                 strncpy(work->nsui_ipaddr, ipaddr, sizeof(work->nsui_ipaddr));
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/strncpy +1219 fs/nfsd/nfs4proc.c

  1174	
  1175	/*
  1176	 * setup a work entry in the ssc delayed unmount list.
  1177	 */
  1178	static int nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
  1179			struct nfsd4_ssc_umount_item **retwork, struct vfsmount **ss_mnt)
  1180	{
  1181		struct nfsd4_ssc_umount_item *ni = 0;
  1182		struct nfsd4_ssc_umount_item *work = NULL;
  1183		struct nfsd4_ssc_umount_item *tmp;
  1184		DEFINE_WAIT(wait);
  1185	
  1186		*ss_mnt = NULL;
  1187		*retwork = NULL;
  1188		work = kzalloc(sizeof(*work), GFP_KERNEL);
  1189	try_again:
  1190		spin_lock(&nn->nfsd_ssc_lock);
  1191		list_for_each_entry_safe(ni, tmp, &nn->nfsd_ssc_mount_list, nsui_list) {
  1192			if (strncmp(ni->nsui_ipaddr, ipaddr, sizeof(ni->nsui_ipaddr)))
  1193				continue;
  1194			/* found a match */
  1195			if (ni->nsui_busy) {
  1196				/*  wait - and try again */
  1197				prepare_to_wait(&nn->nfsd_ssc_waitq, &wait,
  1198					TASK_INTERRUPTIBLE);
  1199				spin_unlock(&nn->nfsd_ssc_lock);
  1200	
  1201				/* allow 20secs for mount/unmount for now - revisit */
  1202				if (signal_pending(current) ||
  1203						(schedule_timeout(20*HZ) == 0)) {
  1204					kfree(work);
  1205					return nfserr_eagain;
  1206				}
  1207				finish_wait(&nn->nfsd_ssc_waitq, &wait);
  1208				goto try_again;
  1209			}
  1210			*ss_mnt = ni->nsui_vfsmount;
  1211			refcount_inc(&ni->nsui_refcnt);
  1212			spin_unlock(&nn->nfsd_ssc_lock);
  1213			kfree(work);
  1214	
  1215			/* return vfsmount in ss_mnt */
  1216			return 0;
  1217		}
  1218		if (work) {
> 1219			strncpy(work->nsui_ipaddr, ipaddr, sizeof(work->nsui_ipaddr));
  1220			refcount_set(&work->nsui_refcnt, 2);
  1221			work->nsui_busy = true;
  1222			list_add_tail(&work->nsui_list, &nn->nfsd_ssc_mount_list);
  1223			*retwork = work;
  1224		}
  1225		spin_unlock(&nn->nfsd_ssc_lock);
  1226		return 0;
  1227	}
  1228	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
