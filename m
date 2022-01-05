Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B0B485B47
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 23:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244722AbiAEWHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 17:07:02 -0500
Received: from mga18.intel.com ([134.134.136.126]:19133 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244716AbiAEWG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 17:06:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641420417; x=1672956417;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=A3S6i6P/bWmDPC68jtKB8TMGT9TJaBRTy/Rny9domTk=;
  b=BO+47DQRmCKIGaOIVaeCsgYoAkF9g4+q9DwvNujYmBTSOOKhAIpot9uW
   fKasz9dHIGgbSsBYGZg0PXBHwZcytDXT/n3jnPTQZYEhMGgilo3SIySM1
   O8ww2fgTXFlnU5u32GTK05RVX/9wS3uJYDvXZG5CSGGFjBinnRzT3LoH6
   xeYe2w8Dke7JlugFUG54tynr9pTU+BltQwR6wJjabbtOYNTrnuHNGtc/c
   9wnVJx5EOq8EM8wRxvlM098AkMmPewN1t2bmpXwqwyY9jm4OdLOjWAAHA
   X4HBx+rOmFrrL1NnO2R7BKTmwi/DI4BETeD4+CzPz+qB991oqHvfhISkz
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229358708"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="229358708"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 14:06:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="689168076"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 05 Jan 2022 14:06:55 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5EQo-000H4c-Jm; Wed, 05 Jan 2022 22:06:54 +0000
Date:   Thu, 6 Jan 2022 06:06:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jolsa-perf:kprobe/multi 4/14]
 drivers/gpu/drm/i915/gem/i915_gem_internal.c:174:6: error: shift count >=
 width of type
Message-ID: <202201060655.KDdXDde2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git kprobe/multi
head:   27d253a29de023f664387fcc049edeeaadf23c8e
commit: fbf6ec1e4f8e6c1fed1e1d14f16595e2dc01902d [4/14] kprobe: Add support to register multiple ftrace kprobes
config: x86_64-randconfig-r011-20220105 (https://download.01.org/0day-ci/archive/20220106/202201060655.KDdXDde2-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d5b6e30ed3acad794dd0aec400e617daffc6cc3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=fbf6ec1e4f8e6c1fed1e1d14f16595e2dc01902d
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf kprobe/multi
        git checkout fbf6ec1e4f8e6c1fed1e1d14f16595e2dc01902d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/i915/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/i915/gem/i915_gem_internal.c:11:
   In file included from drivers/gpu/drm/i915/i915_drv.h:41:
   In file included from include/linux/backlight.h:13:
   In file included from include/linux/fb.h:6:
   In file included from include/linux/kgdb.h:19:
   include/linux/kprobes.h:77:21: error: field has incomplete type 'struct ftrace_ops'
                   struct ftrace_ops ops;
                                     ^
   include/linux/ftrace.h:332:8: note: forward declaration of 'struct ftrace_ops'
   struct ftrace_ops;
          ^
   In file included from drivers/gpu/drm/i915/gem/i915_gem_internal.c:11:
   In file included from drivers/gpu/drm/i915/i915_drv.h:84:
   In file included from drivers/gpu/drm/i915/gt/intel_engine.h:18:
   In file included from drivers/gpu/drm/i915/gt/intel_gt_types.h:18:
   In file included from drivers/gpu/drm/i915/gt/uc/intel_uc.h:9:
   In file included from drivers/gpu/drm/i915/gt/uc/intel_guc.h:19:
   In file included from drivers/gpu/drm/i915/gt/uc/intel_uc_fw.h:13:
   In file included from drivers/gpu/drm/i915/i915_vma.h:34:
   drivers/gpu/drm/i915/gem/i915_gem_object.h:43:6: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
           if (overflows_type(size, obj->base.size))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_utils.h:126:32: note: expanded from macro 'overflows_type'
           (sizeof(x) > sizeof(T) && (x) >> BITS_PER_TYPE(T))
                                         ^  ~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/i915/gem/i915_gem_internal.c:174:6: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
           if (overflows_type(size, obj->base.size))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_utils.h:126:32: note: expanded from macro 'overflows_type'
           (sizeof(x) > sizeof(T) && (x) >> BITS_PER_TYPE(T))
                                         ^  ~~~~~~~~~~~~~~~~
   3 errors generated.
--
   In file included from drivers/gpu/drm/i915/i915_query.c:9:
   In file included from drivers/gpu/drm/i915/i915_drv.h:41:
   In file included from include/linux/backlight.h:13:
   In file included from include/linux/fb.h:6:
   In file included from include/linux/kgdb.h:19:
   include/linux/kprobes.h:77:21: error: field has incomplete type 'struct ftrace_ops'
                   struct ftrace_ops ops;
                                     ^
   include/linux/ftrace.h:332:8: note: forward declaration of 'struct ftrace_ops'
   struct ftrace_ops;
          ^
   In file included from drivers/gpu/drm/i915/i915_query.c:9:
   In file included from drivers/gpu/drm/i915/i915_drv.h:84:
   In file included from drivers/gpu/drm/i915/gt/intel_engine.h:18:
   In file included from drivers/gpu/drm/i915/gt/intel_gt_types.h:18:
   In file included from drivers/gpu/drm/i915/gt/uc/intel_uc.h:9:
   In file included from drivers/gpu/drm/i915/gt/uc/intel_guc.h:19:
   In file included from drivers/gpu/drm/i915/gt/uc/intel_uc_fw.h:13:
   In file included from drivers/gpu/drm/i915/i915_vma.h:34:
   drivers/gpu/drm/i915/gem/i915_gem_object.h:43:6: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
           if (overflows_type(size, obj->base.size))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_utils.h:126:32: note: expanded from macro 'overflows_type'
           (sizeof(x) > sizeof(T) && (x) >> BITS_PER_TYPE(T))
                                         ^  ~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/i915/i915_query.c:512:7: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
                   if (overflows_type(item.query_id - 1, unsigned long))
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_utils.h:126:32: note: expanded from macro 'overflows_type'
           (sizeof(x) > sizeof(T) && (x) >> BITS_PER_TYPE(T))
                                         ^  ~~~~~~~~~~~~~~~~
   3 errors generated.
--
   In file included from drivers/gpu/drm/i915/display/intel_fb.c:9:
   In file included from drivers/gpu/drm/i915/display/intel_display.h:28:
   In file included from include/drm/drm_util.h:36:
   In file included from include/linux/kgdb.h:19:
   include/linux/kprobes.h:77:21: error: field has incomplete type 'struct ftrace_ops'
                   struct ftrace_ops ops;
                                     ^
   include/linux/ftrace.h:332:8: note: forward declaration of 'struct ftrace_ops'
   struct ftrace_ops;
          ^
   In file included from drivers/gpu/drm/i915/display/intel_fb.c:10:
   In file included from drivers/gpu/drm/i915/display/intel_display_types.h:47:
   In file included from drivers/gpu/drm/i915/i915_drv.h:84:
   In file included from drivers/gpu/drm/i915/gt/intel_engine.h:18:
   In file included from drivers/gpu/drm/i915/gt/intel_gt_types.h:18:
   In file included from drivers/gpu/drm/i915/gt/uc/intel_uc.h:9:
   In file included from drivers/gpu/drm/i915/gt/uc/intel_guc.h:19:
   In file included from drivers/gpu/drm/i915/gt/uc/intel_uc_fw.h:13:
   In file included from drivers/gpu/drm/i915/i915_vma.h:34:
   drivers/gpu/drm/i915/gem/i915_gem_object.h:43:6: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
           if (overflows_type(size, obj->base.size))
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_utils.h:126:32: note: expanded from macro 'overflows_type'
           (sizeof(x) > sizeof(T) && (x) >> BITS_PER_TYPE(T))
                                         ^  ~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/i915/display/intel_fb.c:863:2: error: shift count >= width of type [-Werror,-Wshift-count-overflow]
           assign_chk_ovf(i915, remap_info->offset, obj_offset);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/display/intel_fb.c:845:28: note: expanded from macro 'assign_chk_ovf'
           drm_WARN_ON(&(i915)->drm, overflows_type(val, var)); \
           ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/i915/i915_utils.h:126:32: note: expanded from macro 'overflows_type'
           (sizeof(x) > sizeof(T) && (x) >> BITS_PER_TYPE(T))
                                         ^
   include/drm/drm_print.h:593:19: note: expanded from macro 'drm_WARN_ON'
           drm_WARN((drm), (x), "%s",                                      \
           ~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/drm/drm_print.h:583:7: note: expanded from macro 'drm_WARN'
           WARN(condition, "%s %s: " format,                               \
           ~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:130:25: note: expanded from macro 'WARN'
           int __ret_warn_on = !!(condition);                              \
                                  ^~~~~~~~~
   3 errors generated.


vim +174 drivers/gpu/drm/i915/gem/i915_gem_internal.c

920cf4194954ec6 drivers/gpu/drm/i915/i915_gem_internal.c     Chris Wilson 2016-10-28  147  
920cf4194954ec6 drivers/gpu/drm/i915/i915_gem_internal.c     Chris Wilson 2016-10-28  148  /**
40f46095db0691b drivers/gpu/drm/i915/i915_gem_internal.c     Chris Wilson 2018-02-08  149   * i915_gem_object_create_internal: create an object with volatile pages
40f46095db0691b drivers/gpu/drm/i915/i915_gem_internal.c     Chris Wilson 2018-02-08  150   * @i915: the i915 device
40f46095db0691b drivers/gpu/drm/i915/i915_gem_internal.c     Chris Wilson 2018-02-08  151   * @size: the size in bytes of backing storage to allocate for the object
40f46095db0691b drivers/gpu/drm/i915/i915_gem_internal.c     Chris Wilson 2018-02-08  152   *
920cf4194954ec6 drivers/gpu/drm/i915/i915_gem_internal.c     Chris Wilson 2016-10-28  153   * Creates a new object that wraps some internal memory for private use.
920cf4194954ec6 drivers/gpu/drm/i915/i915_gem_internal.c     Chris Wilson 2016-10-28  154   * This object is not backed by swappable storage, and as such its contents
920cf4194954ec6 drivers/gpu/drm/i915/i915_gem_internal.c     Chris Wilson 2016-10-28  155   * are volatile and only valid whilst pinned. If the object is reaped by the
920cf4194954ec6 drivers/gpu/drm/i915/i915_gem_internal.c     Chris Wilson 2016-10-28  156   * shrinker, its pages and data will be discarded. Equally, it is not a full
920cf4194954ec6 drivers/gpu/drm/i915/i915_gem_internal.c     Chris Wilson 2016-10-28  157   * GEM object and so not valid for access from userspace. This makes it useful
920cf4194954ec6 drivers/gpu/drm/i915/i915_gem_internal.c     Chris Wilson 2016-10-28  158   * for hardware interfaces like ringbuffers (which are pinned from the time
920cf4194954ec6 drivers/gpu/drm/i915/i915_gem_internal.c     Chris Wilson 2016-10-28  159   * the request is written to the time the hardware stops accessing it), but
920cf4194954ec6 drivers/gpu/drm/i915/i915_gem_internal.c     Chris Wilson 2016-10-28  160   * not for contexts (which need to be preserved when not active for later
920cf4194954ec6 drivers/gpu/drm/i915/i915_gem_internal.c     Chris Wilson 2016-10-28  161   * reuse). Note that it is not cleared upon allocation.
920cf4194954ec6 drivers/gpu/drm/i915/i915_gem_internal.c     Chris Wilson 2016-10-28  162   */
920cf4194954ec6 drivers/gpu/drm/i915/i915_gem_internal.c     Chris Wilson 2016-10-28  163  struct drm_i915_gem_object *
920cf4194954ec6 drivers/gpu/drm/i915/i915_gem_internal.c     Chris Wilson 2016-10-28  164  i915_gem_object_create_internal(struct drm_i915_private *i915,
fcd46e53449c4d6 drivers/gpu/drm/i915/i915_gem_internal.c     Chris Wilson 2017-01-12  165  				phys_addr_t size)
920cf4194954ec6 drivers/gpu/drm/i915/i915_gem_internal.c     Chris Wilson 2016-10-28  166  {
7867d709959927e drivers/gpu/drm/i915/gem/i915_gem_internal.c Chris Wilson 2019-10-22  167  	static struct lock_class_key lock_class;
920cf4194954ec6 drivers/gpu/drm/i915/i915_gem_internal.c     Chris Wilson 2016-10-28  168  	struct drm_i915_gem_object *obj;
b8f55be64453ea7 drivers/gpu/drm/i915/i915_gem_internal.c     Chris Wilson 2017-08-11  169  	unsigned int cache_level;
920cf4194954ec6 drivers/gpu/drm/i915/i915_gem_internal.c     Chris Wilson 2016-10-28  170  
fcd46e53449c4d6 drivers/gpu/drm/i915/i915_gem_internal.c     Chris Wilson 2017-01-12  171  	GEM_BUG_ON(!size);
bf6b2030bed9371 drivers/gpu/drm/i915/i915_gem_internal.c     Chris Wilson 2017-01-16  172  	GEM_BUG_ON(!IS_ALIGNED(size, PAGE_SIZE));
fcd46e53449c4d6 drivers/gpu/drm/i915/i915_gem_internal.c     Chris Wilson 2017-01-12  173  
fcd46e53449c4d6 drivers/gpu/drm/i915/i915_gem_internal.c     Chris Wilson 2017-01-12 @174  	if (overflows_type(size, obj->base.size))

:::::: The code at line 174 was first introduced by commit
:::::: fcd46e53449c4d659ffbedcd2823ea2f73e39927 drm/i915: Declare i915_gem_object_create_internal() as taking phys_addr_t size

:::::: TO: Chris Wilson <chris@chris-wilson.co.uk>
:::::: CC: Chris Wilson <chris@chris-wilson.co.uk>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
