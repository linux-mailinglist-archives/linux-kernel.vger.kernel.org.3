Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871AD588533
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 02:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbiHCAzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 20:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiHCAzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 20:55:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2842616B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 17:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659488142; x=1691024142;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9ZtfaA+x1m2xgYbNfxrqEK2e3iLfLdWEbxzXNcdKttU=;
  b=aQwigMH4u1rsFIssf8tApJ2P5Z7MoVTivqnNDnDtN/bEYnfsEXxp154e
   6C2Z0Lll3YmGqCtLSrlpV1fDpLsWqqLtvUk3inxQ0NqwTlwQ/OzD5Z7Sw
   dPrDS8KbZWf9Vqh20VPHA847Vs6DLyb0ss4SGIKBAkkofuHNTIcu/xbg6
   h9A67VujjVcK7vMQPzk2wPYkVyxgi+MChvBfdY/+wqAL0xLJ76Xqj4Wc+
   X4kTbfRBRy0JDLl6aWR3/S5klWmC970JA5M3nm2DFFMKpfzhtuqSGUkQ9
   cDTu7G8Z/MQoM4y+NfTxI17IBlxyiH0Z7OQSQr20eoO315c/89pfkQdud
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="315408032"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="315408032"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 17:55:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="930185995"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 02 Aug 2022 17:55:41 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJ2fk-000Gd9-2A;
        Wed, 03 Aug 2022 00:55:40 +0000
Date:   Wed, 3 Aug 2022 08:55:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>
Subject: [steev:linux-v5.19.0 77/198] drivers/soc/qcom/qmi_interface.c:186:
 undefined reference to `kernel_sendmsg'
Message-ID: <202208030827.9a9XDIkk-lkp@intel.com>
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

Hi Maximilian,

First bad commit (maybe != root cause):

tree:   https://github.com/steev/linux linux-v5.19.0
head:   a4510d0cef54eda304739679db13f1f17abe4125
commit: 530efef96636ea3887e975fc0268b5ee83c9dcf8 [77/198] usb: typec: ucsi: Make UCSI_GLINK select QCOM_PDR_HELPERS
config: arc-randconfig-r033-20220801 (https://download.01.org/0day-ci/archive/20220803/202208030827.9a9XDIkk-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/steev/linux/commit/530efef96636ea3887e975fc0268b5ee83c9dcf8
        git remote add steev https://github.com/steev/linux
        git fetch --no-tags steev linux-v5.19.0
        git checkout 530efef96636ea3887e975fc0268b5ee83c9dcf8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arc-elf-ld: drivers/soc/qcom/qmi_interface.o: in function `qmi_send_new_lookup':
>> drivers/soc/qcom/qmi_interface.c:186: undefined reference to `kernel_sendmsg'
>> arc-elf-ld: drivers/soc/qcom/qmi_interface.c:186: undefined reference to `kernel_sendmsg'
   arc-elf-ld: drivers/soc/qcom/qmi_interface.o: in function `qmi_send_new_server':
   drivers/soc/qcom/qmi_interface.c:251: undefined reference to `kernel_sendmsg'
   arc-elf-ld: drivers/soc/qcom/qmi_interface.c:251: undefined reference to `kernel_sendmsg'
   arc-elf-ld: drivers/soc/qcom/qmi_interface.o: in function `qmi_send_message':
   drivers/soc/qcom/qmi_interface.c:763: undefined reference to `kernel_sendmsg'
   arc-elf-ld: drivers/soc/qcom/qmi_interface.o:drivers/soc/qcom/qmi_interface.c:763: more undefined references to `kernel_sendmsg' follow
   arc-elf-ld: drivers/soc/qcom/qmi_interface.o: in function `qmi_sock_create':
>> drivers/soc/qcom/qmi_interface.c:588: undefined reference to `init_net'
>> arc-elf-ld: drivers/soc/qcom/qmi_interface.c:588: undefined reference to `init_net'
>> arc-elf-ld: drivers/soc/qcom/qmi_interface.c:588: undefined reference to `sock_create_kern'
>> arc-elf-ld: drivers/soc/qcom/qmi_interface.c:588: undefined reference to `sock_create_kern'
>> arc-elf-ld: drivers/soc/qcom/qmi_interface.c:593: undefined reference to `kernel_getsockname'
>> arc-elf-ld: drivers/soc/qcom/qmi_interface.c:593: undefined reference to `kernel_getsockname'
>> arc-elf-ld: drivers/soc/qcom/qmi_interface.c:595: undefined reference to `sock_release'
>> arc-elf-ld: drivers/soc/qcom/qmi_interface.c:595: undefined reference to `sock_release'
   arc-elf-ld: drivers/soc/qcom/qmi_interface.o: in function `qmi_send_message':
   drivers/soc/qcom/qmi_interface.c:763: undefined reference to `kernel_sendmsg'
   arc-elf-ld: drivers/soc/qcom/qmi_interface.c:763: undefined reference to `kernel_sendmsg'
   arc-elf-ld: drivers/soc/qcom/qmi_interface.c:763: undefined reference to `kernel_sendmsg'
   arc-elf-ld: drivers/soc/qcom/qmi_interface.c:763: undefined reference to `kernel_sendmsg'
   arc-elf-ld: drivers/soc/qcom/qmi_interface.o: in function `qmi_handle_release':
>> drivers/soc/qcom/qmi_interface.c:695: undefined reference to `sock_release'
>> arc-elf-ld: drivers/soc/qcom/qmi_interface.c:695: undefined reference to `sock_release'
   arc-elf-ld: drivers/soc/qcom/qmi_interface.o: in function `qmi_data_ready_work':
>> drivers/soc/qcom/qmi_interface.c:537: undefined reference to `kernel_recvmsg'
>> arc-elf-ld: drivers/soc/qcom/qmi_interface.c:537: undefined reference to `kernel_recvmsg'
   arc-elf-ld: drivers/soc/qcom/qmi_interface.o: in function `qmi_sock_create':
>> drivers/soc/qcom/qmi_interface.c:588: undefined reference to `init_net'
>> arc-elf-ld: drivers/soc/qcom/qmi_interface.c:588: undefined reference to `init_net'
>> arc-elf-ld: drivers/soc/qcom/qmi_interface.c:588: undefined reference to `sock_create_kern'
>> arc-elf-ld: drivers/soc/qcom/qmi_interface.c:588: undefined reference to `sock_create_kern'
>> arc-elf-ld: drivers/soc/qcom/qmi_interface.c:593: undefined reference to `kernel_getsockname'
>> arc-elf-ld: drivers/soc/qcom/qmi_interface.c:593: undefined reference to `kernel_getsockname'
   arc-elf-ld: drivers/soc/qcom/qmi_interface.c:595: undefined reference to `sock_release'
   arc-elf-ld: drivers/soc/qcom/qmi_interface.c:595: undefined reference to `sock_release'
   arc-elf-ld: drivers/soc/qcom/qmi_interface.o: in function `qmi_handle_net_reset':
   drivers/soc/qcom/qmi_interface.c:450: undefined reference to `sock_release'
   arc-elf-ld: drivers/soc/qcom/qmi_interface.c:450: undefined reference to `sock_release'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for QCOM_QMI_HELPERS
   Depends on [n]: NET [=n]
   Selected by [y]:
   - QCOM_PDR_HELPERS [=y]


vim +186 drivers/soc/qcom/qmi_interface.c

3830d0771ef66a Bjorn Andersson 2017-12-05  163  
3830d0771ef66a Bjorn Andersson 2017-12-05  164  static void qmi_send_new_lookup(struct qmi_handle *qmi, struct qmi_service *svc)
3830d0771ef66a Bjorn Andersson 2017-12-05  165  {
3830d0771ef66a Bjorn Andersson 2017-12-05  166  	struct qrtr_ctrl_pkt pkt;
3830d0771ef66a Bjorn Andersson 2017-12-05  167  	struct sockaddr_qrtr sq;
3830d0771ef66a Bjorn Andersson 2017-12-05  168  	struct msghdr msg = { };
3830d0771ef66a Bjorn Andersson 2017-12-05  169  	struct kvec iv = { &pkt, sizeof(pkt) };
3830d0771ef66a Bjorn Andersson 2017-12-05  170  	int ret;
3830d0771ef66a Bjorn Andersson 2017-12-05  171  
3830d0771ef66a Bjorn Andersson 2017-12-05  172  	memset(&pkt, 0, sizeof(pkt));
3830d0771ef66a Bjorn Andersson 2017-12-05  173  	pkt.cmd = cpu_to_le32(QRTR_TYPE_NEW_LOOKUP);
3830d0771ef66a Bjorn Andersson 2017-12-05  174  	pkt.server.service = cpu_to_le32(svc->service);
3830d0771ef66a Bjorn Andersson 2017-12-05  175  	pkt.server.instance = cpu_to_le32(svc->version | svc->instance << 8);
3830d0771ef66a Bjorn Andersson 2017-12-05  176  
3830d0771ef66a Bjorn Andersson 2017-12-05  177  	sq.sq_family = qmi->sq.sq_family;
3830d0771ef66a Bjorn Andersson 2017-12-05  178  	sq.sq_node = qmi->sq.sq_node;
3830d0771ef66a Bjorn Andersson 2017-12-05  179  	sq.sq_port = QRTR_PORT_CTRL;
3830d0771ef66a Bjorn Andersson 2017-12-05  180  
3830d0771ef66a Bjorn Andersson 2017-12-05  181  	msg.msg_name = &sq;
3830d0771ef66a Bjorn Andersson 2017-12-05  182  	msg.msg_namelen = sizeof(sq);
3830d0771ef66a Bjorn Andersson 2017-12-05  183  
3830d0771ef66a Bjorn Andersson 2017-12-05  184  	mutex_lock(&qmi->sock_lock);
3830d0771ef66a Bjorn Andersson 2017-12-05  185  	if (qmi->sock) {
3830d0771ef66a Bjorn Andersson 2017-12-05 @186  		ret = kernel_sendmsg(qmi->sock, &msg, &iv, 1, sizeof(pkt));
3830d0771ef66a Bjorn Andersson 2017-12-05  187  		if (ret < 0)
3830d0771ef66a Bjorn Andersson 2017-12-05  188  			pr_err("failed to send lookup registration: %d\n", ret);
3830d0771ef66a Bjorn Andersson 2017-12-05  189  	}
3830d0771ef66a Bjorn Andersson 2017-12-05  190  	mutex_unlock(&qmi->sock_lock);
3830d0771ef66a Bjorn Andersson 2017-12-05  191  }
3830d0771ef66a Bjorn Andersson 2017-12-05  192  

:::::: The code at line 186 was first introduced by commit
:::::: 3830d0771ef66a3bb9ab57b70630b3598593a4f0 soc: qcom: Introduce QMI helpers

:::::: TO: Bjorn Andersson <bjorn.andersson@linaro.org>
:::::: CC: Andy Gross <andy.gross@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
