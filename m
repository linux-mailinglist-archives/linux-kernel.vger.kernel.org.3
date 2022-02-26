Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975FD4C55D7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 13:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbiBZMoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 07:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiBZMo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 07:44:28 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DAB1E3747
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 04:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645879433; x=1677415433;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mg6lSrhzTV79kXZrKoAJ29rvsoJs82Jl9+ZhflBuARo=;
  b=eePiwbHjA53i9SfHVxJ8B0Dq7V/A/J1W9wLFBLK/FoYUVKM3NoE6L/aD
   yAJ/bLKznI0ftADV6s10baut7c5QANv4YFDk65SI9PtLIiM+Om7NwXBNy
   z0kJq+pcT2nwGEe/p2lBslWrKyTCor7VDsMRpVrJ60B1iMVuDKAZ3IYuW
   hRsWuNiKWOTN7Z3rx0hvSC+5FrLfk50pS8PPCDIbkMAIHQKqqGLo6F7ZS
   H0rsTm4kEDZlHqbabg8bAcPxGmKZtlPPcS3dPoxR+4mM7PUJNKpT5hRi7
   zVyby4wu8CqB8+M8/Q0hWMMbV9FNoEUIGxXgfUy1bwyqIeI7hb9iDRnVy
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10269"; a="252384893"
X-IronPort-AV: E=Sophos;i="5.90,139,1643702400"; 
   d="scan'208";a="252384893"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 04:43:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,139,1643702400"; 
   d="scan'208";a="492247224"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 26 Feb 2022 04:43:51 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNwQQ-0005T0-J3; Sat, 26 Feb 2022 12:43:50 +0000
Date:   Sat, 26 Feb 2022 20:43:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: drivers/message/fusion/mptlan.c:1234:52: sparse: sparse: incorrect
 type in assignment (different base types)
Message-ID: <202202262010.eUEF0fTt-lkp@intel.com>
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
head:   9137eda53752ef73148e42b0d7640a00f1bc96b1
commit: 4e2e619f3c9e3c49859f085995554a53e9fc0e02 scsi: message: mptlan: Replace one-element array with flexible-array member
date:   11 months ago
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20220226/202202262010.eUEF0fTt-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4e2e619f3c9e3c49859f085995554a53e9fc0e02
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4e2e619f3c9e3c49859f085995554a53e9fc0e02
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/ security/ sound/soc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/message/fusion/mptlan.c:1172:21: sparse: sparse: cast to restricted __le16
>> drivers/message/fusion/mptlan.c:1234:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] TransactionContext @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:1234:52: sparse:     expected unsigned int [usertype] TransactionContext
   drivers/message/fusion/mptlan.c:1234:52: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptlan.c:1238:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] FlagsLength @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:1238:46: sparse:     expected unsigned int [usertype] FlagsLength
   drivers/message/fusion/mptlan.c:1238:46: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptlan.c:1242:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] Low @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:1242:46: sparse:     expected unsigned int [usertype] Low
   drivers/message/fusion/mptlan.c:1242:46: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptlan.c:1244:55: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] High @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:1244:55: sparse:     expected unsigned int [usertype] High
   drivers/message/fusion/mptlan.c:1244:55: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptlan.c:1258:38: sparse: sparse: invalid assignment: |=
   drivers/message/fusion/mptlan.c:1258:38: sparse:    left side has type unsigned int
   drivers/message/fusion/mptlan.c:1258:38: sparse:    right side has type restricted __le32
   drivers/message/fusion/mptlan.c:1260:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] BucketCount @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:1260:39: sparse:     expected unsigned int [usertype] BucketCount
   drivers/message/fusion/mptlan.c:1260:39: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptlan.c:964:25: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:969:9: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:972:14: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:976:15: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:982:53: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:986:18: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:990:18: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:1020:31: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:612:9: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:617:17: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:641:23: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:346:17: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:1492:27: sparse: sparse: restricted __be16 degrades to integer
   drivers/message/fusion/mptlan.c:1529:29: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned short @@     got restricted __be16 [usertype] ethertype @@
   drivers/message/fusion/mptlan.c:1529:29: sparse:     expected unsigned short
   drivers/message/fusion/mptlan.c:1529:29: sparse:     got restricted __be16 [usertype] ethertype
   drivers/message/fusion/mptlan.c:1532:16: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned short @@     got restricted __be16 [usertype] @@
   drivers/message/fusion/mptlan.c:1532:16: sparse:     expected unsigned short
   drivers/message/fusion/mptlan.c:1532:16: sparse:     got restricted __be16 [usertype]
   drivers/message/fusion/mptlan.c:745:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] TransactionContext @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:745:36: sparse:     expected unsigned int [usertype] TransactionContext
   drivers/message/fusion/mptlan.c:745:36: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptlan.c:753:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:753:39: sparse:     expected unsigned int
   drivers/message/fusion/mptlan.c:753:39: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptlan.c:756:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:756:39: sparse:     expected unsigned int
   drivers/message/fusion/mptlan.c:756:39: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptlan.c:766:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] FlagsLength @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:766:30: sparse:     expected unsigned int [usertype] FlagsLength
   drivers/message/fusion/mptlan.c:766:30: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptlan.c:775:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] Low @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:775:30: sparse:     expected unsigned int [usertype] Low
   drivers/message/fusion/mptlan.c:775:30: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptlan.c:777:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] High @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:777:39: sparse:     expected unsigned int [usertype] High
   drivers/message/fusion/mptlan.c:777:39: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptlan.c:784:9: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:819:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] protocol @@     got unsigned short @@
   drivers/message/fusion/mptlan.c:819:23: sparse:     expected restricted __be16 [usertype] protocol
   drivers/message/fusion/mptlan.c:819:23: sparse:     got unsigned short
   drivers/message/fusion/mptlan.c:919:23: sparse: sparse: cast to restricted __le32

vim +1234 drivers/message/fusion/mptlan.c

  1134	
  1135	static void
  1136	mpt_lan_post_receive_buckets(struct mpt_lan_priv *priv)
  1137	{
  1138		struct net_device *dev = priv->dev;
  1139		MPT_ADAPTER *mpt_dev = priv->mpt_dev;
  1140		MPT_FRAME_HDR *mf;
  1141		LANReceivePostRequest_t *pRecvReq;
  1142		SGETransaction32_t *pTrans;
  1143		SGESimple64_t *pSimple;
  1144		struct sk_buff *skb;
  1145		dma_addr_t dma;
  1146		u32 curr, buckets, count, max;
  1147		u32 len = (dev->mtu + dev->hard_header_len + 4);
  1148		unsigned long flags;
  1149		int i;
  1150	
  1151		curr = atomic_read(&priv->buckets_out);
  1152		buckets = (priv->max_buckets_out - curr);
  1153	
  1154		dioprintk((KERN_INFO MYNAM ": %s/%s: @%s, Start_buckets = %u, buckets_out = %u\n",
  1155				IOC_AND_NETDEV_NAMES_s_s(dev),
  1156				__func__, buckets, curr));
  1157	
  1158		max = (mpt_dev->req_sz - MPT_LAN_RECEIVE_POST_REQUEST_SIZE) /
  1159				(sizeof(SGETransaction32_t) + sizeof(SGESimple64_t));
  1160	
  1161		while (buckets) {
  1162			mf = mpt_get_msg_frame(LanCtx, mpt_dev);
  1163			if (mf == NULL) {
  1164				printk (KERN_ERR "%s: Unable to alloc request frame\n",
  1165					__func__);
  1166				dioprintk((KERN_ERR "%s: %u buckets remaining\n",
  1167					 __func__, buckets));
  1168				goto out;
  1169			}
  1170			pRecvReq = (LANReceivePostRequest_t *) mf;
  1171	
  1172			i = le16_to_cpu(mf->u.frame.hwhdr.msgctxu.fld.req_idx);
  1173			mpt_dev->RequestNB[i] = 0;
  1174			count = buckets;
  1175			if (count > max)
  1176				count = max;
  1177	
  1178			pRecvReq->Function    = MPI_FUNCTION_LAN_RECEIVE;
  1179			pRecvReq->ChainOffset = 0;
  1180			pRecvReq->MsgFlags    = 0;
  1181			pRecvReq->PortNumber  = priv->pnum;
  1182	
  1183			pTrans = (SGETransaction32_t *) pRecvReq->SG_List;
  1184			pSimple = NULL;
  1185	
  1186			for (i = 0; i < count; i++) {
  1187				int ctx;
  1188	
  1189				spin_lock_irqsave(&priv->rxfidx_lock, flags);
  1190				if (priv->mpt_rxfidx_tail < 0) {
  1191					printk (KERN_ERR "%s: Can't alloc context\n",
  1192						__func__);
  1193					spin_unlock_irqrestore(&priv->rxfidx_lock,
  1194							       flags);
  1195					break;
  1196				}
  1197	
  1198				ctx = priv->mpt_rxfidx[priv->mpt_rxfidx_tail--];
  1199	
  1200				skb = priv->RcvCtl[ctx].skb;
  1201				if (skb && (priv->RcvCtl[ctx].len != len)) {
  1202					pci_unmap_single(mpt_dev->pcidev,
  1203							 priv->RcvCtl[ctx].dma,
  1204							 priv->RcvCtl[ctx].len,
  1205							 PCI_DMA_FROMDEVICE);
  1206					dev_kfree_skb(priv->RcvCtl[ctx].skb);
  1207					skb = priv->RcvCtl[ctx].skb = NULL;
  1208				}
  1209	
  1210				if (skb == NULL) {
  1211					skb = dev_alloc_skb(len);
  1212					if (skb == NULL) {
  1213						printk (KERN_WARNING
  1214							MYNAM "/%s: Can't alloc skb\n",
  1215							__func__);
  1216						priv->mpt_rxfidx[++priv->mpt_rxfidx_tail] = ctx;
  1217						spin_unlock_irqrestore(&priv->rxfidx_lock, flags);
  1218						break;
  1219					}
  1220	
  1221					dma = pci_map_single(mpt_dev->pcidev, skb->data,
  1222							     len, PCI_DMA_FROMDEVICE);
  1223	
  1224					priv->RcvCtl[ctx].skb = skb;
  1225					priv->RcvCtl[ctx].dma = dma;
  1226					priv->RcvCtl[ctx].len = len;
  1227				}
  1228	
  1229				spin_unlock_irqrestore(&priv->rxfidx_lock, flags);
  1230	
  1231				pTrans->ContextSize   = sizeof(u32);
  1232				pTrans->DetailsLength = 0;
  1233				pTrans->Flags         = 0;
> 1234				pTrans->TransactionContext = cpu_to_le32(ctx);
  1235	
  1236				pSimple = (SGESimple64_t *) pTrans->TransactionDetails;
  1237	
  1238				pSimple->FlagsLength = cpu_to_le32(
  1239					((MPI_SGE_FLAGS_END_OF_BUFFER |
  1240					  MPI_SGE_FLAGS_SIMPLE_ELEMENT |
  1241					  MPI_SGE_FLAGS_64_BIT_ADDRESSING) << MPI_SGE_FLAGS_SHIFT) | len);
  1242				pSimple->Address.Low = cpu_to_le32((u32) priv->RcvCtl[ctx].dma);
  1243				if (sizeof(dma_addr_t) > sizeof(u32))
  1244					pSimple->Address.High = cpu_to_le32((u32) ((u64) priv->RcvCtl[ctx].dma >> 32));
  1245				else
  1246					pSimple->Address.High = 0;
  1247	
  1248				pTrans = (SGETransaction32_t *) (pSimple + 1);
  1249			}
  1250	
  1251			if (pSimple == NULL) {
  1252	/**/			printk (KERN_WARNING MYNAM "/%s: No buckets posted\n",
  1253	/**/				__func__);
  1254				mpt_free_msg_frame(mpt_dev, mf);
  1255				goto out;
  1256			}
  1257	
  1258			pSimple->FlagsLength |= cpu_to_le32(MPI_SGE_FLAGS_END_OF_LIST << MPI_SGE_FLAGS_SHIFT);
  1259	
  1260			pRecvReq->BucketCount = cpu_to_le32(i);
  1261	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
