Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C494D27C9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiCIESB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 23:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiCIERx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 23:17:53 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D703BBDD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 20:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646799415; x=1678335415;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WqTbJFB2GOpTxks0g8Gxoq6JzJPPmOhJlCkExqIauBE=;
  b=k7aG5xmY1eDTRsRxZF00ijUz+YnUOGC/pwiq/5Z9EbFNtUl0JQj+SIiU
   3Nk/zFWKgYwh2tLxtu80pQGkS3SOaJVS48t5uSuvaRmDjeJ9RhWxWr4L+
   FygkTWtwVV8pzP/rPdCrJL+yIW4Huh52sDq/JCwt+8OITCdruTktv/yxm
   WTT5CS5OCleKUcfUgQfkabgNsLvusLtgUWrn4W9IgGaNCzyh5HGjV53pa
   6Qh2oH+AY4Bg27BCtiR7nGu86PBhu83DQClaGvN3xTwfOQ0G2SqSeUY9q
   BexBZJzq6aQ3+pogMnlXFCg+GvTKS6aFQwi1glLlK5x0YCSroTxpSf6u4
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="254822227"
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="254822227"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 20:16:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="711794238"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 08 Mar 2022 20:16:50 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRnko-0002ZB-7k; Wed, 09 Mar 2022 04:16:50 +0000
Date:   Wed, 9 Mar 2022 12:16:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
Subject: drivers/bluetooth/hci_qca.c:996:26: sparse: sparse: cast to
 restricted __le16
Message-ID: <202203091200.HA9qx4ka-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   92f90cc9fe0e7a984ea3d4bf3d120e30ba8a2118
commit: d841502c79e3fda2ba0e8d64f9eb00e9dd884af0 Bluetooth: hci_qca: Collect controller memory dump during SSR
date:   2 years, 2 months ago
config: parisc-randconfig-s031-20220212 (https://download.01.org/0day-ci/archive/20220309/202203091200.HA9qx4ka-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d841502c79e3fda2ba0e8d64f9eb00e9dd884af0
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d841502c79e3fda2ba0e8d64f9eb00e9dd884af0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/bluetooth/hci_qca.c: note: in included file (through arch/parisc/include/uapi/asm/unistd.h, arch/parisc/include/asm/unistd.h, include/uapi/linux/unistd.h, ...):
   ./arch/parisc/include/generated/uapi/asm/unistd_32.h:380:41: sparse: sparse: no newline at end of file
>> drivers/bluetooth/hci_qca.c:996:26: sparse: sparse: cast to restricted __le16
>> drivers/bluetooth/hci_qca.c:996:26: sparse: sparse: cast to restricted __le16
>> drivers/bluetooth/hci_qca.c:996:26: sparse: sparse: cast to restricted __le16
>> drivers/bluetooth/hci_qca.c:996:26: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/hci_qca.c:997:26: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/hci_qca.c:997:26: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/hci_qca.c:997:26: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/hci_qca.c:997:26: sparse: sparse: cast to restricted __le16
>> drivers/bluetooth/hci_qca.c:1011:37: sparse: sparse: cast to restricted __le32
>> drivers/bluetooth/hci_qca.c:1011:37: sparse: sparse: cast to restricted __le32
>> drivers/bluetooth/hci_qca.c:1011:37: sparse: sparse: cast to restricted __le32
>> drivers/bluetooth/hci_qca.c:1011:37: sparse: sparse: cast to restricted __le32
>> drivers/bluetooth/hci_qca.c:1011:37: sparse: sparse: cast to restricted __le32
>> drivers/bluetooth/hci_qca.c:1011:37: sparse: sparse: cast to restricted __le32
   drivers/bluetooth/hci_qca.c:1078:5: sparse: sparse: symbol 'qca_controller_memdump_event' was not declared. Should it be static?

vim +996 drivers/bluetooth/hci_qca.c

   968	
   969	static void qca_controller_memdump(struct work_struct *work)
   970	{
   971		struct qca_data *qca = container_of(work, struct qca_data,
   972						    ctrl_memdump_evt);
   973		struct hci_uart *hu = qca->hu;
   974		struct sk_buff *skb;
   975		struct qca_memdump_event_hdr *cmd_hdr;
   976		struct qca_memdump_data *qca_memdump = qca->qca_memdump;
   977		struct qca_dump_size *dump;
   978		char *memdump_buf;
   979		char nullBuff[QCA_DUMP_PACKET_SIZE] = { 0 };
   980		u16 opcode, seq_no;
   981		u32 dump_size;
   982	
   983		while ((skb = skb_dequeue(&qca->rx_memdump_q))) {
   984	
   985			if (!qca_memdump) {
   986				qca_memdump = kzalloc(sizeof(struct qca_memdump_data),
   987						      GFP_ATOMIC);
   988				if (!qca_memdump)
   989					return;
   990	
   991				qca->qca_memdump = qca_memdump;
   992			}
   993	
   994			qca->memdump_state = QCA_MEMDUMP_COLLECTING;
   995			cmd_hdr = (void *) skb->data;
 > 996			opcode = __le16_to_cpu(cmd_hdr->opcode);
   997			seq_no = __le16_to_cpu(cmd_hdr->seq_no);
   998			skb_pull(skb, sizeof(struct qca_memdump_event_hdr));
   999	
  1000			if (!seq_no) {
  1001	
  1002				/* This is the first frame of memdump packet from
  1003				 * the controller, Disable IBS to recevie dump
  1004				 * with out any interruption, ideally time required for
  1005				 * the controller to send the dump is 8 seconds. let us
  1006				 * start timer to handle this asynchronous activity.
  1007				 */
  1008				clear_bit(QCA_IBS_ENABLED, &qca->flags);
  1009				set_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
  1010				dump = (void *) skb->data;
> 1011				dump_size = __le32_to_cpu(dump->dump_size);
  1012				if (!(dump_size)) {
  1013					bt_dev_err(hu->hdev, "Rx invalid memdump size");
  1014					kfree_skb(skb);
  1015					return;
  1016				}
  1017	
  1018				bt_dev_info(hu->hdev, "QCA collecting dump of size:%u",
  1019					    dump_size);
  1020				mod_timer(&qca->memdump_timer, (jiffies +
  1021					  msecs_to_jiffies(MEMDUMP_TIMEOUT_MS)));
  1022	
  1023				skb_pull(skb, sizeof(dump_size));
  1024				memdump_buf = vmalloc(dump_size);
  1025				qca_memdump->memdump_buf_head = memdump_buf;
  1026				qca_memdump->memdump_buf_tail = memdump_buf;
  1027			}
  1028	
  1029			memdump_buf = qca_memdump->memdump_buf_tail;
  1030	
  1031			/* If sequence no 0 is missed then there is no point in
  1032			 * accepting the other sequences.
  1033			 */
  1034			if (!memdump_buf) {
  1035				bt_dev_err(hu->hdev, "QCA: Discarding other packets");
  1036				kfree(qca_memdump);
  1037				kfree_skb(skb);
  1038				qca->qca_memdump = NULL;
  1039				return;
  1040			}
  1041	
  1042			/* There could be chance of missing some packets from
  1043			 * the controller. In such cases let us store the dummy
  1044			 * packets in the buffer.
  1045			 */
  1046			while ((seq_no > qca_memdump->current_seq_no + 1) &&
  1047				seq_no != QCA_LAST_SEQUENCE_NUM) {
  1048				bt_dev_err(hu->hdev, "QCA controller missed packet:%d",
  1049					   qca_memdump->current_seq_no);
  1050				memcpy(memdump_buf, nullBuff, QCA_DUMP_PACKET_SIZE);
  1051				memdump_buf = memdump_buf + QCA_DUMP_PACKET_SIZE;
  1052				qca_memdump->received_dump += QCA_DUMP_PACKET_SIZE;
  1053				qca_memdump->current_seq_no++;
  1054			}
  1055	
  1056			memcpy(memdump_buf, (unsigned char *) skb->data, skb->len);
  1057			memdump_buf = memdump_buf + skb->len;
  1058			qca_memdump->memdump_buf_tail = memdump_buf;
  1059			qca_memdump->current_seq_no = seq_no + 1;
  1060			qca_memdump->received_dump += skb->len;
  1061			qca->qca_memdump = qca_memdump;
  1062			kfree_skb(skb);
  1063			if (seq_no == QCA_LAST_SEQUENCE_NUM) {
  1064				bt_dev_info(hu->hdev, "QCA writing crash dump of size %d bytes",
  1065					   qca_memdump->received_dump);
  1066				memdump_buf = qca_memdump->memdump_buf_head;
  1067				dev_coredumpv(&hu->serdev->dev, memdump_buf,
  1068					      qca_memdump->received_dump, GFP_KERNEL);
  1069				del_timer(&qca->memdump_timer);
  1070				kfree(qca->qca_memdump);
  1071				qca->qca_memdump = NULL;
  1072				qca->memdump_state = QCA_MEMDUMP_COLLECTED;
  1073			}
  1074		}
  1075	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
