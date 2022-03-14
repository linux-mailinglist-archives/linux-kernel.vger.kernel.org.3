Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813424D851E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 13:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241682AbiCNMfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 08:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245460AbiCNMdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 08:33:03 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40290140BC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 05:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647261076; x=1678797076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=41d2Y3qz9PJiQEd569wKArghYLwDa7+efpRCZ6uKdfU=;
  b=NARTRCMgiT5TMSfHPpHwYQucdpzxOqSs5qvX4XqxrR3BEGTWmZckv+v2
   Qeb20dK3J5KksLI4caksMKYoQ8niVrUwEsgMijSlbc5/oytGreHY8uo0+
   tOhS5gf86KDMXzXTi1AQtSWBkUZ+P6vdc5zdZm27J3i4/7JvjbmCkKGSn
   KWA9wxqUgD6X6wDP+RU9+0PRAbbxbdKv1vJAZWmJh8rEuHQ/A1ON5iZgQ
   H9xKABCWDEge3AAnCKa5ed/66S7R4nf+VOPQbW5by3CAQWhaEh1Cc1wdQ
   9t7HSbHfvsP2pvaNm6+mltk2qOEnY7Qt8Arxp0INnQ+V0pbCbVUzmxu9s
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="238183343"
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="238183343"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 05:31:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,180,1643702400"; 
   d="scan'208";a="818911890"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 14 Mar 2022 05:31:13 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTjqz-0009rB-6v; Mon, 14 Mar 2022 12:31:13 +0000
Date:   Mon, 14 Mar 2022 20:31:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     tien.sung.ang@intel.com, Dinh Nguyen <dinguyen@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: Re: [PATCH v2 3/3] firmware: stratix10-svc: add new FCS commands
Message-ID: <202203142003.Vwkl9J7g-lkp@intel.com>
References: <20220314141033.2165303-1-tien.sung.ang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314141033.2165303-1-tien.sung.ang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linux/master]
[also build test WARNING on linus/master v5.17-rc8]
[cannot apply to next-20220310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/tien-sung-ang-intel-com/firmware-stratix10-svc-Add-new-FCS-support/20220314-141232
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2c271fe77d52a0555161926c232cd5bc07178b39
config: arm64-randconfig-r036-20220313 (https://download.01.org/0day-ci/archive/20220314/202203142003.Vwkl9J7g-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 3e4950d7fa78ac83f33bbf1658e2f49a73719236)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/e0831198268601b99d0bdf092fbe2eb8be3b6686
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review tien-sung-ang-intel-com/firmware-stratix10-svc-Add-new-FCS-support/20220314-141232
        git checkout e0831198268601b99d0bdf092fbe2eb8be3b6686
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/firmware/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/firmware/stratix10-svc.c:380:32: warning: variable 'a4' set but not used [-Wunused-but-set-variable]
           unsigned long a0, a1, a2, a3, a4, a5;
                                         ^
>> drivers/firmware/stratix10-svc.c:380:28: warning: variable 'a3' set but not used [-Wunused-but-set-variable]
           unsigned long a0, a1, a2, a3, a4, a5;
                                     ^
>> drivers/firmware/stratix10-svc.c:380:36: warning: variable 'a5' set but not used [-Wunused-but-set-variable]
           unsigned long a0, a1, a2, a3, a4, a5;
                                             ^
   3 warnings generated.


vim +/a4 +380 drivers/firmware/stratix10-svc.c

   362	
   363	/**
   364	 * svc_normal_to_secure_thread() - the function to run in the kthread
   365	 * @data: data pointer for kthread function
   366	 *
   367	 * Service layer driver creates stratix10_svc_smc_hvc_call kthread on CPU
   368	 * node 0, its function stratix10_svc_secure_call_thread is used to handle
   369	 * SMC or HVC calls between kernel driver and secure monitor software.
   370	 *
   371	 * Return: 0 for success or -ENOMEM on error.
   372	 */
   373	static int svc_normal_to_secure_thread(void *data)
   374	{
   375		struct stratix10_svc_controller
   376				*ctrl = (struct stratix10_svc_controller *)data;
   377		struct stratix10_svc_data *pdata;
   378		struct stratix10_svc_cb_data *cbdata;
   379		struct arm_smccc_res res;
 > 380		unsigned long a0, a1, a2, a3, a4, a5;
   381		int ret_fifo = 0;
   382	
   383		pdata =  kmalloc(sizeof(*pdata), GFP_KERNEL);
   384		if (!pdata)
   385			return -ENOMEM;
   386	
   387		cbdata = kmalloc(sizeof(*cbdata), GFP_KERNEL);
   388		if (!cbdata) {
   389			kfree(pdata);
   390			return -ENOMEM;
   391		}
   392	
   393		/* default set, to remove build warning */
   394		a0 = INTEL_SIP_SMC_FPGA_CONFIG_LOOPBACK;
   395		a1 = 0;
   396		a2 = 0;
   397		a3 = 0;
   398		a4 = 0;
   399		a5 = 0;
   400	
   401		pr_debug("smc_hvc_shm_thread is running\n");
   402	
   403		while (!kthread_should_stop()) {
   404			ret_fifo = kfifo_out_spinlocked(&ctrl->svc_fifo,
   405							pdata, sizeof(*pdata),
   406							&ctrl->svc_fifo_lock);
   407	
   408			if (!ret_fifo)
   409				continue;
   410	
   411			pr_debug("get from FIFO pa=0x%016x, command=%u, size=%u\n",
   412				 (unsigned int)pdata->paddr, pdata->command,
   413				 (unsigned int)pdata->size);
   414	
   415			switch (pdata->command) {
   416			case COMMAND_RECONFIG_DATA_CLAIM:
   417				svc_thread_cmd_data_claim(ctrl, pdata, cbdata);
   418				continue;
   419			case COMMAND_RECONFIG:
   420				a0 = INTEL_SIP_SMC_FPGA_CONFIG_START;
   421				pr_debug("conf_type=%u\n", (unsigned int)pdata->flag);
   422				a1 = pdata->flag;
   423				a2 = 0;
   424				break;
   425			case COMMAND_RECONFIG_DATA_SUBMIT:
   426				a0 = INTEL_SIP_SMC_FPGA_CONFIG_WRITE;
   427				a1 = (unsigned long)pdata->paddr;
   428				a2 = (unsigned long)pdata->size;
   429				break;
   430			case COMMAND_RECONFIG_STATUS:
   431				a0 = INTEL_SIP_SMC_FPGA_CONFIG_ISDONE;
   432				a1 = 0;
   433				a2 = 0;
   434				break;
   435			case COMMAND_RSU_STATUS:
   436				a0 = INTEL_SIP_SMC_RSU_STATUS;
   437				a1 = 0;
   438				a2 = 0;
   439				break;
   440			case COMMAND_RSU_UPDATE:
   441				a0 = INTEL_SIP_SMC_RSU_UPDATE;
   442				a1 = pdata->arg[0];
   443				a2 = 0;
   444				break;
   445			case COMMAND_RSU_NOTIFY:
   446				a0 = INTEL_SIP_SMC_RSU_NOTIFY;
   447				a1 = pdata->arg[0];
   448				a2 = 0;
   449				break;
   450			case COMMAND_RSU_RETRY:
   451				a0 = INTEL_SIP_SMC_RSU_RETRY_COUNTER;
   452				a1 = 0;
   453				a2 = 0;
   454				break;
   455			case COMMAND_RSU_MAX_RETRY:
   456				a0 = INTEL_SIP_SMC_RSU_MAX_RETRY;
   457				a1 = 0;
   458				a2 = 0;
   459				break;
   460			case COMMAND_RSU_DCMF_VERSION:
   461				a0 = INTEL_SIP_SMC_RSU_DCMF_VERSION;
   462				a1 = 0;
   463				a2 = 0;
   464				break;
   465	
   466			/* for FCS */
   467			case COMMAND_FCS_DATA_ENCRYPTION:
   468				a0 = INTEL_SIP_SMC_FCS_CRYPTION;
   469				a1 = 1;
   470				a2 = (unsigned long)pdata->paddr;
   471				a3 = (unsigned long)pdata->size;
   472				a4 = (unsigned long)pdata->paddr_output;
   473				a5 = (unsigned long)pdata->size_output;
   474				break;
   475			case COMMAND_FCS_DATA_DECRYPTION:
   476				a0 = INTEL_SIP_SMC_FCS_CRYPTION;
   477				a1 = 0;
   478				a2 = (unsigned long)pdata->paddr;
   479				a3 = (unsigned long)pdata->size;
   480				a4 = (unsigned long)pdata->paddr_output;
   481				a5 = (unsigned long)pdata->size_output;
   482				break;
   483			case COMMAND_FCS_RANDOM_NUMBER_GEN:
   484				a0 = INTEL_SIP_SMC_FCS_RANDOM_NUMBER;
   485				a1 = (unsigned long)pdata->paddr;
   486				a2 = (unsigned long)pdata->size;
   487				break;
   488			case COMMAND_FCS_REQUEST_SERVICE:
   489				a0 = INTEL_SIP_SMC_FCS_SERVICE_REQUEST;
   490				a1 = (unsigned long)pdata->paddr;
   491				a2 = (unsigned long)pdata->size;
   492				break;
   493			case COMMAND_FCS_SEND_CERTIFICATE:
   494				a0 = INTEL_SIP_SMC_FCS_SEND_CERTIFICATE;
   495				a1 = (unsigned long)pdata->paddr;
   496				a2 = (unsigned long)pdata->size;
   497				break;
   498			case COMMAND_FCS_GET_PROVISION_DATA:
   499				a0 = INTEL_SIP_SMC_FCS_GET_PROVISION_DATA;
   500				a1 = (unsigned long)pdata->paddr;
   501				a2 = (unsigned long)pdata->size;
   502				break;
   503	
   504			/* for polling */
   505			case COMMAND_POLL_SERVICE_STATUS:
   506				a0 = INTEL_SIP_SMC_SERVICE_COMPLETED;
   507				a1 = (unsigned long)pdata->paddr;
   508				a2 = 0;
   509				break;
   510	
   511			default:
   512				pr_warn("it shouldn't happen\n");
   513				break;
   514			}
   515			pr_debug("%s: before SMC call -- a0=0x%016x a1=0x%016x",
   516				 __func__, (unsigned int)a0, (unsigned int)a1);
   517			pr_debug(" a2=0x%016x\n", (unsigned int)a2);
   518	
   519			ctrl->invoke_fn(a0, a1, a2, 0, 0, 0, 0, 0, &res);
   520	
   521			pr_debug("%s: after SMC call -- res.a0=0x%016x",
   522				 __func__, (unsigned int)res.a0);
   523			pr_debug(" res.a1=0x%016x, res.a2=0x%016x",
   524				 (unsigned int)res.a1, (unsigned int)res.a2);
   525			pr_debug(" res.a3=0x%016x\n", (unsigned int)res.a3);
   526	
   527			if (pdata->command == COMMAND_RSU_STATUS) {
   528				if (res.a0 == INTEL_SIP_SMC_RSU_ERROR)
   529					cbdata->status = BIT(SVC_STATUS_ERROR);
   530				else
   531					cbdata->status = BIT(SVC_STATUS_OK);
   532	
   533				cbdata->kaddr1 = &res;
   534				cbdata->kaddr2 = NULL;
   535				cbdata->kaddr3 = NULL;
   536				pdata->chan->scl->receive_cb(pdata->chan->scl, cbdata);
   537				continue;
   538			}
   539	
   540			switch (res.a0) {
   541			case INTEL_SIP_SMC_STATUS_OK:
   542				svc_thread_recv_status_ok(pdata, cbdata, res);
   543				break;
   544			case INTEL_SIP_SMC_STATUS_BUSY:
   545				switch (pdata->command) {
   546				case COMMAND_RECONFIG_DATA_SUBMIT:
   547					svc_thread_cmd_data_claim(ctrl,
   548								  pdata, cbdata);
   549					break;
   550				case COMMAND_RECONFIG_STATUS:
   551				case COMMAND_POLL_SERVICE_STATUS:
   552					svc_thread_cmd_config_status(ctrl,
   553								     pdata, cbdata);
   554					break;
   555				default:
   556					pr_warn("it shouldn't happen\n");
   557					break;
   558				}
   559				break;
   560			case INTEL_SIP_SMC_STATUS_REJECTED:
   561				pr_debug("%s: STATUS_REJECTED\n", __func__);
   562				/* for FCS */
   563				switch (pdata->command) {
   564				case COMMAND_FCS_REQUEST_SERVICE:
   565				case COMMAND_FCS_SEND_CERTIFICATE:
   566				case COMMAND_FCS_GET_PROVISION_DATA:
   567				case COMMAND_FCS_DATA_ENCRYPTION:
   568				case COMMAND_FCS_DATA_DECRYPTION:
   569				case COMMAND_FCS_RANDOM_NUMBER_GEN:
   570					cbdata->status = BIT(SVC_STATUS_INVALID_PARAM);
   571					cbdata->kaddr1 = NULL;
   572					cbdata->kaddr2 = NULL;
   573					cbdata->kaddr3 = NULL;
   574					pdata->chan->scl->receive_cb(pdata->chan->scl,
   575								     cbdata);
   576					break;
   577				}
   578				break;
   579			case INTEL_SIP_SMC_STATUS_ERROR:
   580			case INTEL_SIP_SMC_RSU_ERROR:
   581				pr_err("%s: STATUS_ERROR\n", __func__);
   582				cbdata->status = BIT(SVC_STATUS_ERROR);
   583				cbdata->kaddr1 = NULL;
   584				cbdata->kaddr2 = NULL;
   585				cbdata->kaddr3 = NULL;
   586				pdata->chan->scl->receive_cb(pdata->chan->scl, cbdata);
   587				break;
   588			default:
   589				pr_warn("Secure firmware doesn't support...\n");
   590	
   591				/*
   592				 * be compatible with older version firmware which
   593				 * doesn't support RSU notify or retry
   594				 */
   595				if ((pdata->command == COMMAND_RSU_RETRY) ||
   596				    (pdata->command == COMMAND_RSU_MAX_RETRY) ||
   597					(pdata->command == COMMAND_RSU_NOTIFY)) {
   598					cbdata->status =
   599						BIT(SVC_STATUS_NO_SUPPORT);
   600					cbdata->kaddr1 = NULL;
   601					cbdata->kaddr2 = NULL;
   602					cbdata->kaddr3 = NULL;
   603					pdata->chan->scl->receive_cb(
   604						pdata->chan->scl, cbdata);
   605				}
   606				break;
   607	
   608			}
   609		}
   610	
   611		kfree(cbdata);
   612		kfree(pdata);
   613	
   614		return 0;
   615	}
   616	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
