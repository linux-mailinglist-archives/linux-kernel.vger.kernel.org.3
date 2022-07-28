Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F29584534
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 19:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiG1Rio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 13:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiG1Rij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 13:38:39 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA92874793
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 10:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659029917; x=1690565917;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hMrE/qfXra7bqkzhjLAqY2OYuYJGp31GR3EvUrE3HRg=;
  b=HGFIFFLZMcFSZYtEike4SywZf9p4YzL+pLfc0giganqLGG8tVWKN4X7X
   z6WR0raHUQFJAT26d2X/RuzxrvmQ4138z1wwFeeJJa0nv+Vr85fQxs2rN
   dzjPjdhqJOyYpp+ZfBa1ElbGybwKCG1gJYzOSEg54R0XRgm+9LjY1XkIh
   aLR+8MdZSBw3QoDEOzxbOIqxvG14Dftk7rMqE6ygLodHWYGbP0geTvDiX
   Ha2RI3HALKrsxJfkQ0OuSnF1Op991PKwvo9jp1ls23EZIbQz5sALu8TMh
   0zVzgGYcS8pNYWpmpLaGCy7gaJpFhEKNgax6r8WyF9hZCyF4V/mCry8eQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="314368776"
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="314368776"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 10:38:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="576570648"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Jul 2022 10:38:35 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oH7T0-000ARW-1S;
        Thu, 28 Jul 2022 17:38:34 +0000
Date:   Fri, 29 Jul 2022 01:37:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Faycal Benmlih <faycal.benmlih@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/platform/x86/socwatch/sw_driver.c:1309:52: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202207290104.w9OSIAHP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Faycal,

First bad commit (maybe != root cause):

tree:   https://github.com/mchinth/linux sep_socwatch_linux_5_10
head:   c55df4a2b60fc7c6c4d00fd9f9fb447087833513
commit: e65547c5a9bb37e907edecece4da7cb12dadea96 platform/x86: Use $(srctree) instead of $(src) to adapt to kbuild regression
date:   1 year, 10 months ago
config: x86_64-randconfig-s022 (https://download.01.org/0day-ci/archive/20220729/202207290104.w9OSIAHP-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/mchinth/linux/commit/e65547c5a9bb37e907edecece4da7cb12dadea96
        git remote add mchinth https://github.com/mchinth/linux
        git fetch --no-tags mchinth sep_socwatch_linux_5_10
        git checkout e65547c5a9bb37e907edecece4da7cb12dadea96
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> drivers/platform/x86/socwatch/sw_driver.c:1309:52: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got char *[assigned] out_arg @@
   drivers/platform/x86/socwatch/sw_driver.c:1309:52: sparse:     expected void [noderef] __user *to
   drivers/platform/x86/socwatch/sw_driver.c:1309:52: sparse:     got char *[assigned] out_arg
>> drivers/platform/x86/socwatch/sw_driver.c:1053:58: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __user *buffer @@     got char *remote_buffer @@
   drivers/platform/x86/socwatch/sw_driver.c:1053:58: sparse:     expected void [noderef] __user *buffer
   drivers/platform/x86/socwatch/sw_driver.c:1053:58: sparse:     got char *remote_buffer
>> drivers/platform/x86/socwatch/sw_driver.c:1070:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got char *remote_cfg @@
   drivers/platform/x86/socwatch/sw_driver.c:1070:39: sparse:     expected void const [noderef] __user *from
   drivers/platform/x86/socwatch/sw_driver.c:1070:39: sparse:     got char *remote_cfg
--
>> drivers/platform/x86/socwatch/sw_hardware_io.c:149:55: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int flags @@     got restricted gfp_t @@
   drivers/platform/x86/socwatch/sw_hardware_io.c:149:55: sparse:     expected unsigned int flags
   drivers/platform/x86/socwatch/sw_hardware_io.c:149:55: sparse:     got restricted gfp_t
--
>> drivers/platform/x86/socwatch/sw_output_buffer.c:344:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got void *dest @@
   drivers/platform/x86/socwatch/sw_output_buffer.c:344:22: sparse:     expected void [noderef] __user *to
   drivers/platform/x86/socwatch/sw_output_buffer.c:344:22: sparse:     got void *dest
>> drivers/platform/x86/socwatch/sw_output_buffer.c:352:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got void * @@
   drivers/platform/x86/socwatch/sw_output_buffer.c:352:43: sparse:     expected void [noderef] __user *to
   drivers/platform/x86/socwatch/sw_output_buffer.c:352:43: sparse:     got void *
>> drivers/platform/x86/socwatch/sw_output_buffer.c:378:46: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int flags @@     got restricted gfp_t @@
   drivers/platform/x86/socwatch/sw_output_buffer.c:378:46: sparse:     expected unsigned int flags
   drivers/platform/x86/socwatch/sw_output_buffer.c:378:46: sparse:     got restricted gfp_t
   drivers/platform/x86/socwatch/sw_output_buffer.c:562:46: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int flags @@     got restricted gfp_t @@
   drivers/platform/x86/socwatch/sw_output_buffer.c:562:46: sparse:     expected unsigned int flags
   drivers/platform/x86/socwatch/sw_output_buffer.c:562:46: sparse:     got restricted gfp_t
   drivers/platform/x86/socwatch/sw_output_buffer.c:575:67: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int flags @@     got restricted gfp_t @@
   drivers/platform/x86/socwatch/sw_output_buffer.c:575:67: sparse:     expected unsigned int flags
   drivers/platform/x86/socwatch/sw_output_buffer.c:575:67: sparse:     got restricted gfp_t
>> drivers/platform/x86/socwatch/sw_output_buffer.c:774:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *dest @@     got void [noderef] __user *buffer @@
   drivers/platform/x86/socwatch/sw_output_buffer.c:774:48: sparse:     expected void *dest
   drivers/platform/x86/socwatch/sw_output_buffer.c:774:48: sparse:     got void [noderef] __user *buffer
--
>> drivers/platform/x86/socwatch/sw_mem.c:141:18: sparse: sparse: cast to restricted gfp_t
   drivers/platform/x86/socwatch/sw_mem.c:305:38: sparse: sparse: cast to restricted gfp_t
--
>> drivers/platform/x86/socwatch/sw_tracepoint_handlers.c:237:44: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int flags @@     got restricted gfp_t @@
   drivers/platform/x86/socwatch/sw_tracepoint_handlers.c:237:44: sparse:     expected unsigned int flags
   drivers/platform/x86/socwatch/sw_tracepoint_handlers.c:237:44: sparse:     got restricted gfp_t
--
>> drivers/platform/x86/socwatch/sw_internal.c:176:50: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int flags @@     got restricted gfp_t @@
   drivers/platform/x86/socwatch/sw_internal.c:176:50: sparse:     expected unsigned int flags
   drivers/platform/x86/socwatch/sw_internal.c:176:50: sparse:     got restricted gfp_t
--
>> drivers/platform/x86/socwatch/sw_collector.c:99:68: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int flags @@     got restricted gfp_t @@
   drivers/platform/x86/socwatch/sw_collector.c:99:68: sparse:     expected unsigned int flags
   drivers/platform/x86/socwatch/sw_collector.c:99:68: sparse:     got restricted gfp_t
>> drivers/platform/x86/socwatch/sw_collector.c:85:33: sparse: sparse: symbol 'sw_copy_driver_interface_info_i' was not declared. Should it be static?
>> drivers/platform/x86/socwatch/sw_collector.c:116:5: sparse: sparse: symbol 'sw_init_driver_interface_info_i' was not declared. Should it be static?
>> drivers/platform/x86/socwatch/sw_collector.c:138:5: sparse: sparse: symbol 'sw_init_ops_i' was not declared. Should it be static?
   drivers/platform/x86/socwatch/sw_collector.c:186:57: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int flags @@     got restricted gfp_t @@
   drivers/platform/x86/socwatch/sw_collector.c:186:57: sparse:     expected unsigned int flags
   drivers/platform/x86/socwatch/sw_collector.c:186:57: sparse:     got restricted gfp_t
   drivers/platform/x86/socwatch/sw_collector.c:214:57: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int flags @@     got restricted gfp_t @@
   drivers/platform/x86/socwatch/sw_collector.c:214:57: sparse:     expected unsigned int flags
   drivers/platform/x86/socwatch/sw_collector.c:214:57: sparse:     got restricted gfp_t
>> drivers/platform/x86/socwatch/sw_collector.c:211:24: sparse: sparse: symbol 'sw_alloc_ops_i' was not declared. Should it be static?
>> drivers/platform/x86/socwatch/sw_collector.c:323:6: sparse: sparse: symbol 'sw_free_driver_interface_info_i' was not declared. Should it be static?
>> drivers/platform/x86/socwatch/sw_collector.c:329:6: sparse: sparse: symbol 'sw_free_ops_i' was not declared. Should it be static?
>> drivers/platform/x86/socwatch/sw_collector.c:335:5: sparse: sparse: symbol 'sw_reset_driver_interface_info_i' was not declared. Should it be static?
>> drivers/platform/x86/socwatch/sw_collector.c:453:6: sparse: sparse: symbol 'sw_free_collector_msg_i' was not declared. Should it be static?
>> drivers/platform/x86/socwatch/sw_collector.c:459:6: sparse: sparse: symbol 'sw_handle_per_cpu_msg_i' was not declared. Should it be static?
   drivers/platform/x86/socwatch/sw_collector.c:516:51: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int flags @@     got restricted gfp_t @@
   drivers/platform/x86/socwatch/sw_collector.c:516:51: sparse:     expected unsigned int flags
   drivers/platform/x86/socwatch/sw_collector.c:516:51: sparse:     got restricted gfp_t

vim +1309 drivers/platform/x86/socwatch/sw_driver.c

d605aabab41663c Jon Moeller    2018-11-13  1115  
d605aabab41663c Jon Moeller    2018-11-13  1116  static long sw_unlocked_handle_ioctl_i(unsigned int ioctl_num,
d605aabab41663c Jon Moeller    2018-11-13  1117  					   void *p_local_args)
d605aabab41663c Jon Moeller    2018-11-13  1118  {
d605aabab41663c Jon Moeller    2018-11-13  1119  	struct sw_driver_ioctl_arg local_args;
d605aabab41663c Jon Moeller    2018-11-13  1120  	int local_in_len, local_out_len;
d605aabab41663c Jon Moeller    2018-11-13  1121  
d605aabab41663c Jon Moeller    2018-11-13  1122  	if (!p_local_args) {
d605aabab41663c Jon Moeller    2018-11-13  1123  		pw_pr_error("ERROR: NULL p_local_args value?!\n");
d605aabab41663c Jon Moeller    2018-11-13  1124  		return -PW_ERROR;
d605aabab41663c Jon Moeller    2018-11-13  1125  	}
d605aabab41663c Jon Moeller    2018-11-13  1126  
d605aabab41663c Jon Moeller    2018-11-13  1127  	/*
d605aabab41663c Jon Moeller    2018-11-13  1128  	 * (1) Sanity check:
d605aabab41663c Jon Moeller    2018-11-13  1129  	 * Before doing anything, double check to
d605aabab41663c Jon Moeller    2018-11-13  1130  	 * make sure this IOCTL was really intended
d605aabab41663c Jon Moeller    2018-11-13  1131  	 * for us!
d605aabab41663c Jon Moeller    2018-11-13  1132  	 */
d605aabab41663c Jon Moeller    2018-11-13  1133  	if (_IOC_TYPE(ioctl_num) != APWR_IOCTL_MAGIC_NUM) {
d605aabab41663c Jon Moeller    2018-11-13  1134  		pw_pr_error(
688e338c753b33c Faycal Benmlih 2019-04-23  1135  			"ERROR: requested IOCTL TYPE (%d) != \
688e338c753b33c Faycal Benmlih 2019-04-23  1136  				APWR_IOCTL_MAGIC_NUM (%d)\n",
d605aabab41663c Jon Moeller    2018-11-13  1137  			_IOC_TYPE(ioctl_num), APWR_IOCTL_MAGIC_NUM);
d605aabab41663c Jon Moeller    2018-11-13  1138  		return -PW_ERROR;
d605aabab41663c Jon Moeller    2018-11-13  1139  	}
d605aabab41663c Jon Moeller    2018-11-13  1140  	/*
d605aabab41663c Jon Moeller    2018-11-13  1141  	 * (2) Extract arg lengths.
d605aabab41663c Jon Moeller    2018-11-13  1142  	 */
d605aabab41663c Jon Moeller    2018-11-13  1143  	local_args = *((struct sw_driver_ioctl_arg *)p_local_args);
d605aabab41663c Jon Moeller    2018-11-13  1144  
d605aabab41663c Jon Moeller    2018-11-13  1145  	local_in_len = local_args.in_len;
d605aabab41663c Jon Moeller    2018-11-13  1146  	local_out_len = local_args.out_len;
d605aabab41663c Jon Moeller    2018-11-13  1147  	pw_pr_debug("GU: local_in_len = %d, local_out_len = %d\n", local_in_len,
d605aabab41663c Jon Moeller    2018-11-13  1148  		local_out_len);
d605aabab41663c Jon Moeller    2018-11-13  1149  	/*
d605aabab41663c Jon Moeller    2018-11-13  1150  	 * (3) Service individual IOCTL requests.
d605aabab41663c Jon Moeller    2018-11-13  1151  	 */
d605aabab41663c Jon Moeller    2018-11-13  1152  	if (MATCH_IOCTL(ioctl_num, PW_IOCTL_CONFIG)) {
d605aabab41663c Jon Moeller    2018-11-13  1153  		pw_pr_debug("PW_IOCTL_CONFIG\n");
d605aabab41663c Jon Moeller    2018-11-13  1154  		return sw_set_driver_infos_i(
d605aabab41663c Jon Moeller    2018-11-13  1155  			(struct sw_driver_interface_msg __user *)
d605aabab41663c Jon Moeller    2018-11-13  1156  				local_args.in_arg,
d605aabab41663c Jon Moeller    2018-11-13  1157  			local_in_len);
688e338c753b33c Faycal Benmlih 2019-04-23  1158  	} else if (MATCH_IOCTL(ioctl_num, PW_IOCTL_CONFIG_CONTINUOUS)) {
688e338c753b33c Faycal Benmlih 2019-04-23  1159  		pw_pr_debug("DEBUG: PW_IOCTL_CONFIG_CONTINUOUS\n");
688e338c753b33c Faycal Benmlih 2019-04-23  1160  		return sw_set_continuous_i(
688e338c753b33c Faycal Benmlih 2019-04-23  1161  			(struct sw_driver_continuous_collect __user *)
688e338c753b33c Faycal Benmlih 2019-04-23  1162  				local_args.in_arg,
688e338c753b33c Faycal Benmlih 2019-04-23  1163  			local_in_len);
d605aabab41663c Jon Moeller    2018-11-13  1164  	} else if (MATCH_IOCTL(ioctl_num, PW_IOCTL_CMD)) {
d605aabab41663c Jon Moeller    2018-11-13  1165  		sw_driver_collection_cmd_t local_cmd;
d605aabab41663c Jon Moeller    2018-11-13  1166  
d605aabab41663c Jon Moeller    2018-11-13  1167  		pw_pr_debug("PW_IOCTL_CMD\n");
688e338c753b33c Faycal Benmlih 2019-04-23  1168  	if (get_user(local_cmd,
688e338c753b33c Faycal Benmlih 2019-04-23  1169  		(sw_driver_collection_cmd_t __user *)local_args.in_arg)) {
d605aabab41663c Jon Moeller    2018-11-13  1170  		pw_pr_error("ERROR: could NOT extract cmd value!\n");
d605aabab41663c Jon Moeller    2018-11-13  1171  		return -PW_ERROR;
d605aabab41663c Jon Moeller    2018-11-13  1172  	}
688e338c753b33c Faycal Benmlih 2019-04-23  1173  	return sw_handle_cmd_i(local_cmd, (u64 __user *)local_args.out_arg);
d605aabab41663c Jon Moeller    2018-11-13  1174  	} else if (MATCH_IOCTL(ioctl_num, PW_IOCTL_POLL)) {
d605aabab41663c Jon Moeller    2018-11-13  1175  		pw_pr_debug("PW_IOCTL_POLL\n");
d605aabab41663c Jon Moeller    2018-11-13  1176  		return DO_PER_CPU_OVERHEAD_FUNC_RET(int, sw_collection_poll_i);
d605aabab41663c Jon Moeller    2018-11-13  1177  	} else if (MATCH_IOCTL(ioctl_num, PW_IOCTL_IMMEDIATE_IO)) {
d605aabab41663c Jon Moeller    2018-11-13  1178  		struct sw_driver_interface_info *local_info;
d605aabab41663c Jon Moeller    2018-11-13  1179  		struct sw_driver_io_descriptor *local_descriptor = NULL;
d605aabab41663c Jon Moeller    2018-11-13  1180  		int retVal = PW_SUCCESS;
d605aabab41663c Jon Moeller    2018-11-13  1181  		char *src_vals = NULL;
d605aabab41663c Jon Moeller    2018-11-13  1182  		char *dst_vals = NULL;
d605aabab41663c Jon Moeller    2018-11-13  1183  
d605aabab41663c Jon Moeller    2018-11-13  1184  		pw_pr_debug("PW_IOCTL_IMMEDIATE_IO\n");
d605aabab41663c Jon Moeller    2018-11-13  1185  		pw_pr_debug("local_in_len = %u\n", local_in_len);
d605aabab41663c Jon Moeller    2018-11-13  1186  
d605aabab41663c Jon Moeller    2018-11-13  1187  		src_vals = vmalloc(local_in_len);
d605aabab41663c Jon Moeller    2018-11-13  1188  		if (!src_vals) {
d605aabab41663c Jon Moeller    2018-11-13  1189  			pw_pr_error(
d605aabab41663c Jon Moeller    2018-11-13  1190  				"ERROR allocating space for immediate IO\n");
d605aabab41663c Jon Moeller    2018-11-13  1191  			return -PW_ERROR;
d605aabab41663c Jon Moeller    2018-11-13  1192  		}
d605aabab41663c Jon Moeller    2018-11-13  1193  		if (local_out_len) {
d605aabab41663c Jon Moeller    2018-11-13  1194  			dst_vals = vmalloc(local_out_len);
d605aabab41663c Jon Moeller    2018-11-13  1195  			if (!dst_vals) {
d605aabab41663c Jon Moeller    2018-11-13  1196  				vfree(src_vals);
d605aabab41663c Jon Moeller    2018-11-13  1197  				pw_pr_error(
d605aabab41663c Jon Moeller    2018-11-13  1198  					"ERROR allocating space for immediate IO\n");
d605aabab41663c Jon Moeller    2018-11-13  1199  				return -PW_ERROR;
d605aabab41663c Jon Moeller    2018-11-13  1200  			}
d605aabab41663c Jon Moeller    2018-11-13  1201  		}
d605aabab41663c Jon Moeller    2018-11-13  1202  		if (copy_from_user(src_vals, (char __user *)local_args.in_arg,
d605aabab41663c Jon Moeller    2018-11-13  1203  				   local_in_len)) {
d605aabab41663c Jon Moeller    2018-11-13  1204  			pw_pr_error(
d605aabab41663c Jon Moeller    2018-11-13  1205  				"ERROR copying in immediate IO descriptor\n");
d605aabab41663c Jon Moeller    2018-11-13  1206  			retVal = -PW_ERROR;
d605aabab41663c Jon Moeller    2018-11-13  1207  			goto ret_immediate_io;
d605aabab41663c Jon Moeller    2018-11-13  1208  		}
d605aabab41663c Jon Moeller    2018-11-13  1209  		local_info = (struct sw_driver_interface_info *)src_vals;
d605aabab41663c Jon Moeller    2018-11-13  1210  		pw_pr_debug(
d605aabab41663c Jon Moeller    2018-11-13  1211  			"OK, asked to perform immediate IO on cpu(s) %d, # descriptors = %d\n",
d605aabab41663c Jon Moeller    2018-11-13  1212  			local_info->cpu_mask, local_info->num_io_descriptors);
d605aabab41663c Jon Moeller    2018-11-13  1213  		/*
d605aabab41663c Jon Moeller    2018-11-13  1214  		 * For now, require only a single descriptor.
d605aabab41663c Jon Moeller    2018-11-13  1215  		 */
d605aabab41663c Jon Moeller    2018-11-13  1216  		if (local_info->num_io_descriptors != 1) {
d605aabab41663c Jon Moeller    2018-11-13  1217  			pw_pr_error(
d605aabab41663c Jon Moeller    2018-11-13  1218  				"ERROR: told to perform immediate IO with %d descriptors -- MAX of 1 descriptor allowed!\n",
d605aabab41663c Jon Moeller    2018-11-13  1219  				local_info->num_io_descriptors);
d605aabab41663c Jon Moeller    2018-11-13  1220  			retVal = -PW_ERROR;
d605aabab41663c Jon Moeller    2018-11-13  1221  			goto ret_immediate_io;
d605aabab41663c Jon Moeller    2018-11-13  1222  		}
d605aabab41663c Jon Moeller    2018-11-13  1223  		local_descriptor = ((struct sw_driver_io_descriptor *)
d605aabab41663c Jon Moeller    2018-11-13  1224  						local_info->descriptors);
d605aabab41663c Jon Moeller    2018-11-13  1225  		pw_pr_debug("Collection type after %d\n",
d605aabab41663c Jon Moeller    2018-11-13  1226  				local_descriptor->collection_type);
d605aabab41663c Jon Moeller    2018-11-13  1227  		/*
d605aabab41663c Jon Moeller    2018-11-13  1228  		 * Check cpu mask for correctness here. For now, we do NOT allow
d605aabab41663c Jon Moeller    2018-11-13  1229  		 * reading on ALL cpus.
d605aabab41663c Jon Moeller    2018-11-13  1230  		 */
d605aabab41663c Jon Moeller    2018-11-13  1231  		if ((int)local_info->cpu_mask < -1 ||
d605aabab41663c Jon Moeller    2018-11-13  1232  			(int)local_info->cpu_mask >= (int)sw_max_num_cpus) {
d605aabab41663c Jon Moeller    2018-11-13  1233  			pw_pr_error(
d605aabab41663c Jon Moeller    2018-11-13  1234  				"ERROR: invalid cpu mask %d specified in immediate IO; valid values are: -1, [0 -- %d]!\n",
d605aabab41663c Jon Moeller    2018-11-13  1235  				local_info->cpu_mask, sw_max_num_cpus - 1);
d605aabab41663c Jon Moeller    2018-11-13  1236  			retVal = -PW_ERROR;
d605aabab41663c Jon Moeller    2018-11-13  1237  			goto ret_immediate_io;
d605aabab41663c Jon Moeller    2018-11-13  1238  		}
d605aabab41663c Jon Moeller    2018-11-13  1239  		/*
d605aabab41663c Jon Moeller    2018-11-13  1240  		 * Check collection type for correctness here
d605aabab41663c Jon Moeller    2018-11-13  1241  		 */
d605aabab41663c Jon Moeller    2018-11-13  1242  		pw_pr_debug(
d605aabab41663c Jon Moeller    2018-11-13  1243  			"Asked to perform immediate IO with descriptor with type = %d, on cpu = %d\n",
d605aabab41663c Jon Moeller    2018-11-13  1244  			local_descriptor->collection_type,
d605aabab41663c Jon Moeller    2018-11-13  1245  			local_info->cpu_mask);
d605aabab41663c Jon Moeller    2018-11-13  1246  		if (sw_is_valid_hw_op_id(local_descriptor->collection_type) ==
d605aabab41663c Jon Moeller    2018-11-13  1247  			false) {
d605aabab41663c Jon Moeller    2018-11-13  1248  			pw_pr_error(
d605aabab41663c Jon Moeller    2018-11-13  1249  				"ERROR: invalid collection type %d specified for immediate IO\n",
d605aabab41663c Jon Moeller    2018-11-13  1250  				(int)local_descriptor->collection_type);
d605aabab41663c Jon Moeller    2018-11-13  1251  			retVal = -PW_ERROR;
d605aabab41663c Jon Moeller    2018-11-13  1252  			goto ret_immediate_io;
d605aabab41663c Jon Moeller    2018-11-13  1253  		}
d605aabab41663c Jon Moeller    2018-11-13  1254  		/*
d605aabab41663c Jon Moeller    2018-11-13  1255  		 * Check collection cmd for correctness here
d605aabab41663c Jon Moeller    2018-11-13  1256  		 */
d605aabab41663c Jon Moeller    2018-11-13  1257  		if (local_descriptor->collection_command < SW_IO_CMD_READ ||
d605aabab41663c Jon Moeller    2018-11-13  1258  			local_descriptor->collection_command > SW_IO_CMD_WRITE) {
d605aabab41663c Jon Moeller    2018-11-13  1259  			pw_pr_error(
d605aabab41663c Jon Moeller    2018-11-13  1260  				"ERROR: invalid collection command %d specified for immediate IO\n",
d605aabab41663c Jon Moeller    2018-11-13  1261  				local_descriptor->collection_command);
d605aabab41663c Jon Moeller    2018-11-13  1262  			retVal = -PW_ERROR;
d605aabab41663c Jon Moeller    2018-11-13  1263  			goto ret_immediate_io;
d605aabab41663c Jon Moeller    2018-11-13  1264  		}
d605aabab41663c Jon Moeller    2018-11-13  1265  		/*
d605aabab41663c Jon Moeller    2018-11-13  1266  		 * Initialize the descriptor -- 'MMIO' and 'IPC' reads may need
d605aabab41663c Jon Moeller    2018-11-13  1267  		 * an "ioremap_nocache"
d605aabab41663c Jon Moeller    2018-11-13  1268  		 */
d605aabab41663c Jon Moeller    2018-11-13  1269  		if (sw_init_driver_io_descriptor(local_descriptor)) {
d605aabab41663c Jon Moeller    2018-11-13  1270  			pw_pr_error(
d605aabab41663c Jon Moeller    2018-11-13  1271  				"ERROR initializing immediate IO descriptor\n");
d605aabab41663c Jon Moeller    2018-11-13  1272  			retVal = -PW_ERROR;
d605aabab41663c Jon Moeller    2018-11-13  1273  			goto ret_immediate_io;
d605aabab41663c Jon Moeller    2018-11-13  1274  		}
d605aabab41663c Jon Moeller    2018-11-13  1275  		/*
d605aabab41663c Jon Moeller    2018-11-13  1276  		 * OK, perform the actual IO.
d605aabab41663c Jon Moeller    2018-11-13  1277  		 */
d605aabab41663c Jon Moeller    2018-11-13  1278  		{
d605aabab41663c Jon Moeller    2018-11-13  1279  			struct sw_immediate_request_info request_info = {
d605aabab41663c Jon Moeller    2018-11-13  1280  				local_descriptor, dst_vals, &retVal
d605aabab41663c Jon Moeller    2018-11-13  1281  			};
d605aabab41663c Jon Moeller    2018-11-13  1282  			struct cpumask cpumask;
d605aabab41663c Jon Moeller    2018-11-13  1283  
d605aabab41663c Jon Moeller    2018-11-13  1284  			cpumask_clear(&cpumask);
d605aabab41663c Jon Moeller    2018-11-13  1285  			switch (local_info->cpu_mask) {
981639a5616748f Jon Moeller    2018-12-15  1286  			case -1: /* IO on ANY CPU (assume current CPU) */
d605aabab41663c Jon Moeller    2018-11-13  1287  				cpumask_set_cpu(RAW_CPU(), &cpumask);
d605aabab41663c Jon Moeller    2018-11-13  1288  				pw_pr_debug("ANY CPU\n");
d605aabab41663c Jon Moeller    2018-11-13  1289  				break;
981639a5616748f Jon Moeller    2018-12-15  1290  			default: /* IO on a particular CPU */
d605aabab41663c Jon Moeller    2018-11-13  1291  				cpumask_set_cpu(local_info->cpu_mask, &cpumask);
d605aabab41663c Jon Moeller    2018-11-13  1292  				pw_pr_debug("[%d] setting for %d\n", RAW_CPU(),
d605aabab41663c Jon Moeller    2018-11-13  1293  						local_info->cpu_mask);
d605aabab41663c Jon Moeller    2018-11-13  1294  				break;
d605aabab41663c Jon Moeller    2018-11-13  1295  			}
d605aabab41663c Jon Moeller    2018-11-13  1296  			sw_schedule_work(&cpumask,
d605aabab41663c Jon Moeller    2018-11-13  1297  					 &sw_handle_immediate_request_i,
d605aabab41663c Jon Moeller    2018-11-13  1298  					 &request_info);
d605aabab41663c Jon Moeller    2018-11-13  1299  		}
d605aabab41663c Jon Moeller    2018-11-13  1300  		if (retVal != PW_SUCCESS) {
d605aabab41663c Jon Moeller    2018-11-13  1301  			pw_pr_error(
d605aabab41663c Jon Moeller    2018-11-13  1302  				"ERROR performing immediate IO on one (or more) CPUs!\n");
d605aabab41663c Jon Moeller    2018-11-13  1303  			goto ret_immediate_io_reset;
d605aabab41663c Jon Moeller    2018-11-13  1304  		}
d605aabab41663c Jon Moeller    2018-11-13  1305  		/*
d605aabab41663c Jon Moeller    2018-11-13  1306  		 * OK, all done.
d605aabab41663c Jon Moeller    2018-11-13  1307  		 */
d605aabab41663c Jon Moeller    2018-11-13  1308  		if (local_descriptor->collection_command == SW_IO_CMD_READ) {
d605aabab41663c Jon Moeller    2018-11-13 @1309  			if (copy_to_user(local_args.out_arg, dst_vals,
d605aabab41663c Jon Moeller    2018-11-13  1310  					 local_out_len)) {
d605aabab41663c Jon Moeller    2018-11-13  1311  				pw_pr_error(
d605aabab41663c Jon Moeller    2018-11-13  1312  					"ERROR copying %u bytes of value to userspace!\n",
d605aabab41663c Jon Moeller    2018-11-13  1313  					local_out_len);
d605aabab41663c Jon Moeller    2018-11-13  1314  				retVal = -PW_ERROR;
d605aabab41663c Jon Moeller    2018-11-13  1315  				goto ret_immediate_io_reset;
d605aabab41663c Jon Moeller    2018-11-13  1316  			}
d605aabab41663c Jon Moeller    2018-11-13  1317  			pw_pr_debug(
d605aabab41663c Jon Moeller    2018-11-13  1318  				"OK, copied %u bytes of value to userspace addr %p!\n",
d605aabab41663c Jon Moeller    2018-11-13  1319  				local_out_len, local_args.out_arg);
d605aabab41663c Jon Moeller    2018-11-13  1320  		}
d605aabab41663c Jon Moeller    2018-11-13  1321  ret_immediate_io_reset:
d605aabab41663c Jon Moeller    2018-11-13  1322  		/*
d605aabab41663c Jon Moeller    2018-11-13  1323  		 * Reset the descriptor -- 'MMIO' and 'IPC' reads may have
d605aabab41663c Jon Moeller    2018-11-13  1324  		 * performed an "ioremap_nocache" which now needs to be
d605aabab41663c Jon Moeller    2018-11-13  1325  		 * unmapped.
d605aabab41663c Jon Moeller    2018-11-13  1326  		 */
d605aabab41663c Jon Moeller    2018-11-13  1327  		if (sw_reset_driver_io_descriptor(local_descriptor)) {
d605aabab41663c Jon Moeller    2018-11-13  1328  			pw_pr_error(
d605aabab41663c Jon Moeller    2018-11-13  1329  				"ERROR resetting immediate IO descriptor\n");
d605aabab41663c Jon Moeller    2018-11-13  1330  			retVal = -PW_ERROR;
d605aabab41663c Jon Moeller    2018-11-13  1331  			goto ret_immediate_io;
d605aabab41663c Jon Moeller    2018-11-13  1332  		}
d605aabab41663c Jon Moeller    2018-11-13  1333  ret_immediate_io:
d605aabab41663c Jon Moeller    2018-11-13  1334  		vfree(src_vals);
688e338c753b33c Faycal Benmlih 2019-04-23  1335  		if (dst_vals)
d605aabab41663c Jon Moeller    2018-11-13  1336  			vfree(dst_vals);
688e338c753b33c Faycal Benmlih 2019-04-23  1337  
d605aabab41663c Jon Moeller    2018-11-13  1338  		return retVal;
d605aabab41663c Jon Moeller    2018-11-13  1339  	} else if (MATCH_IOCTL(ioctl_num, PW_IOCTL_GET_SCU_FW_VERSION)) {
d605aabab41663c Jon Moeller    2018-11-13  1340  		u32 local_data = (u32)sw_scu_fw_major_minor;
d605aabab41663c Jon Moeller    2018-11-13  1341  
d605aabab41663c Jon Moeller    2018-11-13  1342  		if (put_user(local_data, (u32 __user *)local_args.out_arg)) {
d605aabab41663c Jon Moeller    2018-11-13  1343  			pw_pr_error(
688e338c753b33c Faycal Benmlih 2019-04-23  1344  				"ERROR copying scu fw version to userspace!\n"
688e338c753b33c Faycal Benmlih 2019-04-23  1345  				);
d605aabab41663c Jon Moeller    2018-11-13  1346  			return -PW_ERROR;
d605aabab41663c Jon Moeller    2018-11-13  1347  		}
d605aabab41663c Jon Moeller    2018-11-13  1348  		return PW_SUCCESS;
d605aabab41663c Jon Moeller    2018-11-13  1349  	} else if (MATCH_IOCTL(ioctl_num, PW_IOCTL_GET_DRIVER_VERSION)) {
d605aabab41663c Jon Moeller    2018-11-13  1350  		pw_u64_t local_version =
d605aabab41663c Jon Moeller    2018-11-13  1351  			(pw_u64_t)SW_DRIVER_VERSION_MAJOR << 32 |
d605aabab41663c Jon Moeller    2018-11-13  1352  			(pw_u64_t)SW_DRIVER_VERSION_MINOR << 16 |
d605aabab41663c Jon Moeller    2018-11-13  1353  			(pw_u64_t)SW_DRIVER_VERSION_OTHER;
688e338c753b33c Faycal Benmlih 2019-04-23  1354  		if (put_user(local_version,
688e338c753b33c Faycal Benmlih 2019-04-23  1355  			(u64 __user *)local_args.out_arg)) {
d605aabab41663c Jon Moeller    2018-11-13  1356  			pw_pr_error(
688e338c753b33c Faycal Benmlih 2019-04-23  1357  				"ERROR copying driver version to userspace!\n"
688e338c753b33c Faycal Benmlih 2019-04-23  1358  				);
d605aabab41663c Jon Moeller    2018-11-13  1359  			return -PW_ERROR;
d605aabab41663c Jon Moeller    2018-11-13  1360  		}
d605aabab41663c Jon Moeller    2018-11-13  1361  		return PW_SUCCESS;
688e338c753b33c Faycal Benmlih 2019-04-23  1362  	} else if (MATCH_IOCTL(ioctl_num,
688e338c753b33c Faycal Benmlih 2019-04-23  1363  			PW_IOCTL_GET_AVAILABLE_TRACEPOINTS)) {
d605aabab41663c Jon Moeller    2018-11-13  1364  		pw_pr_debug("DEBUG: AVAIL tracepoints! local_out_len = %u\n",
d605aabab41663c Jon Moeller    2018-11-13  1365  			local_out_len);
d605aabab41663c Jon Moeller    2018-11-13  1366  		return sw_get_available_name_id_mappings_i(
d605aabab41663c Jon Moeller    2018-11-13  1367  			SW_NAME_TYPE_TRACEPOINT,
d605aabab41663c Jon Moeller    2018-11-13  1368  			(struct sw_name_info_msg __user *)local_args.out_arg,
d605aabab41663c Jon Moeller    2018-11-13  1369  			local_out_len);
d605aabab41663c Jon Moeller    2018-11-13  1370  	} else if (MATCH_IOCTL(ioctl_num, PW_IOCTL_GET_AVAILABLE_NOTIFIERS)) {
688e338c753b33c Faycal Benmlih 2019-04-23  1371  		pw_pr_debug("DEBUG: AVAIL notifiers! local_out_len = %u\n",
d605aabab41663c Jon Moeller    2018-11-13  1372  			local_out_len);
d605aabab41663c Jon Moeller    2018-11-13  1373  		return sw_get_available_name_id_mappings_i(
d605aabab41663c Jon Moeller    2018-11-13  1374  			SW_NAME_TYPE_NOTIFIER,
d605aabab41663c Jon Moeller    2018-11-13  1375  			(struct sw_name_info_msg __user *)local_args.out_arg,
d605aabab41663c Jon Moeller    2018-11-13  1376  			local_out_len);
d605aabab41663c Jon Moeller    2018-11-13  1377  	} else if (MATCH_IOCTL(ioctl_num, PW_IOCTL_GET_AVAILABLE_COLLECTORS)) {
688e338c753b33c Faycal Benmlih 2019-04-23  1378  		pw_pr_debug("DEBUG: AVAIL collectors! local_out_len = %u\n",
d605aabab41663c Jon Moeller    2018-11-13  1379  			local_out_len);
d605aabab41663c Jon Moeller    2018-11-13  1380  		return sw_get_available_name_id_mappings_i(
d605aabab41663c Jon Moeller    2018-11-13  1381  			SW_NAME_TYPE_COLLECTOR,
d605aabab41663c Jon Moeller    2018-11-13  1382  			(struct sw_name_info_msg __user *)local_args.out_arg,
d605aabab41663c Jon Moeller    2018-11-13  1383  			local_out_len);
d605aabab41663c Jon Moeller    2018-11-13  1384  	} else if (MATCH_IOCTL(ioctl_num, PW_IOCTL_GET_TOPOLOGY_CHANGES)) {
d605aabab41663c Jon Moeller    2018-11-13  1385  		pw_pr_debug("DEBUG: TOPOLOGY changes! local_out_len = %u\n",
d605aabab41663c Jon Moeller    2018-11-13  1386  			local_out_len);
d605aabab41663c Jon Moeller    2018-11-13  1387  		return sw_get_topology_changes_i(
d605aabab41663c Jon Moeller    2018-11-13  1388  			(struct sw_driver_topology_msg __user *)
688e338c753b33c Faycal Benmlih 2019-04-23  1389  				local_args.out_arg, local_out_len);
688e338c753b33c Faycal Benmlih 2019-04-23  1390  	} else if (MATCH_IOCTL(ioctl_num, PW_IOCTL_READ_CONTINUOUS)) {
688e338c753b33c Faycal Benmlih 2019-04-23  1391  		pw_pr_debug("DEBUG: READ_CONTINUOUS!\n");
688e338c753b33c Faycal Benmlih 2019-04-23  1392  		return sw_read_continuous_i(local_args.out_arg, local_out_len);
688e338c753b33c Faycal Benmlih 2019-04-23  1393  	} else if (MATCH_IOCTL(ioctl_num, PW_IOCTL_SET_TELEM_BAR)) {
688e338c753b33c Faycal Benmlih 2019-04-23  1394  		pw_pr_debug("DEBUG: got a request to set telem bar!\n");
688e338c753b33c Faycal Benmlih 2019-04-23  1395  		return sw_set_telem_cfgs_i(local_args.in_arg, local_in_len);
d605aabab41663c Jon Moeller    2018-11-13  1396  	}
688e338c753b33c Faycal Benmlih 2019-04-23  1397  
688e338c753b33c Faycal Benmlih 2019-04-23  1398  	pw_pr_error("ERROR: invalid ioctl num: %u\n", _IOC_NR(ioctl_num));
d605aabab41663c Jon Moeller    2018-11-13  1399  	return -PW_ERROR;
d605aabab41663c Jon Moeller    2018-11-13  1400  }
d605aabab41663c Jon Moeller    2018-11-13  1401  

:::::: The code at line 1309 was first introduced by commit
:::::: d605aabab41663c9be9e8c549042933189adbf2f platform/x86: add sep and socwatch drivers without socperf.

:::::: TO: Jon Moeller <jon.moeller@intel.com>
:::::: CC: Faycal Benmlih <faycal.benmlih@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
