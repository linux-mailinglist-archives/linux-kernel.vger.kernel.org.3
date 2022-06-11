Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D08547785
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 22:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbiFKUar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 16:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiFKUap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 16:30:45 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75296B656;
        Sat, 11 Jun 2022 13:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654979443; x=1686515443;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=btdK/KTIo3K5kFVxw3S6KoQxkEXifhXgZQTDN1wwsOE=;
  b=E01lrtBjS5jfRI4gxlCsSH1egCS6ifmQS/O7ihWBRauL3nIz7bEn93Ex
   9L2k5j0oKAO9JZ3kVojUpRHuzao8601O88KHHUmpFbhlV3/ViN5fHVRDq
   Xs8kqXWC4bbOsH7TC7lnxdZZDKnaz5rOYEuFqex5FbUOFwBMNxTlhmCJZ
   QQj91IlBuDamZkMv3ON/C9mVidCaZuDNLxN8ckPKQzq/m/YTtS6L5cKxc
   Jt+9BEf+XZxfR8at66m1mPEotNUp2Fh2dZcFnlxi7nMHIAo+zqhN7fYKj
   6Kwy4aFQAS/aN/hFnxnvXIiEHdGLBZlll4KLW/WmDLOa2w0mNp3pSiR0s
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="277974906"
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="277974906"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 13:30:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="672510836"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Jun 2022 13:30:42 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o07kn-000JGj-Fc;
        Sat, 11 Jun 2022 20:30:41 +0000
Date:   Sun, 12 Jun 2022 04:30:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ang Tien Sung <tien.sung.ang@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dinh Nguyen <dinguyen@kernel.org>, linux-doc@vger.kernel.org
Subject: [dinguyen:svc_driver_updates_for_v4.20 1/6] htmldocs:
 include/linux/firmware/intel/stratix10-svc-client.h:19: warning: This
 comment starts with '/**', but isn't a kernel-doc comment. Refer
 Documentation/doc-guide/kernel-doc.rst
Message-ID: <202206120445.FeU5wA93-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git svc_driver_updates_for_v4.20
head:   107da326a0a3e7b6e81557c4225548db670a2647
commit: 88f42ac48b89689a3e8673263c09ad77be157a09 [1/6] firmware: stratix10-svc: Add support for FCS
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> include/linux/firmware/intel/stratix10-svc-client.h:19: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

vim +19 include/linux/firmware/intel/stratix10-svc-client.h

7ca5ce896524f5 Richard Gong          2018-11-13   8  
e23bd83368af41 Mauro Carvalho Chehab 2021-01-14   9  /*
7ca5ce896524f5 Richard Gong          2018-11-13  10   * Service layer driver supports client names
7ca5ce896524f5 Richard Gong          2018-11-13  11   *
7ca5ce896524f5 Richard Gong          2018-11-13  12   * fpga: for FPGA configuration
6b50d882d38d5a Richard Gong          2018-11-13  13   * rsu: for remote status update
7ca5ce896524f5 Richard Gong          2018-11-13  14   */
7ca5ce896524f5 Richard Gong          2018-11-13  15  #define SVC_CLIENT_FPGA			"fpga"
6b50d882d38d5a Richard Gong          2018-11-13  16  #define SVC_CLIENT_RSU			"rsu"
88f42ac48b8968 Ang Tien Sung         2022-03-15  17  #define SVC_CLIENT_FCS			"fcs"
88f42ac48b8968 Ang Tien Sung         2022-03-15  18  /**
7ca5ce896524f5 Richard Gong          2018-11-13 @19   * Status of the sent command, in bit number
7ca5ce896524f5 Richard Gong          2018-11-13  20   *
7536ad8dbfcfd5 Richard Gong          2020-04-14  21   * SVC_STATUS_OK:
7536ad8dbfcfd5 Richard Gong          2020-04-14  22   * Secure firmware accepts the request issued by one of service clients.
7ca5ce896524f5 Richard Gong          2018-11-13  23   *
7536ad8dbfcfd5 Richard Gong          2020-04-14  24   * SVC_STATUS_BUFFER_SUBMITTED:
7536ad8dbfcfd5 Richard Gong          2020-04-14  25   * Service client successfully submits data buffer to secure firmware.
7ca5ce896524f5 Richard Gong          2018-11-13  26   *
7536ad8dbfcfd5 Richard Gong          2020-04-14  27   * SVC_STATUS_BUFFER_DONE:
7ca5ce896524f5 Richard Gong          2018-11-13  28   * Secure firmware completes data process, ready to accept the
7ca5ce896524f5 Richard Gong          2018-11-13  29   * next WRITE transaction.
7ca5ce896524f5 Richard Gong          2018-11-13  30   *
7536ad8dbfcfd5 Richard Gong          2020-04-14  31   * SVC_STATUS_COMPLETED:
7536ad8dbfcfd5 Richard Gong          2020-04-14  32   * Secure firmware completes service request successfully. In case of
7536ad8dbfcfd5 Richard Gong          2020-04-14  33   * FPGA configuration, FPGA should be in user mode.
7ca5ce896524f5 Richard Gong          2018-11-13  34   *
7536ad8dbfcfd5 Richard Gong          2020-04-14  35   * SVC_COMMAND_STATUS_BUSY:
7536ad8dbfcfd5 Richard Gong          2020-04-14  36   * Service request is still in process.
7ca5ce896524f5 Richard Gong          2018-11-13  37   *
7536ad8dbfcfd5 Richard Gong          2020-04-14  38   * SVC_COMMAND_STATUS_ERROR:
7536ad8dbfcfd5 Richard Gong          2020-04-14  39   * Error encountered during the process of the service request.
6b50d882d38d5a Richard Gong          2018-11-13  40   *
7536ad8dbfcfd5 Richard Gong          2020-04-14  41   * SVC_STATUS_NO_SUPPORT:
7536ad8dbfcfd5 Richard Gong          2020-04-14  42   * Secure firmware doesn't support requested features such as RSU retry
7536ad8dbfcfd5 Richard Gong          2020-04-14  43   * or RSU notify.
7ca5ce896524f5 Richard Gong          2018-11-13  44   */
7536ad8dbfcfd5 Richard Gong          2020-04-14  45  #define SVC_STATUS_OK			0
7536ad8dbfcfd5 Richard Gong          2020-04-14  46  #define SVC_STATUS_BUFFER_SUBMITTED	1
7536ad8dbfcfd5 Richard Gong          2020-04-14  47  #define SVC_STATUS_BUFFER_DONE		2
7536ad8dbfcfd5 Richard Gong          2020-04-14  48  #define SVC_STATUS_COMPLETED		3
7536ad8dbfcfd5 Richard Gong          2020-04-14  49  #define SVC_STATUS_BUSY			4
7536ad8dbfcfd5 Richard Gong          2020-04-14  50  #define SVC_STATUS_ERROR		5
7536ad8dbfcfd5 Richard Gong          2020-04-14  51  #define SVC_STATUS_NO_SUPPORT		6
e9cb0497b1c801 Richard Gong          2019-11-04  52  

:::::: The code at line 19 was first introduced by commit
:::::: 7ca5ce896524f5292e610b27d168269e5ab74951 firmware: add Intel Stratix10 service layer driver

:::::: TO: Richard Gong <richard.gong@intel.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
