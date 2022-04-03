Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D5D4F0B8C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 19:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359653AbiDCRYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 13:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242679AbiDCRYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 13:24:34 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66D939836
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 10:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649006559; x=1680542559;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l6k6xzqdz7LtU171d9mt1RnvE9i7VuxAE8V9SxSL0BY=;
  b=HsmsJXCrt4+OD9N3csE8xou//jib5N9OVte39CzK2gg25sE7wXD8VlVP
   Fo67YrSh5CDPpdBsPK2Y5uDXWvbaeAA2mDiXKvU7cnxcIOaToFS2wFu27
   DAXXqTlLxFUsb/azvh+kh3w9h21EtqY7Mu2+dodWl0WEn11U8EAoCAjac
   StyhkfjfUd+rQHHedCo6TzuqpxRX+3ZYmLDjcHj0L9QhmEKCAP0M0pu8U
   xfTzx8ZQpfc4zH8n1eiJdIlmbM8Z97NkSGXrO+VKkZ7TAcOzb5uq/Y68r
   iJvkjbZgt8z0mIkb4kLy4BB2Rke3ipHhbzU7B3cvOqGxvC7cdgxNr6QTi
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="346837215"
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="346837215"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 10:22:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,231,1643702400"; 
   d="scan'208";a="721411724"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 03 Apr 2022 10:22:37 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nb3vx-00018B-9k;
        Sun, 03 Apr 2022 17:22:37 +0000
Date:   Mon, 4 Apr 2022 01:22:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Borislav Petkov <bp@suse.de>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:bp/bp/test 21/23] drivers/edac/ghes_edac.c:533:
 undefined reference to `mce_register_decode_chain'
Message-ID: <202204040142.nm9rQcco-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block bp/bp/test
head:   aff0e90f2a981e0350187c8a931071d7f35df6e5
commit: ef3a8acde71eb676a92d9f3158d7f112061e2bf9 [21/23] ghes_edac: Convert MCE to its representation
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220404/202204040142.nm9rQcco-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/ef3a8acde71eb676a92d9f3158d7f112061e2bf9
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block bp/bp/test
        git checkout ef3a8acde71eb676a92d9f3158d7f112061e2bf9
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   vmlinux.o: warning: objtool: __do_fast_syscall_32()+0x1a: call to static_key_count.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: do_syscall_64()+0xc: call to static_key_count.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: do_int80_syscall_32()+0x1a: call to static_key_count.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: enter_from_user_mode()+0x18: call to __kcsan_check_access() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode()+0x1d: call to __kcsan_check_access() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_enter_from_user_mode_prepare()+0x18: call to __kcsan_check_access() leaves .noinstr.text section
   vmlinux.o: warning: objtool: exit_to_user_mode()+0x10: call to static_key_count.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: syscall_exit_to_user_mode()+0x29: call to static_key_count.constprop.0() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_enter_from_user_mode()+0x18: call to __kcsan_check_access() leaves .noinstr.text section
   vmlinux.o: warning: objtool: irqentry_exit_to_user_mode()+0x17: call to static_key_count.constprop.0() leaves .noinstr.text section
   ld: drivers/edac/ghes_edac.o: in function `ghes_edac_register':
>> drivers/edac/ghes_edac.c:533: undefined reference to `mce_register_decode_chain'
   ld: drivers/edac/ghes_edac.o: in function `ghes_edac_unregister':
>> drivers/edac/ghes_edac.c:561: undefined reference to `mce_unregister_decode_chain'


vim +533 drivers/edac/ghes_edac.c

   414	
   415	int ghes_edac_register(struct ghes *ghes, struct device *dev)
   416	{
   417		bool fake = false;
   418		struct mem_ctl_info *mci;
   419		struct ghes_pvt *pvt;
   420		struct edac_mc_layer layers[1];
   421		unsigned long flags;
   422		int idx = -1;
   423		int rc = 0;
   424	
   425		if (IS_ENABLED(CONFIG_X86)) {
   426			/* Check if safe to enable on this system */
   427			idx = acpi_match_platform_list(plat_list);
   428			if (!force_load && idx < 0)
   429				return -ENODEV;
   430		} else {
   431			force_load = true;
   432			idx = 0;
   433		}
   434	
   435		/* finish another registration/unregistration instance first */
   436		mutex_lock(&ghes_reg_mutex);
   437	
   438		/*
   439		 * We have only one logical memory controller to which all DIMMs belong.
   440		 */
   441		if (refcount_inc_not_zero(&ghes_refcount))
   442			goto unlock;
   443	
   444		ghes_scan_system();
   445	
   446		/* Check if we've got a bogus BIOS */
   447		if (!ghes_hw.num_dimms) {
   448			fake = true;
   449			ghes_hw.num_dimms = 1;
   450		}
   451	
   452		layers[0].type = EDAC_MC_LAYER_ALL_MEM;
   453		layers[0].size = ghes_hw.num_dimms;
   454		layers[0].is_virt_csrow = true;
   455	
   456		mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(struct ghes_pvt));
   457		if (!mci) {
   458			pr_info("Can't allocate memory for EDAC data\n");
   459			rc = -ENOMEM;
   460			goto unlock;
   461		}
   462	
   463		pvt		= mci->pvt_info;
   464		pvt->mci	= mci;
   465	
   466		mci->pdev = dev;
   467		mci->mtype_cap = MEM_FLAG_EMPTY;
   468		mci->edac_ctl_cap = EDAC_FLAG_NONE;
   469		mci->edac_cap = EDAC_FLAG_NONE;
   470		mci->mod_name = "ghes_edac.c";
   471		mci->ctl_name = "ghes_edac";
   472		mci->dev_name = "ghes";
   473	
   474		if (fake) {
   475			pr_info("This system has a very crappy BIOS: It doesn't even list the DIMMS.\n");
   476			pr_info("Its SMBIOS info is wrong. It is doubtful that the error report would\n");
   477			pr_info("work on such system. Use this driver with caution\n");
   478		} else if (idx < 0) {
   479			pr_info("This EDAC driver relies on BIOS to enumerate memory and get error reports.\n");
   480			pr_info("Unfortunately, not all BIOSes reflect the memory layout correctly.\n");
   481			pr_info("So, the end result of using this driver varies from vendor to vendor.\n");
   482			pr_info("If you find incorrect reports, please contact your hardware vendor\n");
   483			pr_info("to correct its BIOS.\n");
   484			pr_info("This system has %d DIMM sockets.\n", ghes_hw.num_dimms);
   485		}
   486	
   487		if (!fake) {
   488			struct dimm_info *src, *dst;
   489			int i = 0;
   490	
   491			mci_for_each_dimm(mci, dst) {
   492				src = &ghes_hw.dimms[i];
   493	
   494				dst->idx	   = src->idx;
   495				dst->smbios_handle = src->smbios_handle;
   496				dst->nr_pages	   = src->nr_pages;
   497				dst->mtype	   = src->mtype;
   498				dst->edac_mode	   = src->edac_mode;
   499				dst->dtype	   = src->dtype;
   500				dst->grain	   = src->grain;
   501	
   502				/*
   503				 * If no src->label, preserve default label assigned
   504				 * from EDAC core.
   505				 */
   506				if (strlen(src->label))
   507					memcpy(dst->label, src->label, sizeof(src->label));
   508	
   509				i++;
   510			}
   511	
   512		} else {
   513			struct dimm_info *dimm = edac_get_dimm(mci, 0, 0, 0);
   514	
   515			dimm->nr_pages = 1;
   516			dimm->grain = 128;
   517			dimm->mtype = MEM_UNKNOWN;
   518			dimm->dtype = DEV_UNKNOWN;
   519			dimm->edac_mode = EDAC_SECDED;
   520		}
   521	
   522		rc = edac_mc_add_mc(mci);
   523		if (rc < 0) {
   524			pr_info("Can't register with the EDAC core\n");
   525			edac_mc_free(mci);
   526			rc = -ENODEV;
   527			goto unlock;
   528		}
   529	
   530		spin_lock_irqsave(&ghes_lock, flags);
   531		ghes_pvt = pvt;
   532	
 > 533		mce_register_decode_chain(&ghes_mce_dec_nb);
   534	
   535		spin_unlock_irqrestore(&ghes_lock, flags);
   536	
   537		/* only set on success */
   538		refcount_set(&ghes_refcount, 1);
   539	
   540	unlock:
   541	
   542		/* Not needed anymore */
   543		kfree(ghes_hw.dimms);
   544		ghes_hw.dimms = NULL;
   545	
   546		mutex_unlock(&ghes_reg_mutex);
   547	
   548		return rc;
   549	}
   550	
   551	void ghes_edac_unregister(struct ghes *ghes)
   552	{
   553		struct mem_ctl_info *mci;
   554		unsigned long flags;
   555	
   556		if (!force_load)
   557			return;
   558	
   559		mutex_lock(&ghes_reg_mutex);
   560	
 > 561		mce_unregister_decode_chain(&ghes_mce_dec_nb);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
