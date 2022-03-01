Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2911C4C7F29
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 01:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbiCAA0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 19:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiCAA0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 19:26:20 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2064CD48
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 16:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646094340; x=1677630340;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=F60nCeJxhMM1qvPB/Mi0kNCoGRaaxp9NNgVcv/Ja1v4=;
  b=DXuS9uBhXr9rKjQYIPljFDpLOzOdpiq5skOwN7wnV64WkK+BUjbUF8fw
   59L8dlkI982/PrV/bubwwq8YTskH8F+NevYsRX6sWauUtqNZF2hrR12jX
   FlZfxD67sxkQ3qKC+n7CAJ5xWVad0J20rsO0dX0KselsmXZMr1McK7EOn
   UtjgBa8Q1J6EmUlwFTBR07PbLlPiUqR7Ls9epqqli81rE2sVCVzQ9XxxU
   6OPPR0O1pX7Q7FCfmxUj9VD4n5to7gAo/eLB9lH2v9OjI1ro63GKdFCuB
   Nkjk4emB7pXODvBElv7Uzk+HOtLAqb/g38IQLqgX3koBM1frV7ciV85+J
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="253212641"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="253212641"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 16:25:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="510297676"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Feb 2022 16:25:38 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOqKf-0007w0-C9; Tue, 01 Mar 2022 00:25:37 +0000
Date:   Tue, 1 Mar 2022 08:24:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wang Qing <wangqing@vivo.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:netdev/net-next/master 81/85]
 drivers/net/hamradio/dmascc.c:1357:83: error: expected ')' before '{' token
Message-ID: <202203010813.uYqLFxOY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block netdev/net-next/master
head:   0b9e69e1a1e4d60473486d15217845ae1e151d4a
commit: 61c4fb9c4d09dfb6f33690169560862d5d0e42f7 [81/85] net: hamradio: use time_is_after_jiffies() instead of open coding it
config: alpha-buildonly-randconfig-r005-20220227 (https://download.01.org/0day-ci/archive/20220301/202203010813.uYqLFxOY-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/61c4fb9c4d09dfb6f33690169560862d5d0e42f7
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block netdev/net-next/master
        git checkout 61c4fb9c4d09dfb6f33690169560862d5d0e42f7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/net/hamradio/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/hamradio/dmascc.c: In function 'es_isr':
>> drivers/net/hamradio/dmascc.c:1357:83: error: expected ')' before '{' token
    1357 |                     time_is_after_jiffies(priv->tx_start + priv->param.txtimeout) {
         |                                                                                   ^
   drivers/net/hamradio/dmascc.c:1356:20: note: to match this '('
    1356 |                 if (priv->tx_count &&
         |                    ^
>> drivers/net/hamradio/dmascc.c:1364:9: error: expected expression before '}' token
    1364 |         }
         |         ^


vim +1357 drivers/net/hamradio/dmascc.c

  1305	
  1306	
  1307	static void es_isr(struct scc_priv *priv)
  1308	{
  1309		int i, rr0, drr0, res;
  1310		unsigned long flags;
  1311	
  1312		/* Read status, reset interrupt bit (open latches) */
  1313		rr0 = read_scc(priv, R0);
  1314		write_scc(priv, R0, RES_EXT_INT);
  1315		drr0 = priv->rr0 ^ rr0;
  1316		priv->rr0 = rr0;
  1317	
  1318		/* Transmit underrun (2.4.9.6). We can't check the TxEOM flag, since
  1319		   it might have already been cleared again by AUTOEOM. */
  1320		if (priv->state == TX_DATA) {
  1321			/* Get remaining bytes */
  1322			i = priv->tx_tail;
  1323			if (priv->param.dma >= 0) {
  1324				disable_dma(priv->param.dma);
  1325				flags = claim_dma_lock();
  1326				res = get_dma_residue(priv->param.dma);
  1327				release_dma_lock(flags);
  1328			} else {
  1329				res = priv->tx_len[i] - priv->tx_ptr;
  1330				priv->tx_ptr = 0;
  1331			}
  1332			/* Disable DREQ / TX interrupt */
  1333			if (priv->param.dma >= 0 && priv->type == TYPE_TWIN)
  1334				outb(0, priv->card_base + TWIN_DMA_CFG);
  1335			else
  1336				write_scc(priv, R1, EXT_INT_ENAB | WT_FN_RDYFN);
  1337			if (res) {
  1338				/* Update packet statistics */
  1339				priv->dev->stats.tx_errors++;
  1340				priv->dev->stats.tx_fifo_errors++;
  1341				/* Other underrun interrupts may already be waiting */
  1342				write_scc(priv, R0, RES_EXT_INT);
  1343				write_scc(priv, R0, RES_EXT_INT);
  1344			} else {
  1345				/* Update packet statistics */
  1346				priv->dev->stats.tx_packets++;
  1347				priv->dev->stats.tx_bytes += priv->tx_len[i];
  1348				/* Remove frame from FIFO */
  1349				priv->tx_tail = (i + 1) % NUM_TX_BUF;
  1350				priv->tx_count--;
  1351				/* Inform upper layers */
  1352				netif_wake_queue(priv->dev);
  1353			}
  1354			/* Switch state */
  1355			write_scc(priv, R15, 0);
  1356			if (priv->tx_count &&
> 1357			    time_is_after_jiffies(priv->tx_start + priv->param.txtimeout) {
  1358				priv->state = TX_PAUSE;
  1359				start_timer(priv, priv->param.txpause, 0);
  1360			} else {
  1361				priv->state = TX_TAIL;
  1362				start_timer(priv, priv->param.txtail, 0);
  1363			}
> 1364		}
  1365	
  1366		/* DCD transition */
  1367		if (drr0 & DCD) {
  1368			if (rr0 & DCD) {
  1369				switch (priv->state) {
  1370				case IDLE:
  1371				case WAIT:
  1372					priv->state = DCD_ON;
  1373					write_scc(priv, R15, 0);
  1374					start_timer(priv, priv->param.dcdon, 0);
  1375				}
  1376			} else {
  1377				switch (priv->state) {
  1378				case RX_ON:
  1379					rx_off(priv);
  1380					priv->state = DCD_OFF;
  1381					write_scc(priv, R15, 0);
  1382					start_timer(priv, priv->param.dcdoff, 0);
  1383				}
  1384			}
  1385		}
  1386	
  1387		/* CTS transition */
  1388		if ((drr0 & CTS) && (~rr0 & CTS) && priv->type != TYPE_TWIN)
  1389			tm_isr(priv);
  1390	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
