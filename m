Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFE64C57CE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 20:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbiBZTPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 14:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiBZTPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 14:15:42 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BC350069
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 11:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645902908; x=1677438908;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xlslgNYCAv4ByO3P33R5HhtBhn/vF0q4vSk8Knho6cA=;
  b=nCg8O2pm63YJ98Me0goc9MKa8rEzgb/GQhw/6V/QjxHQwcc7R6fJCKIO
   Qh69fB4rFhWjiuG5JvD55n99aAJoyqQCo/SoN+ypttLUqHLJbO1QZrR+W
   FN76Ijf7D+3Hg6FDH/F58GF4MXV0bJDIHiHMTHLyVYFVv5HCTp4HkO6sL
   bn/c5GpaMvw6+yWMJpxqQzmBJA70w8Sa8qBVs12rtjv5w6gb0xAp3i9Ma
   3AV1oDjQJdowr2lLMKfpjzmLAC4hYuamDS4f+1B8byAyouwSyiLVNwqfM
   LdV7U0CdBeCKIcXyBHWuGPeowaOIxWdkTvQ9kMtmdG0cn+/fec5KAhWRR
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10270"; a="251510628"
X-IronPort-AV: E=Sophos;i="5.90,139,1643702400"; 
   d="scan'208";a="251510628"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 11:15:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,139,1643702400"; 
   d="scan'208";a="684951373"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 26 Feb 2022 11:15:06 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nO2X4-0005sN-5C; Sat, 26 Feb 2022 19:15:06 +0000
Date:   Sun, 27 Feb 2022 03:14:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:tls-upcall.v2 157/159]
 drivers/nvme/host/tcp.c:678:7: warning: variable 'map' is uninitialized when
 used here
Message-ID: <202202262236.UVE9DltW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git tls-upcall.v2
head:   21b520ae0b338bd30496feb1ca90a2820dab7a65
commit: 294875f63a598198387eda2c7f5fc00c3ac94b7a [157/159] nvme-tcp: decode c2h term PDU
config: hexagon-randconfig-r023-20220226 (https://download.01.org/0day-ci/archive/20220226/202202262236.UVE9DltW-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=294875f63a598198387eda2c7f5fc00c3ac94b7a
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel tls-upcall.v2
        git checkout 294875f63a598198387eda2c7f5fc00c3ac94b7a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/nvme/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/nvme/host/tcp.c:678:7: warning: variable 'map' is uninitialized when used here [-Wuninitialized]
                   if (map[i].fes == pdu->fes) {
                       ^~~
   drivers/nvme/host/tcp.c:672:28: note: initialize the variable 'map' to silence this warning
           struct fes_status_map *map;
                                     ^
                                      = NULL
   drivers/nvme/host/tcp.c:1351:35: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
                    nvme_tcp_queue_id(queue), ret, iov.iov_len);
                                                   ^~~~~~~~~~~
   include/linux/printk.h:574:26: note: expanded from macro 'pr_debug'
           dynamic_pr_debug(fmt, ##__VA_ARGS__)
                            ~~~    ^~~~~~~~~~~
   include/linux/dynamic_debug.h:163:22: note: expanded from macro 'dynamic_pr_debug'
                              pr_fmt(fmt), ##__VA_ARGS__)
                                     ~~~     ^~~~~~~~~~~
   include/linux/dynamic_debug.h:152:56: note: expanded from macro '_dynamic_func_call'
           __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
                                                                 ^~~~~~~~~~~
   include/linux/dynamic_debug.h:134:15: note: expanded from macro '__dynamic_func_call'
                   func(&id, ##__VA_ARGS__);               \
                               ^~~~~~~~~~~
   drivers/nvme/host/tcp.c:1385:7: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
                                            iov.iov_len);
                                            ^~~~~~~~~~~
   include/linux/printk.h:574:26: note: expanded from macro 'pr_debug'
           dynamic_pr_debug(fmt, ##__VA_ARGS__)
                            ~~~    ^~~~~~~~~~~
   include/linux/dynamic_debug.h:163:22: note: expanded from macro 'dynamic_pr_debug'
                              pr_fmt(fmt), ##__VA_ARGS__)
                                     ~~~     ^~~~~~~~~~~
   include/linux/dynamic_debug.h:152:56: note: expanded from macro '_dynamic_func_call'
           __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
                                                                 ^~~~~~~~~~~
   include/linux/dynamic_debug.h:134:15: note: expanded from macro '__dynamic_func_call'
                   func(&id, ##__VA_ARGS__);               \
                               ^~~~~~~~~~~
   drivers/nvme/host/tcp.c:1400:35: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
                    nvme_tcp_queue_id(queue), ret, iov.iov_len);
                                                   ^~~~~~~~~~~
   include/linux/printk.h:574:26: note: expanded from macro 'pr_debug'
           dynamic_pr_debug(fmt, ##__VA_ARGS__)
                            ~~~    ^~~~~~~~~~~
   include/linux/dynamic_debug.h:163:22: note: expanded from macro 'dynamic_pr_debug'
                              pr_fmt(fmt), ##__VA_ARGS__)
                                     ~~~     ^~~~~~~~~~~
   include/linux/dynamic_debug.h:152:56: note: expanded from macro '_dynamic_func_call'
           __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
                                                                 ^~~~~~~~~~~
   include/linux/dynamic_debug.h:134:15: note: expanded from macro '__dynamic_func_call'
                   func(&id, ##__VA_ARGS__);               \
                               ^~~~~~~~~~~
   4 warnings generated.


vim +/map +678 drivers/nvme/host/tcp.c

   667	
   668	static int nvme_tcp_handle_c2h_term(struct nvme_tcp_queue *queue,
   669			struct nvme_tcp_term_pdu *pdu)
   670	{
   671		struct nvme_tcp_hdr *ref_pdu;
   672		struct fes_status_map *map;
   673		const char *fes_desc = NULL;
   674		int i;
   675		u32 pdu_offset;
   676	
   677		for (i = 0; i < ARRAY_SIZE(fes_status); i++) {
 > 678			if (map[i].fes == pdu->fes) {
   679				fes_desc = map[i].desc;
   680				break;
   681			}
   682		}
   683		if (!fes_desc)
   684			fes_desc = "unknown fatal error status";
   685	
   686		if (pdu->hdr.plen > sizeof(struct nvme_tcp_term_pdu))
   687			ref_pdu = (struct nvme_tcp_hdr *)((u8 *)pdu + 1);
   688	
   689		if (pdu->fes == NVME_TCP_FES_INVALID_PDU_HDR ||
   690		    pdu->fes == NVME_TCP_FES_HDR_DIGEST_ERR ||
   691		    pdu->fes == NVME_TCP_FES_UNSUPPORTED_PARAM) {
   692			pdu_offset = le32_to_cpu(pdu->fei);
   693	
   694			dev_err(queue->ctrl->ctrl.device,
   695				"queue %d c2h term, %s, pdu type %u offset %u\n",
   696				nvme_tcp_queue_id(queue), fes_desc, ref_pdu->type, pdu_offset);
   697		} else
   698			dev_err(queue->ctrl->ctrl.device,
   699				"queue %d c2h term, %s, pdu type %u\n",
   700				nvme_tcp_queue_id(queue), fes_desc, ref_pdu->type);
   701	
   702		return -ECONNRESET;
   703	}
   704	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
