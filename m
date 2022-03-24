Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFB14E6B50
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 00:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356438AbiCXXod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 19:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356381AbiCXXoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 19:44:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E385FBB90E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 16:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648165359; x=1679701359;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0m3vl8D0Cto4zEhd0e9bcLWdk2hC55kP6S5QpJPTy6g=;
  b=VvHI/Qvg2RR0BthVQMhrC0w4wsLIqd94sk0HQg9Ck1m2jDj9JjRww/HG
   CLINKv7SR89g8VDSaPhGz/ohN3xAYDCwCXXOM82bnfwdv3NWWKfnpeUQO
   OKA672objke/1NUmGaqhHUtbQoU2ojzXpC+/UzXo6awjVLJ+LAxsH497N
   FF/TlDjiIxn6rEapwTjq3a1csKqId0dMq989PIy8+K0TAW6PnCyknVZp4
   gsRrFFk/s9Et0G2o9906FrZjBbFq048nawifijdccRAHWaZejUWj2hbdq
   dVvA9d8cBQdlXvquI6qaSOzdywI2221QfJYWSC1k4kw3IqwLSE9MZUUSt
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="258231143"
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="258231143"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 16:42:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="718021056"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 24 Mar 2022 16:42:24 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXX5z-000LYe-Ec; Thu, 24 Mar 2022 23:42:23 +0000
Date:   Fri, 25 Mar 2022 07:41:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ohad Sharabi <osharabi@habana.ai>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Oded Gabbay <ogabbay@kernel.org>
Subject: [ogabbay:habanalabs-next 19/19]
 drivers/misc/habanalabs/common/firmware_if.c:860:28: sparse: sparse: cast to
 restricted __le32
Message-ID: <202203250727.JVrJokTk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git habanalabs-next
head:   8893b113963d24b89844a072c968b042ae76aa46
commit: 8893b113963d24b89844a072c968b042ae76aa46 [19/19] habanalabs/gaudi: add debugfs to fetch internal sync status
config: i386-randconfig-s002 (https://download.01.org/0day-ci/archive/20220325/202203250727.JVrJokTk-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git/commit/?id=8893b113963d24b89844a072c968b042ae76aa46
        git remote add ogabbay https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git
        git fetch --no-tags ogabbay habanalabs-next
        git checkout 8893b113963d24b89844a072c968b042ae76aa46
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/misc/habanalabs/common/firmware_if.c:860:28: sparse: sparse: cast to restricted __le32

vim +860 drivers/misc/habanalabs/common/firmware_if.c

   823	
   824	int hl_fw_get_monitor_dump(struct hl_device *hdev, void *data)
   825	{
   826		struct cpucp_monitor_dump *mon_dump_cpu_addr;
   827		dma_addr_t mon_dump_dma_addr;
   828		struct cpucp_packet pkt = {};
   829		u32 *src_ptr, *dst_ptr;
   830		size_t data_size;
   831		u64 result;
   832		int i, rc;
   833	
   834		data_size = sizeof(struct cpucp_monitor_dump);
   835		mon_dump_cpu_addr = hdev->asic_funcs->cpu_accessible_dma_pool_alloc(hdev, data_size,
   836											&mon_dump_dma_addr);
   837		if (!mon_dump_cpu_addr) {
   838			dev_err(hdev->dev,
   839				"Failed to allocate DMA memory for CPU-CP monitor-dump packet\n");
   840			return -ENOMEM;
   841		}
   842	
   843		memset(mon_dump_cpu_addr, 0, data_size);
   844	
   845		pkt.ctl = cpu_to_le32(CPUCP_PACKET_MONITOR_DUMP_GET << CPUCP_PKT_CTL_OPCODE_SHIFT);
   846		pkt.addr = cpu_to_le64(mon_dump_dma_addr);
   847		pkt.data_max_size = cpu_to_le32(data_size);
   848	
   849		rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
   850								HL_CPUCP_MON_DUMP_TIMEOUT_USEC, &result);
   851		if (rc) {
   852			dev_err(hdev->dev, "Failed to handle CPU-CP monitor-dump packet, error %d\n", rc);
   853			goto out;
   854		}
   855	
   856		/* result contains the actual size */
   857		src_ptr = (u32 *)mon_dump_cpu_addr;
   858		dst_ptr = data;
   859		for (i = 0; i < (data_size / sizeof(u32)); i++) {
 > 860			*dst_ptr = le32_to_cpu(*src_ptr);
   861			src_ptr++;
   862			dst_ptr++;
   863		}
   864	
   865	out:
   866		hdev->asic_funcs->cpu_accessible_dma_pool_free(hdev, data_size, mon_dump_cpu_addr);
   867	
   868		return rc;
   869	}
   870	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
