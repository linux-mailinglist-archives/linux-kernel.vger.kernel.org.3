Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3430D492470
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239024AbiARLO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:14:58 -0500
Received: from mga01.intel.com ([192.55.52.88]:12189 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239037AbiARLOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:14:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642504475; x=1674040475;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=eFxnwfXmMIHxYzPN2YzS42YzJ1oYRzq1vF34oQ8/rgE=;
  b=NnX4rGpe1x4M3CBMpDHqkqMF0TR/k5uVPCVJa1soEIG1bxaHv9bXTe/1
   OqAxhGQ9KfT15041ntbqa/4KKGnlCf8pyR6uBoBY4kx/rvbZCmVj28GbW
   ap06pJkHNJMbWJ0QAeB6CuRXag8BSV2ECBbEGcP0FOEilfK3Vi4rfx+w+
   PuLBnU5mdje8atyTbQMhg8D1hNgmK17Pjz3Cu8kykdF3vb9417y09aMLH
   r8NBxFrHywdU+aNWfPtQQONtHwRJSNy18kenn1KP0JNtisnbbQrluFzKB
   4x8zSBta+9uFx4yp68vAgUzqKWt63gX7TuROGdeAmhxKEC6iJ36vivbZW
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="269172807"
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="269172807"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 03:14:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,297,1635231600"; 
   d="scan'208";a="615321809"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Jan 2022 03:14:30 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9mRZ-000CUw-Ph; Tue, 18 Jan 2022 11:14:29 +0000
Date:   Tue, 18 Jan 2022 19:14:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mkp:5.18/discovery 76/89]
 drivers/scsi/mpt3sas/mpt3sas_scsih.c:12594:16: error: 'SCSI_VPD_PG_LEN'
 undeclared
Message-ID: <202201181804.pwMFkLNX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/linux.git 5.18/discovery
head:   e8d3e07074b4fc3d49dbfcc604d7d03de2b16f2a
commit: 1056b3b530cef4e0d723fd3af2072f65a136b872 [76/89] scsi: core: Query VPD size before getting full page
config: x86_64-rhel-8.3-func (https://download.01.org/0day-ci/archive/20220118/202201181804.pwMFkLNX-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mkp/linux.git/commit/?id=1056b3b530cef4e0d723fd3af2072f65a136b872
        git remote add mkp https://git.kernel.org/pub/scm/linux/kernel/git/mkp/linux.git
        git fetch --no-tags mkp 5.18/discovery
        git checkout 1056b3b530cef4e0d723fd3af2072f65a136b872
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/scsi/mpt3sas/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the mkp/5.18/discovery HEAD e8d3e07074b4fc3d49dbfcc604d7d03de2b16f2a builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   drivers/scsi/mpt3sas/mpt3sas_scsih.c: In function 'scsih_ncq_prio_supp':
>> drivers/scsi/mpt3sas/mpt3sas_scsih.c:12594:16: error: 'SCSI_VPD_PG_LEN' undeclared (first use in this function)
   12594 |  buf = kmalloc(SCSI_VPD_PG_LEN, GFP_KERNEL);
         |                ^~~~~~~~~~~~~~~
   drivers/scsi/mpt3sas/mpt3sas_scsih.c:12594:16: note: each undeclared identifier is reported only once for each function it appears in


vim +/SCSI_VPD_PG_LEN +12594 drivers/scsi/mpt3sas/mpt3sas_scsih.c

f92363d1235949 Sreekanth Reddy          2012-11-30  12578  
307d9075a02b69 Adam Manzanares          2016-12-12  12579  /**
a8d548b0b3eea1 Lee Jones                2021-03-17  12580   * scsih_ncq_prio_supp - Check for NCQ command priority support
307d9075a02b69 Adam Manzanares          2016-12-12  12581   * @sdev: scsi device struct
307d9075a02b69 Adam Manzanares          2016-12-12  12582   *
307d9075a02b69 Adam Manzanares          2016-12-12  12583   * This is called when a user indicates they would like to enable
307d9075a02b69 Adam Manzanares          2016-12-12  12584   * ncq command priorities. This works only on SATA devices.
307d9075a02b69 Adam Manzanares          2016-12-12  12585   */
307d9075a02b69 Adam Manzanares          2016-12-12  12586  bool scsih_ncq_prio_supp(struct scsi_device *sdev)
307d9075a02b69 Adam Manzanares          2016-12-12  12587  {
307d9075a02b69 Adam Manzanares          2016-12-12  12588  	unsigned char *buf;
307d9075a02b69 Adam Manzanares          2016-12-12  12589  	bool ncq_prio_supp = false;
307d9075a02b69 Adam Manzanares          2016-12-12  12590  
307d9075a02b69 Adam Manzanares          2016-12-12  12591  	if (!scsi_device_supports_vpd(sdev))
307d9075a02b69 Adam Manzanares          2016-12-12  12592  		return ncq_prio_supp;
307d9075a02b69 Adam Manzanares          2016-12-12  12593  
307d9075a02b69 Adam Manzanares          2016-12-12 @12594  	buf = kmalloc(SCSI_VPD_PG_LEN, GFP_KERNEL);
307d9075a02b69 Adam Manzanares          2016-12-12  12595  	if (!buf)
307d9075a02b69 Adam Manzanares          2016-12-12  12596  		return ncq_prio_supp;
307d9075a02b69 Adam Manzanares          2016-12-12  12597  
307d9075a02b69 Adam Manzanares          2016-12-12  12598  	if (!scsi_get_vpd_page(sdev, 0x89, buf, SCSI_VPD_PG_LEN))
307d9075a02b69 Adam Manzanares          2016-12-12  12599  		ncq_prio_supp = (buf[213] >> 4) & 1;
307d9075a02b69 Adam Manzanares          2016-12-12  12600  
307d9075a02b69 Adam Manzanares          2016-12-12  12601  	kfree(buf);
307d9075a02b69 Adam Manzanares          2016-12-12  12602  	return ncq_prio_supp;
307d9075a02b69 Adam Manzanares          2016-12-12  12603  }
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12604  /*
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12605   * The pci device ids are defined in mpi/mpi2_cnfg.h.
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12606   */
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12607  static const struct pci_device_id mpt3sas_pci_table[] = {
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12608  	/* Spitfire ~ 2004 */
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12609  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI2_MFGPAGE_DEVID_SAS2004,
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12610  		PCI_ANY_ID, PCI_ANY_ID },
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12611  	/* Falcon ~ 2008 */
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12612  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI2_MFGPAGE_DEVID_SAS2008,
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12613  		PCI_ANY_ID, PCI_ANY_ID },
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12614  	/* Liberator ~ 2108 */
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12615  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI2_MFGPAGE_DEVID_SAS2108_1,
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12616  		PCI_ANY_ID, PCI_ANY_ID },
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12617  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI2_MFGPAGE_DEVID_SAS2108_2,
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12618  		PCI_ANY_ID, PCI_ANY_ID },
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12619  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI2_MFGPAGE_DEVID_SAS2108_3,
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12620  		PCI_ANY_ID, PCI_ANY_ID },
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12621  	/* Meteor ~ 2116 */
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12622  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI2_MFGPAGE_DEVID_SAS2116_1,
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12623  		PCI_ANY_ID, PCI_ANY_ID },
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12624  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI2_MFGPAGE_DEVID_SAS2116_2,
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12625  		PCI_ANY_ID, PCI_ANY_ID },
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12626  	/* Thunderbolt ~ 2208 */
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12627  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI2_MFGPAGE_DEVID_SAS2208_1,
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12628  		PCI_ANY_ID, PCI_ANY_ID },
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12629  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI2_MFGPAGE_DEVID_SAS2208_2,
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12630  		PCI_ANY_ID, PCI_ANY_ID },
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12631  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI2_MFGPAGE_DEVID_SAS2208_3,
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12632  		PCI_ANY_ID, PCI_ANY_ID },
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12633  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI2_MFGPAGE_DEVID_SAS2208_4,
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12634  		PCI_ANY_ID, PCI_ANY_ID },
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12635  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI2_MFGPAGE_DEVID_SAS2208_5,
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12636  		PCI_ANY_ID, PCI_ANY_ID },
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12637  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI2_MFGPAGE_DEVID_SAS2208_6,
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12638  		PCI_ANY_ID, PCI_ANY_ID },
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12639  	/* Mustang ~ 2308 */
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12640  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI2_MFGPAGE_DEVID_SAS2308_1,
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12641  		PCI_ANY_ID, PCI_ANY_ID },
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12642  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI2_MFGPAGE_DEVID_SAS2308_2,
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12643  		PCI_ANY_ID, PCI_ANY_ID },
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12644  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI2_MFGPAGE_DEVID_SAS2308_3,
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12645  		PCI_ANY_ID, PCI_ANY_ID },
1244790d178bb0 Suganath Prabu S         2019-01-29  12646  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI2_MFGPAGE_DEVID_SWITCH_MPI_EP,
c520691b38cde1 Suganath Prabu Subramani 2018-02-07  12647  		PCI_ANY_ID, PCI_ANY_ID },
8f8384503e40c6 Suganath Prabu S         2019-01-29  12648  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI2_MFGPAGE_DEVID_SWITCH_MPI_EP_1,
8f8384503e40c6 Suganath Prabu S         2019-01-29  12649  		PCI_ANY_ID, PCI_ANY_ID },
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12650  	/* SSS6200 */
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12651  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI2_MFGPAGE_DEVID_SSS6200,
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12652  		PCI_ANY_ID, PCI_ANY_ID },
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12653  	/* Fury ~ 3004 and 3008 */
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12654  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI25_MFGPAGE_DEVID_SAS3004,
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12655  		PCI_ANY_ID, PCI_ANY_ID },
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12656  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI25_MFGPAGE_DEVID_SAS3008,
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12657  		PCI_ANY_ID, PCI_ANY_ID },
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12658  	/* Invader ~ 3108 */
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12659  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI25_MFGPAGE_DEVID_SAS3108_1,
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12660  		PCI_ANY_ID, PCI_ANY_ID },
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12661  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI25_MFGPAGE_DEVID_SAS3108_2,
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12662  		PCI_ANY_ID, PCI_ANY_ID },
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12663  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI25_MFGPAGE_DEVID_SAS3108_5,
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12664  		PCI_ANY_ID, PCI_ANY_ID },
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12665  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI25_MFGPAGE_DEVID_SAS3108_6,
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12666  		PCI_ANY_ID, PCI_ANY_ID },
b130b0d56fa97e Suganath prabu Subramani 2016-01-28  12667  	/* Cutlass ~ 3216 and 3224 */
b130b0d56fa97e Suganath prabu Subramani 2016-01-28  12668  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_SAS3216,
b130b0d56fa97e Suganath prabu Subramani 2016-01-28  12669  		PCI_ANY_ID, PCI_ANY_ID },
b130b0d56fa97e Suganath prabu Subramani 2016-01-28  12670  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_SAS3224,
b130b0d56fa97e Suganath prabu Subramani 2016-01-28  12671  		PCI_ANY_ID, PCI_ANY_ID },
b130b0d56fa97e Suganath prabu Subramani 2016-01-28  12672  	/* Intruder ~ 3316 and 3324 */
b130b0d56fa97e Suganath prabu Subramani 2016-01-28  12673  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_SAS3316_1,
b130b0d56fa97e Suganath prabu Subramani 2016-01-28  12674  		PCI_ANY_ID, PCI_ANY_ID },
b130b0d56fa97e Suganath prabu Subramani 2016-01-28  12675  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_SAS3316_2,
b130b0d56fa97e Suganath prabu Subramani 2016-01-28  12676  		PCI_ANY_ID, PCI_ANY_ID },
b130b0d56fa97e Suganath prabu Subramani 2016-01-28  12677  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_SAS3316_3,
b130b0d56fa97e Suganath prabu Subramani 2016-01-28  12678  		PCI_ANY_ID, PCI_ANY_ID },
b130b0d56fa97e Suganath prabu Subramani 2016-01-28  12679  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_SAS3316_4,
b130b0d56fa97e Suganath prabu Subramani 2016-01-28  12680  		PCI_ANY_ID, PCI_ANY_ID },
b130b0d56fa97e Suganath prabu Subramani 2016-01-28  12681  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_SAS3324_1,
b130b0d56fa97e Suganath prabu Subramani 2016-01-28  12682  		PCI_ANY_ID, PCI_ANY_ID },
b130b0d56fa97e Suganath prabu Subramani 2016-01-28  12683  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_SAS3324_2,
b130b0d56fa97e Suganath prabu Subramani 2016-01-28  12684  		PCI_ANY_ID, PCI_ANY_ID },
b130b0d56fa97e Suganath prabu Subramani 2016-01-28  12685  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_SAS3324_3,
b130b0d56fa97e Suganath prabu Subramani 2016-01-28  12686  		PCI_ANY_ID, PCI_ANY_ID },
b130b0d56fa97e Suganath prabu Subramani 2016-01-28  12687  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_SAS3324_4,
b130b0d56fa97e Suganath prabu Subramani 2016-01-28  12688  		PCI_ANY_ID, PCI_ANY_ID },
998f26aedf41bc Suganath Prabu Subramani 2016-10-26  12689  	/* Ventura, Crusader, Harpoon & Tomcat ~ 3516, 3416, 3508 & 3408*/
998f26aedf41bc Suganath Prabu Subramani 2016-10-26  12690  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_SAS3508,
998f26aedf41bc Suganath Prabu Subramani 2016-10-26  12691  		PCI_ANY_ID, PCI_ANY_ID },
998f26aedf41bc Suganath Prabu Subramani 2016-10-26  12692  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_SAS3508_1,
998f26aedf41bc Suganath Prabu Subramani 2016-10-26  12693  		PCI_ANY_ID, PCI_ANY_ID },
998f26aedf41bc Suganath Prabu Subramani 2016-10-26  12694  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_SAS3408,
998f26aedf41bc Suganath Prabu Subramani 2016-10-26  12695  		PCI_ANY_ID, PCI_ANY_ID },
998f26aedf41bc Suganath Prabu Subramani 2016-10-26  12696  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_SAS3516,
998f26aedf41bc Suganath Prabu Subramani 2016-10-26  12697  		PCI_ANY_ID, PCI_ANY_ID },
998f26aedf41bc Suganath Prabu Subramani 2016-10-26  12698  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_SAS3516_1,
998f26aedf41bc Suganath Prabu Subramani 2016-10-26  12699  		PCI_ANY_ID, PCI_ANY_ID },
998f26aedf41bc Suganath Prabu Subramani 2016-10-26  12700  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_SAS3416,
998f26aedf41bc Suganath Prabu Subramani 2016-10-26  12701  		PCI_ANY_ID, PCI_ANY_ID },
15fd7c74dadc8d Sreekanth Reddy          2017-10-10  12702  	/* Mercator ~ 3616*/
15fd7c74dadc8d Sreekanth Reddy          2017-10-10  12703  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_SAS3616,
15fd7c74dadc8d Sreekanth Reddy          2017-10-10  12704  		PCI_ANY_ID, PCI_ANY_ID },
6c2938f7bfd937 Suganath Prabu           2018-10-25  12705  
6c2938f7bfd937 Suganath Prabu           2018-10-25  12706  	/* Aero SI 0x00E1 Configurable Secure
6c2938f7bfd937 Suganath Prabu           2018-10-25  12707  	 * 0x00E2 Hard Secure
6c2938f7bfd937 Suganath Prabu           2018-10-25  12708  	 */
6c2938f7bfd937 Suganath Prabu           2018-10-25  12709  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_CFG_SEC_3916,
6c2938f7bfd937 Suganath Prabu           2018-10-25  12710  		PCI_ANY_ID, PCI_ANY_ID },
6c2938f7bfd937 Suganath Prabu           2018-10-25  12711  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_HARD_SEC_3916,
6c2938f7bfd937 Suganath Prabu           2018-10-25  12712  		PCI_ANY_ID, PCI_ANY_ID },
6c2938f7bfd937 Suganath Prabu           2018-10-25  12713  
f38c43a0e9007e Sreekanth Reddy          2020-08-14  12714  	/*
f38c43a0e9007e Sreekanth Reddy          2020-08-14  12715  	 *  Aero SI –> 0x00E0 Invalid, 0x00E3 Tampered
f38c43a0e9007e Sreekanth Reddy          2020-08-14  12716  	 */
f38c43a0e9007e Sreekanth Reddy          2020-08-14  12717  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_INVALID0_3916,
f38c43a0e9007e Sreekanth Reddy          2020-08-14  12718  		PCI_ANY_ID, PCI_ANY_ID },
f38c43a0e9007e Sreekanth Reddy          2020-08-14  12719  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_INVALID1_3916,
f38c43a0e9007e Sreekanth Reddy          2020-08-14  12720  		PCI_ANY_ID, PCI_ANY_ID },
f38c43a0e9007e Sreekanth Reddy          2020-08-14  12721  
eb9c7ce5604533 Suganath Prabu S         2019-01-29  12722  	/* Atlas PCIe Switch Management Port */
eb9c7ce5604533 Suganath Prabu S         2019-01-29  12723  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_ATLAS_PCIe_SWITCH_DEVID,
eb9c7ce5604533 Suganath Prabu S         2019-01-29  12724  		PCI_ANY_ID, PCI_ANY_ID },
eb9c7ce5604533 Suganath Prabu S         2019-01-29  12725  
6c2938f7bfd937 Suganath Prabu           2018-10-25  12726  	/* Sea SI 0x00E5 Configurable Secure
6c2938f7bfd937 Suganath Prabu           2018-10-25  12727  	 * 0x00E6 Hard Secure
6c2938f7bfd937 Suganath Prabu           2018-10-25  12728  	 */
6c2938f7bfd937 Suganath Prabu           2018-10-25  12729  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_CFG_SEC_3816,
6c2938f7bfd937 Suganath Prabu           2018-10-25  12730  		PCI_ANY_ID, PCI_ANY_ID },
6c2938f7bfd937 Suganath Prabu           2018-10-25  12731  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_HARD_SEC_3816,
6c2938f7bfd937 Suganath Prabu           2018-10-25  12732  		PCI_ANY_ID, PCI_ANY_ID },
6c2938f7bfd937 Suganath Prabu           2018-10-25  12733  
f38c43a0e9007e Sreekanth Reddy          2020-08-14  12734  	/*
f38c43a0e9007e Sreekanth Reddy          2020-08-14  12735  	 *  Sea SI –> 0x00E4 Invalid, 0x00E7 Tampered
f38c43a0e9007e Sreekanth Reddy          2020-08-14  12736  	 */
f38c43a0e9007e Sreekanth Reddy          2020-08-14  12737  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_INVALID0_3816,
f38c43a0e9007e Sreekanth Reddy          2020-08-14  12738  		PCI_ANY_ID, PCI_ANY_ID },
f38c43a0e9007e Sreekanth Reddy          2020-08-14  12739  	{ MPI2_MFGPAGE_VENDORID_LSI, MPI26_MFGPAGE_DEVID_INVALID1_3816,
f38c43a0e9007e Sreekanth Reddy          2020-08-14  12740  		PCI_ANY_ID, PCI_ANY_ID },
f38c43a0e9007e Sreekanth Reddy          2020-08-14  12741  
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12742  	{0}     /* Terminating entry */
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12743  };
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12744  MODULE_DEVICE_TABLE(pci, mpt3sas_pci_table);
c84b06a48c4d8a Sreekanth Reddy          2015-11-11  12745  

:::::: The code at line 12594 was first introduced by commit
:::::: 307d9075a02b696e817b775c565e45c4fa3c32f2 scsi: mpt3sas: Recognize and act on iopriority info

:::::: TO: Adam Manzanares <adam.manzanares@wdc.com>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
