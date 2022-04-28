Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B4F51293E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 04:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241107AbiD1CDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 22:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiD1CDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 22:03:41 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AFD5F260
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 19:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651111227; x=1682647227;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=r80S5RlrCHTO+WHljuKK3YXhMww5NAcQ9LX5n0cWaN4=;
  b=XuVZYke+TynYopcKIKqtxzCRr7WoVdcYYR34L4blngKAqBouHgae/BiE
   GFYANKcRAiomGJb0ShmPEh2xDf1946/fdVTamnmzWIvutGN+hv3orGUhK
   MhRrpgtApxrHi96Bcyc7d5UjthBOGcHyd0RSGDiuKnvz9AqwMd0vLI+rQ
   Fp01Z9x3j9JcA6NsBzNEGH/9bSOl2Em+RDfz12V6N1+pYmznqPf9XNvc0
   FpKNK3RkIZTrP4m322Bv+/4uhuuuNDf3/8oLMZ16JVcBWktFhFdrE6bww
   TGry9OLQJ9V+a6RGc39NVBPyJn5lbsXmkj1gVsz/AJbhGWVdyfdDsfWH/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="291287361"
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="291287361"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 19:00:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="533553095"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 27 Apr 2022 19:00:24 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njtSB-0004xv-Nj;
        Thu, 28 Apr 2022 02:00:23 +0000
Date:   Thu, 28 Apr 2022 09:59:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sumit Saxena <sumit.saxena@broadcom.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [mkp-scsi:for-next 107/122]
 ./usr/include/scsi/scsi_bsg_mpi3mr.h:118:9: error: unknown type name
 'uint8_t'
Message-ID: <202204280408.sLsHM0ax-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
head:   6c86c1c0cc900e847743e164b0e4914fffc2fefe
commit: a212ebe7d4b185007ad9084022907bc2349fa366 [107/122] scsi: mpi3mr: Add support for driver commands
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220428/202204280408.sLsHM0ax-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/commit/?id=a212ebe7d4b185007ad9084022907bc2349fa366
        git remote add mkp-scsi https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git
        git fetch --no-tags mkp-scsi for-next
        git checkout a212ebe7d4b185007ad9084022907bc2349fa366
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:106:9: error: unknown type name 'uint32_t'
     106 |         uint32_t adp_type;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:107:9: error: unknown type name 'uint32_t'
     107 |         uint32_t rsvd1;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:108:9: error: unknown type name 'uint32_t'
     108 |         uint32_t pci_dev_id;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:109:9: error: unknown type name 'uint32_t'
     109 |         uint32_t pci_dev_hw_rev;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:110:9: error: unknown type name 'uint32_t'
     110 |         uint32_t pci_subsys_dev_id;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:111:9: error: unknown type name 'uint32_t'
     111 |         uint32_t pci_subsys_ven_id;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:112:9: error: unknown type name 'uint32_t'
     112 |         uint32_t pci_dev:5;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:113:9: error: unknown type name 'uint32_t'
     113 |         uint32_t pci_func:3;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:114:9: error: unknown type name 'uint32_t'
     114 |         uint32_t pci_bus:8;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:115:9: error: unknown type name 'uint16_t'
     115 |         uint16_t rsvd2;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:116:9: error: unknown type name 'uint32_t'
     116 |         uint32_t pci_seg_id;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:117:9: error: unknown type name 'uint32_t'
     117 |         uint32_t app_intfc_ver;
         |         ^~~~~~~~
>> ./usr/include/scsi/scsi_bsg_mpi3mr.h:118:9: error: unknown type name 'uint8_t'
     118 |         uint8_t adp_state;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:119:9: error: unknown type name 'uint8_t'
     119 |         uint8_t rsvd3;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:120:9: error: unknown type name 'uint16_t'
     120 |         uint16_t rsvd4;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:121:9: error: unknown type name 'uint32_t'
     121 |         uint32_t rsvd5[2];
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:122:40: error: field 'driver_info' has incomplete type
     122 |         struct mpi3_driver_info_layout driver_info;
         |                                        ^~~~~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:134:9: error: unknown type name 'uint8_t'
     134 |         uint8_t reset_type;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:135:9: error: unknown type name 'uint8_t'
     135 |         uint8_t rsvd1;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:136:9: error: unknown type name 'uint16_t'
     136 |         uint16_t rsvd2;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:147:9: error: unknown type name 'uint16_t'
     147 |         uint16_t change_count;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:148:9: error: unknown type name 'uint16_t'
     148 |         uint16_t rsvd;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:163:9: error: unknown type name 'uint16_t'
     163 |         uint16_t handle;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:164:9: error: unknown type name 'uint16_t'
     164 |         uint16_t perst_id;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:165:9: error: unknown type name 'uint32_t'
     165 |         uint32_t target_id;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:166:9: error: unknown type name 'uint8_t'
     166 |         uint8_t bus_id;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:167:9: error: unknown type name 'uint8_t'
     167 |         uint8_t rsvd1;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:168:9: error: unknown type name 'uint16_t'
     168 |         uint16_t rsvd2;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:181:9: error: unknown type name 'uint16_t'
     181 |         uint16_t num_devices;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:182:9: error: unknown type name 'uint16_t'
     182 |         uint16_t rsvd1;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:183:9: error: unknown type name 'uint32_t'
     183 |         uint32_t rsvd2;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:196:9: error: unknown type name 'uint16_t'
     196 |         uint16_t max_entries;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:197:9: error: unknown type name 'uint16_t'
     197 |         uint16_t rsvd;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:209:9: error: unknown type name 'uint16_t'
     209 |         uint16_t pel_locale;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:210:9: error: unknown type name 'uint8_t'
     210 |         uint8_t pel_class;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:211:9: error: unknown type name 'uint8_t'
     211 |         uint8_t rsvd;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:224:9: error: unknown type name 'uint8_t'
     224 |         uint8_t valid_entry;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:225:9: error: unknown type name 'uint8_t'
     225 |         uint8_t rsvd1;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:226:9: error: unknown type name 'uint16_t'
     226 |         uint16_t rsvd2;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:227:9: error: unknown type name 'uint8_t'
     227 |         uint8_t data[1]; /* Variable length Array */
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:255:9: error: unknown type name 'uint8_t'
     255 |         uint8_t buf_type;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:256:9: error: unknown type name 'uint8_t'
     256 |         uint8_t status;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:257:9: error: unknown type name 'uint8_t'
     257 |         uint8_t trigger_type;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:258:9: error: unknown type name 'uint8_t'
     258 |         uint8_t rsvd1;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:259:9: error: unknown type name 'uint16_t'
     259 |         uint16_t size;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:260:9: error: unknown type name 'uint16_t'
     260 |         uint16_t rsvd2;
         |         ^~~~~~~~
>> ./usr/include/scsi/scsi_bsg_mpi3mr.h:261:9: error: unknown type name 'uint64_t'
     261 |         uint64_t trigger_data;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:262:9: error: unknown type name 'uint32_t'
     262 |         uint32_t rsvd3;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:263:9: error: unknown type name 'uint32_t'
     263 |         uint32_t rsvd4;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:281:9: error: unknown type name 'uint8_t'
     281 |         uint8_t num_hdb_types;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:282:9: error: unknown type name 'uint8_t'
     282 |         uint8_t rsvd1;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:283:9: error: unknown type name 'uint16_t'
     283 |         uint16_t rsvd2;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:284:9: error: unknown type name 'uint32_t'
     284 |         uint32_t rsvd3;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:297:9: error: unknown type name 'uint8_t'
     297 |         uint8_t buf_type;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:298:9: error: unknown type name 'uint8_t'
     298 |         uint8_t rsvd1;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:299:9: error: unknown type name 'uint16_t'
     299 |         uint16_t rsvd2;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:313:9: error: unknown type name 'uint8_t'
     313 |         uint8_t buf_type;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:314:9: error: unknown type name 'uint8_t'
     314 |         uint8_t rsvd1;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:315:9: error: unknown type name 'uint16_t'
     315 |         uint16_t rsvd2;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:316:9: error: unknown type name 'uint32_t'
     316 |         uint32_t start_offset;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:317:9: error: unknown type name 'uint32_t'
     317 |         uint32_t length;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:329:9: error: unknown type name 'uint8_t'
     329 |         uint8_t page_type;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:330:9: error: unknown type name 'uint8_t'
     330 |         uint8_t rsvd1;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:331:9: error: unknown type name 'uint16_t'
     331 |         uint16_t rsvd2;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:343:9: error: unknown type name 'uint8_t'
     343 |         uint8_t mrioc_id;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:344:9: error: unknown type name 'uint8_t'
     344 |         uint8_t opcode;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:345:9: error: unknown type name 'uint16_t'
     345 |         uint16_t rsvd1;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:346:9: error: unknown type name 'uint32_t'
     346 |         uint32_t rsvd2[4];
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:358:9: error: unknown type name 'uint8_t'
     358 |         uint8_t mpi_reply_type;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:359:9: error: unknown type name 'uint8_t'
     359 |         uint8_t rsvd1;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:360:9: error: unknown type name 'uint16_t'
     360 |         uint16_t rsvd2;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:361:9: error: unknown type name 'uint8_t'
     361 |         uint8_t reply_buf[1];
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:374:9: error: unknown type name 'uint8_t'
     374 |         uint8_t buf_type;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:375:9: error: unknown type name 'uint8_t'
     375 |         uint8_t rsvd1;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:376:9: error: unknown type name 'uint16_t'
     376 |         uint16_t rsvd2;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:377:9: error: unknown type name 'uint32_t'
     377 |         uint32_t buf_len;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:390:9: error: unknown type name 'uint8_t'
     390 |         uint8_t num_of_entries;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:391:9: error: unknown type name 'uint8_t'
     391 |         uint8_t rsvd1;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:392:9: error: unknown type name 'uint16_t'
     392 |         uint16_t rsvd2;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:393:9: error: unknown type name 'uint32_t'
     393 |         uint32_t rsvd3;

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
