Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270DC4624D0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbhK2W3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:29:23 -0500
Received: from mga12.intel.com ([192.55.52.136]:62873 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231156AbhK2W24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:28:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="216106430"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="216106430"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 14:25:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="653812644"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 29 Nov 2021 14:25:22 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mrp5N-000CQP-HE; Mon, 29 Nov 2021 22:25:21 +0000
Date:   Tue, 30 Nov 2021 06:24:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luo bin <luobin9@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:618:22: sparse:
 sparse: cast to restricted __be64
Message-ID: <202111300604.cMPVrgfV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d58071a8a76d779eedab38033ae4c821c30295a5
commit: a425b6e1c69ba907b72b737a4d44f8cfbc43ce3c hinic: add mailbox function support
date:   1 year, 7 months ago
config: x86_64-randconfig-s022-20211124 (https://download.01.org/0day-ci/archive/20211130/202111300604.cMPVrgfV-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a425b6e1c69ba907b72b737a4d44f8cfbc43ce3c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a425b6e1c69ba907b72b737a4d44f8cfbc43ce3c
        # save the config file to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:543:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned char [usertype] * @@
   drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:543:54: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:543:54: sparse:     got unsigned char [usertype] *
   drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:566:58: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned char [usertype] * @@
   drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:566:58: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:566:58: sparse:     got unsigned char [usertype] *
   drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:601:6: sparse: sparse: symbol 'dump_mox_reg' was not declared. Should it be static?
>> drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:618:22: sparse: sparse: cast to restricted __be64
>> drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:618:22: sparse: sparse: cast to restricted __be64
>> drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:618:22: sparse: sparse: cast to restricted __be64
>> drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:618:22: sparse: sparse: cast to restricted __be64
>> drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:618:22: sparse: sparse: cast to restricted __be64
>> drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:618:22: sparse: sparse: cast to restricted __be64
>> drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:618:22: sparse: sparse: cast to restricted __be64
>> drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:618:22: sparse: sparse: cast to restricted __be64
>> drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:618:22: sparse: sparse: cast to restricted __be64
>> drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:618:22: sparse: sparse: cast to restricted __be64
   drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:1057:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [usertype] *data @@     got void [noderef] <asn:2> * @@
   drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:1057:25: sparse:     expected unsigned char [usertype] *data
   drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:1057:25: sparse:     got void [noderef] <asn:2> *
   drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c: note: in included file:
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int val @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse:     expected unsigned int val
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int val @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse:     expected unsigned int val
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:250:16: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:250:16: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:250:16: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:250:16: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:250:16: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:250:16: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:250:16: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:250:16: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:250:16: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:250:16: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:250:16: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:250:16: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int val @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse:     expected unsigned int val
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int val @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse:     expected unsigned int val
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int val @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse:     expected unsigned int val
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int val @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse:     expected unsigned int val
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse:     got restricted __be32 [usertype]

vim +618 drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c

   535	
   536	static void mbox_copy_header(struct hinic_hwdev *hwdev,
   537				     struct hinic_send_mbox *mbox, u64 *header)
   538	{
   539		u32 i, idx_max = MBOX_HEADER_SZ / sizeof(u32);
   540		u32 *data = (u32 *)header;
   541	
   542		for (i = 0; i < idx_max; i++)
 > 543			__raw_writel(*(data + i), mbox->data + i * sizeof(u32));
   544	}
   545	
   546	static void mbox_copy_send_data(struct hinic_hwdev *hwdev,
   547					struct hinic_send_mbox *mbox, void *seg,
   548					u16 seg_len)
   549	{
   550		u8 mbox_max_buf[MBOX_SEG_LEN] = {0};
   551		u32 data_len, chk_sz = sizeof(u32);
   552		u32 *data = seg;
   553		u32 i, idx_max;
   554	
   555		/* The mbox message should be aligned in 4 bytes. */
   556		if (seg_len % chk_sz) {
   557			memcpy(mbox_max_buf, seg, seg_len);
   558			data = (u32 *)mbox_max_buf;
   559		}
   560	
   561		data_len = seg_len;
   562		idx_max = ALIGN(data_len, chk_sz) / chk_sz;
   563	
   564		for (i = 0; i < idx_max; i++)
   565			__raw_writel(*(data + i),
   566				     mbox->data + MBOX_HEADER_SZ + i * sizeof(u32));
   567	}
   568	
   569	static void write_mbox_msg_attr(struct hinic_mbox_func_to_func *func_to_func,
   570					u16 dst_func, u16 dst_aeqn, u16 seg_len,
   571					int poll)
   572	{
   573		u16 rsp_aeq = (dst_aeqn == 0) ? 0 : HINIC_MBOX_RSP_AEQN;
   574		u32 mbox_int, mbox_ctrl;
   575	
   576		mbox_int = HINIC_MBOX_INT_SET(dst_func, DST_FUNC) |
   577			   HINIC_MBOX_INT_SET(dst_aeqn, DST_AEQN) |
   578			   HINIC_MBOX_INT_SET(rsp_aeq, SRC_RESP_AEQN) |
   579			   HINIC_MBOX_INT_SET(NO_DMA_ATTRIBUTE_VAL, STAT_DMA) |
   580			   HINIC_MBOX_INT_SET(ALIGN(MBOX_SEG_LEN + MBOX_HEADER_SZ +
   581					      MBOX_INFO_SZ, MBOX_SEG_LEN_ALIGN) >> 2,
   582					      TX_SIZE) |
   583			   HINIC_MBOX_INT_SET(STRONG_ORDER, STAT_DMA_SO_RO) |
   584			   HINIC_MBOX_INT_SET(WRITE_BACK, WB_EN);
   585	
   586		hinic_hwif_write_reg(func_to_func->hwif,
   587				     HINIC_FUNC_CSR_MAILBOX_INT_OFFSET_OFF, mbox_int);
   588	
   589		wmb(); /* writing the mbox int attributes */
   590		mbox_ctrl = HINIC_MBOX_CTRL_SET(TX_NOT_DONE, TX_STATUS);
   591	
   592		if (poll)
   593			mbox_ctrl |= HINIC_MBOX_CTRL_SET(NOT_TRIGGER, TRIGGER_AEQE);
   594		else
   595			mbox_ctrl |= HINIC_MBOX_CTRL_SET(TRIGGER, TRIGGER_AEQE);
   596	
   597		hinic_hwif_write_reg(func_to_func->hwif,
   598				     HINIC_FUNC_CSR_MAILBOX_CONTROL_OFF, mbox_ctrl);
   599	}
   600	
   601	void dump_mox_reg(struct hinic_hwdev *hwdev)
   602	{
   603		u32 val;
   604	
   605		val = hinic_hwif_read_reg(hwdev->hwif,
   606					  HINIC_FUNC_CSR_MAILBOX_CONTROL_OFF);
   607		dev_err(&hwdev->hwif->pdev->dev, "Mailbox control reg: 0x%x\n", val);
   608	
   609		val = hinic_hwif_read_reg(hwdev->hwif,
   610					  HINIC_FUNC_CSR_MAILBOX_INT_OFFSET_OFF);
   611		dev_err(&hwdev->hwif->pdev->dev, "Mailbox interrupt offset: 0x%x\n",
   612			val);
   613	}
   614	
   615	static u16 get_mbox_status(struct hinic_send_mbox *mbox)
   616	{
   617		/* write back is 16B, but only use first 4B */
 > 618		u64 wb_val = be64_to_cpu(*mbox->wb_status);
   619	
   620		rmb(); /* verify reading before check */
   621	
   622		return (u16)(wb_val & MBOX_WB_STATUS_ERRCODE_MASK);
   623	}
   624	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
