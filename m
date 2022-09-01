Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3D65AA062
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiIATuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbiIATt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:49:58 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBEB1094
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 12:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662061796; x=1693597796;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yYgBD3dEtOYwCyHEs1WR6swv/1/GzneYq7e8RSs+6H0=;
  b=Q171PAePavzfvrACk1mFvAU19PZiSHsqWHArZSmQN0JgJxgsiqspipPG
   UKYTk6g18ByoZcjZj+OObWiLRY6te31zScbR5ii2KbeXoG+pUGKU9BFVl
   YO0oJznKcMp3x50JnWhO+xkw3tReuDIrpf3ovyeHjkaR8faAS4iph53wM
   z8cBIzaHqnuOgbr1EFJ4pn3QNVYyxQH/mwzQ/BgDGUgbUWIBRiYVOQ8F4
   7RzsAYEFx9wpOewl5ckgRPy+2HCQmS8vtha/Pv5/qXVYxTWAhVGzpd6vR
   a6IspLtKiFPlQXJmiHoqLZMuNiZfhBMlZCckYHwiMKyTGKnuQmWldYfdl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="296596847"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="296596847"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 12:49:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="589687196"
Received: from lkp-server02.sh.intel.com (HELO b138c9e8658c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 01 Sep 2022 12:49:53 -0700
Received: from kbuild by b138c9e8658c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTqCG-0000hR-2q;
        Thu, 01 Sep 2022 19:49:52 +0000
Date:   Fri, 2 Sep 2022 03:49:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>
Subject: [jsarha:topic/cros-sof-v4.19 1155/6555]
 drivers/gpu/drm/drm_atomic_uapi.c:1297: Error: unrecognized opcode `csrs
 sstatus,s8'
Message-ID: <202209020320.DEOLa6AV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.19
head:   d7a3e91d8d16d1ef8653deec5a1fffc4de034a0c
commit: dfdec43d0411076dc70591a0496a0824a8620695 [1155/6555] UPSTREAM: drm: extract drm_atomic_uapi.c
config: riscv-randconfig-r042-20220901 (https://download.01.org/0day-ci/archive/20220902/202209020320.DEOLa6AV-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jsarha/linux/commit/dfdec43d0411076dc70591a0496a0824a8620695
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/cros-sof-v4.19
        git checkout dfdec43d0411076dc70591a0496a0824a8620695
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash M=drivers/gpu/drm

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/drm_atomic_uapi.c: In function 'complete_signaling':
   drivers/gpu/drm/drm_atomic_uapi.c:1193:26: warning: variable 'crtc' set but not used [-Wunused-but-set-variable]
    1193 |         struct drm_crtc *crtc;
         |                          ^~~~
   drivers/gpu/drm/drm_atomic_uapi.c: Assembler messages:
   drivers/gpu/drm/drm_atomic_uapi.c:1230: Error: unrecognized opcode `csrs sstatus,s7'
   drivers/gpu/drm/drm_atomic_uapi.c:1230: Error: unrecognized opcode `csrc sstatus,s7'
   drivers/gpu/drm/drm_atomic_uapi.c:1052: Error: unrecognized opcode `csrs sstatus,a3'
   drivers/gpu/drm/drm_atomic_uapi.c:1052: Error: unrecognized opcode `csrc sstatus,a3'
   drivers/gpu/drm/drm_atomic_uapi.c:466: Error: unrecognized opcode `csrs sstatus,a3'
   drivers/gpu/drm/drm_atomic_uapi.c:466: Error: unrecognized opcode `csrc sstatus,a3'
   drivers/gpu/drm/drm_atomic_uapi.c:366: Error: unrecognized opcode `csrs sstatus,a3'
   drivers/gpu/drm/drm_atomic_uapi.c:366: Error: unrecognized opcode `csrc sstatus,a3'
>> drivers/gpu/drm/drm_atomic_uapi.c:1297: Error: unrecognized opcode `csrs sstatus,s8'
>> drivers/gpu/drm/drm_atomic_uapi.c:1297: Error: unrecognized opcode `csrc sstatus,s8'
   drivers/gpu/drm/drm_atomic_uapi.c:1314: Error: unrecognized opcode `csrs sstatus,s8'
   drivers/gpu/drm/drm_atomic_uapi.c:1314: Error: unrecognized opcode `csrc sstatus,s8'
   drivers/gpu/drm/drm_atomic_uapi.c:1327: Error: unrecognized opcode `csrs sstatus,s4'
   drivers/gpu/drm/drm_atomic_uapi.c:1327: Error: unrecognized opcode `csrc sstatus,s4'


vim +1297 drivers/gpu/drm/drm_atomic_uapi.c

  1186	
  1187	static void complete_signaling(struct drm_device *dev,
  1188				       struct drm_atomic_state *state,
  1189				       struct drm_out_fence_state *fence_state,
  1190				       unsigned int num_fences,
  1191				       bool install_fds)
  1192	{
  1193		struct drm_crtc *crtc;
  1194		struct drm_crtc_state *crtc_state;
  1195		int i;
  1196	
  1197		if (install_fds) {
  1198			for (i = 0; i < num_fences; i++)
  1199				fd_install(fence_state[i].fd,
  1200					   fence_state[i].sync_file->file);
  1201	
  1202			kfree(fence_state);
  1203			return;
  1204		}
  1205	
  1206		for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
  1207			struct drm_pending_vblank_event *event = crtc_state->event;
  1208			/*
  1209			 * Free the allocated event. drm_atomic_helper_setup_commit
  1210			 * can allocate an event too, so only free it if it's ours
  1211			 * to prevent a double free in drm_atomic_state_clear.
  1212			 */
  1213			if (event && (event->base.fence || event->base.file_priv)) {
  1214				drm_event_cancel_free(dev, &event->base);
  1215				crtc_state->event = NULL;
  1216			}
  1217		}
  1218	
  1219		if (!fence_state)
  1220			return;
  1221	
  1222		for (i = 0; i < num_fences; i++) {
  1223			if (fence_state[i].sync_file)
  1224				fput(fence_state[i].sync_file->file);
  1225			if (fence_state[i].fd >= 0)
  1226				put_unused_fd(fence_state[i].fd);
  1227	
  1228			/* If this fails log error to the user */
  1229			if (fence_state[i].out_fence_ptr &&
> 1230			    put_user(-1, fence_state[i].out_fence_ptr))
  1231				DRM_DEBUG_ATOMIC("Couldn't clear out_fence_ptr\n");
  1232		}
  1233	
  1234		kfree(fence_state);
  1235	}
  1236	
  1237	int drm_mode_atomic_ioctl(struct drm_device *dev,
  1238				  void *data, struct drm_file *file_priv)
  1239	{
  1240		struct drm_mode_atomic *arg = data;
  1241		uint32_t __user *objs_ptr = (uint32_t __user *)(unsigned long)(arg->objs_ptr);
  1242		uint32_t __user *count_props_ptr = (uint32_t __user *)(unsigned long)(arg->count_props_ptr);
  1243		uint32_t __user *props_ptr = (uint32_t __user *)(unsigned long)(arg->props_ptr);
  1244		uint64_t __user *prop_values_ptr = (uint64_t __user *)(unsigned long)(arg->prop_values_ptr);
  1245		unsigned int copied_objs, copied_props;
  1246		struct drm_atomic_state *state;
  1247		struct drm_modeset_acquire_ctx ctx;
  1248		struct drm_out_fence_state *fence_state;
  1249		int ret = 0;
  1250		unsigned int i, j, num_fences;
  1251	
  1252		/* disallow for drivers not supporting atomic: */
  1253		if (!drm_core_check_feature(dev, DRIVER_ATOMIC))
  1254			return -EINVAL;
  1255	
  1256		/* disallow for userspace that has not enabled atomic cap (even
  1257		 * though this may be a bit overkill, since legacy userspace
  1258		 * wouldn't know how to call this ioctl)
  1259		 */
  1260		if (!file_priv->atomic)
  1261			return -EINVAL;
  1262	
  1263		if (arg->flags & ~DRM_MODE_ATOMIC_FLAGS)
  1264			return -EINVAL;
  1265	
  1266		if (arg->reserved)
  1267			return -EINVAL;
  1268	
  1269		if ((arg->flags & DRM_MODE_PAGE_FLIP_ASYNC) &&
  1270				!dev->mode_config.async_page_flip)
  1271			return -EINVAL;
  1272	
  1273		/* can't test and expect an event at the same time. */
  1274		if ((arg->flags & DRM_MODE_ATOMIC_TEST_ONLY) &&
  1275				(arg->flags & DRM_MODE_PAGE_FLIP_EVENT))
  1276			return -EINVAL;
  1277	
  1278		drm_modeset_acquire_init(&ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE);
  1279	
  1280		state = drm_atomic_state_alloc(dev);
  1281		if (!state)
  1282			return -ENOMEM;
  1283	
  1284		state->acquire_ctx = &ctx;
  1285		state->allow_modeset = !!(arg->flags & DRM_MODE_ATOMIC_ALLOW_MODESET);
  1286	
  1287	retry:
  1288		copied_objs = 0;
  1289		copied_props = 0;
  1290		fence_state = NULL;
  1291		num_fences = 0;
  1292	
  1293		for (i = 0; i < arg->count_objs; i++) {
  1294			uint32_t obj_id, count_props;
  1295			struct drm_mode_object *obj;
  1296	
> 1297			if (get_user(obj_id, objs_ptr + copied_objs)) {

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
