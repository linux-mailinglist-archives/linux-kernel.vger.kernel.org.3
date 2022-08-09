Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E15358E39C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 01:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiHIXMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 19:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiHIXMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 19:12:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4560665A2
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 16:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660086725; x=1691622725;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hwPgQ+Cq+z2s0uaLH1xuRBq76PiNwSF71DNxJfrgOhs=;
  b=UMI6KlWTleyzfxKOJnSGZAeTjS50tPa01u9Ell8KL4oMpm/KxLmEwPks
   qp08+Jx4vE+1dhceQTR1IRhDsBkz0vTfi6xmQHhNvXXVrFRNE0nGye4QE
   Zq+r0JjCu+OVUopAosk2khKEBwxKzuW++rw4CXX7OqS5nBdwVhs7boqC4
   1zz9mLM1V4XgttuZhPTg7+gUwFjvqqN9yrxeYu02DnwsKELgFA32sxRpu
   VieA0hkvtHxYyzPLgkKkgh7TuDyNiXcCn9e1isATImncSgpUoPr1yhYzg
   WwAK0zqICUdF85ryWlIEXF4GYz0xaINykor0EHBdwga95UVpBdLwz+wr0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="270728913"
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="270728913"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2022 16:12:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,225,1654585200"; 
   d="scan'208";a="555519672"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 09 Aug 2022 16:12:02 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLYOI-000NLN-0t;
        Tue, 09 Aug 2022 23:12:02 +0000
Date:   Wed, 10 Aug 2022 07:11:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Quinn Tran <qutran@marvell.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Nilesh Javali <njavali@marvell.com>
Subject: drivers/scsi/qla2xxx/qla_init.c:171:17: warning: variable 'bail' set
 but not used
Message-ID: <202208100749.O5lpvjoS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   15205c2829ca2cbb5ece5ceaafe1171a8470e62b
commit: 63fa7f2644b4b48e1913af33092c044bf48e9321 scsi: qla2xxx: Fix imbalance vha->vref_count
date:   3 weeks ago
config: parisc-buildonly-randconfig-r002-20220810 (https://download.01.org/0day-ci/archive/20220810/202208100749.O5lpvjoS-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=63fa7f2644b4b48e1913af33092c044bf48e9321
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 63fa7f2644b4b48e1913af33092c044bf48e9321
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/scsi/qla2xxx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/scsi/qla2xxx/qla_init.c: In function 'qla24xx_async_abort_cmd':
>> drivers/scsi/qla2xxx/qla_init.c:171:17: warning: variable 'bail' set but not used [-Wunused-but-set-variable]
     171 |         uint8_t bail;
         |                 ^~~~
   drivers/scsi/qla2xxx/qla_init.c: In function 'qla2x00_async_tm_cmd':
   drivers/scsi/qla2xxx/qla_init.c:2023:17: warning: variable 'bail' set but not used [-Wunused-but-set-variable]
    2023 |         uint8_t bail;
         |                 ^~~~


vim +/bail +171 drivers/scsi/qla2xxx/qla_init.c

   164	
   165	int qla24xx_async_abort_cmd(srb_t *cmd_sp, bool wait)
   166	{
   167		scsi_qla_host_t *vha = cmd_sp->vha;
   168		struct srb_iocb *abt_iocb;
   169		srb_t *sp;
   170		int rval = QLA_FUNCTION_FAILED;
 > 171		uint8_t bail;
   172	
   173		/* ref: INIT for ABTS command */
   174		sp = qla2xxx_get_qpair_sp(cmd_sp->vha, cmd_sp->qpair, cmd_sp->fcport,
   175					  GFP_ATOMIC);
   176		if (!sp)
   177			return QLA_MEMORY_ALLOC_FAILED;
   178	
   179		QLA_VHA_MARK_BUSY(vha, bail);
   180		abt_iocb = &sp->u.iocb_cmd;
   181		sp->type = SRB_ABT_CMD;
   182		sp->name = "abort";
   183		sp->qpair = cmd_sp->qpair;
   184		sp->cmd_sp = cmd_sp;
   185		if (wait)
   186			sp->flags = SRB_WAKEUP_ON_COMP;
   187	
   188		init_completion(&abt_iocb->u.abt.comp);
   189		/* FW can send 2 x ABTS's timeout/20s */
   190		qla2x00_init_async_sp(sp, 42, qla24xx_abort_sp_done);
   191		sp->u.iocb_cmd.timeout = qla24xx_abort_iocb_timeout;
   192	
   193		abt_iocb->u.abt.cmd_hndl = cmd_sp->handle;
   194		abt_iocb->u.abt.req_que_no = cpu_to_le16(cmd_sp->qpair->req->id);
   195	
   196		ql_dbg(ql_dbg_async, vha, 0x507c,
   197		       "Abort command issued - hdl=%x, type=%x\n", cmd_sp->handle,
   198		       cmd_sp->type);
   199	
   200		rval = qla2x00_start_sp(sp);
   201		if (rval != QLA_SUCCESS) {
   202			/* ref: INIT */
   203			kref_put(&sp->cmd_kref, qla2x00_sp_release);
   204			return rval;
   205		}
   206	
   207		if (wait) {
   208			wait_for_completion(&abt_iocb->u.abt.comp);
   209			rval = abt_iocb->u.abt.comp_status == CS_COMPLETE ?
   210				QLA_SUCCESS : QLA_ERR_FROM_FW;
   211			/* ref: INIT */
   212			kref_put(&sp->cmd_kref, qla2x00_sp_release);
   213		}
   214	
   215		return rval;
   216	}
   217	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
