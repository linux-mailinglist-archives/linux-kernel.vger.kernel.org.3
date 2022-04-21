Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B9350A493
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390250AbiDUPrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241885AbiDUPrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:47:15 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039B64830F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650555865; x=1682091865;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ufRPfKF5jt4TF7zDaqnZ+J7Q8GBnzvU5he8jEm62DKg=;
  b=iQdynh1xVOmWfi4fRSOlIWvLqc3BTm0Xqolw9Tfhc9Jp8CiwMKrUsPPg
   xFhptAlQmCGWDwu/YqqQ/va1ISFUhXQ+MAjmHBSBYv7NojCvzRx150HYf
   IhzOBPI2kOrw5w9qc25Y3tvW4H6RT2wBY0XItjuzw/Tm0nXSeMJ6MjE7E
   VAlijsfU+bUAuwR9T6CYqaFSNDHdAl6d03GSe1YEtZdxCdYoybjrcdtAv
   s7VSbQW1C3CjZVTUZ4zsTvtl1jJukogy4AgSyNzdevyuJ2eBWYWWX7gGd
   XFxxOApTN6cCwMD98jyOT+Cm6OtecrgaugCOsMqDyw1eaLvhtByRyOwl/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="261994562"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="261994562"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 08:44:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="593714573"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 21 Apr 2022 08:44:23 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhYyk-0008Wx-Fq;
        Thu, 21 Apr 2022 15:44:22 +0000
Date:   Thu, 21 Apr 2022 23:43:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thierry Reding <treding@nvidia.com>
Subject: drivers/gpu/drm/tegra/dc.c:2223:38: warning: variable 'old_state'
 set but not used
Message-ID: <202204212356.rwOZkf1l-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b253435746d9a4a701b5f09211b9c14d3370d0da
commit: 04d5d5df9df79f9045e76404775fc8a084aac23d drm/tegra: dc: Support memory bandwidth management
date:   8 months ago
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220421/202204212356.rwOZkf1l-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=04d5d5df9df79f9045e76404775fc8a084aac23d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 04d5d5df9df79f9045e76404775fc8a084aac23d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/gpu/drm/tegra/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/tegra/dc.c: In function 'tegra_crtc_update_memory_bandwidth':
   drivers/gpu/drm/tegra/dc.c:1843:53: warning: variable 'new_dc_state' set but not used [-Wunused-but-set-variable]
    1843 |         const struct tegra_dc_state *old_dc_state, *new_dc_state;
         |                                                     ^~~~~~~~~~~~
   drivers/gpu/drm/tegra/dc.c:1843:38: warning: variable 'old_dc_state' set but not used [-Wunused-but-set-variable]
    1843 |         const struct tegra_dc_state *old_dc_state, *new_dc_state;
         |                                      ^~~~~~~~~~~~
   drivers/gpu/drm/tegra/dc.c: In function 'tegra_crtc_calculate_memory_bandwidth':
>> drivers/gpu/drm/tegra/dc.c:2223:38: warning: variable 'old_state' set but not used [-Wunused-but-set-variable]
    2223 |         const struct drm_crtc_state *old_state;
         |                                      ^~~~~~~~~


vim +/old_state +2223 drivers/gpu/drm/tegra/dc.c

  2213	
  2214	static int tegra_crtc_calculate_memory_bandwidth(struct drm_crtc *crtc,
  2215							 struct drm_atomic_state *state)
  2216	{
  2217		ulong overlap_mask[TEGRA_DC_LEGACY_PLANES_NUM] = {}, mask;
  2218		u32 plane_peak_bw[TEGRA_DC_LEGACY_PLANES_NUM] = {};
  2219		bool all_planes_overlap_simultaneously = true;
  2220		const struct tegra_plane_state *tegra_state;
  2221		const struct drm_plane_state *plane_state;
  2222		struct tegra_dc *dc = to_tegra_dc(crtc);
> 2223		const struct drm_crtc_state *old_state;
  2224		struct drm_crtc_state *new_state;
  2225		struct tegra_plane *tegra;
  2226		struct drm_plane *plane;
  2227	
  2228		/*
  2229		 * The nv-display uses shared planes.  The algorithm below assumes
  2230		 * maximum 3 planes per-CRTC, this assumption isn't applicable to
  2231		 * the nv-display.  Note that T124 support has additional windows,
  2232		 * but currently they aren't supported by the driver.
  2233		 */
  2234		if (dc->soc->has_nvdisplay)
  2235			return 0;
  2236	
  2237		new_state = drm_atomic_get_new_crtc_state(state, crtc);
  2238		old_state = drm_atomic_get_old_crtc_state(state, crtc);
  2239	
  2240		/*
  2241		 * For overlapping planes pixel's data is fetched for each plane at
  2242		 * the same time, hence bandwidths are accumulated in this case.
  2243		 * This needs to be taken into account for calculating total bandwidth
  2244		 * consumed by all planes.
  2245		 *
  2246		 * Here we get the overlapping state of each plane, which is a
  2247		 * bitmask of plane indices telling with what planes there is an
  2248		 * overlap. Note that bitmask[plane] includes BIT(plane) in order
  2249		 * to make further code nicer and simpler.
  2250		 */
  2251		drm_atomic_crtc_state_for_each_plane_state(plane, plane_state, new_state) {
  2252			tegra_state = to_const_tegra_plane_state(plane_state);
  2253			tegra = to_tegra_plane(plane);
  2254	
  2255			if (WARN_ON_ONCE(tegra->index >= TEGRA_DC_LEGACY_PLANES_NUM))
  2256				return -EINVAL;
  2257	
  2258			plane_peak_bw[tegra->index] = tegra_state->peak_memory_bandwidth;
  2259			mask = tegra_plane_overlap_mask(new_state, plane_state);
  2260			overlap_mask[tegra->index] = mask;
  2261	
  2262			if (hweight_long(mask) != 3)
  2263				all_planes_overlap_simultaneously = false;
  2264		}
  2265	
  2266		/*
  2267		 * Then we calculate maximum bandwidth of each plane state.
  2268		 * The bandwidth includes the plane BW + BW of the "simultaneously"
  2269		 * overlapping planes, where "simultaneously" means areas where DC
  2270		 * fetches from the planes simultaneously during of scan-out process.
  2271		 *
  2272		 * For example, if plane A overlaps with planes B and C, but B and C
  2273		 * don't overlap, then the peak bandwidth will be either in area where
  2274		 * A-and-B or A-and-C planes overlap.
  2275		 *
  2276		 * The plane_peak_bw[] contains peak memory bandwidth values of
  2277		 * each plane, this information is needed by interconnect provider
  2278		 * in order to set up latency allowance based on the peak BW, see
  2279		 * tegra_crtc_update_memory_bandwidth().
  2280		 */
  2281		drm_atomic_crtc_state_for_each_plane_state(plane, plane_state, new_state) {
  2282			u32 i, old_peak_bw, new_peak_bw, overlap_bw = 0;
  2283	
  2284			/*
  2285			 * Note that plane's atomic check doesn't touch the
  2286			 * total_peak_memory_bandwidth of enabled plane, hence the
  2287			 * current state contains the old bandwidth state from the
  2288			 * previous CRTC commit.
  2289			 */
  2290			tegra_state = to_const_tegra_plane_state(plane_state);
  2291			tegra = to_tegra_plane(plane);
  2292	
  2293			for_each_set_bit(i, &overlap_mask[tegra->index], 3) {
  2294				if (i == tegra->index)
  2295					continue;
  2296	
  2297				if (all_planes_overlap_simultaneously)
  2298					overlap_bw += plane_peak_bw[i];
  2299				else
  2300					overlap_bw = max(overlap_bw, plane_peak_bw[i]);
  2301			}
  2302	
  2303			new_peak_bw = plane_peak_bw[tegra->index] + overlap_bw;
  2304			old_peak_bw = tegra_state->total_peak_memory_bandwidth;
  2305	
  2306			/*
  2307			 * If plane's peak bandwidth changed (for example plane isn't
  2308			 * overlapped anymore) and plane isn't in the atomic state,
  2309			 * then add plane to the state in order to have the bandwidth
  2310			 * updated.
  2311			 */
  2312			if (old_peak_bw != new_peak_bw) {
  2313				struct tegra_plane_state *new_tegra_state;
  2314				struct drm_plane_state *new_plane_state;
  2315	
  2316				new_plane_state = drm_atomic_get_plane_state(state, plane);
  2317				if (IS_ERR(new_plane_state))
  2318					return PTR_ERR(new_plane_state);
  2319	
  2320				new_tegra_state = to_tegra_plane_state(new_plane_state);
  2321				new_tegra_state->total_peak_memory_bandwidth = new_peak_bw;
  2322			}
  2323		}
  2324	
  2325		return 0;
  2326	}
  2327	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
