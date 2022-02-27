Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC62B4C5B45
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 13:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiB0MzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 07:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiB0MzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 07:55:12 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D362654D
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 04:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645966475; x=1677502475;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OkrvMWaxCI4REMVT2HVC8Ueg9MJHUHVZMXl86Jc3hCY=;
  b=hy7cRuogAB+/E1VvSizo5lz4KUzZSTwCcSj4D2i/IrU7XUq++uHA3KPB
   Vwdtqe/+tq5UZrMPTwHkl+IFZ+wefuFBV5Eo/82NPRdqXPpB0CJWymtTd
   yfLwVh6ksN1ibpOAlM1/gQZw+OFvoGFTkgXxN2+1ah/iEE9pts3v43Ngz
   qWYXiTRoCgWfCCGQc0+5QZf02GghceLRkdlQc5WXz9E/crg7zQNl/jJxe
   tyL36uDStRBWDVQ+FzXgOg2htZRjQvyReEm0fH6FDbFHoGaDCvmTB9Cur
   iqPRR6RbWUsDBFTpUXlRVq/Rm4fX1crnSShJrknYKif9kK5ctqTPngtZy
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10270"; a="251565560"
X-IronPort-AV: E=Sophos;i="5.90,141,1643702400"; 
   d="scan'208";a="251565560"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2022 04:54:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,141,1643702400"; 
   d="scan'208";a="509770904"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 27 Feb 2022 04:54:34 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOJ4L-0006WI-BD; Sun, 27 Feb 2022 12:54:33 +0000
Date:   Sun, 27 Feb 2022 20:54:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:tls-upcall.v2 157/159]
 drivers/nvme/host/tcp.c:659:3: sparse: sparse: symbol 'fes_status' was not
 declared. Should it be static?
Message-ID: <202202272008.yNSnSONs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20220227/202202272008.yNSnSONs-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=294875f63a598198387eda2c7f5fc00c3ac94b7a
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel tls-upcall.v2
        git checkout 294875f63a598198387eda2c7f5fc00c3ac94b7a
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/host/tcp.c:659:3: sparse: sparse: symbol 'fes_status' was not declared. Should it be static?
>> drivers/nvme/host/tcp.c:678:38: sparse: sparse: restricted __le16 degrades to integer
>> drivers/nvme/host/tcp.c:686:21: sparse: sparse: restricted __le32 degrades to integer
   drivers/nvme/host/tcp.c:689:16: sparse: sparse: restricted __le16 degrades to integer
   drivers/nvme/host/tcp.c:690:16: sparse: sparse: restricted __le16 degrades to integer
   drivers/nvme/host/tcp.c:691:16: sparse: sparse: restricted __le16 degrades to integer

vim +/fes_status +659 drivers/nvme/host/tcp.c

   655	
   656	struct fes_status_map {
   657		enum nvme_tcp_fatal_error_status fes;
   658		const char *desc;
 > 659	} fes_status[] = {
   660		{ NVME_TCP_FES_INVALID_PDU_HDR, "invalid pdu header"},
   661		{ NVME_TCP_FES_PDU_SEQ_ERR, "pdu sequence error" },
   662		{ NVME_TCP_FES_HDR_DIGEST_ERR, "header digest error" },
   663		{ NVME_TCP_FES_DATA_OUT_OF_RANGE, "data transfer out of range" },
   664		{ NVME_TCP_FES_DATA_LIMIT_EXCEEDED, "data limit exceeded" },
   665		{ NVME_TCP_FES_UNSUPPORTED_PARAM, "unsupported parameter" },
   666	};
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
 > 686		if (pdu->hdr.plen > sizeof(struct nvme_tcp_term_pdu))
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
