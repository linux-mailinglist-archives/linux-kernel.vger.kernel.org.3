Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF56512942
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 04:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241174AbiD1CEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 22:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241039AbiD1CEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 22:04:40 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B198606EF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 19:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651111287; x=1682647287;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zreYBvWleK4niRUzLd+EkJYG2HaMmTc6G5o+t2PNz38=;
  b=hGNfKIcTp12bDu4ZioOVYubHJjNtPVKTf+CsAchaZF/ScKnVH3Tgncdl
   RiPrfak7WDFcKBsxubnK5aeP3PNbnttdxVnT6SayHWzUj4xRxCj1VjiGy
   JRF7bdLq7sM+7ZpG0KmqhJHe4rCLBCmEIxVAH5d++G+Ucdw9uJMGYZwm/
   th/IjpRSaVyjNJNUgvBbV+Xt7Ud/RZCO5yR8EYKhX4q79JZzxgbLHy+WY
   HiVQmhx+j4j11tw0ow6HJTefFYineiCN8EjCz8q66odsFWWemr8b3dN2X
   2wtDyLlPpIsR8CRw6QIHHBvjFMolV3KDXtSactT7gQcNmtkgX88Socv+H
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="248061615"
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="248061615"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 19:01:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="580964625"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 27 Apr 2022 19:01:24 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njtT9-0004yY-U4;
        Thu, 28 Apr 2022 02:01:23 +0000
Date:   Thu, 28 Apr 2022 10:00:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sumit Saxena <sumit.saxena@broadcom.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [mkp-scsi:for-next 108/122]
 ./usr/include/scsi/scsi_bsg_mpi3mr.h:463:9: error: unknown type name
 '__le16'
Message-ID: <202204280658.JSiocHFi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
head:   6c86c1c0cc900e847743e164b0e4914fffc2fefe
commit: 455aac4f7a13eced7697437f348b1287d6961838 [108/122] scsi: mpi3mr: Move data structures/definitions from MPI headers to uapi header
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220428/202204280658.JSiocHFi-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/commit/?id=455aac4f7a13eced7697437f348b1287d6961838
        git remote add mkp-scsi https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git
        git fetch --no-tags mkp-scsi for-next
        git checkout 455aac4f7a13eced7697437f348b1287d6961838
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:321:9: error: unknown type name 'uint16_t'
     321 |         uint16_t rsvd2;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:335:9: error: unknown type name 'uint8_t'
     335 |         uint8_t buf_type;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:336:9: error: unknown type name 'uint8_t'
     336 |         uint8_t rsvd1;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:337:9: error: unknown type name 'uint16_t'
     337 |         uint16_t rsvd2;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:338:9: error: unknown type name 'uint32_t'
     338 |         uint32_t start_offset;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:339:9: error: unknown type name 'uint32_t'
     339 |         uint32_t length;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:351:9: error: unknown type name 'uint8_t'
     351 |         uint8_t page_type;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:352:9: error: unknown type name 'uint8_t'
     352 |         uint8_t rsvd1;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:353:9: error: unknown type name 'uint16_t'
     353 |         uint16_t rsvd2;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:365:9: error: unknown type name 'uint8_t'
     365 |         uint8_t mrioc_id;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:366:9: error: unknown type name 'uint8_t'
     366 |         uint8_t opcode;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:367:9: error: unknown type name 'uint16_t'
     367 |         uint16_t rsvd1;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:368:9: error: unknown type name 'uint32_t'
     368 |         uint32_t rsvd2[4];
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:380:9: error: unknown type name 'uint8_t'
     380 |         uint8_t mpi_reply_type;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:381:9: error: unknown type name 'uint8_t'
     381 |         uint8_t rsvd1;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:382:9: error: unknown type name 'uint16_t'
     382 |         uint16_t rsvd2;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:383:9: error: unknown type name 'uint8_t'
     383 |         uint8_t reply_buf[1];
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:396:9: error: unknown type name 'uint8_t'
     396 |         uint8_t buf_type;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:397:9: error: unknown type name 'uint8_t'
     397 |         uint8_t rsvd1;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:398:9: error: unknown type name 'uint16_t'
     398 |         uint16_t rsvd2;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:399:9: error: unknown type name 'uint32_t'
     399 |         uint32_t buf_len;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:412:9: error: unknown type name 'uint8_t'
     412 |         uint8_t num_of_entries;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:413:9: error: unknown type name 'uint8_t'
     413 |         uint8_t rsvd1;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:414:9: error: unknown type name 'uint16_t'
     414 |         uint16_t rsvd2;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:415:9: error: unknown type name 'uint32_t'
     415 |         uint32_t rsvd3;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:428:9: error: unknown type name 'uint8_t'
     428 |         uint8_t mrioc_id;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:429:9: error: unknown type name 'uint8_t'
     429 |         uint8_t rsvd1;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:430:9: error: unknown type name 'uint16_t'
     430 |         uint16_t timeout;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:431:9: error: unknown type name 'uint32_t'
     431 |         uint32_t rsvd2;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:446:9: error: unknown type name 'uint8_t'
     446 |         uint8_t cmd_type;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:447:9: error: unknown type name 'uint8_t'
     447 |         uint8_t rsvd1;
         |         ^~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:448:9: error: unknown type name 'uint16_t'
     448 |         uint16_t rsvd2;
         |         ^~~~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:449:9: error: unknown type name 'uint32_t'
     449 |         uint32_t rsvd3;
         |         ^~~~~~~~
>> ./usr/include/scsi/scsi_bsg_mpi3mr.h:463:9: error: unknown type name '__le16'
     463 |         __le16                     host_tag;
         |         ^~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:464:9: error: unknown type name 'u8'
     464 |         u8                         ioc_use_only02;
         |         ^~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:465:9: error: unknown type name 'u8'
     465 |         u8                         function;
         |         ^~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:466:9: error: unknown type name '__le16'
     466 |         __le16                     ioc_use_only04;
         |         ^~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:467:9: error: unknown type name 'u8'
     467 |         u8                         ioc_use_only06;
         |         ^~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:468:9: error: unknown type name 'u8'
     468 |         u8                         msg_flags;
         |         ^~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:469:9: error: unknown type name '__le16'
     469 |         __le16                     change_count;
         |         ^~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:470:9: error: unknown type name '__le16'
     470 |         __le16                     dev_handle;
         |         ^~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:471:9: error: unknown type name '__le16'
     471 |         __le16                     encapsulated_command_length;
         |         ^~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:472:9: error: unknown type name '__le16'
     472 |         __le16                     flags;
         |         ^~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:473:9: error: unknown type name '__le32'
     473 |         __le32                     data_length;
         |         ^~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:474:9: error: unknown type name '__le32'
     474 |         __le32                     reserved14[3];
         |         ^~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:475:9: error: unknown type name '__le32'
     475 |         __le32                     command[MPI3_NVME_ENCAP_CMD_MAX];
         |         ^~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:479:9: error: unknown type name '__le16'
     479 |         __le16                     host_tag;
         |         ^~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:480:9: error: unknown type name 'u8'
     480 |         u8                         ioc_use_only02;
         |         ^~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:481:9: error: unknown type name 'u8'
     481 |         u8                         function;
         |         ^~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:482:9: error: unknown type name '__le16'
     482 |         __le16                     ioc_use_only04;
         |         ^~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:483:9: error: unknown type name 'u8'
     483 |         u8                         ioc_use_only06;
         |         ^~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:484:9: error: unknown type name 'u8'
     484 |         u8                         msg_flags;
         |         ^~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:485:9: error: unknown type name '__le16'
     485 |         __le16                     ioc_use_only08;
         |         ^~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:486:9: error: unknown type name '__le16'
     486 |         __le16                     ioc_status;
         |         ^~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:487:9: error: unknown type name '__le32'
     487 |         __le32                     ioc_log_info;
         |         ^~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:488:9: error: unknown type name '__le32'
     488 |         __le32                     nvme_completion_entry[4];
         |         ^~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:493:9: error: unknown type name '__le16'
     493 |         __le16                     host_tag;
         |         ^~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:494:9: error: unknown type name 'u8'
     494 |         u8                         ioc_use_only02;
         |         ^~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:495:9: error: unknown type name 'u8'
     495 |         u8                         function;
         |         ^~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:496:9: error: unknown type name '__le16'
     496 |         __le16                     ioc_use_only04;
         |         ^~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:497:9: error: unknown type name 'u8'
     497 |         u8                         ioc_use_only06;
         |         ^~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:498:9: error: unknown type name 'u8'
     498 |         u8                         msg_flags;
         |         ^~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:499:9: error: unknown type name '__le16'
     499 |         __le16                     change_count;
         |         ^~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:500:9: error: unknown type name '__le16'
     500 |         __le16                     dev_handle;
         |         ^~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:501:9: error: unknown type name '__le16'
     501 |         __le16                     task_host_tag;
         |         ^~~~~~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:502:9: error: unknown type name 'u8'
     502 |         u8                         task_type;
         |         ^~
   ./usr/include/scsi/scsi_bsg_mpi3mr.h:503:9: error: unknown type name 'u8'
     503 |         u8                         reserved0f;

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
