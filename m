Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4052E523A32
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344655AbiEKQVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239974AbiEKQVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:21:25 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA0837028
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652286084; x=1683822084;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EfMBhlQXAU1MQXDmgFL/wcvIL8MHq+xSFKfwYV33fY4=;
  b=eCd1FlJyRebx13PuauKDfrvt+zX+1yetUXF+FGMLZG8xYeAf1yAHiKVv
   BkJCHHW6BxpAOgWzetLVi2g7cJM2msRrPJWi2fY7JefMQprv33WvvwiW1
   FRCWElyPMUxWhE7NYb7vh3WWd84v8XuMeIfrskPQR7lkNjAts+xts3zYx
   cpWIRXcPg+kUL55oGxTAEE2SiH/X0XjSUauWcbE6tXjUjgHcfhXYaZpHg
   dy++Uz3FTBufx+4hiCXXoPtpIADR9caxmfjAHrb7+0AV8dNgkzWHOWtya
   tHqJfJSyyMWP/6bO1tYP4oMHm65ebP9lHzakMrfXzRfy0nsA6ZeW0Ji4X
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="269876902"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="269876902"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 09:18:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="814542469"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 11 May 2022 09:17:57 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nop2C-000JI4-Uj;
        Wed, 11 May 2022 16:17:56 +0000
Date:   Thu, 12 May 2022 00:17:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xingui Yang <yangxingui@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Qi Liu <liuqi115@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:2168:43: sparse: sparse:
 restricted __le32 degrades to integer
Message-ID: <202205120028.ztSHSLFJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   feb9c5e19e913b53cb536a7aa7c9f20107bb51ec
commit: 62413199cd6d2906c121c2dfa3d7b82fd05f08db scsi: hisi_sas: Modify v3 HW SSP underflow error processing
date:   2 months ago
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220512/202205120028.ztSHSLFJ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=62413199cd6d2906c121c2dfa3d7b82fd05f08db
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 62413199cd6d2906c121c2dfa3d7b82fd05f08db
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/scsi/hisi_sas/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:2168:43: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:2169:46: sparse: sparse: restricted __le32 degrades to integer
   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:4427:35: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __le32 [usertype] *[assigned] ptr @@     got unsigned int * @@
   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:4427:35: sparse:     expected restricted __le32 [usertype] *[assigned] ptr
   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:4427:35: sparse:     got unsigned int *

vim +2168 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c

  2144	
  2145	static bool
  2146	slot_err_v3_hw(struct hisi_hba *hisi_hba, struct sas_task *task,
  2147		       struct hisi_sas_slot *slot)
  2148	{
  2149		struct task_status_struct *ts = &task->task_status;
  2150		struct hisi_sas_complete_v3_hdr *complete_queue =
  2151				hisi_hba->complete_hdr[slot->cmplt_queue];
  2152		struct hisi_sas_complete_v3_hdr *complete_hdr =
  2153				&complete_queue[slot->cmplt_queue_slot];
  2154		struct hisi_sas_err_record_v3 *record =
  2155				hisi_sas_status_buf_addr_mem(slot);
  2156		u32 dma_rx_err_type = le32_to_cpu(record->dma_rx_err_type);
  2157		u32 trans_tx_fail_type = le32_to_cpu(record->trans_tx_fail_type);
  2158		u32 dw3 = le32_to_cpu(complete_hdr->dw3);
  2159	
  2160		switch (task->task_proto) {
  2161		case SAS_PROTOCOL_SSP:
  2162			if (dma_rx_err_type & RX_DATA_LEN_UNDERFLOW_MSK) {
  2163				/*
  2164				 * If returned response frame is incorrect because of data underflow,
  2165				 * but I/O information has been written to the host memory, we examine
  2166				 * response IU.
  2167				 */
> 2168				if (!(complete_hdr->dw0 & CMPLT_HDR_RSPNS_GOOD_MSK) &&
  2169					(complete_hdr->dw0 & CMPLT_HDR_RSPNS_XFRD_MSK))
  2170					return false;
  2171	
  2172				ts->residual = trans_tx_fail_type;
  2173				ts->stat = SAS_DATA_UNDERRUN;
  2174			} else if (dw3 & CMPLT_HDR_IO_IN_TARGET_MSK) {
  2175				ts->stat = SAS_QUEUE_FULL;
  2176				slot->abort = 1;
  2177			} else {
  2178				ts->stat = SAS_OPEN_REJECT;
  2179				ts->open_rej_reason = SAS_OREJ_RSVD_RETRY;
  2180			}
  2181			break;
  2182		case SAS_PROTOCOL_SATA:
  2183		case SAS_PROTOCOL_STP:
  2184		case SAS_PROTOCOL_SATA | SAS_PROTOCOL_STP:
  2185			if (dma_rx_err_type & RX_DATA_LEN_UNDERFLOW_MSK) {
  2186				ts->residual = trans_tx_fail_type;
  2187				ts->stat = SAS_DATA_UNDERRUN;
  2188			} else if (dw3 & CMPLT_HDR_IO_IN_TARGET_MSK) {
  2189				ts->stat = SAS_PHY_DOWN;
  2190				slot->abort = 1;
  2191			} else {
  2192				ts->stat = SAS_OPEN_REJECT;
  2193				ts->open_rej_reason = SAS_OREJ_RSVD_RETRY;
  2194			}
  2195			hisi_sas_sata_done(task, slot);
  2196			break;
  2197		case SAS_PROTOCOL_SMP:
  2198			ts->stat = SAS_SAM_STAT_CHECK_CONDITION;
  2199			break;
  2200		default:
  2201			break;
  2202		}
  2203		return true;
  2204	}
  2205	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
