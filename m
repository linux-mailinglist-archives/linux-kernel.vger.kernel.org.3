Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1BC4AC87D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 19:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238630AbiBGSYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 13:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235906AbiBGSWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 13:22:19 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C39C0401DC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 10:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644258137; x=1675794137;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vC9sAF8h2IwzwAaasvP35mbG0oIdz/OPeQG9samMx2I=;
  b=VYBawi8DbUpoE+IfGG4AnsAh920tjyUlok3lfQoHC0H34xggeJttREYg
   FsR0K9fN/64RK0d+9rCiw0X91GPRYIkZ6fEZ6GNLXI7fDklExt4CqBoWx
   NbZGeVeHI8rjVDZYAiXXpzOcVDTdoKrZqOki+Lua4rWoNj5RAm3AxNNQD
   vkEA8CL19jUPFssLUwLvhnrwwUXB1/w3NsjDQTdUnANyzGbeSwEWZGbnB
   yZUw/4yHcI/bkZ/A1WZm8OYBTz6PZr57wSxbDl+NYWnwn2hXqfgERR87o
   0fK1ydPCAYHbNi6WrWFWE731MV4VaPGqR8oREGR2D728GfU9tauY6G4vC
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10250"; a="273301293"
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="273301293"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 10:21:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="632558049"
Received: from lkp-server01.sh.intel.com (HELO 9dd77a123018) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 07 Feb 2022 10:21:50 -0800
Received: from kbuild by 9dd77a123018 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nH8e5-0000r6-Ev; Mon, 07 Feb 2022 18:21:49 +0000
Date:   Tue, 8 Feb 2022 02:21:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        David Teigland <teigland@redhat.com>
Subject: fs/dlm/midcomms.c:913:22: sparse: sparse: restricted __le32 degrades
 to integer
Message-ID: <202202080253.WdgaN4vt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dfd42facf1e4ada021b939b4e19c935dcdd55566
commit: 658bd576f95ed597e519cdadf1c86ac87c17aea5 fs: dlm: move version conversion to compile time
date:   3 months ago
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220208/202202080253.WdgaN4vt-lkp@intel.com/config)
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
