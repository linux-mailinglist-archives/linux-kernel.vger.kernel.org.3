Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B910E53F3E9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 04:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235847AbiFGC3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 22:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbiFGC3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 22:29:42 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F398A32D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 19:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654568981; x=1686104981;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=v5oXcANHyW89S52EIMm3FhyHqq8xqZN2FZuxdjut53o=;
  b=H8+WEODbnpk3jhUv/W/eIpk1YbC92syAcdSOvcVRis/YrDeusFwl/VLv
   oYqrs08AJjvlnK/eevTmuy+yfOgtwza8owv/sw7Rk8kC0mk6L254H8xbl
   uBoBjnTu2xZBigDzlz8zSWgYlFYjktOOZU1oxfDf1/UvL1FPnjdlkcI2n
   AiE4Pt2atRTqdLbFWZP4mv/YKeMhD9EZXkL5GBsx1Z9gbmmsQBe3eTOCY
   0Gq0XWxSOhYjqH3gTSr3SsfHdLtbQI47O/RKktMT/DgMF+w38wOg6ZEtc
   aRHOSJsHYi+PgnU2x6IE4W4RCb+ULT6SZ0xDL9QqXuLoDZzP2WkdLUc5Q
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="275479029"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="275479029"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 19:29:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="532419121"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 06 Jun 2022 19:29:38 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyOyP-000DG3-Kw;
        Tue, 07 Jun 2022 02:29:37 +0000
Date:   Tue, 7 Jun 2022 10:28:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: drivers/gpu/drm/drm_atomic.c:1670:33: error: variable 'obj' set but
 not used
Message-ID: <202206071049.pofHsRih-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e71e60cd74df9386c3f684c54888f2367050b831
commit: 97a1f01b3f2f734bd3982aa5639b2b54632f8f7d drm/atomic: Add atomic_print_state to private objects
date:   10 weeks ago
config: x86_64-sof-customedconfig-mach-driver-defconfig (https://download.01.org/0day-ci/archive/20220607/202206071049.pofHsRih-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=97a1f01b3f2f734bd3982aa5639b2b54632f8f7d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 97a1f01b3f2f734bd3982aa5639b2b54632f8f7d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/drm_atomic.c: In function 'drm_atomic_print_new_state':
>> drivers/gpu/drm/drm_atomic.c:1670:33: error: variable 'obj' set but not used [-Werror=unused-but-set-variable]
    1670 |         struct drm_private_obj *obj;
         |                                 ^~~
   cc1: all warnings being treated as errors


vim +/obj +1670 drivers/gpu/drm/drm_atomic.c

  1649	
  1650	/**
  1651	 * drm_atomic_print_new_state - prints drm atomic state
  1652	 * @state: atomic configuration to check
  1653	 * @p: drm printer
  1654	 *
  1655	 * This functions prints the drm atomic state snapshot using the drm printer
  1656	 * which is passed to it. This snapshot can be used for debugging purposes.
  1657	 *
  1658	 * Note that this function looks into the new state objects and hence its not
  1659	 * safe to be used after the call to drm_atomic_helper_commit_hw_done().
  1660	 */
  1661	void drm_atomic_print_new_state(const struct drm_atomic_state *state,
  1662			struct drm_printer *p)
  1663	{
  1664		struct drm_plane *plane;
  1665		struct drm_plane_state *plane_state;
  1666		struct drm_crtc *crtc;
  1667		struct drm_crtc_state *crtc_state;
  1668		struct drm_connector *connector;
  1669		struct drm_connector_state *connector_state;
> 1670		struct drm_private_obj *obj;
  1671		struct drm_private_state *obj_state;
  1672		int i;
  1673	
  1674		if (!p) {
  1675			drm_err(state->dev, "invalid drm printer\n");
  1676			return;
  1677		}
  1678	
  1679		drm_dbg_atomic(state->dev, "checking %p\n", state);
  1680	
  1681		for_each_new_plane_in_state(state, plane, plane_state, i)
  1682			drm_atomic_plane_print_state(p, plane_state);
  1683	
  1684		for_each_new_crtc_in_state(state, crtc, crtc_state, i)
  1685			drm_atomic_crtc_print_state(p, crtc_state);
  1686	
  1687		for_each_new_connector_in_state(state, connector, connector_state, i)
  1688			drm_atomic_connector_print_state(p, connector_state);
  1689	
  1690		for_each_new_private_obj_in_state(state, obj, obj_state, i)
  1691			drm_atomic_private_obj_print_state(p, obj_state);
  1692	}
  1693	EXPORT_SYMBOL(drm_atomic_print_new_state);
  1694	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
