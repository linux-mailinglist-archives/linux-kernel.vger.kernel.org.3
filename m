Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481074AE443
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387458AbiBHW1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239316AbiBHWUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 17:20:15 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB85C0612BC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 14:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644358813; x=1675894813;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Yufv6cv4/3vguwhcn1V790iDRzQOgdMBKx6n1D9pxAQ=;
  b=lK6Iv/bM7E8q+QRTxe0MKdXVYANrkp2EOb7FwbmTI2XUyw+BAtIkdRrm
   DLI1W78yQ2cW/IslRyrKNKUpJVcPMjQ3uUeb6QUxDpjuGuFWzBsC7ocTT
   jfqDWMwHndYNeYX8wxsPwzqXm7eE6JApPdOFU4pThJRRkgPbLRM427KJp
   CDTa/bs1oK+vAggf3FVdxJmxpWq/aNujaauPMKunkDPpBgZbKspBbnrGx
   AbcLf4XaQ2FQalhkVO05gjVSsEaPb4gBqDAHzkYkR0tNI4VXIzvTVfHP2
   j9m9j4gTYsktNsHSb5IEK2B9h76yfL2JJTDRY3PICKA6onipmzZF9VtwL
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="248826565"
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="248826565"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 14:20:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="484976933"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Feb 2022 14:20:12 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHYqJ-0000ol-FR; Tue, 08 Feb 2022 22:20:11 +0000
Date:   Wed, 9 Feb 2022 06:19:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        David Teigland <teigland@redhat.com>
Subject: fs/dlm/midcomms.c:913:22: sparse: sparse: restricted __le32 degrades
 to integer
Message-ID: <202202090632.SQ22xw2f-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   555f3d7be91a873114c9656069f1a9fa476ec41a
commit: 658bd576f95ed597e519cdadf1c86ac87c17aea5 fs: dlm: move version conversion to compile time
date:   3 months ago
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220209/202202090632.SQ22xw2f-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=658bd576f95ed597e519cdadf1c86ac87c17aea5
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 658bd576f95ed597e519cdadf1c86ac87c17aea5
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   fs/dlm/midcomms.c:213:1: sparse: sparse: symbol '__srcu_struct_nodes_srcu' was not declared. Should it be static?
   fs/dlm/midcomms.c:570:25: sparse: sparse: cast to restricted __le32
   fs/dlm/midcomms.c:678:19: sparse: sparse: cast to restricted __le16
   fs/dlm/midcomms.c:680:16: sparse: sparse: cast to restricted __le16
   fs/dlm/midcomms.c:718:27: sparse: sparse: cast to restricted __le16
   fs/dlm/midcomms.c:737:25: sparse: sparse: cast to restricted __le32
   fs/dlm/midcomms.c:747:25: sparse: sparse: cast to restricted __le32
   fs/dlm/midcomms.c:756:23: sparse: sparse: cast to restricted __le32
   fs/dlm/midcomms.c:766:42: sparse: sparse: cast to restricted __le16
   fs/dlm/midcomms.c:769:26: sparse: sparse: cast to restricted __le16
   fs/dlm/midcomms.c:804:23: sparse: sparse: cast to restricted __le32
   fs/dlm/midcomms.c:838:27: sparse: sparse: cast to restricted __le16
   fs/dlm/midcomms.c:898:26: sparse: sparse: cast to restricted __le16
   fs/dlm/midcomms.c:920:25: sparse: sparse: cast to restricted __le32
>> fs/dlm/midcomms.c:913:22: sparse: sparse: restricted __le32 degrades to integer
   fs/dlm/midcomms.c:916:22: sparse: sparse: restricted __le32 degrades to integer
   fs/dlm/midcomms.c:1056:20: sparse: sparse: context imbalance in 'dlm_midcomms_get_mhandle' - wrong count at exit
   fs/dlm/midcomms.c: note: in included file (through include/linux/notifier.h, arch/x86/include/asm/uprobes.h, include/linux/uprobes.h, ...):
   include/linux/srcu.h:188:9: sparse: sparse: context imbalance in 'dlm_midcomms_commit_mhandle' - unexpected unlock

vim +913 fs/dlm/midcomms.c

   871	
   872	/*
   873	 * Called from the low-level comms layer to process a buffer of
   874	 * commands.
   875	 */
   876	
   877	int dlm_process_incoming_buffer(int nodeid, unsigned char *buf, int len)
   878	{
   879		const unsigned char *ptr = buf;
   880		const struct dlm_header *hd;
   881		uint16_t msglen;
   882		int ret = 0;
   883	
   884		while (len >= sizeof(struct dlm_header)) {
   885			hd = (struct dlm_header *)ptr;
   886	
   887			/* no message should be more than DLM_MAX_SOCKET_BUFSIZE or
   888			 * less than dlm_header size.
   889			 *
   890			 * Some messages does not have a 8 byte length boundary yet
   891			 * which can occur in a unaligned memory access of some dlm
   892			 * messages. However this problem need to be fixed at the
   893			 * sending side, for now it seems nobody run into architecture
   894			 * related issues yet but it slows down some processing.
   895			 * Fixing this issue should be scheduled in future by doing
   896			 * the next major version bump.
   897			 */
   898			msglen = le16_to_cpu(hd->h_length);
   899			if (msglen > DLM_MAX_SOCKET_BUFSIZE ||
   900			    msglen < sizeof(struct dlm_header)) {
   901				log_print("received invalid length header: %u from node %d, will abort message parsing",
   902					  msglen, nodeid);
   903				return -EBADMSG;
   904			}
   905	
   906			/* caller will take care that leftover
   907			 * will be parsed next call with more data
   908			 */
   909			if (msglen > len)
   910				break;
   911	
   912			switch (hd->h_version) {
 > 913			case cpu_to_le32(DLM_VERSION_3_1):
   914				dlm_midcomms_receive_buffer_3_1((union dlm_packet *)ptr, nodeid);
   915				break;
   916			case cpu_to_le32(DLM_VERSION_3_2):
   917				dlm_midcomms_receive_buffer_3_2((union dlm_packet *)ptr, nodeid);
   918				break;
   919			default:
   920				log_print("received invalid version header: %u from node %d, will skip this message",
   921					  le32_to_cpu(hd->h_version), nodeid);
   922				break;
   923			}
   924	
   925			ret += msglen;
   926			len -= msglen;
   927			ptr += msglen;
   928		}
   929	
   930		return ret;
   931	}
   932	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
