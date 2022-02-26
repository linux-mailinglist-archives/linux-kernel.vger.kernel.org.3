Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCF94C57CF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 20:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiBZTPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 14:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbiBZTPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 14:15:43 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8792F50443
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 11:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645902908; x=1677438908;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iTx/cdsZYnpjN4MPQmksYIfh70val3MraI7g3Wbkceo=;
  b=iO9+C6DNlx2Bp7vzxSgCYOLOX5K2TDuUqBDzFFW/jrQBvWs3oGEYE+7W
   XvT02MOasXMu63IXDPXU68/TdmldmbZAXlX3t/SetQTnV3V1SD0lAqLa5
   MS5/nlmoqxY2CodwPzTOPuc9uBimkO0L2Lks15/7ZiEaqE8VSo9q4piZq
   KUEu7mNhd0LlfylQ58sZE6Bx5XQ5vq4ZLAk/PRKSUsf7+67KnTKVGkjaZ
   /FJAHgWnase6YLeb4vetD19X3MBbyXkE1p1MI9qdJ+2TQOa4RB+qtZLEL
   twlMHuehD1npLHawukVNQasLLjJrl4TP7g1VhuCLZ5kyaH2KoFNKb2gpp
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10270"; a="250259622"
X-IronPort-AV: E=Sophos;i="5.90,139,1643702400"; 
   d="scan'208";a="250259622"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 11:15:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,139,1643702400"; 
   d="scan'208";a="492294414"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 26 Feb 2022 11:15:06 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nO2X4-0005sF-3Y; Sat, 26 Feb 2022 19:15:06 +0000
Date:   Sun, 27 Feb 2022 03:14:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:tls-upcall.v2 157/159]
 drivers/nvme/host/tcp.c:672:32: warning: 'map' is used uninitialized
Message-ID: <202202270248.qwgDD0GP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git tls-upcall.v2
head:   21b520ae0b338bd30496feb1ca90a2820dab7a65
commit: 294875f63a598198387eda2c7f5fc00c3ac94b7a [157/159] nvme-tcp: decode c2h term PDU
config: riscv-randconfig-r042-20220226 (https://download.01.org/0day-ci/archive/20220227/202202270248.qwgDD0GP-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=294875f63a598198387eda2c7f5fc00c3ac94b7a
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel tls-upcall.v2
        git checkout 294875f63a598198387eda2c7f5fc00c3ac94b7a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/nvme/host/tcp.c: In function 'nvme_tcp_handle_c2h_term.constprop':
>> drivers/nvme/host/tcp.c:672:32: warning: 'map' is used uninitialized [-Wuninitialized]
     672 |         struct fes_status_map *map;
         |                                ^~~


vim +/map +672 drivers/nvme/host/tcp.c

   667	
   668	static int nvme_tcp_handle_c2h_term(struct nvme_tcp_queue *queue,
   669			struct nvme_tcp_term_pdu *pdu)
   670	{
   671		struct nvme_tcp_hdr *ref_pdu;
 > 672		struct fes_status_map *map;
   673		const char *fes_desc = NULL;
   674		int i;
   675		u32 pdu_offset;
   676	
   677		for (i = 0; i < ARRAY_SIZE(fes_status); i++) {
   678			if (map[i].fes == pdu->fes) {
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
