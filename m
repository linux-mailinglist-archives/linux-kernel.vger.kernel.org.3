Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B974D7858
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 22:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbiCMVP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 17:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiCMVP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 17:15:28 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C8A2DAA1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 14:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647206060; x=1678742060;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2xnGeG+YflCYRNzddnzYRTRSJ7OyObHbMDP5oHxfGQ8=;
  b=DJh314Z0pp4P5QLlohFipPynTVtIavZWmmv3wqJv+ed7Ut9XsoQ7sKYO
   0K5DxLpSUFu523DUsIxrFvDoqW7nccvRxX6QM1Ehzaqczcrs/n3p08cuN
   +GeExhqxSOr6nXL4qhZkI8qGisQzsziFTvH9lFBiVD2jW22rGDcSY74Wm
   Vv7LsIDaMCR3O+Ce/gpMPPZA7Gj9Xwf+7b8k5THF/PkyR3rxaCQRwaq3N
   6FW/QIKbBZYHPp4BxRaLagP8GFAi1m1i9huvpMCwmJiCxvhsKZV0cMs7V
   57mKmPcyNQqLlEj85J6n0V3uB1pzBxDUWwX/dTzrsITS+j+bZUaMeyji1
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="235846412"
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="235846412"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 14:14:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="539703925"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 13 Mar 2022 14:14:18 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTVXd-0009I4-Uh; Sun, 13 Mar 2022 21:14:17 +0000
Date:   Mon, 14 Mar 2022 05:13:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:tls-upcall.v4 145/156]
 drivers/nvme/host/tcp.c:1814: undefined reference to `tls_client_hello'
Message-ID: <202203140523.xM6MD8hZ-lkp@intel.com>
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
commit: 0683576e9521319c36f3a3a728cc0f9205a51065 [145/156] nvme-tcp: start TLS if requested
config: i386-randconfig-a012 (https://download.01.org/0day-ci/archive/20220314/202203140523.xM6MD8hZ-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=0683576e9521319c36f3a3a728cc0f9205a51065
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel tls-upcall.v4
        git checkout 0683576e9521319c36f3a3a728cc0f9205a51065
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
   drivers/nvme/host/tcp.c:1764: undefined reference to `nvme_keyring_lookup_generated_key'
   ld: drivers/nvme/host/tcp.c:1780: undefined reference to `nvme_keyring_insert_tls'
   ld: drivers/nvme/host/tcp.o: in function `nvme_tcp_start_tls_with_key':
>> drivers/nvme/host/tcp.c:1814: undefined reference to `tls_client_hello'
   ld: drivers/nvme/host/tcp.o: in function `nvme_tcp_lookup_psk':
>> drivers/nvme/host/tcp.c:1775: undefined reference to `nvme_keyring_lookup_tls'
   ld: drivers/nvme/host/tcp.c:1778: undefined reference to `nvme_keyring_lookup_retained_key'


vim +1814 drivers/nvme/host/tcp.c

  1737	
  1738	/*
  1739	 * nvme_tcp_lookup_psk - Look up PSKs to use for TLS
  1740	 *
  1741	 * We have several combinations to worry about:
  1742	 * 1) Host requires encryption (opts->tls is set)
  1743	 *    -> lookup pre-provisioned TLS PSKs; keys must be set for
  1744	 *       a connection to be allowed.
  1745	 * 2) Host allows encryptionn (opts->tls is not set)
  1746	 *    -> lookup pre-provisioned TLS PSK;
  1747	 *    -> lookup retained TLS key if no PSKs are found, and
  1748	 *       generate PSK based on the retained TLS key.
  1749	 *    -> Do not start TLS if no key (PSK or retained) is found.
  1750	 * 2) Host does not use encryption (opts->tls is not set)
  1751	 *    -> no keys are provisioned.
  1752	 */
  1753	static struct key *nvme_tcp_lookup_psk(struct nvme_ctrl *nctrl, int qid,
  1754					       int hmac, bool generated)
  1755	{
  1756		char *hostnqn = nctrl->opts->host->nqn;
  1757		char *subnqn = nvmf_ctrl_subsysnqn(nctrl);
  1758		struct key *nvme_key, *tls_key;
  1759		bool force_tls = nctrl->opts->tls;
  1760	
  1761		/* Check for pre-provisioned keys */
  1762		if (generated) {
  1763			/* Lookup generated key */
  1764			nvme_key = nvme_keyring_lookup_generated_key(hostnqn, subnqn,
  1765								     hmac);
  1766			if (!IS_ERR(nvme_key)) {
  1767				tls_key = nvme_keyring_insert_tls(nvme_key, nctrl,
  1768								  hmac, true);
  1769				key_put(nvme_key);
  1770				return tls_key;
  1771			}
  1772			return ERR_PTR(-ENOKEY);
  1773		}
  1774		/* Lookup retained key */
> 1775		tls_key = nvme_keyring_lookup_tls(nctrl, hmac, false);
  1776		if (IS_ERR(tls_key) && !force_tls) {
  1777			/* Not found, derive key from PSK if present */
  1778			nvme_key = nvme_keyring_lookup_retained_key(hostnqn, hmac);
  1779			if (!IS_ERR(nvme_key)) {
  1780				tls_key = nvme_keyring_insert_tls(nvme_key, nctrl,
  1781								  hmac, false);
  1782				key_put(nvme_key);
  1783				return tls_key;
  1784			}
  1785		}
  1786		return ERR_PTR(-ENOKEY);
  1787	}
  1788	
  1789	static void nvme_tcp_tls_handshake_done(void *data, int status)
  1790	{
  1791		struct nvme_tcp_queue *queue = data;
  1792	
  1793		queue->tls_err = status;
  1794		if (queue->tls_complete)
  1795			complete(queue->tls_complete);
  1796	}
  1797	
  1798	static int nvme_tcp_start_tls_with_key(struct nvme_ctrl *nctrl, int qid,
  1799					       struct key *tls_key)
  1800	{
  1801		struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
  1802		struct nvme_tcp_queue *queue = &ctrl->queues[qid];
  1803		DECLARE_COMPLETION_ONSTACK(tls_complete);
  1804		unsigned long tmo = 10 * HZ;
  1805		int rc;
  1806	
  1807		queue->tls_complete = &tls_complete;
  1808		queue->tls_err = -EOPNOTSUPP;
  1809	
  1810		dev_dbg(nctrl->device,
  1811			"starting TLS handshake on queue %d with key %u\n",
  1812			nvme_tcp_queue_id(queue), tls_key->serial);
  1813	
> 1814		rc = tls_client_hello(queue->sock, nvme_tcp_tls_handshake_done,
  1815				      queue, NULL, tls_key->serial);
  1816		if (rc) {
  1817			queue->tls_complete = NULL;
  1818			dev_err(nctrl->device, "error %d starting TLS handshake\n", rc);
  1819			return rc;
  1820		}
  1821	
  1822		if (wait_for_completion_timeout(queue->tls_complete, tmo) == 0)
  1823			rc = -ETIMEDOUT;
  1824		else
  1825			rc = queue->tls_err;
  1826	
  1827		queue->tls_complete = NULL;
  1828		dev_dbg(nctrl->device,
  1829			"TLS handshake on queue %d complete, tmo %lu, error %d\n",
  1830			nvme_tcp_queue_id(queue), tmo, rc);
  1831		return rc;
  1832	}
  1833	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
