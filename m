Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B49655B477
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 01:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiFZXfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 19:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiFZXfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 19:35:02 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1C92BF5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 16:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656286501; x=1687822501;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5MgXAYhyDmJiWj3nK4Tsfoihr4NEtEEPspUQSvNUDE0=;
  b=le0qzDx6wjpfTmUtGKkrV6dVxBjxP3xCR76v/A7MXd5o9l/3oH8CXaQd
   HX5GmmchWFe3D7gNAwuefNf1xVJi5mWRAgXq/neRi2oGzwGoNgRMdiUpn
   qs56svOKei7tmH0+8/LhnAWj/v087X0qgINupr9V9gdvi3ktf6wYexgOU
   eMWRrizDgqD/QRQozyY5Z6s+TewY28lfRqesFfrBG8oC7LwqbskP59qW+
   jciNfA+8kvWF96MnBN6fmdUfwERhv3u5qrR7k/cA/OqYVIQemv564nfuY
   ErK4PKH3OT4kqFOfS7ewZzn/D1lZmJeIAe1o4cC2cPOz0aaV6BPmm5YsY
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="261128425"
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="261128425"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2022 16:35:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,225,1650956400"; 
   d="scan'208";a="692350983"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jun 2022 16:34:59 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5bmM-0007wZ-VH;
        Sun, 26 Jun 2022 23:34:58 +0000
Date:   Mon, 27 Jun 2022 07:34:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Anders Pedersen <anders.pedersen@arm.com>
Subject: [jsarha:topic/cros-sof-v4.19 438/6555]
 drivers/gpu/arm/midgard/mali_kbase_jd.c:275:22: warning: variable
 'exclusive' set but not used
Message-ID: <202206270739.pdQiVOdj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.19
head:   d7a3e91d8d16d1ef8653deec5a1fffc4de034a0c
commit: b303c6455c178a647340cd5e75fddbdf57cc697a [438/6555] CHROMIUM: MALI: Bifrost r13p0 EAC release
config: arm64-buildonly-randconfig-r006-20220626
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jsarha/linux/commit/b303c6455c178a647340cd5e75fddbdf57cc697a
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/cros-sof-v4.19
        git checkout b303c6455c178a647340cd5e75fddbdf57cc697a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash M=drivers/gpu/arm/midgard

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   cc1: warning: -Idrivers/gpu/arm/midgard/../../../base: No such file or directory [-Wmissing-include-dirs]
   drivers/gpu/arm/midgard/mali_kbase_jd.c: In function 'kbase_jd_pre_external_resources':
>> drivers/gpu/arm/midgard/mali_kbase_jd.c:275:22: warning: variable 'exclusive' set but not used [-Wunused-but-set-variable]
     275 |                 bool exclusive;
         |                      ^~~~~~~~~
   drivers/gpu/arm/midgard/mali_kbase_jd.c: In function 'jd_cancel_worker':
   drivers/gpu/arm/midgard/mali_kbase_jd.c:1400:14: warning: variable 'need_to_try_schedule_context' set but not used [-Wunused-but-set-variable]
    1400 |         bool need_to_try_schedule_context;
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/arm/midgard/mali_kbase_defs.h:37,
                    from drivers/gpu/arm/midgard/mali_kbase.h:57,
                    from drivers/gpu/arm/midgard/mali_kbase_jd.c:31:
   At top level:
   drivers/gpu/arm/midgard/mali_base_hwconfig_issues.h:1216:33: warning: 'base_hw_issues_model_tEGx' defined but not used [-Wunused-const-variable=]
    1216 | static const enum base_hw_issue base_hw_issues_model_tEGx[] = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/arm/midgard/mali_base_hwconfig_issues.h:1209:33: warning: 'base_hw_issues_tEGx_r0p0' defined but not used [-Wunused-const-variable=]
    1209 | static const enum base_hw_issue base_hw_issues_tEGx_r0p0[] = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/arm/midgard/mali_base_hwconfig_issues.h:1201:33: warning: 'base_hw_issues_model_tBOx' defined but not used [-Wunused-const-variable=]
    1201 | static const enum base_hw_issue base_hw_issues_model_tBOx[] = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/arm/midgard/mali_base_hwconfig_issues.h:1194:33: warning: 'base_hw_issues_tBOx_r0p0' defined but not used [-Wunused-const-variable=]
    1194 | static const enum base_hw_issue base_hw_issues_tBOx_r0p0[] = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/arm/midgard/mali_base_hwconfig_issues.h:1186:33: warning: 'base_hw_issues_model_tTRx' defined but not used [-Wunused-const-variable=]
    1186 | static const enum base_hw_issue base_hw_issues_model_tTRx[] = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/arm/midgard/mali_base_hwconfig_issues.h:1179:33: warning: 'base_hw_issues_tTRx_r0p0' defined but not used [-Wunused-const-variable=]
    1179 | static const enum base_hw_issue base_hw_issues_tTRx_r0p0[] = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/arm/midgard/mali_base_hwconfig_issues.h:1171:33: warning: 'base_hw_issues_model_tKAx' defined but not used [-Wunused-const-variable=]
    1171 | static const enum base_hw_issue base_hw_issues_model_tKAx[] = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/arm/midgard/mali_base_hwconfig_issues.h:1164:33: warning: 'base_hw_issues_tKAx_r0p0' defined but not used [-Wunused-const-variable=]
    1164 | static const enum base_hw_issue base_hw_issues_tKAx_r0p0[] = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/arm/midgard/mali_base_hwconfig_issues.h:1156:33: warning: 'base_hw_issues_model_tGOx' defined but not used [-Wunused-const-variable=]
    1156 | static const enum base_hw_issue base_hw_issues_model_tGOx[] = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/arm/midgard/mali_base_hwconfig_issues.h:1148:33: warning: 'base_hw_issues_tGOx_r1p0' defined but not used [-Wunused-const-variable=]
    1148 | static const enum base_hw_issue base_hw_issues_tGOx_r1p0[] = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/arm/midgard/mali_base_hwconfig_issues.h:1140:33: warning: 'base_hw_issues_tGOx_r0p0' defined but not used [-Wunused-const-variable=]
    1140 | static const enum base_hw_issue base_hw_issues_tGOx_r0p0[] = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/arm/midgard/mali_base_hwconfig_issues.h:1132:33: warning: 'base_hw_issues_model_tNOx' defined but not used [-Wunused-const-variable=]
    1132 | static const enum base_hw_issue base_hw_issues_model_tNOx[] = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/arm/midgard/mali_base_hwconfig_issues.h:1124:33: warning: 'base_hw_issues_tNOx_r0p0' defined but not used [-Wunused-const-variable=]
    1124 | static const enum base_hw_issue base_hw_issues_tNOx_r0p0[] = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/arm/midgard/mali_base_hwconfig_issues.h:1116:33: warning: 'base_hw_issues_model_tDVx' defined but not used [-Wunused-const-variable=]
    1116 | static const enum base_hw_issue base_hw_issues_model_tDVx[] = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/arm/midgard/mali_base_hwconfig_issues.h:1109:33: warning: 'base_hw_issues_tDVx_r0p0' defined but not used [-Wunused-const-variable=]
    1109 | static const enum base_hw_issue base_hw_issues_tDVx_r0p0[] = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/arm/midgard/mali_base_hwconfig_issues.h:1101:33: warning: 'base_hw_issues_model_tSIx' defined but not used [-Wunused-const-variable=]
    1101 | static const enum base_hw_issue base_hw_issues_model_tSIx[] = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/arm/midgard/mali_base_hwconfig_issues.h:1094:33: warning: 'base_hw_issues_tSIx_r1p1' defined but not used [-Wunused-const-variable=]
    1094 | static const enum base_hw_issue base_hw_issues_tSIx_r1p1[] = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/arm/midgard/mali_base_hwconfig_issues.h:1086:33: warning: 'base_hw_issues_tSIx_r1p0' defined but not used [-Wunused-const-variable=]
    1086 | static const enum base_hw_issue base_hw_issues_tSIx_r1p0[] = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/arm/midgard/mali_base_hwconfig_issues.h:1078:33: warning: 'base_hw_issues_tSIx_r0p1' defined but not used [-Wunused-const-variable=]
    1078 | static const enum base_hw_issue base_hw_issues_tSIx_r0p1[] = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/arm/midgard/mali_base_hwconfig_issues.h:1070:33: warning: 'base_hw_issues_tSIx_r0p0' defined but not used [-Wunused-const-variable=]
    1070 | static const enum base_hw_issue base_hw_issues_tSIx_r0p0[] = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/arm/midgard/mali_base_hwconfig_issues.h:1061:33: warning: 'base_hw_issues_model_tHEx' defined but not used [-Wunused-const-variable=]
    1061 | static const enum base_hw_issue base_hw_issues_model_tHEx[] = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/arm/midgard/mali_base_hwconfig_issues.h:1052:33: warning: 'base_hw_issues_tHEx_r0p3' defined but not used [-Wunused-const-variable=]
    1052 | static const enum base_hw_issue base_hw_issues_tHEx_r0p3[] = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/arm/midgard/mali_base_hwconfig_issues.h:1042:33: warning: 'base_hw_issues_tHEx_r0p2' defined but not used [-Wunused-const-variable=]
    1042 | static const enum base_hw_issue base_hw_issues_tHEx_r0p2[] = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/arm/midgard/mali_base_hwconfig_issues.h:1032:33: warning: 'base_hw_issues_tHEx_r0p1' defined but not used [-Wunused-const-variable=]
    1032 | static const enum base_hw_issue base_hw_issues_tHEx_r0p1[] = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/arm/midgard/mali_base_hwconfig_issues.h:1022:33: warning: 'base_hw_issues_tHEx_r0p0' defined but not used [-Wunused-const-variable=]
    1022 | static const enum base_hw_issue base_hw_issues_tHEx_r0p0[] = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/arm/midgard/mali_base_hwconfig_issues.h:1008:33: warning: 'base_hw_issues_model_tMIx' defined but not used [-Wunused-const-variable=]
    1008 | static const enum base_hw_issue base_hw_issues_model_tMIx[] = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/arm/midgard/mali_base_hwconfig_issues.h:991:33: warning: 'base_hw_issues_tMIx_r0p1' defined but not used [-Wunused-const-variable=]
     991 | static const enum base_hw_issue base_hw_issues_tMIx_r0p1[] = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/arm/midgard/mali_base_hwconfig_issues.h:974:33: warning: 'base_hw_issues_tMIx_r0p0' defined but not used [-Wunused-const-variable=]
     974 | static const enum base_hw_issue base_hw_issues_tMIx_r0p0[] = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/arm/midgard/mali_base_hwconfig_issues.h:957:33: warning: 'base_hw_issues_tMIx_r0p0_05dev0' defined but not used [-Wunused-const-variable=]
     957 | static const enum base_hw_issue base_hw_issues_tMIx_r0p0_05dev0[] = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/arm/midgard/mali_base_hwconfig_issues.h:943:33: warning: 'base_hw_issues_model_t82x' defined but not used [-Wunused-const-variable=]
     943 | static const enum base_hw_issue base_hw_issues_model_t82x[] = {
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/exclusive +275 drivers/gpu/arm/midgard/mali_kbase_jd.c

   265	
   266		/* Take the processes mmap lock */
   267		down_read(&current->mm->mmap_sem);
   268	
   269		/* need to keep the GPU VM locked while we set up UMM buffers */
   270		kbase_gpu_vm_lock(katom->kctx);
   271		for (res_no = 0; res_no < katom->nr_extres; res_no++) {
   272			struct base_external_resource *res;
   273			struct kbase_va_region *reg;
   274			struct kbase_mem_phy_alloc *alloc;
 > 275			bool exclusive;
   276	
   277			res = &input_extres[res_no];
   278			exclusive = (res->ext_resource & BASE_EXT_RES_ACCESS_EXCLUSIVE)
   279					? true : false;
   280			reg = kbase_region_tracker_find_region_enclosing_address(
   281					katom->kctx,
   282					res->ext_resource & ~BASE_EXT_RES_ACCESS_EXCLUSIVE);
   283			/* did we find a matching region object? */
   284			if (NULL == reg || (reg->flags & KBASE_REG_FREE)) {
   285				/* roll back */
   286				goto failed_loop;
   287			}
   288	
   289			if (!(katom->core_req & BASE_JD_REQ_SOFT_JOB) &&
   290					(reg->flags & KBASE_REG_SECURE)) {
   291				katom->atom_flags |= KBASE_KATOM_FLAG_PROTECTED;
   292			}
   293	
   294			alloc = kbase_map_external_resource(katom->kctx, reg,
   295					current->mm);
   296			if (!alloc) {
   297				err_ret_val = -EINVAL;
   298				goto failed_loop;
   299			}
   300	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
