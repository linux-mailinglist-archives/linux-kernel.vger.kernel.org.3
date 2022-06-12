Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998D2547848
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 05:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbiFLDG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 23:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbiFLDG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 23:06:56 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19417544FD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 20:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655003215; x=1686539215;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xZTWEI2x5lRv9nqFwNr0qwQYzuGFpJLU3hijCLI2x3c=;
  b=bofpx468ShysfzMWBjsbNjbNYWcvprl0itvH7HNCblARw8d8PWCNju1A
   KTQ4wSH5OGaNpf/V/Y3ce06u6eysUd0mjP3HeYxw9Wme8i3Gpy6SaopMv
   z3tOqjyXZ6NqLJXLFyJVKpA3DtrZe7vWWBPmvY4Ywagq9Lcy1KixqH/Ao
   k1kuKZmWs3vxHfu9i87cXCRkXdoVq1mY+lPTno+qVnyvZFa6EsCFACIrr
   adgRV8tIoFWqtost29PAjt3RoeeIZw+Iyv8p/Iuv6BaVKVGhKe83/d/Rf
   B/WURoeSMtfDaBZ4eDC1oSI0wiVIl9AKP0MB9nQbly8xBkoyiWfeyCgX1
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="258414323"
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="258414323"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 20:06:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="685368735"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jun 2022 20:06:53 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0DwC-000JXm-JT;
        Sun, 12 Jun 2022 03:06:52 +0000
Date:   Sun, 12 Jun 2022 11:06:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ang Tien Sung <tien.sung.ang@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [dinguyen:svc_driver_updates_for_v4.20 3/6] htmldocs:
 include/linux/firmware/intel/stratix10-svc-client.h:149: warning: Excess
 enum value 'COMMAND_FCS_REQUEST_SERVICE' description in
 'stratix10_svc_command_code'
Message-ID: <202206121119.pgq8mAPv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git svc_driver_updates_for_v4.20
head:   107da326a0a3e7b6e81557c4225548db670a2647
commit: 389d4793ec9af06a6b3f110b309561cb98eaa013 [3/6] firmware: stratix10-svc: add new FCS commands
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> include/linux/firmware/intel/stratix10-svc-client.h:149: warning: Excess enum value 'COMMAND_FCS_REQUEST_SERVICE' description in 'stratix10_svc_command_code'
>> include/linux/firmware/intel/stratix10-svc-client.h:149: warning: Excess enum value 'COMMAND_FCS_DATA_DECRYPTION' description in 'stratix10_svc_command_code'
>> include/linux/firmware/intel/stratix10-svc-client.h:149: warning: Excess enum value 'COMMAND_FCS_SEND_CERTIFICATE' description in 'stratix10_svc_command_code'
>> include/linux/firmware/intel/stratix10-svc-client.h:149: warning: Excess enum value 'COMMAND_FCS_GET_PROVISION_DATA' description in 'stratix10_svc_command_code'
>> include/linux/firmware/intel/stratix10-svc-client.h:149: warning: Excess enum value 'COMMAND_FCS_DATA_ENCRYPTION' description in 'stratix10_svc_command_code'
>> include/linux/firmware/intel/stratix10-svc-client.h:149: warning: Excess enum value 'COMMAND_FCS_RANDOM_NUMBER_GEN' description in 'stratix10_svc_command_code'

vim +149 include/linux/firmware/intel/stratix10-svc-client.h

7ca5ce896524f5 Richard Gong          2018-11-13    8  
e23bd83368af41 Mauro Carvalho Chehab 2021-01-14    9  /*
7ca5ce896524f5 Richard Gong          2018-11-13   10   * Service layer driver supports client names
7ca5ce896524f5 Richard Gong          2018-11-13   11   *
7ca5ce896524f5 Richard Gong          2018-11-13   12   * fpga: for FPGA configuration
6b50d882d38d5a Richard Gong          2018-11-13   13   * rsu: for remote status update
7ca5ce896524f5 Richard Gong          2018-11-13   14   */
7ca5ce896524f5 Richard Gong          2018-11-13   15  #define SVC_CLIENT_FPGA			"fpga"
6b50d882d38d5a Richard Gong          2018-11-13   16  #define SVC_CLIENT_RSU			"rsu"
88f42ac48b8968 Ang Tien Sung         2022-03-15   17  #define SVC_CLIENT_FCS			"fcs"
88f42ac48b8968 Ang Tien Sung         2022-03-15   18  /**
7ca5ce896524f5 Richard Gong          2018-11-13  @19   * Status of the sent command, in bit number
7ca5ce896524f5 Richard Gong          2018-11-13   20   *
7536ad8dbfcfd5 Richard Gong          2020-04-14   21   * SVC_STATUS_OK:
7536ad8dbfcfd5 Richard Gong          2020-04-14   22   * Secure firmware accepts the request issued by one of service clients.
7ca5ce896524f5 Richard Gong          2018-11-13   23   *
7536ad8dbfcfd5 Richard Gong          2020-04-14   24   * SVC_STATUS_BUFFER_SUBMITTED:
7536ad8dbfcfd5 Richard Gong          2020-04-14   25   * Service client successfully submits data buffer to secure firmware.
7ca5ce896524f5 Richard Gong          2018-11-13   26   *
7536ad8dbfcfd5 Richard Gong          2020-04-14   27   * SVC_STATUS_BUFFER_DONE:
7ca5ce896524f5 Richard Gong          2018-11-13   28   * Secure firmware completes data process, ready to accept the
7ca5ce896524f5 Richard Gong          2018-11-13   29   * next WRITE transaction.
7ca5ce896524f5 Richard Gong          2018-11-13   30   *
7536ad8dbfcfd5 Richard Gong          2020-04-14   31   * SVC_STATUS_COMPLETED:
7536ad8dbfcfd5 Richard Gong          2020-04-14   32   * Secure firmware completes service request successfully. In case of
7536ad8dbfcfd5 Richard Gong          2020-04-14   33   * FPGA configuration, FPGA should be in user mode.
7ca5ce896524f5 Richard Gong          2018-11-13   34   *
7536ad8dbfcfd5 Richard Gong          2020-04-14   35   * SVC_COMMAND_STATUS_BUSY:
7536ad8dbfcfd5 Richard Gong          2020-04-14   36   * Service request is still in process.
7ca5ce896524f5 Richard Gong          2018-11-13   37   *
7536ad8dbfcfd5 Richard Gong          2020-04-14   38   * SVC_COMMAND_STATUS_ERROR:
7536ad8dbfcfd5 Richard Gong          2020-04-14   39   * Error encountered during the process of the service request.
6b50d882d38d5a Richard Gong          2018-11-13   40   *
7536ad8dbfcfd5 Richard Gong          2020-04-14   41   * SVC_STATUS_NO_SUPPORT:
7536ad8dbfcfd5 Richard Gong          2020-04-14   42   * Secure firmware doesn't support requested features such as RSU retry
7536ad8dbfcfd5 Richard Gong          2020-04-14   43   * or RSU notify.
7ca5ce896524f5 Richard Gong          2018-11-13   44   */
7536ad8dbfcfd5 Richard Gong          2020-04-14   45  #define SVC_STATUS_OK			0
7536ad8dbfcfd5 Richard Gong          2020-04-14   46  #define SVC_STATUS_BUFFER_SUBMITTED	1
7536ad8dbfcfd5 Richard Gong          2020-04-14   47  #define SVC_STATUS_BUFFER_DONE		2
7536ad8dbfcfd5 Richard Gong          2020-04-14   48  #define SVC_STATUS_COMPLETED		3
7536ad8dbfcfd5 Richard Gong          2020-04-14   49  #define SVC_STATUS_BUSY			4
7536ad8dbfcfd5 Richard Gong          2020-04-14   50  #define SVC_STATUS_ERROR		5
7536ad8dbfcfd5 Richard Gong          2020-04-14   51  #define SVC_STATUS_NO_SUPPORT		6
389d4793ec9af0 Ang Tien Sung         2022-06-09   52  #define SVC_STATUS_INVALID_PARAM	7
389d4793ec9af0 Ang Tien Sung         2022-06-09   53  /**
7ca5ce896524f5 Richard Gong          2018-11-13   54   * Flag bit for COMMAND_RECONFIG
7ca5ce896524f5 Richard Gong          2018-11-13   55   *
7ca5ce896524f5 Richard Gong          2018-11-13   56   * COMMAND_RECONFIG_FLAG_PARTIAL:
36847f9e3e56c1 Richard Gong          2020-06-15   57   * Set to FPGA configuration type (full or partial).
7ca5ce896524f5 Richard Gong          2018-11-13   58   */
2e8496f31d0be8 Richard Gong          2021-02-09   59  #define COMMAND_RECONFIG_FLAG_PARTIAL	0
7ca5ce896524f5 Richard Gong          2018-11-13   60  
e23bd83368af41 Mauro Carvalho Chehab 2021-01-14   61  /*
7ca5ce896524f5 Richard Gong          2018-11-13   62   * Timeout settings for service clients:
7ca5ce896524f5 Richard Gong          2018-11-13   63   * timeout value used in Stratix10 FPGA manager driver.
6b50d882d38d5a Richard Gong          2018-11-13   64   * timeout value used in RSU driver
7ca5ce896524f5 Richard Gong          2018-11-13   65   */
36847f9e3e56c1 Richard Gong          2020-06-15   66  #define SVC_RECONFIG_REQUEST_TIMEOUT_MS         300
36847f9e3e56c1 Richard Gong          2020-06-15   67  #define SVC_RECONFIG_BUFFER_TIMEOUT_MS          720
6b50d882d38d5a Richard Gong          2018-11-13   68  #define SVC_RSU_REQUEST_TIMEOUT_MS              300
389d4793ec9af0 Ang Tien Sung         2022-06-09   69  #define SVC_FCS_REQUEST_TIMEOUT_MS		2000
389d4793ec9af0 Ang Tien Sung         2022-06-09   70  #define SVC_COMPLETED_TIMEOUT_MS		30000
7ca5ce896524f5 Richard Gong          2018-11-13   71  
7ca5ce896524f5 Richard Gong          2018-11-13   72  struct stratix10_svc_chan;
7ca5ce896524f5 Richard Gong          2018-11-13   73  
7ca5ce896524f5 Richard Gong          2018-11-13   74  /**
7ca5ce896524f5 Richard Gong          2018-11-13   75   * enum stratix10_svc_command_code - supported service commands
7ca5ce896524f5 Richard Gong          2018-11-13   76   *
7ca5ce896524f5 Richard Gong          2018-11-13   77   * @COMMAND_NOOP: do 'dummy' request for integration/debug/trouble-shooting
7ca5ce896524f5 Richard Gong          2018-11-13   78   *
7ca5ce896524f5 Richard Gong          2018-11-13   79   * @COMMAND_RECONFIG: ask for FPGA configuration preparation, return status
7536ad8dbfcfd5 Richard Gong          2020-04-14   80   * is SVC_STATUS_OK
7ca5ce896524f5 Richard Gong          2018-11-13   81   *
7ca5ce896524f5 Richard Gong          2018-11-13   82   * @COMMAND_RECONFIG_DATA_SUBMIT: submit buffer(s) of bit-stream data for the
7536ad8dbfcfd5 Richard Gong          2020-04-14   83   * FPGA configuration, return status is SVC_STATUS_SUBMITTED or SVC_STATUS_ERROR
7ca5ce896524f5 Richard Gong          2018-11-13   84   *
7ca5ce896524f5 Richard Gong          2018-11-13   85   * @COMMAND_RECONFIG_DATA_CLAIM: check the status of the configuration, return
7536ad8dbfcfd5 Richard Gong          2020-04-14   86   * status is SVC_STATUS_COMPLETED, or SVC_STATUS_BUSY, or SVC_STATUS_ERROR
7ca5ce896524f5 Richard Gong          2018-11-13   87   *
7ca5ce896524f5 Richard Gong          2018-11-13   88   * @COMMAND_RECONFIG_STATUS: check the status of the configuration, return
7536ad8dbfcfd5 Richard Gong          2020-04-14   89   * status is SVC_STATUS_COMPLETED, or SVC_STATUS_BUSY, or SVC_STATUS_ERROR
6b50d882d38d5a Richard Gong          2018-11-13   90   *
6b50d882d38d5a Richard Gong          2018-11-13   91   * @COMMAND_RSU_STATUS: request remote system update boot log, return status
6b50d882d38d5a Richard Gong          2018-11-13   92   * is log data or SVC_STATUS_RSU_ERROR
6b50d882d38d5a Richard Gong          2018-11-13   93   *
6b50d882d38d5a Richard Gong          2018-11-13   94   * @COMMAND_RSU_UPDATE: set the offset of the bitstream to boot after reboot,
7536ad8dbfcfd5 Richard Gong          2020-04-14   95   * return status is SVC_STATUS_OK or SVC_STATUS_ERROR
b5dc75c915cdae Richard Gong          2019-09-03   96   *
b5dc75c915cdae Richard Gong          2019-09-03   97   * @COMMAND_RSU_NOTIFY: report the status of hard processor system
7536ad8dbfcfd5 Richard Gong          2020-04-14   98   * software to firmware, return status is SVC_STATUS_OK or
7536ad8dbfcfd5 Richard Gong          2020-04-14   99   * SVC_STATUS_ERROR
b5dc75c915cdae Richard Gong          2019-09-03  100   *
b5dc75c915cdae Richard Gong          2019-09-03  101   * @COMMAND_RSU_RETRY: query firmware for the current image's retry counter,
7536ad8dbfcfd5 Richard Gong          2020-04-14  102   * return status is SVC_STATUS_OK or SVC_STATUS_ERROR
bf0e5bf68a207b Richard Gong          2020-06-15  103   *
bf0e5bf68a207b Richard Gong          2020-06-15  104   * @COMMAND_RSU_MAX_RETRY: query firmware for the max retry value,
bf0e5bf68a207b Richard Gong          2020-06-15  105   * return status is SVC_STATUS_OK or SVC_STATUS_ERROR
bf0e5bf68a207b Richard Gong          2020-06-15  106   *
bf0e5bf68a207b Richard Gong          2020-06-15  107   * @COMMAND_RSU_DCMF_VERSION: query firmware for the DCMF version, return status
bf0e5bf68a207b Richard Gong          2020-06-15  108   * is SVC_STATUS_OK or SVC_STATUS_ERROR
085a884434f3e3 Richard Gong          2022-02-23  109   *
01fa95d63a56d2 Ang Tien Sung         2022-06-09  110   * @COMMAND_POLL_SERVICE_STATUS: poll if the service request is complete,
01fa95d63a56d2 Ang Tien Sung         2022-06-09  111   * return statis is SVC_STATUS_OK, SVC_STATUS_ERROR or SVC_STATUS_BUSY
01fa95d63a56d2 Ang Tien Sung         2022-06-09  112   *
085a884434f3e3 Richard Gong          2022-02-23  113   * @COMMAND_FIRMWARE_VERSION: query running firmware version, return status
085a884434f3e3 Richard Gong          2022-02-23  114   * is SVC_STATUS_OK or SVC_STATUS_ERROR
389d4793ec9af0 Ang Tien Sung         2022-06-09  115   *
389d4793ec9af0 Ang Tien Sung         2022-06-09  116   * @COMMAND_FCS_REQUEST_SERVICE: request validation of image from firmware,
389d4793ec9af0 Ang Tien Sung         2022-06-09  117   * return status is SVC_STATUS_OK, SVC_STATUS_INVALID_PARAM
389d4793ec9af0 Ang Tien Sung         2022-06-09  118   *
389d4793ec9af0 Ang Tien Sung         2022-06-09  119   * @COMMAND_FCS_SEND_CERTIFICATE: send a certificate, return status is
389d4793ec9af0 Ang Tien Sung         2022-06-09  120   * SVC_STATUS_OK, SVC_STATUS_INVALID_PARAM, SVC_STATUS_ERROR
389d4793ec9af0 Ang Tien Sung         2022-06-09  121   *
389d4793ec9af0 Ang Tien Sung         2022-06-09  122   * @COMMAND_FCS_GET_PROVISION_DATA: read the provisioning data, return status is
389d4793ec9af0 Ang Tien Sung         2022-06-09  123   * SVC_STATUS_OK, SVC_STATUS_INVALID_PARAM, SVC_STATUS_ERROR
389d4793ec9af0 Ang Tien Sung         2022-06-09  124   *
389d4793ec9af0 Ang Tien Sung         2022-06-09  125   * @COMMAND_FCS_DATA_ENCRYPTION: encrypt the data, return status is
389d4793ec9af0 Ang Tien Sung         2022-06-09  126   * SVC_STATUS_OK, SVC_STATUS_INVALID_PARAM, SVC_STATUS_ERROR
389d4793ec9af0 Ang Tien Sung         2022-06-09  127   *
389d4793ec9af0 Ang Tien Sung         2022-06-09  128   * @COMMAND_FCS_DATA_DECRYPTION: decrypt the data, return status is
389d4793ec9af0 Ang Tien Sung         2022-06-09  129   * SVC_STATUS_OK, SVC_STATUS_INVALID_PARAM, SVC_STATUS_ERROR
389d4793ec9af0 Ang Tien Sung         2022-06-09  130   *
389d4793ec9af0 Ang Tien Sung         2022-06-09  131   * @COMMAND_FCS_RANDOM_NUMBER_GEN: generate a random number, return status
389d4793ec9af0 Ang Tien Sung         2022-06-09  132   * is SVC_STATUS_OK, SVC_STATUS_ERROR
7ca5ce896524f5 Richard Gong          2018-11-13  133   */
7ca5ce896524f5 Richard Gong          2018-11-13  134  enum stratix10_svc_command_code {
7ca5ce896524f5 Richard Gong          2018-11-13  135  	COMMAND_NOOP = 0,
7ca5ce896524f5 Richard Gong          2018-11-13  136  	COMMAND_RECONFIG,
7ca5ce896524f5 Richard Gong          2018-11-13  137  	COMMAND_RECONFIG_DATA_SUBMIT,
7ca5ce896524f5 Richard Gong          2018-11-13  138  	COMMAND_RECONFIG_DATA_CLAIM,
6b50d882d38d5a Richard Gong          2018-11-13  139  	COMMAND_RECONFIG_STATUS,
6b50d882d38d5a Richard Gong          2018-11-13  140  	COMMAND_RSU_STATUS,
b5dc75c915cdae Richard Gong          2019-09-03  141  	COMMAND_RSU_UPDATE,
b5dc75c915cdae Richard Gong          2019-09-03  142  	COMMAND_RSU_NOTIFY,
b5dc75c915cdae Richard Gong          2019-09-03  143  	COMMAND_RSU_RETRY,
bf0e5bf68a207b Richard Gong          2020-06-15  144  	COMMAND_RSU_MAX_RETRY,
bf0e5bf68a207b Richard Gong          2020-06-15  145  	COMMAND_RSU_DCMF_VERSION,
085a884434f3e3 Richard Gong          2022-02-23  146  	COMMAND_FIRMWARE_VERSION,
01fa95d63a56d2 Ang Tien Sung         2022-06-09  147  	/* for general status poll */
01fa95d63a56d2 Ang Tien Sung         2022-06-09  148  	COMMAND_POLL_SERVICE_STATUS = 40,
7ca5ce896524f5 Richard Gong          2018-11-13 @149  };
7ca5ce896524f5 Richard Gong          2018-11-13  150  

:::::: The code at line 149 was first introduced by commit
:::::: 7ca5ce896524f5292e610b27d168269e5ab74951 firmware: add Intel Stratix10 service layer driver

:::::: TO: Richard Gong <richard.gong@intel.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
