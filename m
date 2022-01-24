Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFBC49A170
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 00:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360008AbiAXXfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:35:40 -0500
Received: from mga09.intel.com ([134.134.136.24]:3335 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1838591AbiAXWqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 17:46:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643064413; x=1674600413;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sym5jT8q5cwujBGyj2U5vtxo55C4dQq5swJKkshUwVE=;
  b=cK4ERk5bh8DEopCyNBWTpF8OUIFFgl6Md7V3V520cdfP1a07zsWdRjbL
   OQ/TugxsVZY/i/m3ji/QjhATFs+cI1FHGvrnF5yIjf0+WrLIaZ7hRoXa2
   Hz1DJDOtg4E884bReZO0tuvjCiO64l4CeOVbdG5oZKqmwx8jHJM/W7dDB
   KqYQGQczmcAglN9hJuiwNqkEizn8sloS60uin5LQ8nv6fbIwqUar7Ys1Q
   RZhx5sQ8Cvkwx+MOJldUXjAa7E8JDyexkc1EkQeQCpoCwERnA+ZvcfVtu
   AU2a5K9kimJm/5yed/PiXQ20dNk/6TRMyT9f4Dwfpk/h3z8od1rMRxmpb
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="245947129"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="245947129"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 14:46:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="617408129"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jan 2022 14:46:12 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nC86F-000J2b-Dx; Mon, 24 Jan 2022 22:46:11 +0000
Date:   Tue, 25 Jan 2022 06:45:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        David Teigland <teigland@redhat.com>
Subject: fs/dlm/midcomms.c:913:22: sparse: sparse: restricted __le32 degrades
 to integer
Message-ID: <202201250653.Cd12vqu0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dd81e1c7d5fb126e5fbc5c9e334d7b3ec29a16a0
commit: 658bd576f95ed597e519cdadf1c86ac87c17aea5 fs: dlm: move version conversion to compile time
date:   3 months ago
config: csky-randconfig-s032-20220120 (https://download.01.org/0day-ci/archive/20220125/202201250653.Cd12vqu0-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=658bd576f95ed597e519cdadf1c86ac87c17aea5
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 658bd576f95ed597e519cdadf1c86ac87c17aea5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
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
   fs/dlm/midcomms.c: note: in included file (through include/linux/notifier.h, include/linux/memory_hotplug.h, include/linux/mmzone.h, ...):
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
