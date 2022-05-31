Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E122538B99
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 08:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244383AbiEaGxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 02:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244378AbiEaGxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 02:53:04 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F78939FA
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 23:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653979982; x=1685515982;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ma44jTROXQUBIJvV7UIVSeUgWdRfrebXzqj5X6VLvO8=;
  b=naHeEerfj/puzaRQeIk3DmJnl1qjw7gbBNtuBG5R0tJHEhM0XAQ3M8KW
   c2LwUkg7xgYwXDmBb7VHpldLBViuJZrNx/Lezz9YLqbMexgrq8af4595y
   WYJ48EJA1c6utkxMeeDMmwb7s779ycX4cIcPiZl61vugdbnIxqbap6EXK
   xOpWhoEggW2Ijw/NmU1uyvWnbkznXdlf8595pSlWQg1iz127NubqIjO9V
   odH1GGKbOLFqWTTj1N49tAFs7cAnP+b/968cpJo2EeJdM4dyd0q8mMPTQ
   T7Sywa5H8mna3++P5NWHi4MIzovMDa6887k9ybZj4VLuiUJjmvL0JYonV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="361535472"
X-IronPort-AV: E=Sophos;i="5.91,264,1647327600"; 
   d="scan'208";a="361535472"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 23:53:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,264,1647327600"; 
   d="scan'208";a="529448406"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 30 May 2022 23:52:59 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvvkR-0002RQ-6m;
        Tue, 31 May 2022 06:52:59 +0000
Date:   Tue, 31 May 2022 14:52:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [hare-scsi-devel:auth.v13 8/9]
 drivers/nvme/target/fabrics-cmd-auth.c:364:30: sparse: sparse: incorrect
 type in assignment (different base types)
Message-ID: <202205311440.ymt1kZQE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git auth.v13
head:   a444c5289874c2a619b92858d240a7cf40c9874b
commit: 830cde52659a9c803beaa86a353ee8209a1f0767 [8/9] nvmet-auth: Diffie-Hellman key exchange support
config: arm-randconfig-s032-20220531 (https://download.01.org/0day-ci/archive/20220531/202205311440.ymt1kZQE-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-14-g5a0004b5-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=830cde52659a9c803beaa86a353ee8209a1f0767
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel auth.v13
        git checkout 830cde52659a9c803beaa86a353ee8209a1f0767
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/nvme/target/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/nvme/target/fabrics-cmd-auth.c:20:30: sparse: sparse: invalid assignment: |=
   drivers/nvme/target/fabrics-cmd-auth.c:20:30: sparse:    left side has type restricted __le32
   drivers/nvme/target/fabrics-cmd-auth.c:20:30: sparse:    right side has type int
   drivers/nvme/target/fabrics-cmd-auth.c:102:22: sparse: sparse: cast to restricted __le32
   drivers/nvme/target/fabrics-cmd-auth.c:102:22: sparse: sparse: cast from restricted __le16
>> drivers/nvme/target/fabrics-cmd-auth.c:364:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] dhvlen @@     got restricted __le32 [usertype] @@
   drivers/nvme/target/fabrics-cmd-auth.c:364:30: sparse:     expected restricted __le16 [usertype] dhvlen
   drivers/nvme/target/fabrics-cmd-auth.c:364:30: sparse:     got restricted __le32 [usertype]

vim +364 drivers/nvme/target/fabrics-cmd-auth.c

   333	
   334	static int nvmet_auth_challenge(struct nvmet_req *req, void *d, int al)
   335	{
   336		struct nvmf_auth_dhchap_challenge_data *data = d;
   337		struct nvmet_ctrl *ctrl = req->sq->ctrl;
   338		int ret = 0;
   339		int hash_len = nvme_auth_hmac_hash_len(ctrl->shash_id);
   340		int data_size = sizeof(*d) + hash_len;
   341	
   342		if (ctrl->dh_tfm)
   343			data_size += ctrl->dh_keysize;
   344		if (al < data_size) {
   345			pr_debug("%s: buffer too small (al %d need %d)\n", __func__,
   346				 al, data_size);
   347			return -EINVAL;
   348		}
   349		memset(data, 0, data_size);
   350		req->sq->dhchap_s1 = nvme_auth_get_seqnum();
   351		data->auth_type = NVME_AUTH_DHCHAP_MESSAGES;
   352		data->auth_id = NVME_AUTH_DHCHAP_MESSAGE_CHALLENGE;
   353		data->t_id = cpu_to_le16(req->sq->dhchap_tid);
   354		data->hashid = ctrl->shash_id;
   355		data->hl = hash_len;
   356		data->seqnum = cpu_to_le32(req->sq->dhchap_s1);
   357		req->sq->dhchap_c1 = kmalloc(data->hl, GFP_KERNEL);
   358		if (!req->sq->dhchap_c1)
   359			return -ENOMEM;
   360		get_random_bytes(req->sq->dhchap_c1, data->hl);
   361		memcpy(data->cval, req->sq->dhchap_c1, data->hl);
   362		if (ctrl->dh_tfm) {
   363			data->dhgid = ctrl->dh_gid;
 > 364			data->dhvlen = cpu_to_le32(ctrl->dh_keysize);
   365			ret = nvmet_auth_ctrl_exponential(req, data->cval + data->hl,
   366							  ctrl->dh_keysize);
   367		}
   368		pr_debug("%s: ctrl %d qid %d seq %d transaction %d hl %d dhvlen %zu\n",
   369			 __func__, ctrl->cntlid, req->sq->qid, req->sq->dhchap_s1,
   370			 req->sq->dhchap_tid, data->hl, ctrl->dh_keysize);
   371		return ret;
   372	}
   373	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
