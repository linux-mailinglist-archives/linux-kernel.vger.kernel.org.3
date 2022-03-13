Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7254D7518
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 13:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbiCMMDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 08:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiCMMDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 08:03:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657DC106618
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 05:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647172921; x=1678708921;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4SRHZuX/eV2gOdC6RCH3ANjbmHhZl4jM6hxYVQo8gOQ=;
  b=N96KoG5LQ1dgZ2mZaNXA5W+Pa8TTe4xRBeffhCDGgTfOwhOaFIiqLXRb
   YOtwj35QvP0sLstl3yhz+FpBKcq/HieBsvLowJz8WUgxzWAPn4WO7628f
   VI4mSUIcdWy/PAgXUPfOqG6iGIQwL+2cQ6Z+PkZ04pH5qgdqnC4FyR/b1
   JsDRgW4El9CgQjQUelE3sL6nkfogBcp4y5psDbsXTMghoYp062A80Dwpo
   177t944Rlg5bWs0JT55xRly4BE1KVEI8ajJjKws3RaweDJmu91liQA39s
   jaWkafCF57ogipFaT/6c0NVNI8pD/KWKcleHw0itfvDDTdtLe7P3m44PU
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="243310973"
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="243310973"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 05:01:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="515086042"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 13 Mar 2022 05:01:57 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTMv6-0008vY-AM; Sun, 13 Mar 2022 12:01:56 +0000
Date:   Sun, 13 Mar 2022 20:00:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:tls-upcall.v4 141/156]
 drivers/nvme/host/tcp.c:674:7: warning: variable 'map' is uninitialized when
 used here
Message-ID: <202203131914.rJjnMLih-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git tls-upcall.v4
head:   d2416ecdb6b03fc2e4aa40b20cdf919322713224
commit: fb16aba001d4b403be727c8dd379da6e3dbf56e4 [141/156] nvme-tcp: decode c2h term PDU
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220313/202203131914.rJjnMLih-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0467eb2cb7654c15ae366967ef35093c5724c416)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=fb16aba001d4b403be727c8dd379da6e3dbf56e4
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel tls-upcall.v4
        git checkout fb16aba001d4b403be727c8dd379da6e3dbf56e4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/nvme/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/nvme/host/tcp.c:674:7: warning: variable 'map' is uninitialized when used here [-Wuninitialized]
                   if (map[i].fes == pdu->fes) {
                       ^~~
   drivers/nvme/host/tcp.c:668:28: note: initialize the variable 'map' to silence this warning
           struct fes_status_map *map;
                                     ^
                                      = NULL
   1 warning generated.


vim +/map +674 drivers/nvme/host/tcp.c

   663	
   664	static int nvme_tcp_handle_c2h_term(struct nvme_tcp_queue *queue,
   665			struct nvme_tcp_term_pdu *pdu)
   666	{
   667		struct nvme_tcp_hdr *ref_pdu;
   668		struct fes_status_map *map;
   669		const char *fes_desc = NULL;
   670		int i;
   671		u32 pdu_offset;
   672	
   673		for (i = 0; i < ARRAY_SIZE(fes_status); i++) {
 > 674			if (map[i].fes == pdu->fes) {
   675				fes_desc = map[i].desc;
   676				break;
   677			}
   678		}
   679		if (!fes_desc)
   680			fes_desc = "unknown fatal error status";
   681	
   682		if (pdu->hdr.plen > sizeof(struct nvme_tcp_term_pdu))
   683			ref_pdu = (struct nvme_tcp_hdr *)((u8 *)pdu + 1);
   684	
   685		if (pdu->fes == NVME_TCP_FES_INVALID_PDU_HDR ||
   686		    pdu->fes == NVME_TCP_FES_HDR_DIGEST_ERR ||
   687		    pdu->fes == NVME_TCP_FES_UNSUPPORTED_PARAM) {
   688			pdu_offset = le32_to_cpu(pdu->fei);
   689	
   690			dev_err(queue->ctrl->ctrl.device,
   691				"queue %d c2h term, %s, pdu type %u offset %u\n",
   692				nvme_tcp_queue_id(queue), fes_desc, ref_pdu->type, pdu_offset);
   693		} else
   694			dev_err(queue->ctrl->ctrl.device,
   695				"queue %d c2h term, %s, pdu type %u\n",
   696				nvme_tcp_queue_id(queue), fes_desc, ref_pdu->type);
   697	
   698		return -ECONNRESET;
   699	}
   700	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
