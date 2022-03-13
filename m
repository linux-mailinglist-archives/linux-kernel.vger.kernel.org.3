Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B974D75EC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 15:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbiCMOrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 10:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbiCMOrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 10:47:08 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29D8723C5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 07:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647182760; x=1678718760;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=C1+fPtX4v5XBuVxo0iaCBJ6hRTM48ZxZEP3GnbDOMGw=;
  b=XwNkXnRyAB4Mvaos8TprNAtAO01xDuayXIo4JszReUt7Y/BEK6vYobG8
   V7xohUJCexvKJj7z+cJoOIQGO7/6xXy8tnxoQ6YDNqSXxqew8YuJJ6M8Q
   RLCo5hNpciY2FS05/8hxusvMLk/267tjs6KfIYTdKThUle1/DGUEmM5AA
   Yl8Y0KaBbGtJTFVpOWwHbgl0ZrtI7RP5txFodlI9KcAT4tU3/EgpYwbmB
   Dj5xOHh7Rv0O6wcpEm9MGXl76mdjHh4PoqtjW6PcOraKJNtva2t5yPksJ
   hOBi0LLcBvhAcU/JIfQ8bC1UbpzlvfcxeyzU9Mnw4rLIdBezewHEAF75o
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="235822601"
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="235822601"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 07:46:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="579851675"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 13 Mar 2022 07:45:58 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTPTq-00092J-AC; Sun, 13 Mar 2022 14:45:58 +0000
Date:   Sun, 13 Mar 2022 22:45:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:tls-upcall.v4 140/156]
 drivers/nvme/host/tcp.c:1429: undefined reference to
 `nvme_keyring_lookup_generated_key'
Message-ID: <202203132228.duAdAwbv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git tls-upcall.v4
head:   d2416ecdb6b03fc2e4aa40b20cdf919322713224
commit: 2025db31c639eb71ba4cd675cb846a14a48cd932 [140/156] nvme-tcp: derive retained keys for TLS
config: i386-randconfig-a012 (https://download.01.org/0day-ci/archive/20220313/202203132228.duAdAwbv-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=2025db31c639eb71ba4cd675cb846a14a48cd932
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel tls-upcall.v4
        git checkout 2025db31c639eb71ba4cd675cb846a14a48cd932
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: drivers/nvme/host/core.o: in function `nvme_core_exit':
   drivers/nvme/host/core.c:4946: undefined reference to `nvme_keyring_exit'
   ld: drivers/nvme/host/core.o: in function `nvme_core_init':
   drivers/nvme/host/core.c:4918: undefined reference to `nvme_keyring_init'
   ld: drivers/nvme/host/tcp.o: in function `nvme_tcp_lookup_psk':
>> drivers/nvme/host/tcp.c:1429: undefined reference to `nvme_keyring_lookup_generated_key'
>> ld: drivers/nvme/host/tcp.c:1431: undefined reference to `nvme_keyring_insert_tls'
   ld: drivers/nvme/host/tcp.c:1439: undefined reference to `nvme_keyring_lookup_tls'
   ld: drivers/nvme/host/tcp.c:1455: undefined reference to `nvme_keyring_lookup_generated_key'
   ld: drivers/nvme/host/tcp.c:1457: undefined reference to `nvme_keyring_insert_tls'
   ld: drivers/nvme/host/tcp.c:1465: undefined reference to `nvme_keyring_lookup_tls'
>> ld: drivers/nvme/host/tcp.c:1442: undefined reference to `nvme_keyring_lookup_retained_key'
   ld: drivers/nvme/host/tcp.c:1444: undefined reference to `nvme_keyring_insert_tls'
   ld: drivers/nvme/host/tcp.c:1468: undefined reference to `nvme_keyring_lookup_retained_key'
   ld: drivers/nvme/host/tcp.c:1470: undefined reference to `nvme_keyring_insert_tls'


vim +1429 drivers/nvme/host/tcp.c

  1403	
  1404	/*
  1405	 * nvme_tcp_lookup_psk - Look up PSKs to use for TLS
  1406	 *
  1407	 * We have several combinations to worry about:
  1408	 * 1) Host requires encryption (opts->tls is set)
  1409	 *    -> lookup pre-provisioned TLS PSKs; keys must be set for
  1410	 *       a connection to be allowed.
  1411	 * 2) Host allows encryptionn (opts->tls is not set)
  1412	 *    -> lookup pre-provisioned TLS PSK;
  1413	 *    -> lookup retained TLS key if no PSKs are found, and
  1414	 *       generate PSK based on the retained TLS key.
  1415	 *    -> Do not start TLS if no key (PSK or retained) is found.
  1416	 * 2) Host does not use encryption (opts->tls is not set)
  1417	 *    -> no keys are provisioned.
  1418	 */
  1419	static int nvme_tcp_lookup_psk(struct nvme_ctrl *nctrl, int qid,
  1420				       bool force_tls)
  1421	{
  1422		char *hostnqn = nctrl->opts->host->nqn;
  1423		char *subnqn = nvmf_ctrl_subsysnqn(nctrl);
  1424		int num_keys = 0;
  1425		struct key *generated_key, *retained_key, *tls_key;
  1426	
  1427		/* Check for pre-provisioned keys */
  1428		/* Generated key with hmac256 */
> 1429		generated_key = nvme_keyring_lookup_generated_key(hostnqn, subnqn, 1);
  1430		if (!IS_ERR(generated_key)) {
> 1431			tls_key = nvme_keyring_insert_tls(generated_key, nctrl,
  1432							  1, true);
  1433			if (!IS_ERR(tls_key)) {
  1434				key_put(tls_key);
  1435				num_keys++;
  1436			}
  1437		}
  1438		/* Retained key with hmac256 */
  1439		tls_key = nvme_keyring_lookup_tls(nctrl, 1, false);
  1440		if (IS_ERR(tls_key) && !force_tls) {
  1441			/* Not found, derive key from PSK if present */
> 1442			retained_key = nvme_keyring_lookup_retained_key(hostnqn, 1);
  1443			if (!IS_ERR(retained_key)) {
  1444				tls_key = nvme_keyring_insert_tls(retained_key, nctrl,
  1445								  1, false);
  1446				if (!IS_ERR(tls_key)) {
  1447					key_put(tls_key);
  1448					num_keys++;
  1449				}
  1450			}
  1451		} else
  1452			num_keys++;
  1453	
  1454		/* Generated key with hmac384 */
  1455		generated_key = nvme_keyring_lookup_generated_key(hostnqn, subnqn, 2);
  1456		if (!IS_ERR(generated_key)) {
  1457			tls_key = nvme_keyring_insert_tls(generated_key, nctrl,
  1458							  2, true);
  1459			if (!IS_ERR(tls_key)) {
  1460				key_put(tls_key);
  1461				num_keys++;
  1462			}
  1463		}
  1464		/* Retained key with hmac384 */
  1465		tls_key = nvme_keyring_lookup_tls(nctrl, 2, false);
  1466		if (IS_ERR(tls_key) && !force_tls) {
  1467			/* Not found, derive key from PSK if present */
  1468			retained_key = nvme_keyring_lookup_retained_key(hostnqn, 2);
  1469			if (!IS_ERR(retained_key)) {
  1470				tls_key = nvme_keyring_insert_tls(retained_key,
  1471								  nctrl, 2, false);
  1472				if (!IS_ERR(tls_key)) {
  1473					key_put(tls_key);
  1474					num_keys++;
  1475				}
  1476			}
  1477		} else
  1478			num_keys++;
  1479	
  1480		if (!num_keys)
  1481			return 0;
  1482	
  1483		dev_dbg(nctrl->device, "qid %d: start tls with %d keys\n",
  1484			qid, num_keys);
  1485		return num_keys;
  1486	}
  1487	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
