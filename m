Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DF556D846
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiGKIhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiGKIh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:37:26 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2804813D13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657528645; x=1689064645;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=g9SmQ8wfGwhk0MsY3t3oS2JR1R4VILZNOmqok5xSlNY=;
  b=EZb3W+4nEmgopYEtK1FNpBNrQLItnt+mPgVWG2An2evBimvdfiLjaqXh
   RRzfRkabXDues4lbLI0sb1SBWkmQ3C7N66qUDOQygN/QZn5l+dGMpM3wW
   egq17j4L7AxaDKBKB3XtKBsuYT2D6E07I4fdxuIONIg3rsN/FrjdvJjga
   pXLzaviiCNghS8iINLKoYoe2dMwFbd4MAXH200BpwjO/pf+6+0Eg4MIK6
   oCKyyAuWRz4k7gKwsnnTUTNpUBzyX+abnwRVS3QsPpKv+YOhWNEFmY3rB
   tHuxzDOTG2ofOZRpXT/kx4JXjNrbTb4Ya+ew2YeTk54E1K5Ul/7ugxUCV
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="370917816"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="370917816"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 01:37:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="621988207"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 11 Jul 2022 01:37:22 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oAouv-0000cz-Sp;
        Mon, 11 Jul 2022 08:37:21 +0000
Date:   Mon, 11 Jul 2022 16:36:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chen Lin <chen45464546@163.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.15.y 7889/8235]
 drivers/net/ethernet/mediatek/mtk_eth_soc.c:1325:23: warning: result of
 comparison of constant 65536 with expression of type 'u16' (aka 'unsigned
 short') is always true
Message-ID: <202207111644.LOc31cfI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
head:   eb18ccd146339b58faa47c1837f1b61ba05a1acf
commit: fcba12a4308143f1f1dcb0face8b3ffb51edcc5c [7889/8235] net: ethernet: mtk_eth_soc: fix misuse of mem alloc interface netdev[napi]_alloc_frag
config: arm64-randconfig-r003-20220710 (https://download.01.org/0day-ci/archive/20220711/202207111644.LOc31cfI-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6ce63e267aab79ca87bf63453d34dd3909ab978d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=fcba12a4308143f1f1dcb0face8b3ffb51edcc5c
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.15.y
        git checkout fcba12a4308143f1f1dcb0face8b3ffb51edcc5c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/net/ethernet/mediatek/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/mediatek/mtk_eth_soc.c:1325:23: warning: result of comparison of constant 65536 with expression of type 'u16' (aka 'unsigned short') is always true [-Wtautological-constant-out-of-range-compare]
                   if (ring->frag_size <= PAGE_SIZE)
                       ~~~~~~~~~~~~~~~ ^  ~~~~~~~~~
   drivers/net/ethernet/mediatek/mtk_eth_soc.c:1742:23: warning: result of comparison of constant 65536 with expression of type 'u16' (aka 'unsigned short') is always true [-Wtautological-constant-out-of-range-compare]
                   if (ring->frag_size <= PAGE_SIZE)
                       ~~~~~~~~~~~~~~~ ^  ~~~~~~~~~
   2 warnings generated.


vim +1325 drivers/net/ethernet/mediatek/mtk_eth_soc.c

  1277	
  1278	static int mtk_poll_rx(struct napi_struct *napi, int budget,
  1279			       struct mtk_eth *eth)
  1280	{
  1281		struct dim_sample dim_sample = {};
  1282		struct mtk_rx_ring *ring;
  1283		int idx;
  1284		struct sk_buff *skb;
  1285		u8 *data, *new_data;
  1286		struct mtk_rx_dma *rxd, trxd;
  1287		int done = 0, bytes = 0;
  1288	
  1289		while (done < budget) {
  1290			struct net_device *netdev;
  1291			unsigned int pktlen;
  1292			dma_addr_t dma_addr;
  1293			u32 hash;
  1294			int mac;
  1295	
  1296			ring = mtk_get_rx_ring(eth);
  1297			if (unlikely(!ring))
  1298				goto rx_done;
  1299	
  1300			idx = NEXT_DESP_IDX(ring->calc_idx, ring->dma_size);
  1301			rxd = &ring->dma[idx];
  1302			data = ring->data[idx];
  1303	
  1304			if (!mtk_rx_get_desc(&trxd, rxd))
  1305				break;
  1306	
  1307			/* find out which mac the packet come from. values start at 1 */
  1308			if (MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628) ||
  1309			    (trxd.rxd4 & RX_DMA_SPECIAL_TAG))
  1310				mac = 0;
  1311			else
  1312				mac = ((trxd.rxd4 >> RX_DMA_FPORT_SHIFT) &
  1313				       RX_DMA_FPORT_MASK) - 1;
  1314	
  1315			if (unlikely(mac < 0 || mac >= MTK_MAC_COUNT ||
  1316				     !eth->netdev[mac]))
  1317				goto release_desc;
  1318	
  1319			netdev = eth->netdev[mac];
  1320	
  1321			if (unlikely(test_bit(MTK_RESETTING, &eth->state)))
  1322				goto release_desc;
  1323	
  1324			/* alloc new buffer */
> 1325			if (ring->frag_size <= PAGE_SIZE)
  1326				new_data = napi_alloc_frag(ring->frag_size);
  1327			else
  1328				new_data = mtk_max_lro_buf_alloc(GFP_ATOMIC);
  1329			if (unlikely(!new_data)) {
  1330				netdev->stats.rx_dropped++;
  1331				goto release_desc;
  1332			}
  1333			dma_addr = dma_map_single(eth->dev,
  1334						  new_data + NET_SKB_PAD +
  1335						  eth->ip_align,
  1336						  ring->buf_size,
  1337						  DMA_FROM_DEVICE);
  1338			if (unlikely(dma_mapping_error(eth->dev, dma_addr))) {
  1339				skb_free_frag(new_data);
  1340				netdev->stats.rx_dropped++;
  1341				goto release_desc;
  1342			}
  1343	
  1344			dma_unmap_single(eth->dev, trxd.rxd1,
  1345					 ring->buf_size, DMA_FROM_DEVICE);
  1346	
  1347			/* receive data */
  1348			skb = build_skb(data, ring->frag_size);
  1349			if (unlikely(!skb)) {
  1350				skb_free_frag(data);
  1351				netdev->stats.rx_dropped++;
  1352				goto skip_rx;
  1353			}
  1354			skb_reserve(skb, NET_SKB_PAD + NET_IP_ALIGN);
  1355	
  1356			pktlen = RX_DMA_GET_PLEN0(trxd.rxd2);
  1357			skb->dev = netdev;
  1358			skb_put(skb, pktlen);
  1359			if (trxd.rxd4 & eth->rx_dma_l4_valid)
  1360				skb->ip_summed = CHECKSUM_UNNECESSARY;
  1361			else
  1362				skb_checksum_none_assert(skb);
  1363			skb->protocol = eth_type_trans(skb, netdev);
  1364			bytes += pktlen;
  1365	
  1366			hash = trxd.rxd4 & MTK_RXD4_FOE_ENTRY;
  1367			if (hash != MTK_RXD4_FOE_ENTRY) {
  1368				hash = jhash_1word(hash, 0);
  1369				skb_set_hash(skb, hash, PKT_HASH_TYPE_L4);
  1370			}
  1371	
  1372			if (netdev->features & NETIF_F_HW_VLAN_CTAG_RX &&
  1373			    (trxd.rxd2 & RX_DMA_VTAG))
  1374				__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
  1375						       RX_DMA_VID(trxd.rxd3));
  1376			skb_record_rx_queue(skb, 0);
  1377			napi_gro_receive(napi, skb);
  1378	
  1379	skip_rx:
  1380			ring->data[idx] = new_data;
  1381			rxd->rxd1 = (unsigned int)dma_addr;
  1382	
  1383	release_desc:
  1384			if (MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628))
  1385				rxd->rxd2 = RX_DMA_LSO;
  1386			else
  1387				rxd->rxd2 = RX_DMA_PLEN0(ring->buf_size);
  1388	
  1389			ring->calc_idx = idx;
  1390	
  1391			done++;
  1392		}
  1393	
  1394	rx_done:
  1395		if (done) {
  1396			/* make sure that all changes to the dma ring are flushed before
  1397			 * we continue
  1398			 */
  1399			wmb();
  1400			mtk_update_rx_cpu_idx(eth);
  1401		}
  1402	
  1403		eth->rx_packets += done;
  1404		eth->rx_bytes += bytes;
  1405		dim_update_sample(eth->rx_events, eth->rx_packets, eth->rx_bytes,
  1406				  &dim_sample);
  1407		net_dim(&eth->rx_dim, dim_sample);
  1408	
  1409		return done;
  1410	}
  1411	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
