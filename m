Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662914D27BF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiCID0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 22:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiCID0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 22:26:53 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B433165AF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 19:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646796354; x=1678332354;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Gth5hINsnvAcq51cqIrJAOXK3LeiVlry6Zr5SVVDeeo=;
  b=Q0y4t6xwNwUJBo2CGucyOvA2MX9oKTc9zkCfGPCJD4L2qhTKUxAZOHeU
   T3UDwf+7zCg19ctym1mikY+fIypunmRNfSlz/7aXe1KSWK1JJ8pOcjilJ
   dTifctmjGfgiGlzVCy5/k8MWPCIrZLGjq7FARxZngegU8O+jzRwrfuUx0
   C27XKOe8lJcmy20gLfWnYtieDUq7oS7MRR9w8d0sH9uTlfMbUmPfpS4mp
   hCCPY8yT7XPIj3COIBUd7cHAZaZzfwQLcQQqEuDXQLGG4v5a7IJ6PnxY+
   BJchdDoq8Logz5TEkvMkVRgpgEtEHwQXN/qDLGtm6qAga2lq5LUDKjHSc
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="252446020"
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="252446020"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 19:25:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="537837159"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 08 Mar 2022 19:25:49 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRmxQ-0002UL-JP; Wed, 09 Mar 2022 03:25:48 +0000
Date:   Wed, 9 Mar 2022 11:25:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-5.10
 2362/9999] mm/page_pinner.c:304:22: warning: variable 'page_pinner' set but
 not used
Message-ID: <202203091120.mN0fCHUE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-5.10
head:   fcaaaaae6d4c72eb4084dc136acd478ad09fe0f0
commit: ddc4a48797352076586ef3ab79c6bfaba08fd06e [2362/9999] ANDROID: mm: page_pinner: introduce failure_tracking feature
config: x86_64-randconfig-c007-20220307 (https://download.01.org/0day-ci/archive/20220309/202203091120.mN0fCHUE-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/ddc4a48797352076586ef3ab79c6bfaba08fd06e
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-5.10
        git checkout ddc4a48797352076586ef3ab79c6bfaba08fd06e
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 clang-analyzer 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/page_pinner.c:304:22: warning: variable 'page_pinner' set but not used [-Wunused-but-set-variable]
           struct page_pinner *page_pinner;
                               ^
   1 warning generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_MIPI_DSI
   Depends on HAS_IOMEM && DRM
   Selected by
   - GKI_HIDDEN_DRM_CONFIGS
   WARNING: unmet direct dependencies detected for DRM_KMS_CMA_HELPER
   Depends on HAS_IOMEM && DRM
   Selected by
   - GKI_HIDDEN_DRM_CONFIGS
   WARNING: unmet direct dependencies detected for DRM_GEM_CMA_HELPER
   Depends on HAS_IOMEM && DRM
   Selected by
   - GKI_HIDDEN_DRM_CONFIGS


clang-analyzer warnings: (new ones prefixed by >>)
               ^~~~~~
   drivers/scsi/myrb.c:478:56: note: Left side of '&&' is false
           if (status == MYRB_NO_STDBY_RBLD_OR_CHECK_IN_PROGRESS &&
                                                                 ^
   drivers/scsi/myrb.c:481:6: note: 'status' is not equal to MYRB_NO_STDBY_RBLD_OR_CHECK_IN_PROGRESS
           if (status != MYRB_NO_STDBY_RBLD_OR_CHECK_IN_PROGRESS) {
               ^~~~~~
   drivers/scsi/myrb.c:481:2: note: Taking true branch
           if (status != MYRB_NO_STDBY_RBLD_OR_CHECK_IN_PROGRESS) {
           ^
   drivers/scsi/myrb.c:483:23: note: The left operand of '-' is a garbage value
                           rbld_buf.ldev_size - rbld_buf.blocks_left;
                           ~~~~~~~~~~~~~~~~~~ ^
   drivers/scsi/myrb.c:1937:24: warning: The left operand of '!=' is a garbage value [clang-analyzer-core.UndefinedBinaryOperatorResult]
           if (rbld_buf.ldev_num != sdev->id ||
                                 ^
   drivers/scsi/myrb.c:2160:9: note: Calling 'rebuild_show'
           return rebuild_show(dev, attr, buf);
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/myrb.c:1927:29: note: Left side of '&&' is false
           struct scsi_device *sdev = to_scsi_device(dev);
                                      ^
   include/scsi/scsi_device.h:244:2: note: expanded from macro 'to_scsi_device'
           container_of(d, struct scsi_device, sdev_gendev)
           ^
   include/linux/kernel.h:853:61: note: expanded from macro 'container_of'
           BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
                                                                      ^
   drivers/scsi/myrb.c:1927:29: note: Taking false branch
           struct scsi_device *sdev = to_scsi_device(dev);
                                      ^
   include/scsi/scsi_device.h:244:2: note: expanded from macro 'to_scsi_device'
           container_of(d, struct scsi_device, sdev_gendev)
           ^
   include/linux/kernel.h:853:2: note: expanded from macro 'container_of'
           BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
           ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                       ^
   include/linux/compiler_types.h:323:2: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ^
   include/linux/compiler_types.h:311:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:303:3: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                   ^
   drivers/scsi/myrb.c:1927:29: note: Loop condition is false.  Exiting loop
           struct scsi_device *sdev = to_scsi_device(dev);
                                      ^
   include/scsi/scsi_device.h:244:2: note: expanded from macro 'to_scsi_device'
           container_of(d, struct scsi_device, sdev_gendev)
           ^
   include/linux/kernel.h:853:2: note: expanded from macro 'container_of'
           BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
           ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                       ^
   include/linux/compiler_types.h:323:2: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ^
   include/linux/compiler_types.h:311:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:301:2: note: expanded from macro '__compiletime_assert'
           do {                                                            \
           ^
   drivers/scsi/myrb.c:1932:6: note: Assuming the condition is false
           if (sdev->channel < myrb_logical_channel(sdev->host))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/myrb.c:1932:2: note: Taking false branch
           if (sdev->channel < myrb_logical_channel(sdev->host))
           ^
   drivers/scsi/myrb.c:1935:11: note: Calling 'myrb_get_rbld_progress'
           status = myrb_get_rbld_progress(cb, &rbld_buf);
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/myrb.c:451:6: note: Assuming 'rbld_buf' is null
           if (!rbld_buf)
               ^~~~~~~~~
   drivers/scsi/myrb.c:451:2: note: Taking true branch
           if (!rbld_buf)
           ^
   drivers/scsi/myrb.c:452:3: note: Returning without writing to 'rbld->ldev_num'
                   return MYRB_STATUS_RBLD_NOT_CHECKED;
                   ^
   drivers/scsi/myrb.c:1935:11: note: Returning from 'myrb_get_rbld_progress'
           status = myrb_get_rbld_progress(cb, &rbld_buf);
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/myrb.c:1937:24: note: The left operand of '!=' is a garbage value
           if (rbld_buf.ldev_num != sdev->id ||
               ~~~~~~~~~~~~~~~~~ ^
   Suppressed 18 warnings (6 in non-user code, 12 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   5 warnings generated.
   Suppressed 5 warnings (5 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   7 warnings generated.
>> mm/page_pinner.c:312:2: warning: Value stored to 'page_pinner' is never read [clang-analyzer-deadcode.DeadStores]
           page_pinner = get_page_pinner(page_ext);
           ^             ~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/page_pinner.c:312:2: note: Value stored to 'page_pinner' is never read
           page_pinner = get_page_pinner(page_ext);
           ^             ~~~~~~~~~~~~~~~~~~~~~~~~~
   Suppressed 6 warnings (5 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   5 warnings generated.
   Suppressed 5 warnings (5 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   5 warnings generated.
   Suppressed 5 warnings (5 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   5 warnings generated.
   Suppressed 5 warnings (5 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   6 warnings generated.
   Suppressed 6 warnings (6 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   6 warnings generated.
   Suppressed 6 warnings (6 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   5 warnings generated.
   Suppressed 5 warnings (5 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   5 warnings generated.
   Suppressed 5 warnings (5 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   4 warnings generated.
   Suppressed 4 warnings (4 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   5 warnings generated.
   Suppressed 5 warnings (5 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   4 warnings generated.
   Suppressed 4 warnings (4 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   5 warnings generated.
   Suppressed 5 warnings (5 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   4 warnings generated.
   Suppressed 4 warnings (4 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   5 warnings generated.
   Suppressed 5 warnings (5 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   12 warnings generated.
   drivers/scsi/smartpqi/smartpqi_init.c:1650:4: warning: Value stored to 'count' is never read [clang-analyzer-deadcode.DeadStores]
                           count += scnprintf(buffer + count,
                           ^        ~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/smartpqi/smartpqi_init.c:1650:4: note: Value stored to 'count' is never read
                           count += scnprintf(buffer + count,
                           ^        ~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/smartpqi/smartpqi_init.c:1662:4: warning: Value stored to 'count' is never read [clang-analyzer-deadcode.DeadStores]
                           count += scnprintf(buffer + count,
                           ^        ~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/smartpqi/smartpqi_init.c:1662:4: note: Value stored to 'count' is never read
                           count += scnprintf(buffer + count,
                           ^        ~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/smartpqi/smartpqi_init.c:2117:19: warning: Access to field 'wwid' results in a dereference of a null pointer (loaded from variable 'phys_lun_ext_entry') [clang-analyzer-core.NullDereference]
                           device->wwid = phys_lun_ext_entry->wwid;
                                          ^~~~~~~~~~~~~~~~~~
   drivers/scsi/smartpqi/smartpqi_init.c:1976:7: note: Calling 'pqi_get_device_lists'
           rc = pqi_get_device_lists(ctrl_info, &physdev_list, &logdev_list);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/smartpqi/smartpqi_init.c:1001:6: note: 'rc' is 0
           if (rc)
               ^~
   drivers/scsi/smartpqi/smartpqi_init.c:1001:2: note: Taking false branch
           if (rc)
           ^
   drivers/scsi/smartpqi/smartpqi_init.c:1006:6: note: 'rc' is 0
           if (rc)
               ^~
   drivers/scsi/smartpqi/smartpqi_init.c:1006:2: note: Taking false branch
           if (rc)
           ^
   drivers/scsi/smartpqi/smartpqi_init.c:1016:6: note: 'logdev_data' is non-null
           if (logdev_data) {
               ^~~~~~~~~~~
   drivers/scsi/smartpqi/smartpqi_init.c:1016:2: note: Taking true branch
           if (logdev_data) {
           ^
   drivers/scsi/smartpqi/smartpqi_init.c:1031:6: note: Assuming 'internal_logdev_list' is non-null
           if (!internal_logdev_list) {
               ^~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/smartpqi/smartpqi_init.c:1031:2: note: Taking false branch
           if (!internal_logdev_list) {
           ^
   drivers/scsi/smartpqi/smartpqi_init.c:1047:2: note: Returning zero, which participates in a condition later
           return 0;
           ^~~~~~~~
   drivers/scsi/smartpqi/smartpqi_init.c:1976:7: note: Returning from 'pqi_get_device_lists'
           rc = pqi_get_device_lists(ctrl_info, &physdev_list, &logdev_list);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/smartpqi/smartpqi_init.c:1977:6: note: 'rc' is 0
           if (rc)
               ^~
   drivers/scsi/smartpqi/smartpqi_init.c:1977:2: note: Taking false branch
           if (rc)
--
           __X64_SYS_STUBx(x, name, __VA_ARGS__)                           \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:96:2: note: expanded from macro '__X64_SYS_STUBx'
           __SYS_STUBx(x64, sys##name,                                     \
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:79:10: note: expanded from macro '__SYS_STUBx'
                   return __se_##name(__VA_ARGS__);                        \
                          ^~~~~~~~~~~~~~~~~~~~~~~~
   note: expanded from here
   fs/pipe.c:1013:1: note: Calling '__do_sys_pipe'
   SYSCALL_DEFINE1(pipe, int __user *, fildes)
   ^
   include/linux/syscalls.h:213:36: note: expanded from macro 'SYSCALL_DEFINE1'
   #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:224:2: note: expanded from macro 'SYSCALL_DEFINEx'
           __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/syscall_wrapper.h:234:14: note: expanded from macro '__SYSCALL_DEFINEx'
                   long ret = __do_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));\
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   note: expanded from here
   fs/pipe.c:1015:9: note: Calling 'do_pipe2'
           return do_pipe2(fildes, 0);
                  ^~~~~~~~~~~~~~~~~~~
   fs/pipe.c:992:10: note: Calling '__do_pipe_flags'
           error = __do_pipe_flags(fd, files, flags);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/pipe.c:941:2: note: Taking false branch
           if (flags & ~(O_CLOEXEC | O_NONBLOCK | O_DIRECT | O_NOTIFICATION_PIPE))
           ^
   fs/pipe.c:944:10: note: Calling 'create_pipe_files'
           error = create_pipe_files(files, flags);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/pipe.c:899:7: note: 'inode' is non-null
           if (!inode)
                ^~~~~
   fs/pipe.c:899:2: note: Taking false branch
           if (!inode)
           ^
   fs/pipe.c:902:2: note: Taking false branch
           if (flags & O_NOTIFICATION_PIPE) {
           ^
   fs/pipe.c:914:2: note: Taking false branch
           if (IS_ERR(f)) {
           ^
   fs/pipe.c:924:2: note: Taking true branch
           if (IS_ERR(res[0])) {
           ^
   fs/pipe.c:944:10: note: Returning from 'create_pipe_files'
           error = create_pipe_files(files, flags);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/pipe.c:945:6: note: Assuming 'error' is 0
           if (error)
               ^~~~~
   fs/pipe.c:945:2: note: Taking false branch
           if (error)
           ^
   fs/pipe.c:949:6: note: Assuming 'error' is >= 0
           if (error < 0)
               ^~~~~~~~~
   fs/pipe.c:949:2: note: Taking false branch
           if (error < 0)
           ^
   fs/pipe.c:954:6: note: Assuming 'error' is >= 0
           if (error < 0)
               ^~~~~~~~~
   fs/pipe.c:954:2: note: Taking false branch
           if (error < 0)
           ^
   fs/pipe.c:961:2: note: Returning zero, which participates in a condition later
           return 0;
           ^~~~~~~~
   fs/pipe.c:992:10: note: Returning from '__do_pipe_flags'
           error = __do_pipe_flags(fd, files, flags);
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/pipe.c:993:7: note: 'error' is 0
           if (!error) {
                ^~~~~
   fs/pipe.c:993:2: note: Taking true branch
           if (!error) {
           ^
   fs/pipe.c:994:7: note: Assuming the condition is true
                   if (unlikely(copy_to_user(fildes, fd, sizeof(fd)))) {
                       ^
   include/linux/compiler.h:78:40: note: expanded from macro 'unlikely'
   # define unlikely(x)    __builtin_expect(!!(x), 0)
                                             ^~~~
   fs/pipe.c:994:3: note: Taking false branch
                   if (unlikely(copy_to_user(fildes, fd, sizeof(fd)))) {
                   ^
   fs/pipe.c:1002:4: note: 2nd function call argument is an uninitialized value
                           fd_install(fd[1], files[1]);
                           ^                 ~~~~~~~~
   Suppressed 10 warnings (5 in non-user code, 5 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   5 warnings generated.
   Suppressed 5 warnings (5 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   7 warnings generated.
>> mm/page_pinner.c:312:2: warning: Value stored to 'page_pinner' is never read [clang-analyzer-deadcode.DeadStores]
           page_pinner = get_page_pinner(page_ext);
           ^             ~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/page_pinner.c:312:2: note: Value stored to 'page_pinner' is never read
           page_pinner = get_page_pinner(page_ext);
           ^             ~~~~~~~~~~~~~~~~~~~~~~~~~
   Suppressed 6 warnings (5 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   5 warnings generated.
   Suppressed 5 warnings (5 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   5 warnings generated.
   Suppressed 5 warnings (5 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   5 warnings generated.
   Suppressed 5 warnings (5 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   4 warnings generated.
   Suppressed 4 warnings (4 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   1 warning generated.
   Suppressed 1 warnings (1 with check filters).
   5 warnings generated.
   Suppressed 5 warnings (5 in non-user code).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   7 warnings generated.
   Suppressed 7 warnings (6 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   7 warnings generated.
   Suppressed 7 warnings (6 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   7 warnings generated.
   Suppressed 7 warnings (6 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   7 warnings generated.
   Suppressed 7 warnings (6 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   14 warnings generated.
   drivers/scsi/aic7xxx/aic79xx_osm.c:561:2: warning: Call to function 'strcpy' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcpy'. CWE-119 [clang-analyzer-security.insecureAPI.strcpy]
           strcpy(bp, "Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev " AIC79XX_DRIVER_VERSION "\n"
           ^~~~~~
   drivers/scsi/aic7xxx/aic79xx_osm.c:561:2: note: Call to function 'strcpy' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcpy'. CWE-119
           strcpy(bp, "Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev " AIC79XX_DRIVER_VERSION "\n"
           ^~~~~~
   drivers/scsi/aic7xxx/aic79xx_osm.c:563:2: warning: Call to function 'strcat' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcat'. CWE-119 [clang-analyzer-security.insecureAPI.strcpy]
           strcat(bp, ahd->description);
           ^~~~~~
   drivers/scsi/aic7xxx/aic79xx_osm.c:563:2: note: Call to function 'strcat' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcat'. CWE-119
           strcat(bp, ahd->description);
           ^~~~~~
   drivers/scsi/aic7xxx/aic79xx_osm.c:564:2: warning: Call to function 'strcat' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcat'. CWE-119 [clang-analyzer-security.insecureAPI.strcpy]
           strcat(bp, ">\n"
           ^~~~~~
   drivers/scsi/aic7xxx/aic79xx_osm.c:564:2: note: Call to function 'strcat' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcat'. CWE-119
           strcat(bp, ">\n"
           ^~~~~~
   drivers/scsi/aic7xxx/aic79xx_osm.c:567:2: warning: Call to function 'strcat' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcat'. CWE-119 [clang-analyzer-security.insecureAPI.strcpy]
           strcat(bp, ahd_info);
           ^~~~~~
   drivers/scsi/aic7xxx/aic79xx_osm.c:567:2: note: Call to function 'strcat' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcat'. CWE-119
           strcat(bp, ahd_info);
           ^~~~~~
   drivers/scsi/aic7xxx/aic79xx_osm.c:649:2: warning: Value stored to 'tinfo' is never read [clang-analyzer-deadcode.DeadStores]
           tinfo = ahd_fetch_transinfo(ahd, channel, ahd->our_id,
           ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/aic7xxx/aic79xx_osm.c:649:2: note: Value stored to 'tinfo' is never read
           tinfo = ahd_fetch_transinfo(ahd, channel, ahd->our_id,
           ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/aic7xxx/aic79xx_osm.c:1239:3: warning: Call to function 'strcpy' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcpy'. CWE-119 [clang-analyzer-security.insecureAPI.strcpy]
                   strcpy(new_name, buf);
                   ^~~~~~
   drivers/scsi/aic7xxx/aic79xx_osm.c:1239:3: note: Call to function 'strcpy' is insecure as it does not provide bounding of the memory buffer. Replace unbounded copy functions with analogous functions that support length arguments such as 'strlcpy'. CWE-119
                   strcpy(new_name, buf);
                   ^~~~~~
   drivers/scsi/aic7xxx/aic79xx_osm.c:2257:2: warning: Value stored to 'saved_scsiid' is never read [clang-analyzer-deadcode.DeadStores]
           saved_scsiid = ahd_inb(ahd, SAVED_SCSIID);
           ^              ~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/scsi/aic7xxx/aic79xx_osm.c:2257:2: note: Value stored to 'saved_scsiid' is never read
           saved_scsiid = ahd_inb(ahd, SAVED_SCSIID);
           ^              ~~~~~~~~~~~~~~~~~~~~~~~~~~
   Suppressed 7 warnings (6 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   7 warnings generated.
   kernel/trace/ring_buffer.c:1985:2: warning: Value stored to 'size' is never read [clang-analyzer-deadcode.DeadStores]
           size = nr_pages * BUF_PAGE_SIZE;
           ^      ~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/ring_buffer.c:1985:2: note: Value stored to 'size' is never read
           size = nr_pages * BUF_PAGE_SIZE;
           ^      ~~~~~~~~~~~~~~~~~~~~~~~~
   Suppressed 6 warnings (5 in non-user code, 1 with check filters).
   Use -header-filter=.* to display errors from all non-system headers. Use -system-headers to display errors from system headers as well.
   11 warnings generated.
   kernel/trace/trace.c:353:2: warning: Access to field 'next' results in a dereference of a null pointer [clang-analyzer-core.NullDereference]
           rcu_assign_pointer(*p, (*p)->next);
           ^
   include/linux/rcupdate.h:424:35: note: expanded from macro 'rcu_assign_pointer'
           uintptr_t _r_a_p__v = (uintptr_t)(v);                                 \
                                            ^
   kernel/trace/trace.c:396:2: note: Value assigned to 'ftrace_exports_list'
           mutex_lock(&ftrace_export_lock);
           ^

vim +/page_pinner +304 mm/page_pinner.c

   300	
   301	void __page_pinner_migration_failed(struct page *page)
   302	{
   303		struct page_ext *page_ext = lookup_page_ext(page);
 > 304		struct page_pinner *page_pinner;
   305		depot_stack_handle_t handle;
   306		unsigned long flags;
   307		unsigned int idx;
   308	
   309		if (unlikely(!page_ext))
   310			return;
   311	
 > 312		page_pinner = get_page_pinner(page_ext);
   313		if (!test_bit(PAGE_EXT_PINNER_MIGRATION_FAILED, &page_ext->flags))
   314			return;
   315	
   316		handle = save_stack(GFP_NOWAIT|__GFP_NOWARN);
   317	
   318		spin_lock_irqsave(&acf_pinner.lock, flags);
   319		idx = acf_pinner.index++;
   320		acf_pinner.index %= LONTERM_PIN_BUCKETS;
   321	
   322		acf_pinner.pinner[idx].handle = handle;
   323		acf_pinner.pinner[idx].ts_usec = ktime_to_us(ktime_get_boottime());
   324		acf_pinner.pinner[idx].page_flags = page->flags;
   325		acf_pinner.pinner[idx].page_mt = get_pageblock_migratetype(page);
   326		acf_pinner.pinner[idx].pfn = page_to_pfn(page);
   327		spin_unlock_irqrestore(&acf_pinner.lock, flags);
   328	}
   329	EXPORT_SYMBOL(__page_pinner_migration_failed);
   330	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
