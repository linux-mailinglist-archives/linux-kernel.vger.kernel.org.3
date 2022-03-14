Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37BD4D7DAB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 09:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbiCNIip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 04:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiCNIio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 04:38:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010193FBE1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 01:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647247054; x=1678783054;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=a9SSRbxUGbW8aNdc8oQyfGX6SRebbcVBqLThNKIaF3U=;
  b=kjagJ2Y25/zkuiU8vqSD68neL6IiU2ebZNlxeDa2v15TBikneCerRC1M
   r2cCxWLFue+WzCMWR8kRIB5dy1eejiyUHgaAEABYapgKIoelovS9ag9oy
   G+T/jmil43GQPdzrLUCXsngGTd5c7AzUgEdlxDdOOJgdnLrIm2BPJTcc1
   F+J1+GLcrgFDOurCQzl5YpNfoCOD7Wzjzc6xIxcbBaV7SaWtu7yeJ/H4y
   nH3chQBk18iTeOZNVER+ZIQsppr5ji1cwYcfZIkdKk4ktV/02roPS9rcL
   7+fHxGdKWwn75KU//JjlUdwuBedxpod2s5Ft6ZQsbApVgEs717CVir4ub
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="235916607"
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="235916607"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 01:37:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="515336043"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 14 Mar 2022 01:37:33 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTgCq-0009jT-9H; Mon, 14 Mar 2022 08:37:32 +0000
Date:   Mon, 14 Mar 2022 16:36:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:tls-upcall.v4 141/156]
 drivers/nvme/host/tcp.c:655:3: sparse: sparse: symbol 'fes_status' was not
 declared. Should it be static?
Message-ID: <202203141612.l0D9X0i9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git tls-upcall.v4
head:   d2416ecdb6b03fc2e4aa40b20cdf919322713224
commit: fb16aba001d4b403be727c8dd379da6e3dbf56e4 [141/156] nvme-tcp: decode c2h term PDU
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20220314/202203141612.l0D9X0i9-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=fb16aba001d4b403be727c8dd379da6e3dbf56e4
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel tls-upcall.v4
        git checkout fb16aba001d4b403be727c8dd379da6e3dbf56e4
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/host/tcp.c:655:3: sparse: sparse: symbol 'fes_status' was not declared. Should it be static?
>> drivers/nvme/host/tcp.c:674:38: sparse: sparse: restricted __le16 degrades to integer
>> drivers/nvme/host/tcp.c:682:21: sparse: sparse: restricted __le32 degrades to integer
   drivers/nvme/host/tcp.c:685:16: sparse: sparse: restricted __le16 degrades to integer
   drivers/nvme/host/tcp.c:686:16: sparse: sparse: restricted __le16 degrades to integer
   drivers/nvme/host/tcp.c:687:16: sparse: sparse: restricted __le16 degrades to integer

vim +/fes_status +655 drivers/nvme/host/tcp.c

   651	
   652	struct fes_status_map {
   653		enum nvme_tcp_fatal_error_status fes;
   654		const char *desc;
 > 655	} fes_status[] = {
   656		{ NVME_TCP_FES_INVALID_PDU_HDR, "invalid pdu header"},
   657		{ NVME_TCP_FES_PDU_SEQ_ERR, "pdu sequence error" },
   658		{ NVME_TCP_FES_HDR_DIGEST_ERR, "header digest error" },
   659		{ NVME_TCP_FES_DATA_OUT_OF_RANGE, "data transfer out of range" },
   660		{ NVME_TCP_FES_DATA_LIMIT_EXCEEDED, "data limit exceeded" },
   661		{ NVME_TCP_FES_UNSUPPORTED_PARAM, "unsupported parameter" },
   662	};
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
 > 682		if (pdu->hdr.plen > sizeof(struct nvme_tcp_term_pdu))
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
