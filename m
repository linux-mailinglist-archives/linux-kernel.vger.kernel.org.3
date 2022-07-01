Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2785563B84
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 23:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiGAVAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 17:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiGAVAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 17:00:11 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBEA68A3F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 14:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656709210; x=1688245210;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rf8HT950/V1tx+eLpNTg8Num1burT6Aodou+IMQfb+A=;
  b=iuKFnXdnmpqvAeqHwWRNdkCWt79dcSRgzb1EHC4wP1XKv7OoVy6rHv81
   4WirkGaPyCDhWvj/b0+HiAKbx783eY6DqgNNB5ha1s++nQGKD5zy5INgn
   la2S8tgApZV2nwMUwHGEeWSFL+hf2+tb6SKDF0iRe8cL4XCfM1aWRjYSa
   jVl8KmXXaecxtAM+Th+WoPDHXqM7fpycP+oqX5dGw5i/184WE6V+CBbYS
   kveDnO3zMsSsN4ZT8216DieLXxwwXGSw+7D1F3syJkk8mYBQn93nwqvl3
   rbsIRPDEBvBaNHDyVWe9hV9jrMbc7mt9YWXvqcYjdRt0vqeKg2J9Vw65r
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="271515797"
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="271515797"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 14:00:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="838183172"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 01 Jul 2022 14:00:04 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7NkC-000ELu-42;
        Fri, 01 Jul 2022 21:00:04 +0000
Date:   Sat, 2 Jul 2022 04:59:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:bluetooth-wip 3/3]
 drivers/bluetooth/hci_bcm43xx.c:1187:29: error: passing argument 3 of
 'dmam_alloc_coherent' from incompatible pointer type
Message-ID: <202207020450.cvFsdSzR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bluetooth-wip
head:   ae58697c8114c393cfdf5da0a1331a61b3766321
commit: ae58697c8114c393cfdf5da0a1331a61b3766321 [3/3] WIP:/DO-NOT-MERGE: bluetooth
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220702/202207020450.cvFsdSzR-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/AsahiLinux/linux/commit/ae58697c8114c393cfdf5da0a1331a61b3766321
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bluetooth-wip
        git checkout ae58697c8114c393cfdf5da0a1331a61b3766321
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/bluetooth/hci_bcm43xx.c: In function 'bcm43xx_init_context':
>> drivers/bluetooth/hci_bcm43xx.c:1187:29: error: passing argument 3 of 'dmam_alloc_coherent' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1187 |                             &bcm43xx->ctx->per_info_addr, GFP_KERNEL);
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                             |
         |                             __le64 * {aka long long unsigned int *}
   In file included from include/linux/pci.h:2484,
                    from drivers/bluetooth/hci_bcm43xx.c:28:
   include/linux/dma-mapping.h:550:29: note: expected 'dma_addr_t *' {aka 'unsigned int *'} but argument is of type '__le64 *' {aka 'long long unsigned int *'}
     550 |                 dma_addr_t *dma_handle, gfp_t gfp)
         |                 ~~~~~~~~~~~~^~~~~~~~~~
   drivers/bluetooth/hci_bcm43xx.c: In function 'bcm43xx_setup_msi':
>> drivers/bluetooth/hci_bcm43xx.c:1373:15: error: implicit declaration of function 'irq_chip_compose_msi_msg' [-Werror=implicit-function-declaration]
    1373 |         ret = irq_chip_compose_msi_msg(irq_get_irq_data(bcm43xx->irq),
         |               ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/bluetooth/hci_bcm43xx.c:1373:40: error: implicit declaration of function 'irq_get_irq_data'; did you mean 'irq_set_irq_wake'? [-Werror=implicit-function-declaration]
    1373 |         ret = irq_chip_compose_msi_msg(irq_get_irq_data(bcm43xx->irq),
         |                                        ^~~~~~~~~~~~~~~~
         |                                        irq_set_irq_wake
   cc1: some warnings being treated as errors


vim +/dmam_alloc_coherent +1187 drivers/bluetooth/hci_bcm43xx.c

  1163	
  1164	static int bcm43xx_init_context(struct bcm43xx_data *bcm43xx)
  1165	{
  1166		struct device *dev = &bcm43xx->pdev->dev;
  1167	
  1168		bcm43xx->ctx = dmam_alloc_coherent(dev, sizeof(*bcm43xx->ctx),
  1169						   &bcm43xx->ctx_dma, GFP_KERNEL);
  1170		if (!bcm43xx->ctx)
  1171			return -ENOMEM;
  1172		memset(bcm43xx->ctx, 0, sizeof(*bcm43xx->ctx));
  1173	
  1174		bcm43xx->ring_state =
  1175			dmam_alloc_coherent(dev, sizeof(*bcm43xx->ring_state),
  1176					    &bcm43xx->ring_state_dma, GFP_KERNEL);
  1177		if (!bcm43xx->ring_state)
  1178			return -ENOMEM;
  1179		memset(bcm43xx->ring_state, 0, sizeof(*bcm43xx->ring_state));
  1180	
  1181		bcm43xx->ctx->version = cpu_to_le16(1);
  1182		bcm43xx->ctx->size = cpu_to_le16(sizeof(*bcm43xx->ctx));
  1183		bcm43xx->ctx->enabled_caps = cpu_to_le16(2);
  1184	
  1185		// TODO: do we actually care about the contents here?
  1186		dmam_alloc_coherent(&bcm43xx->pdev->dev, PAGE_SIZE,
> 1187				    &bcm43xx->ctx->per_info_addr, GFP_KERNEL);
  1188	
  1189		bcm43xx->ctx->xfer_ring_heads_addr =
  1190			bcm43xx->ring_state_dma +
  1191			offsetof(struct bcm43xx_ring_state, xfer_ring_head);
  1192		bcm43xx->ctx->xfer_ring_tails_addr =
  1193			bcm43xx->ring_state_dma +
  1194			offsetof(struct bcm43xx_ring_state, xfer_ring_tail);
  1195		bcm43xx->ctx->completion_ring_heads_addr =
  1196			bcm43xx->ring_state_dma +
  1197			offsetof(struct bcm43xx_ring_state, completion_ring_head);
  1198		bcm43xx->ctx->completion_ring_tails_addr =
  1199			bcm43xx->ring_state_dma +
  1200			offsetof(struct bcm43xx_ring_state, completion_ring_tail);
  1201	
  1202		bcm43xx->ctx->n_completion_rings =
  1203			cpu_to_le16(BCM43XX_N_COMPLETION_RINGS);
  1204		bcm43xx->ctx->n_xfer_rings = cpu_to_le16(BCM43XX_N_TRANSFER_RINGS);
  1205	
  1206		bcm43xx->ctx->control_completion_ring_addr =
  1207			cpu_to_le64(bcm43xx->control_ack_ring.ring_dma);
  1208		bcm43xx->ctx->control_completion_ring_n_entries =
  1209			cpu_to_le16(bcm43xx->control_ack_ring.n_entries);
  1210		bcm43xx->ctx->control_completion_ring_doorbell = cpu_to_le16(0xffff);
  1211		bcm43xx->ctx->control_completion_ring_msi = 0;
  1212		bcm43xx->ctx->control_completion_ring_header_size = 0;
  1213		bcm43xx->ctx->control_completion_ring_footer_size = 0;
  1214	
  1215		bcm43xx->ctx->control_xfer_ring_addr =
  1216			cpu_to_le64(bcm43xx->control_h2d_ring.ring_dma);
  1217		bcm43xx->ctx->control_xfer_ring_n_entries =
  1218			cpu_to_le16(bcm43xx->control_h2d_ring.n_entries);
  1219		bcm43xx->ctx->control_xfer_ring_doorbell =
  1220			cpu_to_le16(bcm43xx->control_h2d_ring.doorbell);
  1221		bcm43xx->ctx->control_xfer_ring_msi = 0;
  1222		bcm43xx->ctx->control_xfer_ring_header_size = 0;
  1223		bcm43xx->ctx->control_xfer_ring_footer_size =
  1224			bcm43xx->control_h2d_ring.payload_size / 4;
  1225	
  1226		return 0;
  1227	}
  1228	
  1229	static int bcm43xx_prepare_rings(struct bcm43xx_data *bcm43xx)
  1230	{
  1231		int ret;
  1232	
  1233		/*
  1234		 * Even though many of these settings appear to be configurable
  1235		 * when sending the "create ring" messages most of these are
  1236		 * actually hardcoded in some (and quite possibly all) firmware versions
  1237		 * and changing them on the host has no effect.
  1238		 * Specifically, this applies to at least the doorbells, the transfer
  1239		 * and completion ring ids and their mapping (e.g. both HCI and ACL
  1240		 * entries will always be queued in completion rings 1 and 2 no matter
  1241		 * what we configure here).
  1242		 */
  1243		bcm43xx->control_ack_ring.ring_id = BCM43XX_ACK_RING_CONTROL;
  1244		bcm43xx->control_ack_ring.n_entries = 128;
  1245		bcm43xx->control_ack_ring.transfer_rings =
  1246			BIT(BCM43XX_XFER_RING_CONTROL);
  1247	
  1248		bcm43xx->hci_acl_ack_ring.ring_id = BCM43XX_ACK_RING_HCI_ACL;
  1249		bcm43xx->hci_acl_ack_ring.n_entries = 256;
  1250		bcm43xx->hci_acl_ack_ring.transfer_rings =
  1251			BIT(BCM43XX_XFER_RING_HCI_H2D) | BIT(BCM43XX_XFER_RING_ACL_H2D);
  1252		bcm43xx->hci_acl_ack_ring.delay = 1000;
  1253	
  1254		bcm43xx->hci_acl_event_ring.ring_id = BCM43XX_EVENT_RING_HCI_ACL;
  1255		// TODO: this is just a max-sized HCI frame, but small for ACL?
  1256		bcm43xx->hci_acl_event_ring.payload_size = 4 * 66;
  1257		bcm43xx->hci_acl_event_ring.n_entries = 256;
  1258		bcm43xx->hci_acl_event_ring.transfer_rings =
  1259			BIT(BCM43XX_XFER_RING_HCI_D2H) | BIT(BCM43XX_XFER_RING_ACL_D2H);
  1260		bcm43xx->hci_acl_event_ring.delay = 1000;
  1261	
  1262		bcm43xx->sco_ack_ring.ring_id = BCM43XX_ACK_RING_SCO;
  1263		bcm43xx->sco_ack_ring.n_entries = 128;
  1264		bcm43xx->sco_ack_ring.transfer_rings = BIT(BCM43XX_XFER_RING_SCO_H2D);
  1265	
  1266		bcm43xx->sco_event_ring.ring_id = BCM43XX_EVENT_RING_SCO;
  1267		// TODO: this is just a max-sized SCO frame
  1268		bcm43xx->sco_event_ring.payload_size = 4 * 66;
  1269		bcm43xx->sco_event_ring.n_entries = 128;
  1270		bcm43xx->sco_event_ring.transfer_rings = BIT(BCM43XX_XFER_RING_SCO_D2H);
  1271	
  1272		bcm43xx->control_h2d_ring.ring_id = BCM43XX_XFER_RING_CONTROL;
  1273		bcm43xx->control_h2d_ring.doorbell = BCM43XX_DOORBELL_CONTROL;
  1274		bcm43xx->control_h2d_ring.payload_size = BCM43XX_CIPC_CONTROL_MSG_SIZE;
  1275		bcm43xx->control_h2d_ring.completion_ring = BCM43XX_ACK_RING_CONTROL;
  1276		bcm43xx->control_h2d_ring.allow_wait = true;
  1277		bcm43xx->control_h2d_ring.n_entries = 128;
  1278	
  1279		bcm43xx->hci_h2d_ring.ring_id = BCM43XX_XFER_RING_HCI_H2D;
  1280		bcm43xx->hci_h2d_ring.doorbell = BCM43XX_DOORBELL_HCI_H2D;
  1281		// TODO: this is just a max-sized HCI frame, what about ACL though?
  1282		bcm43xx->hci_h2d_ring.payload_size = 4 * 66;
  1283		bcm43xx->hci_h2d_ring.completion_ring = BCM43XX_ACK_RING_HCI_ACL;
  1284		bcm43xx->hci_h2d_ring.n_entries = 128;
  1285	
  1286		bcm43xx->hci_d2h_ring.ring_id = BCM43XX_XFER_RING_HCI_D2H;
  1287		bcm43xx->hci_d2h_ring.doorbell = BCM43XX_DOORBELL_HCI_D2H;
  1288		bcm43xx->hci_d2h_ring.completion_ring = BCM43XX_EVENT_RING_HCI_ACL;
  1289		bcm43xx->hci_d2h_ring.virtual = true;
  1290		bcm43xx->hci_d2h_ring.n_entries = 128;
  1291	
  1292		bcm43xx->sco_h2d_ring.ring_id = BCM43XX_XFER_RING_SCO_H2D;
  1293		bcm43xx->sco_h2d_ring.doorbell = BCM43XX_DOORBELL_SCO;
  1294		// TODO: this is just a max-sized SCO frame
  1295		bcm43xx->sco_h2d_ring.payload_size = 4 * 66;
  1296		bcm43xx->sco_h2d_ring.completion_ring = BCM43XX_ACK_RING_SCO;
  1297		bcm43xx->sco_h2d_ring.sync = true;
  1298		bcm43xx->sco_h2d_ring.n_entries = 128;
  1299	
  1300		bcm43xx->sco_d2h_ring.ring_id = BCM43XX_XFER_RING_SCO_D2H;
  1301		bcm43xx->sco_d2h_ring.doorbell = BCM43XX_DOORBELL_SCO;
  1302		bcm43xx->sco_d2h_ring.completion_ring = BCM43XX_EVENT_RING_SCO;
  1303		bcm43xx->sco_d2h_ring.virtual = true;
  1304		bcm43xx->sco_d2h_ring.sync = true;
  1305		bcm43xx->sco_d2h_ring.n_entries = 128;
  1306	
  1307		bcm43xx->acl_h2d_ring.ring_id = BCM43XX_XFER_RING_ACL_H2D;
  1308		bcm43xx->acl_h2d_ring.doorbell = BCM43XX_DOORBELL_ACL_H2D;
  1309		// TODO: this almost fits a max-size ACL frame
  1310		bcm43xx->acl_h2d_ring.payload_size = 4 * 252;
  1311		bcm43xx->acl_h2d_ring.completion_ring = BCM43XX_ACK_RING_HCI_ACL;
  1312		bcm43xx->acl_h2d_ring.n_entries = 128;
  1313	
  1314		bcm43xx->acl_d2h_ring.ring_id = BCM43XX_XFER_RING_ACL_D2H;
  1315		bcm43xx->acl_d2h_ring.doorbell = BCM43XX_DOORBELL_ACL_D2H;
  1316		bcm43xx->acl_d2h_ring.completion_ring = BCM43XX_EVENT_RING_HCI_ACL;
  1317		bcm43xx->acl_d2h_ring.virtual = true;
  1318		bcm43xx->acl_d2h_ring.n_entries = 128;
  1319	
  1320		/*
  1321		 * no need for any cleanup since this is only called from _probe
  1322		 * and only devres-managed allocations are used
  1323		 */
  1324		ret = bcm43xx_alloc_transfer_ring(bcm43xx, &bcm43xx->control_h2d_ring);
  1325		if (ret)
  1326			return ret;
  1327		ret = bcm43xx_alloc_transfer_ring(bcm43xx, &bcm43xx->hci_h2d_ring);
  1328		if (ret)
  1329			return ret;
  1330		ret = bcm43xx_alloc_transfer_ring(bcm43xx, &bcm43xx->hci_d2h_ring);
  1331		if (ret)
  1332			return ret;
  1333		ret = bcm43xx_alloc_transfer_ring(bcm43xx, &bcm43xx->sco_h2d_ring);
  1334		if (ret)
  1335			return ret;
  1336		ret = bcm43xx_alloc_transfer_ring(bcm43xx, &bcm43xx->sco_d2h_ring);
  1337		if (ret)
  1338			return ret;
  1339		ret = bcm43xx_alloc_transfer_ring(bcm43xx, &bcm43xx->acl_h2d_ring);
  1340		if (ret)
  1341			return ret;
  1342		ret = bcm43xx_alloc_transfer_ring(bcm43xx, &bcm43xx->acl_d2h_ring);
  1343		if (ret)
  1344			return ret;
  1345	
  1346		ret = bcm43xx_alloc_completion_ring(bcm43xx,
  1347						    &bcm43xx->control_ack_ring);
  1348		if (ret)
  1349			return ret;
  1350		ret = bcm43xx_alloc_completion_ring(bcm43xx,
  1351						    &bcm43xx->hci_acl_ack_ring);
  1352		if (ret)
  1353			return ret;
  1354		ret = bcm43xx_alloc_completion_ring(bcm43xx,
  1355						    &bcm43xx->hci_acl_event_ring);
  1356		if (ret)
  1357			return ret;
  1358		ret = bcm43xx_alloc_completion_ring(bcm43xx, &bcm43xx->sco_ack_ring);
  1359		if (ret)
  1360			return ret;
  1361		ret = bcm43xx_alloc_completion_ring(bcm43xx, &bcm43xx->sco_event_ring);
  1362		if (ret)
  1363			return ret;
  1364	
  1365		return 0;
  1366	}
  1367	
  1368	static int bcm43xx_setup_msi(struct bcm43xx_data *bcm43xx)
  1369	{
  1370		struct msi_msg msi_msg;
  1371		int ret;
  1372	
> 1373		ret = irq_chip_compose_msi_msg(irq_get_irq_data(bcm43xx->irq),
  1374					       &msi_msg);
  1375		if (ret)
  1376			return ret;
  1377	
  1378		iowrite32(msi_msg.address_lo, bcm43xx->bar0 + BCM43XX_BAR0_MSI_ADDR_LO);
  1379		iowrite32(msi_msg.address_hi, bcm43xx->bar0 + BCM43XX_BAR0_MSI_ADDR_HI);
  1380	
  1381		return 0;
  1382	}
  1383	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
