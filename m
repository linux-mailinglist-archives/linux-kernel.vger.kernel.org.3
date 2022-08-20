Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5D0059B048
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 22:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbiHTUIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 16:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiHTUIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 16:08:17 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA64B99
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 13:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661026094; x=1692562094;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oY21mxCtzpqrOI5WhljHEFjnQh9rlwsHU22OuWdu/Ps=;
  b=POd/MQ7xoXgdLtWxpvQ/lSXCKWL4pCdMFn2P/GcSNaC/kKbx9TGsemY3
   KKKfYRisz1PwwVypV8iNoHqKTA2qiE9Fw3lyyOo6rWG2fUZxht9p42GXw
   L/+lcp0P5/ycYCDpgMz6f8i2vn6O2bBOWBEXe1LXMH5N3ERtmMftEpnZD
   N1rzaCpE2D+xckoE+fSJdqIgdrZ6NLiHZISgQErFkaO/lxX/l7+/WmVYd
   KFruTNrd+kk3QbALaUGR9psXmjrdkstlhHDkRev9udal6uPrXvP+zpjva
   mo1dehXul2nch6ux/QULzJLUJBnPiEDRawBHxOzmH2JudxuagzwhLb1bY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10445"; a="276229455"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="276229455"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 13:08:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="637664854"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 20 Aug 2022 13:08:12 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPUlP-00038j-33;
        Sat, 20 Aug 2022 20:08:11 +0000
Date:   Sun, 21 Aug 2022 04:07:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: drivers/message/fusion/mptlan.c:1177:21: sparse: sparse: cast to
 restricted __le16
Message-ID: <202208210318.I5GlR6yM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f31c32efd57c860f2b237a08327840f8444362f3
commit: 57fc7323a8e7c2e7c1d5795ab63cb3ffea3cfdfb LoongArch: Add PCI controller support
date:   9 days ago
config: loongarch-randconfig-s033-20220820 (https://download.01.org/0day-ci/archive/20220821/202208210318.I5GlR6yM-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=57fc7323a8e7c2e7c1d5795ab63cb3ffea3cfdfb
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 57fc7323a8e7c2e7c1d5795ab63cb3ffea3cfdfb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/message/fusion/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/message/fusion/mptlan.c:1177:21: sparse: sparse: cast to restricted __le16
>> drivers/message/fusion/mptlan.c:1240:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] TransactionContext @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:1240:52: sparse:     expected unsigned int [usertype] TransactionContext
   drivers/message/fusion/mptlan.c:1240:52: sparse:     got restricted __le32 [usertype]
>> drivers/message/fusion/mptlan.c:1244:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] FlagsLength @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:1244:46: sparse:     expected unsigned int [usertype] FlagsLength
   drivers/message/fusion/mptlan.c:1244:46: sparse:     got restricted __le32 [usertype]
>> drivers/message/fusion/mptlan.c:1248:46: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] Low @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:1248:46: sparse:     expected unsigned int [usertype] Low
   drivers/message/fusion/mptlan.c:1248:46: sparse:     got restricted __le32 [usertype]
>> drivers/message/fusion/mptlan.c:1250:55: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] High @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:1250:55: sparse:     expected unsigned int [usertype] High
   drivers/message/fusion/mptlan.c:1250:55: sparse:     got restricted __le32 [usertype]
>> drivers/message/fusion/mptlan.c:1264:38: sparse: sparse: invalid assignment: |=
>> drivers/message/fusion/mptlan.c:1264:38: sparse:    left side has type unsigned int
>> drivers/message/fusion/mptlan.c:1264:38: sparse:    right side has type restricted __le32
>> drivers/message/fusion/mptlan.c:1266:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] BucketCount @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:1266:39: sparse:     expected unsigned int [usertype] BucketCount
   drivers/message/fusion/mptlan.c:1266:39: sparse:     got restricted __le32 [usertype]
>> drivers/message/fusion/mptlan.c:969:25: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:974:9: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:977:14: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:981:15: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:986:17: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:991:18: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:995:18: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:1025:31: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:612:9: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:617:17: sparse: sparse: cast to restricted __le16
   drivers/message/fusion/mptlan.c:641:23: sparse: sparse: cast to restricted __le32
   drivers/message/fusion/mptlan.c:346:17: sparse: sparse: cast to restricted __le32
>> drivers/message/fusion/mptlan.c:1498:27: sparse: sparse: restricted __be16 degrades to integer
>> drivers/message/fusion/mptlan.c:1535:29: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned short @@     got restricted __be16 [usertype] ethertype @@
   drivers/message/fusion/mptlan.c:1535:29: sparse:     expected unsigned short
   drivers/message/fusion/mptlan.c:1535:29: sparse:     got restricted __be16 [usertype] ethertype
>> drivers/message/fusion/mptlan.c:1538:16: sparse: sparse: incorrect type in return expression (different base types) @@     expected unsigned short @@     got restricted __be16 [usertype] @@
   drivers/message/fusion/mptlan.c:1538:16: sparse:     expected unsigned short
   drivers/message/fusion/mptlan.c:1538:16: sparse:     got restricted __be16 [usertype]
   drivers/message/fusion/mptlan.c:746:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] TransactionContext @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:746:36: sparse:     expected unsigned int [usertype] TransactionContext
   drivers/message/fusion/mptlan.c:746:36: sparse:     got restricted __le32 [usertype]
>> drivers/message/fusion/mptlan.c:754:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:754:39: sparse:     expected unsigned int
   drivers/message/fusion/mptlan.c:754:39: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptlan.c:757:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:757:39: sparse:     expected unsigned int
   drivers/message/fusion/mptlan.c:757:39: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptlan.c:767:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] FlagsLength @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:767:30: sparse:     expected unsigned int [usertype] FlagsLength
   drivers/message/fusion/mptlan.c:767:30: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptlan.c:776:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] Low @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:776:30: sparse:     expected unsigned int [usertype] Low
   drivers/message/fusion/mptlan.c:776:30: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptlan.c:778:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] High @@     got restricted __le32 [usertype] @@
   drivers/message/fusion/mptlan.c:778:39: sparse:     expected unsigned int [usertype] High
   drivers/message/fusion/mptlan.c:778:39: sparse:     got restricted __le32 [usertype]
   drivers/message/fusion/mptlan.c:785:9: sparse: sparse: cast to restricted __le32
>> drivers/message/fusion/mptlan.c:820:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] protocol @@     got unsigned short @@
   drivers/message/fusion/mptlan.c:820:23: sparse:     expected restricted __be16 [usertype] protocol
   drivers/message/fusion/mptlan.c:820:23: sparse:     got unsigned short
   drivers/message/fusion/mptlan.c:924:23: sparse: sparse: cast to restricted __le32

vim +1177 drivers/message/fusion/mptlan.c

^1da177e4c3f41 Linus Torvalds      2005-04-16  1139  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1140  static void
c4028958b6ecad David Howells       2006-11-22  1141  mpt_lan_post_receive_buckets(struct mpt_lan_priv *priv)
^1da177e4c3f41 Linus Torvalds      2005-04-16  1142  {
c4028958b6ecad David Howells       2006-11-22  1143  	struct net_device *dev = priv->dev;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1144  	MPT_ADAPTER *mpt_dev = priv->mpt_dev;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1145  	MPT_FRAME_HDR *mf;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1146  	LANReceivePostRequest_t *pRecvReq;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1147  	SGETransaction32_t *pTrans;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1148  	SGESimple64_t *pSimple;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1149  	struct sk_buff *skb;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1150  	dma_addr_t dma;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1151  	u32 curr, buckets, count, max;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1152  	u32 len = (dev->mtu + dev->hard_header_len + 4);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1153  	unsigned long flags;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1154  	int i;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1155  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1156  	curr = atomic_read(&priv->buckets_out);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1157  	buckets = (priv->max_buckets_out - curr);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1158  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1159  	dioprintk((KERN_INFO MYNAM ": %s/%s: @%s, Start_buckets = %u, buckets_out = %u\n",
^1da177e4c3f41 Linus Torvalds      2005-04-16  1160  			IOC_AND_NETDEV_NAMES_s_s(dev),
cadbd4a5e36dde Harvey Harrison     2008-07-03  1161  			__func__, buckets, curr));
^1da177e4c3f41 Linus Torvalds      2005-04-16  1162  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1163  	max = (mpt_dev->req_sz - MPT_LAN_RECEIVE_POST_REQUEST_SIZE) /
4e2e619f3c9e3c Gustavo A. R. Silva 2021-03-24  1164  			(sizeof(SGETransaction32_t) + sizeof(SGESimple64_t));
^1da177e4c3f41 Linus Torvalds      2005-04-16  1165  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1166  	while (buckets) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  1167  		mf = mpt_get_msg_frame(LanCtx, mpt_dev);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1168  		if (mf == NULL) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  1169  			printk (KERN_ERR "%s: Unable to alloc request frame\n",
cadbd4a5e36dde Harvey Harrison     2008-07-03  1170  				__func__);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1171  			dioprintk((KERN_ERR "%s: %u buckets remaining\n",
cadbd4a5e36dde Harvey Harrison     2008-07-03  1172  				 __func__, buckets));
^1da177e4c3f41 Linus Torvalds      2005-04-16  1173  			goto out;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1174  		}
^1da177e4c3f41 Linus Torvalds      2005-04-16  1175  		pRecvReq = (LANReceivePostRequest_t *) mf;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1176  
e1fc2b5167f9c3 Eric Moore          2007-09-29 @1177  		i = le16_to_cpu(mf->u.frame.hwhdr.msgctxu.fld.req_idx);
e1fc2b5167f9c3 Eric Moore          2007-09-29  1178  		mpt_dev->RequestNB[i] = 0;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1179  		count = buckets;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1180  		if (count > max)
^1da177e4c3f41 Linus Torvalds      2005-04-16  1181  			count = max;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1182  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1183  		pRecvReq->Function    = MPI_FUNCTION_LAN_RECEIVE;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1184  		pRecvReq->ChainOffset = 0;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1185  		pRecvReq->MsgFlags    = 0;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1186  		pRecvReq->PortNumber  = priv->pnum;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1187  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1188  		pTrans = (SGETransaction32_t *) pRecvReq->SG_List;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1189  		pSimple = NULL;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1190  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1191  		for (i = 0; i < count; i++) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  1192  			int ctx;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1193  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1194  			spin_lock_irqsave(&priv->rxfidx_lock, flags);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1195  			if (priv->mpt_rxfidx_tail < 0) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  1196  				printk (KERN_ERR "%s: Can't alloc context\n",
cadbd4a5e36dde Harvey Harrison     2008-07-03  1197  					__func__);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1198  				spin_unlock_irqrestore(&priv->rxfidx_lock,
^1da177e4c3f41 Linus Torvalds      2005-04-16  1199  						       flags);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1200  				break;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1201  			}
^1da177e4c3f41 Linus Torvalds      2005-04-16  1202  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1203  			ctx = priv->mpt_rxfidx[priv->mpt_rxfidx_tail--];
^1da177e4c3f41 Linus Torvalds      2005-04-16  1204  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1205  			skb = priv->RcvCtl[ctx].skb;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1206  			if (skb && (priv->RcvCtl[ctx].len != len)) {
b114dda6f2f10c Christophe JAILLET  2022-01-06  1207  				dma_unmap_single(&mpt_dev->pcidev->dev,
^1da177e4c3f41 Linus Torvalds      2005-04-16  1208  						 priv->RcvCtl[ctx].dma,
^1da177e4c3f41 Linus Torvalds      2005-04-16  1209  						 priv->RcvCtl[ctx].len,
b114dda6f2f10c Christophe JAILLET  2022-01-06  1210  						 DMA_FROM_DEVICE);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1211  				dev_kfree_skb(priv->RcvCtl[ctx].skb);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1212  				skb = priv->RcvCtl[ctx].skb = NULL;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1213  			}
^1da177e4c3f41 Linus Torvalds      2005-04-16  1214  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1215  			if (skb == NULL) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  1216  				skb = dev_alloc_skb(len);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1217  				if (skb == NULL) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  1218  					printk (KERN_WARNING
^1da177e4c3f41 Linus Torvalds      2005-04-16  1219  						MYNAM "/%s: Can't alloc skb\n",
cadbd4a5e36dde Harvey Harrison     2008-07-03  1220  						__func__);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1221  					priv->mpt_rxfidx[++priv->mpt_rxfidx_tail] = ctx;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1222  					spin_unlock_irqrestore(&priv->rxfidx_lock, flags);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1223  					break;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1224  				}
^1da177e4c3f41 Linus Torvalds      2005-04-16  1225  
b114dda6f2f10c Christophe JAILLET  2022-01-06  1226  				dma = dma_map_single(&mpt_dev->pcidev->dev,
b114dda6f2f10c Christophe JAILLET  2022-01-06  1227  						     skb->data, len,
b114dda6f2f10c Christophe JAILLET  2022-01-06  1228  						     DMA_FROM_DEVICE);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1229  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1230  				priv->RcvCtl[ctx].skb = skb;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1231  				priv->RcvCtl[ctx].dma = dma;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1232  				priv->RcvCtl[ctx].len = len;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1233  			}
^1da177e4c3f41 Linus Torvalds      2005-04-16  1234  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1235  			spin_unlock_irqrestore(&priv->rxfidx_lock, flags);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1236  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1237  			pTrans->ContextSize   = sizeof(u32);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1238  			pTrans->DetailsLength = 0;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1239  			pTrans->Flags         = 0;
4e2e619f3c9e3c Gustavo A. R. Silva 2021-03-24 @1240  			pTrans->TransactionContext = cpu_to_le32(ctx);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1241  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1242  			pSimple = (SGESimple64_t *) pTrans->TransactionDetails;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1243  
^1da177e4c3f41 Linus Torvalds      2005-04-16 @1244  			pSimple->FlagsLength = cpu_to_le32(
^1da177e4c3f41 Linus Torvalds      2005-04-16  1245  				((MPI_SGE_FLAGS_END_OF_BUFFER |
^1da177e4c3f41 Linus Torvalds      2005-04-16  1246  				  MPI_SGE_FLAGS_SIMPLE_ELEMENT |
^1da177e4c3f41 Linus Torvalds      2005-04-16  1247  				  MPI_SGE_FLAGS_64_BIT_ADDRESSING) << MPI_SGE_FLAGS_SHIFT) | len);
^1da177e4c3f41 Linus Torvalds      2005-04-16 @1248  			pSimple->Address.Low = cpu_to_le32((u32) priv->RcvCtl[ctx].dma);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1249  			if (sizeof(dma_addr_t) > sizeof(u32))
^1da177e4c3f41 Linus Torvalds      2005-04-16 @1250  				pSimple->Address.High = cpu_to_le32((u32) ((u64) priv->RcvCtl[ctx].dma >> 32));
^1da177e4c3f41 Linus Torvalds      2005-04-16  1251  			else
^1da177e4c3f41 Linus Torvalds      2005-04-16  1252  				pSimple->Address.High = 0;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1253  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1254  			pTrans = (SGETransaction32_t *) (pSimple + 1);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1255  		}
^1da177e4c3f41 Linus Torvalds      2005-04-16  1256  
^1da177e4c3f41 Linus Torvalds      2005-04-16  1257  		if (pSimple == NULL) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  1258  /**/			printk (KERN_WARNING MYNAM "/%s: No buckets posted\n",
cadbd4a5e36dde Harvey Harrison     2008-07-03  1259  /**/				__func__);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1260  			mpt_free_msg_frame(mpt_dev, mf);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1261  			goto out;
^1da177e4c3f41 Linus Torvalds      2005-04-16  1262  		}
^1da177e4c3f41 Linus Torvalds      2005-04-16  1263  
^1da177e4c3f41 Linus Torvalds      2005-04-16 @1264  		pSimple->FlagsLength |= cpu_to_le32(MPI_SGE_FLAGS_END_OF_LIST << MPI_SGE_FLAGS_SHIFT);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1265  
^1da177e4c3f41 Linus Torvalds      2005-04-16 @1266  		pRecvReq->BucketCount = cpu_to_le32(i);
^1da177e4c3f41 Linus Torvalds      2005-04-16  1267  

:::::: The code at line 1177 was first introduced by commit
:::::: e1fc2b5167f9c3614099e55d3f49763a26a5a339 [SCSI] mptlan: bug fix, only half the message frame is dma'd resulting in corruption

:::::: TO: Eric Moore <eric.moore@lsi.com>
:::::: CC: James Bottomley <jejb@mulgrave.localdomain>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
