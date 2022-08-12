Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE37591732
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 00:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236667AbiHLWPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 18:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbiHLWPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 18:15:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DBFB56D2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 15:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660342501; x=1691878501;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=c+iWu2KBOSxQcGXLwHUUijeL9rMZ6j+Ot8fZK770gVw=;
  b=iRCN4cRcYSZ//qpjl2CkMXmPv2cf9BQbAdpVCzcChoP7H3mxug/0stWQ
   nPeAOh9R1FLgyCMlw/7GzOWGgfwvOxEZsqo7Jfqdl9S97HVH3Q2IN4ACQ
   ohK+1hnugZemWRCVljw2o9OAk+nh3Ge7suqlgzVD8F59fVRMgWE7j9OgN
   uel/uCVIJlATUGgrDcji+BrISl0gxaw8d2rFfIQ4lVXG26nhaJSmhiMfz
   2XYBtKoU/RCe4sdu4SF21UrRjx6EEFdvFuKHSXPfPREVsELtgOOVsoi6U
   QlRZWNxP7RLoBaNjAMz9PQrb4hRfTtP0dV8gkFkO/EOi+zsU+zveFl0sa
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="272091405"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="272091405"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 15:15:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="582243933"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 12 Aug 2022 15:14:58 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMcvh-00010D-2n;
        Fri, 12 Aug 2022 22:14:57 +0000
Date:   Sat, 13 Aug 2022 06:14:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Paul <seanpaul@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>
Subject: [jsarha:topic/cros-sof-v4.19 5045/6555]
 drivers/gpu/drm/drm_crtc.c:717: Error: unrecognized opcode `csrs sstatus,s2'
Message-ID: <202208130605.cW3nV4mk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jsarha/linux topic/cros-sof-v4.19
head:   d7a3e91d8d16d1ef8653deec5a1fffc4de034a0c
commit: 1552942d364e880ebdd4648addb8bc2af48aeb44 [5045/6555] FROMGIT: drm: Add DRM_MODESET_LOCK_BEGIN/END helpers
config: riscv-buildonly-randconfig-r002-20220812 (https://download.01.org/0day-ci/archive/20220813/202208130605.cW3nV4mk-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jsarha/linux/commit/1552942d364e880ebdd4648addb8bc2af48aeb44
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/cros-sof-v4.19
        git checkout 1552942d364e880ebdd4648addb8bc2af48aeb44
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash M=drivers/gpu/drm

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   include/asm-generic/bug.h:123:9: note: in expansion of macro 'if'
     123 |         if (unlikely(__ret_warn_on))                                    \
         |         ^~
   drivers/gpu/drm/drm_crtc.c:377:9: note: in expansion of macro 'WARN_ON'
     377 |         WARN_ON(crtc->state && !crtc->funcs->atomic_destroy_state);
         |         ^~~~~~~
   drivers/gpu/drm/drm_crtc.c: In function '__drm_mode_set_config_internal':
   include/linux/compiler.h:25:39: warning: ignoring attribute 'section ("_ftrace_annotated_branch")' because it conflicts with previous 'section ("_ftrace_branch")' [-Wattributes]
      25 |                         static struct ftrace_likely_data                \
         |                                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:69:30: note: in definition of macro '__trace_if'
      69 |                 ______r = !!(cond);                                     \
         |                              ^~~~
   include/asm-generic/bug.h:123:9: note: in expansion of macro 'if'
     123 |         if (unlikely(__ret_warn_on))                                    \
         |         ^~
   include/linux/compiler.h:48:26: note: in expansion of macro '__branch_check__'
      48 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:123:13: note: in expansion of macro 'unlikely'
     123 |         if (unlikely(__ret_warn_on))                                    \
         |             ^~~~~~~~
   drivers/gpu/drm/drm_crtc.c:467:9: note: in expansion of macro 'WARN_ON'
     467 |         WARN_ON(drm_drv_uses_atomic_modeset(crtc->dev));
         |         ^~~~~~~
   include/linux/compiler.h:64:25: note: previous declaration here
      64 |                         ______f = {                                     \
         |                         ^~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
      56 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   include/asm-generic/bug.h:123:9: note: in expansion of macro 'if'
     123 |         if (unlikely(__ret_warn_on))                                    \
         |         ^~
   drivers/gpu/drm/drm_crtc.c:467:9: note: in expansion of macro 'WARN_ON'
     467 |         WARN_ON(drm_drv_uses_atomic_modeset(crtc->dev));
         |         ^~~~~~~
   drivers/gpu/drm/drm_crtc.c: In function 'drm_mode_set_config_internal':
   include/linux/compiler.h:25:39: warning: ignoring attribute 'section ("_ftrace_annotated_branch")' because it conflicts with previous 'section ("_ftrace_branch")' [-Wattributes]
      25 |                         static struct ftrace_likely_data                \
         |                                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:69:30: note: in definition of macro '__trace_if'
      69 |                 ______r = !!(cond);                                     \
         |                              ^~~~
   include/asm-generic/bug.h:123:9: note: in expansion of macro 'if'
     123 |         if (unlikely(__ret_warn_on))                                    \
         |         ^~
   include/linux/compiler.h:48:26: note: in expansion of macro '__branch_check__'
      48 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/asm-generic/bug.h:123:13: note: in expansion of macro 'unlikely'
     123 |         if (unlikely(__ret_warn_on))                                    \
         |             ^~~~~~~~
   drivers/gpu/drm/drm_crtc.c:518:9: note: in expansion of macro 'WARN_ON'
     518 |         WARN_ON(drm_drv_uses_atomic_modeset(set->crtc->dev));
         |         ^~~~~~~
   include/linux/compiler.h:64:25: note: previous declaration here
      64 |                         ______f = {                                     \
         |                         ^~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
      56 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   include/asm-generic/bug.h:123:9: note: in expansion of macro 'if'
     123 |         if (unlikely(__ret_warn_on))                                    \
         |         ^~
   drivers/gpu/drm/drm_crtc.c:518:9: note: in expansion of macro 'WARN_ON'
     518 |         WARN_ON(drm_drv_uses_atomic_modeset(set->crtc->dev));
         |         ^~~~~~~
   drivers/gpu/drm/drm_crtc.c: In function 'drm_mode_setcrtc':
   include/linux/compiler.h:25:39: warning: ignoring attribute 'section ("_ftrace_annotated_branch")' because it conflicts with previous 'section ("_ftrace_branch")' [-Wattributes]
      25 |                         static struct ftrace_likely_data                \
         |                                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:69:30: note: in definition of macro '__trace_if'
      69 |                 ______r = !!(cond);                                     \
         |                              ^~~~
   drivers/gpu/drm/drm_crtc.c:717:25: note: in expansion of macro 'if'
     717 |                         if (get_user(out_id, &set_connectors_ptr[i])) {
         |                         ^~
   include/linux/compiler.h:45:26: note: in expansion of macro '__branch_check__'
      45 | #  define likely(x)     (__branch_check__(x, 1, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   arch/riscv/include/asm/uaccess.h:81:9: note: in expansion of macro 'likely'
      81 |         likely(__access_ok((unsigned long __force)(addr), (size)));     \
         |         ^~~~~~
   arch/riscv/include/asm/uaccess.h:261:9: note: in expansion of macro 'access_ok'
     261 |         access_ok(VERIFY_READ, __p, sizeof(*__p)) ?             \
         |         ^~~~~~~~~
   drivers/gpu/drm/drm_crtc.c:717:29: note: in expansion of macro 'get_user'
     717 |                         if (get_user(out_id, &set_connectors_ptr[i])) {
         |                             ^~~~~~~~
   include/linux/compiler.h:64:25: note: previous declaration here
      64 |                         ______f = {                                     \
         |                         ^~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
      56 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   drivers/gpu/drm/drm_crtc.c:717:25: note: in expansion of macro 'if'
     717 |                         if (get_user(out_id, &set_connectors_ptr[i])) {
         |                         ^~
   drivers/gpu/drm/drm_crtc.c: Assembler messages:
>> drivers/gpu/drm/drm_crtc.c:717: Error: unrecognized opcode `csrs sstatus,s2'
>> drivers/gpu/drm/drm_crtc.c:717: Error: unrecognized opcode `csrc sstatus,s2'


vim +717 drivers/gpu/drm/drm_crtc.c

c11e928360777b Damien Lespiau    2013-09-25  552  
f453ba0460742a Dave Airlie       2008-11-07  553  /**
f453ba0460742a Dave Airlie       2008-11-07  554   * drm_mode_setcrtc - set CRTC configuration
065a50ed3ef75c Daniel Vetter     2012-12-02  555   * @dev: drm device for the ioctl
065a50ed3ef75c Daniel Vetter     2012-12-02  556   * @data: data pointer for the ioctl
065a50ed3ef75c Daniel Vetter     2012-12-02  557   * @file_priv: drm file for the ioctl call
f453ba0460742a Dave Airlie       2008-11-07  558   *
f453ba0460742a Dave Airlie       2008-11-07  559   * Build a new CRTC configuration based on user request.
f453ba0460742a Dave Airlie       2008-11-07  560   *
f453ba0460742a Dave Airlie       2008-11-07  561   * Called by the user via ioctl.
f453ba0460742a Dave Airlie       2008-11-07  562   *
c8e32cc1219fc1 Daniel Vetter     2014-03-10  563   * Returns:
1a49863349929f Daniel Vetter     2014-11-19  564   * Zero on success, negative errno on failure.
f453ba0460742a Dave Airlie       2008-11-07  565   */
f453ba0460742a Dave Airlie       2008-11-07  566  int drm_mode_setcrtc(struct drm_device *dev, void *data,
f453ba0460742a Dave Airlie       2008-11-07  567  		     struct drm_file *file_priv)
f453ba0460742a Dave Airlie       2008-11-07  568  {
f453ba0460742a Dave Airlie       2008-11-07  569  	struct drm_mode_config *config = &dev->mode_config;
f453ba0460742a Dave Airlie       2008-11-07  570  	struct drm_mode_crtc *crtc_req = data;
6653cc8d3b8d1c Ville Syrjälä     2012-03-13  571  	struct drm_crtc *crtc;
64c32b490333c9 Ville Syrjälä     2018-03-22  572  	struct drm_plane *plane;
853e37394285fb Sean Paul         2018-11-29  573  	struct drm_connector **connector_set = NULL, *connector;
853e37394285fb Sean Paul         2018-11-29  574  	struct drm_framebuffer *fb = NULL;
853e37394285fb Sean Paul         2018-11-29  575  	struct drm_display_mode *mode = NULL;
f453ba0460742a Dave Airlie       2008-11-07  576  	struct drm_mode_set set;
f453ba0460742a Dave Airlie       2008-11-07  577  	uint32_t __user *set_connectors_ptr;
2ceb585a956c10 Daniel Vetter     2017-03-22  578  	struct drm_modeset_acquire_ctx ctx;
4a1b0714275796 Laurent Pinchart  2012-05-17  579  	int ret;
f453ba0460742a Dave Airlie       2008-11-07  580  	int i;
f453ba0460742a Dave Airlie       2008-11-07  581  
fb3b06c8a1fd1a Dave Airlie       2011-02-08  582  	if (!drm_core_check_feature(dev, DRIVER_MODESET))
e12a9fb249dd8e Chris Wilson      2018-09-13  583  		return -EOPNOTSUPP;
fb3b06c8a1fd1a Dave Airlie       2011-02-08  584  
01447e9f04ba1c Zhao Junwang      2015-07-07  585  	/*
01447e9f04ba1c Zhao Junwang      2015-07-07  586  	 * Universal plane src offsets are only 16.16, prevent havoc for
01447e9f04ba1c Zhao Junwang      2015-07-07  587  	 * drivers using universal plane code internally.
01447e9f04ba1c Zhao Junwang      2015-07-07  588  	 */
01447e9f04ba1c Zhao Junwang      2015-07-07  589  	if (crtc_req->x & 0xffff0000 || crtc_req->y & 0xffff0000)
1d97e9154821d5 Ville Syrjälä     2012-03-13  590  		return -ERANGE;
1d97e9154821d5 Ville Syrjälä     2012-03-13  591  
418da17214aca5 Keith Packard     2017-03-14  592  	crtc = drm_crtc_find(dev, file_priv, crtc_req->crtc_id);
a2b34e226ac9fb Rob Clark         2013-10-05  593  	if (!crtc) {
58367ed65f3012 Zhao Yakui        2009-07-20  594  		DRM_DEBUG_KMS("Unknown CRTC ID %d\n", crtc_req->crtc_id);
2ceb585a956c10 Daniel Vetter     2017-03-22  595  		return -ENOENT;
f453ba0460742a Dave Airlie       2008-11-07  596  	}
fa3ab4c2113c74 Ville Syrjälä     2015-12-08  597  	DRM_DEBUG_KMS("[CRTC:%d:%s]\n", crtc->base.id, crtc->name);
f453ba0460742a Dave Airlie       2008-11-07  598  
64c32b490333c9 Ville Syrjälä     2018-03-22  599  	plane = crtc->primary;
64c32b490333c9 Ville Syrjälä     2018-03-22  600  
53552d5df6694f Daniel Vetter     2017-04-06  601  	mutex_lock(&crtc->dev->mode_config.mutex);
1552942d364e88 Sean Paul         2018-11-29  602  	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx,
1552942d364e88 Sean Paul         2018-11-29  603  				   DRM_MODESET_ACQUIRE_INTERRUPTIBLE, ret);
bf2d5eb902e29d Ville Syrjälä     2018-03-22  604  
f453ba0460742a Dave Airlie       2008-11-07  605  	if (crtc_req->mode_valid) {
f453ba0460742a Dave Airlie       2008-11-07  606  		/* If we have a mode we need a framebuffer. */
f453ba0460742a Dave Airlie       2008-11-07  607  		/* If we pass -1, set the mode with the currently bound fb */
f453ba0460742a Dave Airlie       2008-11-07  608  		if (crtc_req->fb_id == -1) {
a36c027db57b6a Ville Syrjälä     2018-03-22  609  			struct drm_framebuffer *old_fb;
a36c027db57b6a Ville Syrjälä     2018-03-22  610  
a36c027db57b6a Ville Syrjälä     2018-03-22  611  			if (plane->state)
a36c027db57b6a Ville Syrjälä     2018-03-22  612  				old_fb = plane->state->fb;
a36c027db57b6a Ville Syrjälä     2018-03-22  613  			else
a36c027db57b6a Ville Syrjälä     2018-03-22  614  				old_fb = plane->fb;
a36c027db57b6a Ville Syrjälä     2018-03-22  615  
a36c027db57b6a Ville Syrjälä     2018-03-22  616  			if (!old_fb) {
6653cc8d3b8d1c Ville Syrjälä     2012-03-13  617  				DRM_DEBUG_KMS("CRTC doesn't have current FB\n");
6653cc8d3b8d1c Ville Syrjälä     2012-03-13  618  				ret = -EINVAL;
6653cc8d3b8d1c Ville Syrjälä     2012-03-13  619  				goto out;
f453ba0460742a Dave Airlie       2008-11-07  620  			}
bf2d5eb902e29d Ville Syrjälä     2018-03-22  621  
a36c027db57b6a Ville Syrjälä     2018-03-22  622  			fb = old_fb;
b0d1232589df55 Daniel Vetter     2012-12-11  623  			/* Make refcounting symmetric with the lookup path. */
a4a69da06bc11a Thierry Reding    2017-02-28  624  			drm_framebuffer_get(fb);
f453ba0460742a Dave Airlie       2008-11-07  625  		} else {
418da17214aca5 Keith Packard     2017-03-14  626  			fb = drm_framebuffer_lookup(dev, file_priv, crtc_req->fb_id);
786b99ed13223d Daniel Vetter     2012-12-02  627  			if (!fb) {
58367ed65f3012 Zhao Yakui        2009-07-20  628  				DRM_DEBUG_KMS("Unknown FB ID%d\n",
58367ed65f3012 Zhao Yakui        2009-07-20  629  						crtc_req->fb_id);
37c4e705fcc4ac Ville Syrjälä     2013-10-17  630  				ret = -ENOENT;
f453ba0460742a Dave Airlie       2008-11-07  631  				goto out;
f453ba0460742a Dave Airlie       2008-11-07  632  			}
f453ba0460742a Dave Airlie       2008-11-07  633  		}
f453ba0460742a Dave Airlie       2008-11-07  634  
f453ba0460742a Dave Airlie       2008-11-07  635  		mode = drm_mode_create(dev);
ee34ab5b01e6e7 Ville Syrjälä     2012-03-13  636  		if (!mode) {
ee34ab5b01e6e7 Ville Syrjälä     2012-03-13  637  			ret = -ENOMEM;
ee34ab5b01e6e7 Ville Syrjälä     2012-03-13  638  			goto out;
ee34ab5b01e6e7 Ville Syrjälä     2012-03-13  639  		}
ace5bf0e254b10 Ankit Nautiyal    2018-05-08  640  		if (!file_priv->aspect_ratio_allowed &&
ace5bf0e254b10 Ankit Nautiyal    2018-05-08  641  		    (crtc_req->mode.flags & DRM_MODE_FLAG_PIC_AR_MASK) != DRM_MODE_FLAG_PIC_AR_NONE) {
ace5bf0e254b10 Ankit Nautiyal    2018-05-08  642  			DRM_DEBUG_KMS("Unexpected aspect-ratio flag bits\n");
ace5bf0e254b10 Ankit Nautiyal    2018-05-08  643  			ret = -EINVAL;
ace5bf0e254b10 Ankit Nautiyal    2018-05-08  644  			goto out;
ace5bf0e254b10 Ankit Nautiyal    2018-05-08  645  		}
ace5bf0e254b10 Ankit Nautiyal    2018-05-08  646  
ee34ab5b01e6e7 Ville Syrjälä     2012-03-13  647  
75a655e0a26cf0 Ville Syrjälä     2017-11-14  648  		ret = drm_mode_convert_umode(dev, mode, &crtc_req->mode);
90367bf6e98352 Ville Syrjälä     2012-03-13  649  		if (ret) {
6ab0edf4e79c42 Ville Syrjälä     2018-06-11  650  			DRM_DEBUG_KMS("Invalid mode (ret=%d, status=%s)\n",
6ab0edf4e79c42 Ville Syrjälä     2018-06-11  651  				      ret, drm_get_mode_status_name(mode->status));
6ab0edf4e79c42 Ville Syrjälä     2018-06-11  652  			drm_mode_debug_printmodeline(mode);
90367bf6e98352 Ville Syrjälä     2012-03-13  653  			goto out;
90367bf6e98352 Ville Syrjälä     2012-03-13  654  		}
90367bf6e98352 Ville Syrjälä     2012-03-13  655  
7eb5f302bbe78b Laurent Pinchart  2015-03-09  656  		/*
7eb5f302bbe78b Laurent Pinchart  2015-03-09  657  		 * Check whether the primary plane supports the fb pixel format.
7eb5f302bbe78b Laurent Pinchart  2015-03-09  658  		 * Drivers not implementing the universal planes API use a
7eb5f302bbe78b Laurent Pinchart  2015-03-09  659  		 * default formats list provided by the DRM core which doesn't
7eb5f302bbe78b Laurent Pinchart  2015-03-09  660  		 * match real hardware capabilities. Skip the check in that
7eb5f302bbe78b Laurent Pinchart  2015-03-09  661  		 * case.
7eb5f302bbe78b Laurent Pinchart  2015-03-09  662  		 */
64c32b490333c9 Ville Syrjälä     2018-03-22  663  		if (!plane->format_default) {
64c32b490333c9 Ville Syrjälä     2018-03-22  664  			ret = drm_plane_check_pixel_format(plane,
23163a7d4b0324 Ville Syrjälä     2017-12-22  665  							   fb->format->format,
23163a7d4b0324 Ville Syrjälä     2017-12-22  666  							   fb->modifier);
7eb5f302bbe78b Laurent Pinchart  2015-03-09  667  			if (ret) {
b3c11ac267d461 Eric Engestrom    2016-11-12  668  				struct drm_format_name_buf format_name;
23163a7d4b0324 Ville Syrjälä     2017-12-22  669  				DRM_DEBUG_KMS("Invalid pixel format %s, modifier 0x%llx\n",
438b74a5497c36 Ville Syrjälä     2016-12-14  670  					      drm_get_format_name(fb->format->format,
23163a7d4b0324 Ville Syrjälä     2017-12-22  671  								  &format_name),
23163a7d4b0324 Ville Syrjälä     2017-12-22  672  					      fb->modifier);
7eb5f302bbe78b Laurent Pinchart  2015-03-09  673  				goto out;
7eb5f302bbe78b Laurent Pinchart  2015-03-09  674  			}
7eb5f302bbe78b Laurent Pinchart  2015-03-09  675  		}
7eb5f302bbe78b Laurent Pinchart  2015-03-09  676  
c11e928360777b Damien Lespiau    2013-09-25  677  		ret = drm_crtc_check_viewport(crtc, crtc_req->x, crtc_req->y,
c11e928360777b Damien Lespiau    2013-09-25  678  					      mode, fb);
c11e928360777b Damien Lespiau    2013-09-25  679  		if (ret)
5f61bb421f0102 Ville Syrjälä     2012-03-13  680  			goto out;
c11e928360777b Damien Lespiau    2013-09-25  681  
f453ba0460742a Dave Airlie       2008-11-07  682  	}
f453ba0460742a Dave Airlie       2008-11-07  683  
f453ba0460742a Dave Airlie       2008-11-07  684  	if (crtc_req->count_connectors == 0 && mode) {
58367ed65f3012 Zhao Yakui        2009-07-20  685  		DRM_DEBUG_KMS("Count connectors is 0 but mode set\n");
f453ba0460742a Dave Airlie       2008-11-07  686  		ret = -EINVAL;
f453ba0460742a Dave Airlie       2008-11-07  687  		goto out;
f453ba0460742a Dave Airlie       2008-11-07  688  	}
f453ba0460742a Dave Airlie       2008-11-07  689  
7781de74568bdd Jakob Bornecrantz 2009-08-03  690  	if (crtc_req->count_connectors > 0 && (!mode || !fb)) {
58367ed65f3012 Zhao Yakui        2009-07-20  691  		DRM_DEBUG_KMS("Count connectors is %d but no mode or fb set\n",
f453ba0460742a Dave Airlie       2008-11-07  692  			  crtc_req->count_connectors);
f453ba0460742a Dave Airlie       2008-11-07  693  		ret = -EINVAL;
f453ba0460742a Dave Airlie       2008-11-07  694  		goto out;
f453ba0460742a Dave Airlie       2008-11-07  695  	}
f453ba0460742a Dave Airlie       2008-11-07  696  
f453ba0460742a Dave Airlie       2008-11-07  697  	if (crtc_req->count_connectors > 0) {
f453ba0460742a Dave Airlie       2008-11-07  698  		u32 out_id;
f453ba0460742a Dave Airlie       2008-11-07  699  
f453ba0460742a Dave Airlie       2008-11-07  700  		/* Avoid unbounded kernel memory allocation */
f453ba0460742a Dave Airlie       2008-11-07  701  		if (crtc_req->count_connectors > config->num_connector) {
f453ba0460742a Dave Airlie       2008-11-07  702  			ret = -EINVAL;
f453ba0460742a Dave Airlie       2008-11-07  703  			goto out;
f453ba0460742a Dave Airlie       2008-11-07  704  		}
f453ba0460742a Dave Airlie       2008-11-07  705  
2f6c538924108f Thierry Reding    2014-12-10  706  		connector_set = kmalloc_array(crtc_req->count_connectors,
f453ba0460742a Dave Airlie       2008-11-07  707  					      sizeof(struct drm_connector *),
f453ba0460742a Dave Airlie       2008-11-07  708  					      GFP_KERNEL);
f453ba0460742a Dave Airlie       2008-11-07  709  		if (!connector_set) {
f453ba0460742a Dave Airlie       2008-11-07  710  			ret = -ENOMEM;
f453ba0460742a Dave Airlie       2008-11-07  711  			goto out;
f453ba0460742a Dave Airlie       2008-11-07  712  		}
f453ba0460742a Dave Airlie       2008-11-07  713  
f453ba0460742a Dave Airlie       2008-11-07  714  		for (i = 0; i < crtc_req->count_connectors; i++) {
b164d31f50b292 Dave Airlie       2016-04-27  715  			connector_set[i] = NULL;
81f6c7f873a693 Ville Syrjälä     2011-12-20  716  			set_connectors_ptr = (uint32_t __user *)(unsigned long)crtc_req->set_connectors_ptr;
f453ba0460742a Dave Airlie       2008-11-07 @717  			if (get_user(out_id, &set_connectors_ptr[i])) {
f453ba0460742a Dave Airlie       2008-11-07  718  				ret = -EFAULT;
f453ba0460742a Dave Airlie       2008-11-07  719  				goto out;
f453ba0460742a Dave Airlie       2008-11-07  720  			}
f453ba0460742a Dave Airlie       2008-11-07  721  
418da17214aca5 Keith Packard     2017-03-14  722  			connector = drm_connector_lookup(dev, file_priv, out_id);
a2b34e226ac9fb Rob Clark         2013-10-05  723  			if (!connector) {
58367ed65f3012 Zhao Yakui        2009-07-20  724  				DRM_DEBUG_KMS("Connector id %d unknown\n",
58367ed65f3012 Zhao Yakui        2009-07-20  725  						out_id);
f27657f2ea7ffc Ville Syrjälä     2013-10-17  726  				ret = -ENOENT;
f453ba0460742a Dave Airlie       2008-11-07  727  				goto out;
f453ba0460742a Dave Airlie       2008-11-07  728  			}
9440106b460ddf Jerome Glisse     2010-07-15  729  			DRM_DEBUG_KMS("[CONNECTOR:%d:%s]\n",
9440106b460ddf Jerome Glisse     2010-07-15  730  					connector->base.id,
259338205c4284 Jani Nikula       2014-06-03  731  					connector->name);
f453ba0460742a Dave Airlie       2008-11-07  732  
f453ba0460742a Dave Airlie       2008-11-07  733  			connector_set[i] = connector;
f453ba0460742a Dave Airlie       2008-11-07  734  		}
f453ba0460742a Dave Airlie       2008-11-07  735  	}
f453ba0460742a Dave Airlie       2008-11-07  736  
f453ba0460742a Dave Airlie       2008-11-07  737  	set.crtc = crtc;
f453ba0460742a Dave Airlie       2008-11-07  738  	set.x = crtc_req->x;
f453ba0460742a Dave Airlie       2008-11-07  739  	set.y = crtc_req->y;
f453ba0460742a Dave Airlie       2008-11-07  740  	set.mode = mode;
f453ba0460742a Dave Airlie       2008-11-07  741  	set.connectors = connector_set;
f453ba0460742a Dave Airlie       2008-11-07  742  	set.num_connectors = crtc_req->count_connectors;
f453ba0460742a Dave Airlie       2008-11-07  743  	set.fb = fb;
69a8a1961c7bf5 Ville Syrjälä     2018-07-05  744  
69a8a1961c7bf5 Ville Syrjälä     2018-07-05  745  	if (drm_drv_uses_atomic_modeset(dev))
69a8a1961c7bf5 Ville Syrjälä     2018-07-05  746  		ret = crtc->funcs->set_config(&set, &ctx);
69a8a1961c7bf5 Ville Syrjälä     2018-07-05  747  	else
2ceb585a956c10 Daniel Vetter     2017-03-22  748  		ret = __drm_mode_set_config_internal(&set, &ctx);
f453ba0460742a Dave Airlie       2008-11-07  749  
f453ba0460742a Dave Airlie       2008-11-07  750  out:
b0d1232589df55 Daniel Vetter     2012-12-11  751  	if (fb)
a4a69da06bc11a Thierry Reding    2017-02-28  752  		drm_framebuffer_put(fb);
b0d1232589df55 Daniel Vetter     2012-12-11  753  
b164d31f50b292 Dave Airlie       2016-04-27  754  	if (connector_set) {
b164d31f50b292 Dave Airlie       2016-04-27  755  		for (i = 0; i < crtc_req->count_connectors; i++) {
b164d31f50b292 Dave Airlie       2016-04-27  756  			if (connector_set[i])
ad09360750afa1 Thierry Reding    2017-02-28  757  				drm_connector_put(connector_set[i]);
b164d31f50b292 Dave Airlie       2016-04-27  758  		}
b164d31f50b292 Dave Airlie       2016-04-27  759  	}
f453ba0460742a Dave Airlie       2008-11-07  760  	kfree(connector_set);
ee34ab5b01e6e7 Ville Syrjälä     2012-03-13  761  	drm_mode_destroy(dev, mode);
853e37394285fb Sean Paul         2018-11-29  762  
853e37394285fb Sean Paul         2018-11-29  763  	/* In case we need to retry... */
853e37394285fb Sean Paul         2018-11-29  764  	connector_set = NULL;
853e37394285fb Sean Paul         2018-11-29  765  	fb = NULL;
853e37394285fb Sean Paul         2018-11-29  766  	mode = NULL;
853e37394285fb Sean Paul         2018-11-29  767  
1552942d364e88 Sean Paul         2018-11-29  768  	DRM_MODESET_LOCK_ALL_END(ctx, ret);
53552d5df6694f Daniel Vetter     2017-04-06  769  	mutex_unlock(&crtc->dev->mode_config.mutex);
2ceb585a956c10 Daniel Vetter     2017-03-22  770  
f453ba0460742a Dave Airlie       2008-11-07  771  	return ret;
f453ba0460742a Dave Airlie       2008-11-07  772  }
f453ba0460742a Dave Airlie       2008-11-07  773  

:::::: The code at line 717 was first introduced by commit
:::::: f453ba0460742ad027ae0c4c7d61e62817b3e7ef DRM: add mode setting support

:::::: TO: Dave Airlie <airlied@redhat.com>
:::::: CC: Dave Airlie <airlied@linux.ie>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
