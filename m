Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CF95060BC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238696AbiDSAN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239622AbiDSANw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:13:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF89D656C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650327069; x=1681863069;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UewArZ+Ooa2YI69aAP9Gz6Djow2AUNwlruRAFuHwc2E=;
  b=gkkjrAI7CSK/HWKsWrUeo4fi9aXX0iOXCPtL4fPbJRkAq1AfHkmNEzmq
   DsqVdPr5HtrR1j7ZqXJ6NPCY3BoYsPHEw1MEG116Bn4yNwi5qa1ZTTazA
   R6X6jQow/7EPNWhTlFE6FC8gtd94n+K/vtFDrG2PDyi4Q4cRKtn9gXVEx
   RasBSUG7Tel69vOY8y/iS1+5GzIUGDRXYNKIQ4iYlz7QwWg7nN+F7sanO
   c3Ce0sPcC3d1U0zqy6SMAoOicc2CSU1JtVHHbGwRIcObJbLlNfRAEjQtu
   54Yxq4/0gG+9bP/0Hriud2IvJ1+KfyEM/Vsa54sAsCrUWb1+vppceu0gN
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="245530420"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="245530420"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 17:11:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="665587586"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 18 Apr 2022 17:11:07 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngbSV-00057I-6p;
        Tue, 19 Apr 2022 00:11:07 +0000
Date:   Tue, 19 Apr 2022 08:10:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1769/2356]
 drivers/bluetooth/btmtksdio.c:1393:21: warning: incompatible integer to
 pointer conversion assigning to 'struct device_node *' from 'int'
Message-ID: <202204190814.1ZbNhqrX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   af93551cf39027d176f30b9beafc60a4c130998a
commit: 9f931b54e4f33f52c5cc50956b4aa86a9395e4dc [1769/2356] headers/deps: of: Optimize <linux/of.h> dependencies, remove <linux/of_api.h>
config: i386-randconfig-a016-20220418 (https://download.01.org/0day-ci/archive/20220419/202204190814.1ZbNhqrX-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 429cbac0390654f90bba18a41799464adf31a5ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=9f931b54e4f33f52c5cc50956b4aa86a9395e4dc
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 9f931b54e4f33f52c5cc50956b4aa86a9395e4dc
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/bluetooth/ drivers/misc/ drivers/net/bonding/ drivers/net/ethernet/marvell/prestera/ drivers/net/ethernet/microchip/lan966x/ drivers/net/netdevsim/ drivers/net/phy/ drivers/power/supply/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/bluetooth/btmtksdio.c:1393:23: error: implicit declaration of function 'of_find_compatible_node' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
           bdev->dev->of_node = of_find_compatible_node(NULL, NULL,
                                ^
>> drivers/bluetooth/btmtksdio.c:1393:21: warning: incompatible integer to pointer conversion assigning to 'struct device_node *' from 'int' [-Wint-conversion]
           bdev->dev->of_node = of_find_compatible_node(NULL, NULL,
                              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 1 error generated.


vim +1393 drivers/bluetooth/btmtksdio.c

ce64b3e9491957 Mark Chen        2022-01-10  1312  
9aebfd4a2200ab Sean Wang        2019-03-08  1313  static int btmtksdio_probe(struct sdio_func *func,
9aebfd4a2200ab Sean Wang        2019-03-08  1314  			   const struct sdio_device_id *id)
9aebfd4a2200ab Sean Wang        2019-03-08  1315  {
9aebfd4a2200ab Sean Wang        2019-03-08  1316  	struct btmtksdio_dev *bdev;
9aebfd4a2200ab Sean Wang        2019-03-08  1317  	struct hci_dev *hdev;
9aebfd4a2200ab Sean Wang        2019-03-08  1318  	int err;
9aebfd4a2200ab Sean Wang        2019-03-08  1319  
9aebfd4a2200ab Sean Wang        2019-03-08  1320  	bdev = devm_kzalloc(&func->dev, sizeof(*bdev), GFP_KERNEL);
9aebfd4a2200ab Sean Wang        2019-03-08  1321  	if (!bdev)
9aebfd4a2200ab Sean Wang        2019-03-08  1322  		return -ENOMEM;
9aebfd4a2200ab Sean Wang        2019-03-08  1323  
9aebfd4a2200ab Sean Wang        2019-03-08  1324  	bdev->data = (void *)id->driver_data;
9aebfd4a2200ab Sean Wang        2019-03-08  1325  	if (!bdev->data)
9aebfd4a2200ab Sean Wang        2019-03-08  1326  		return -ENODEV;
9aebfd4a2200ab Sean Wang        2019-03-08  1327  
7f3c563c575e73 Sean Wang        2019-04-18  1328  	bdev->dev = &func->dev;
9aebfd4a2200ab Sean Wang        2019-03-08  1329  	bdev->func = func;
9aebfd4a2200ab Sean Wang        2019-03-08  1330  
26270bc189ea4b Sean Wang        2021-10-19  1331  	INIT_WORK(&bdev->txrx_work, btmtksdio_txrx_work);
9aebfd4a2200ab Sean Wang        2019-03-08  1332  	skb_queue_head_init(&bdev->txq);
9aebfd4a2200ab Sean Wang        2019-03-08  1333  
9aebfd4a2200ab Sean Wang        2019-03-08  1334  	/* Initialize and register HCI device */
9aebfd4a2200ab Sean Wang        2019-03-08  1335  	hdev = hci_alloc_dev();
9aebfd4a2200ab Sean Wang        2019-03-08  1336  	if (!hdev) {
9aebfd4a2200ab Sean Wang        2019-03-08  1337  		dev_err(&func->dev, "Can't allocate HCI device\n");
9aebfd4a2200ab Sean Wang        2019-03-08  1338  		return -ENOMEM;
9aebfd4a2200ab Sean Wang        2019-03-08  1339  	}
9aebfd4a2200ab Sean Wang        2019-03-08  1340  
9aebfd4a2200ab Sean Wang        2019-03-08  1341  	bdev->hdev = hdev;
9aebfd4a2200ab Sean Wang        2019-03-08  1342  
9aebfd4a2200ab Sean Wang        2019-03-08  1343  	hdev->bus = HCI_SDIO;
9aebfd4a2200ab Sean Wang        2019-03-08  1344  	hci_set_drvdata(hdev, bdev);
9aebfd4a2200ab Sean Wang        2019-03-08  1345  
9aebfd4a2200ab Sean Wang        2019-03-08  1346  	hdev->open     = btmtksdio_open;
9aebfd4a2200ab Sean Wang        2019-03-08  1347  	hdev->close    = btmtksdio_close;
8fafe702253d50 Chih-Ying Chiang 2022-02-09  1348  	hdev->cmd_timeout = btmtksdio_cmd_timeout;
9aebfd4a2200ab Sean Wang        2019-03-08  1349  	hdev->flush    = btmtksdio_flush;
9aebfd4a2200ab Sean Wang        2019-03-08  1350  	hdev->setup    = btmtksdio_setup;
9aebfd4a2200ab Sean Wang        2019-03-08  1351  	hdev->shutdown = btmtksdio_shutdown;
9aebfd4a2200ab Sean Wang        2019-03-08  1352  	hdev->send     = btmtksdio_send_frame;
ce64b3e9491957 Mark Chen        2022-01-10  1353  	hdev->wakeup   = btmtksdio_sdio_wakeup;
877ec9e1d07b63 Sean Wang        2021-10-19  1354  	hdev->set_bdaddr = btmtk_set_bdaddr;
877ec9e1d07b63 Sean Wang        2021-10-19  1355  
9aebfd4a2200ab Sean Wang        2019-03-08  1356  	SET_HCIDEV_DEV(hdev, &func->dev);
9aebfd4a2200ab Sean Wang        2019-03-08  1357  
9aebfd4a2200ab Sean Wang        2019-03-08  1358  	hdev->manufacturer = 70;
9aebfd4a2200ab Sean Wang        2019-03-08  1359  	set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
9aebfd4a2200ab Sean Wang        2019-03-08  1360  
b062a0b9c1dc1f Yake Yang        2022-03-17  1361  	sdio_set_drvdata(func, bdev);
b062a0b9c1dc1f Yake Yang        2022-03-17  1362  
9aebfd4a2200ab Sean Wang        2019-03-08  1363  	err = hci_register_dev(hdev);
9aebfd4a2200ab Sean Wang        2019-03-08  1364  	if (err < 0) {
9aebfd4a2200ab Sean Wang        2019-03-08  1365  		dev_err(&func->dev, "Can't register HCI device\n");
9aebfd4a2200ab Sean Wang        2019-03-08  1366  		hci_free_dev(hdev);
9aebfd4a2200ab Sean Wang        2019-03-08  1367  		return err;
9aebfd4a2200ab Sean Wang        2019-03-08  1368  	}
9aebfd4a2200ab Sean Wang        2019-03-08  1369  
7f3c563c575e73 Sean Wang        2019-04-18  1370  	/* pm_runtime_enable would be done after the firmware is being
7f3c563c575e73 Sean Wang        2019-04-18  1371  	 * downloaded because the core layer probably already enables
7f3c563c575e73 Sean Wang        2019-04-18  1372  	 * runtime PM for this func such as the case host->caps &
7f3c563c575e73 Sean Wang        2019-04-18  1373  	 * MMC_CAP_POWER_OFF_CARD.
7f3c563c575e73 Sean Wang        2019-04-18  1374  	 */
7f3c563c575e73 Sean Wang        2019-04-18  1375  	if (pm_runtime_enabled(bdev->dev))
7f3c563c575e73 Sean Wang        2019-04-18  1376  		pm_runtime_disable(bdev->dev);
7f3c563c575e73 Sean Wang        2019-04-18  1377  
7f3c563c575e73 Sean Wang        2019-04-18  1378  	/* As explaination in drivers/mmc/core/sdio_bus.c tells us:
7f3c563c575e73 Sean Wang        2019-04-18  1379  	 * Unbound SDIO functions are always suspended.
7f3c563c575e73 Sean Wang        2019-04-18  1380  	 * During probe, the function is set active and the usage count
7f3c563c575e73 Sean Wang        2019-04-18  1381  	 * is incremented.  If the driver supports runtime PM,
7f3c563c575e73 Sean Wang        2019-04-18  1382  	 * it should call pm_runtime_put_noidle() in its probe routine and
7f3c563c575e73 Sean Wang        2019-04-18  1383  	 * pm_runtime_get_noresume() in its remove routine.
7f3c563c575e73 Sean Wang        2019-04-18  1384  	 *
7f3c563c575e73 Sean Wang        2019-04-18  1385  	 * So, put a pm_runtime_put_noidle here !
7f3c563c575e73 Sean Wang        2019-04-18  1386  	 */
7f3c563c575e73 Sean Wang        2019-04-18  1387  	pm_runtime_put_noidle(bdev->dev);
7f3c563c575e73 Sean Wang        2019-04-18  1388  
ce64b3e9491957 Mark Chen        2022-01-10  1389  	err = device_init_wakeup(bdev->dev, true);
ce64b3e9491957 Mark Chen        2022-01-10  1390  	if (err)
ce64b3e9491957 Mark Chen        2022-01-10  1391  		bt_dev_err(hdev, "failed to initialize device wakeup");
ce64b3e9491957 Mark Chen        2022-01-10  1392  
8fafe702253d50 Chih-Ying Chiang 2022-02-09 @1393  	bdev->dev->of_node = of_find_compatible_node(NULL, NULL,
8fafe702253d50 Chih-Ying Chiang 2022-02-09  1394  						     "mediatek,mt7921s-bluetooth");
8fafe702253d50 Chih-Ying Chiang 2022-02-09  1395  	bdev->reset = devm_gpiod_get_optional(bdev->dev, "reset",
8fafe702253d50 Chih-Ying Chiang 2022-02-09  1396  					      GPIOD_OUT_LOW);
8fafe702253d50 Chih-Ying Chiang 2022-02-09  1397  	if (IS_ERR(bdev->reset))
8fafe702253d50 Chih-Ying Chiang 2022-02-09  1398  		err = PTR_ERR(bdev->reset);
8fafe702253d50 Chih-Ying Chiang 2022-02-09  1399  
ce64b3e9491957 Mark Chen        2022-01-10  1400  	return err;
9aebfd4a2200ab Sean Wang        2019-03-08  1401  }
9aebfd4a2200ab Sean Wang        2019-03-08  1402  

:::::: The code at line 1393 was first introduced by commit
:::::: 8fafe702253d50bf90daf324ae86b5ad5ac8a5e1 Bluetooth: mt7921s: support bluetooth reset mechanism

:::::: TO: Chih-Ying Chiang <chih-yin.chiang@mediatek.com>
:::::: CC: Marcel Holtmann <marcel@holtmann.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
