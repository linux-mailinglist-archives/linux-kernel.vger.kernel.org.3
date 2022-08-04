Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A01589ABE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 13:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239446AbiHDLGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbiHDLGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:06:13 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE5454C8E
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 04:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659611171; x=1691147171;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=g2XIBzwoxWImgIGvbWEAnhhp8ICnZBl8VoMuGlemJfU=;
  b=fenc1XvkkrhRdv5Bmtu6Hp+Tc3Gti3xAvs4v+mg9heFvLMXT6E/NRcYF
   41oAKEyE8wRqNhktIPFSdc4W9RwpNuieZtgrJD4AnmGUDh8oEDMbL28fG
   rTS5kcTq3pEoYumCqZJDUwMvY8hn4pOcAZGEBJrvZOQzm/2jPnvqptLxs
   7tihBWeGFmpIuSRFWI6j7J07ZlKBGE8k8PIOYnRwrMZvhz5L45qsgARmp
   1UolgVvHtfZCYqEoDXb+rqSoetjHJBmsFlRnqPhEVim4GYxUdIoPzmiBu
   XMxnqVsAOuea4jaKO5mE4h9+29Afb9H/M8hN6Xdf1oYU1gJauuKGqZbOs
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="289917000"
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="289917000"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 04:06:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,215,1654585200"; 
   d="scan'208";a="729550086"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 04 Aug 2022 04:06:09 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJYg4-000IKj-1p;
        Thu, 04 Aug 2022 11:06:08 +0000
Date:   Thu, 4 Aug 2022 19:06:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [intel-tdx:guest-attest 1/2] arch/x86/coco/tdx/tdx.c:821:41: sparse:
 sparse: incorrect type in argument 2 (different address spaces)
Message-ID: <202208041820.HEPRjuUe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-attest
head:   d30c4e767a714a03fbef1d64497d9feb9371d966
commit: 7453075aee822045337155e14567e2d74b3b4b4a [1/2] x86/tdx: Add TDX Guest attestation interface driver
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220804/202208041820.HEPRjuUe-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel/tdx/commit/7453075aee822045337155e14567e2d74b3b4b4a
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-attest
        git checkout 7453075aee822045337155e14567e2d74b3b4b4a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/coco/tdx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> arch/x86/coco/tdx/tdx.c:821:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void * @@
   arch/x86/coco/tdx/tdx.c:821:41: sparse:     expected void const [noderef] __user *from
   arch/x86/coco/tdx/tdx.c:821:41: sparse:     got void *
>> arch/x86/coco/tdx/tdx.c:842:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got void * @@
   arch/x86/coco/tdx/tdx.c:842:27: sparse:     expected void [noderef] __user *to
   arch/x86/coco/tdx/tdx.c:842:27: sparse:     got void *

vim +821 arch/x86/coco/tdx/tdx.c

   787	
   788	static long tdx_get_report(void __user *argp)
   789	{
   790		u8 *reportdata = NULL, *tdreport = NULL;
   791		struct tdx_report_req req;
   792		long ret;
   793	
   794		/* Copy request struct from the user buffer */
   795		if (copy_from_user(&req, argp, sizeof(req)))
   796			return -EFAULT;
   797	
   798		/*
   799		 * Per TDX Module 1.0 specification, section titled
   800		 * "TDG.MR.REPORT", REPORTDATA and TDREPORT length
   801		 * is fixed as TDX_REPORTDATA_LEN and TDX_REPORT_LEN.
   802		 */
   803		if (req.rpd_len != TDX_REPORTDATA_LEN || req.tdr_len != TDX_REPORT_LEN)
   804			return -EINVAL;
   805	
   806		/* Allocate kernel buffers for REPORTDATA and TDREPORT */
   807		reportdata = kzalloc(req.rpd_len, GFP_KERNEL);
   808		if (!reportdata) {
   809			ret = -ENOMEM;
   810			goto out;
   811		}
   812	
   813		tdreport = kzalloc(req.tdr_len, GFP_KERNEL);
   814		if (!tdreport) {
   815			ret = -ENOMEM;
   816			goto out;
   817		}
   818	
   819	
   820		/* Copy REPORTDATA from user to kernel buffer */
 > 821		if (copy_from_user(reportdata, (void *)req.reportdata, req.rpd_len)) {
   822			ret = -EFAULT;
   823			goto out;
   824		}
   825	
   826		/*
   827		 * Generate TDREPORT using "TDG.MR.REPORT" TDCALL.
   828		 *
   829		 * Get the TDREPORT using REPORTDATA as input. Refer to
   830		 * section 22.3.3 TDG.MR.REPORT leaf in the TDX Module 1.0
   831		 * Specification for detailed information.
   832		 */
   833		ret = __tdx_module_call(TDX_GET_REPORT, virt_to_phys(tdreport),
   834					virt_to_phys(reportdata), req.subtype,
   835					0, NULL);
   836		if (ret) {
   837			ret = -EIO;
   838			goto out;
   839		}
   840	
   841		/* Copy TDREPORT data back to the user buffer */
 > 842		if (copy_to_user((void *)req.tdreport, tdreport, req.tdr_len))
   843			ret = -EFAULT;
   844	
   845	out:
   846		kfree(reportdata);
   847		kfree(tdreport);
   848		return ret;
   849	}
   850	static long tdx_guest_ioctl(struct file *file, unsigned int cmd,
   851				    unsigned long arg)
   852	{
   853		void __user *argp = (void __user *)arg;
   854		long ret = -EINVAL;
   855	
   856		switch (cmd) {
   857		case TDX_CMD_GET_REPORT:
   858			ret = tdx_get_report(argp);
   859			break;
   860		default:
   861			pr_debug("cmd %d not supported\n", cmd);
   862			break;
   863		}
   864	
   865		return ret;
   866	}
   867	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
