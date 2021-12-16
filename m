Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E51477FF4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 23:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbhLPWR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 17:17:28 -0500
Received: from mga11.intel.com ([192.55.52.93]:62726 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230340AbhLPWR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 17:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639693047; x=1671229047;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BYUu5ZKrH1J8ckToMDzhagj3swX7tjhJ3VHu0z+m1RA=;
  b=KCcnuFwfcCYz6xB11aYjs30zBoN7tfpwQcNMazy+tTNgg2QREwhIy04p
   2XcfRI08wou64iVZcZDj8Vx8u/LJ4INodAIysZ1Z2n2HuFCYJ6XbRYBBC
   S02jFArN7tPwSVbeUAeY4MJKBmW2VOQiSGhPXIbF5jiZWkl2tpXv9cAH4
   n3nmAqxUt6fmJS4y3PL6xyz8Y12aa1szTS21pF2T+El9RtxoZlmA0wjP0
   7oLplXyn99DkAL6CIMrv7dGqnW1U2hlIonhWha8b9AlU9/u1PHIfR5A8g
   GETbNygtyHvTRGzFhsXq58KjKUJGU+d/aHedqMaFJc42dZZxs7PGDsYXW
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="237157669"
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="237157669"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 14:17:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,212,1635231600"; 
   d="scan'208";a="615334846"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 16 Dec 2021 14:17:25 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxz40-0003so-RB; Thu, 16 Dec 2021 22:17:24 +0000
Date:   Fri, 17 Dec 2021 06:16:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vladimir Stempen <vladimir.stempen@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:2005
 dcn10_align_pixel_clocks() warn: inconsistent indenting
Message-ID: <202112170643.aEpVHFk9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fa36bbe6d43f3bbce1f10a187e153587c7584d83
commit: 77a2b7265f20ee827e527eaa6f82b87e88388947 drm/amd/display: Synchronize displays with different timings
date:   10 months ago
config: x86_64-randconfig-m001-20211207 (https://download.01.org/0day-ci/archive/20211217/202112170643.aEpVHFk9-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:2005 dcn10_align_pixel_clocks() warn: inconsistent indenting
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:2050 dcn10_enable_vblanks_synchronization() warn: if statement not indented
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:2058 dcn10_enable_vblanks_synchronization() warn: inconsistent indenting

Old smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:1449 dcn10_init_hw() error: we previously assumed 'dc->clk_mgr' could be null (see line 1276)
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:1691 dcn10_set_output_transfer_func() warn: variable dereferenced before check 'stream' (see line 1674)
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:3433 dcn10_update_pending_status() warn: variable dereferenced before check 'plane_state' (see line 3431)
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:3923 dcn10_set_clock() error: we previously assumed 'dc->clk_mgr' could be null (see line 3919)
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:3943 dcn10_set_clock() warn: variable dereferenced before check 'dc->clk_mgr' (see line 3923)

vim +2005 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c

  1928	
  1929	int dcn10_align_pixel_clocks(
  1930		struct dc *dc,
  1931		int group_size,
  1932		struct pipe_ctx *grouped_pipes[])
  1933	{
  1934		struct dc_context *dc_ctx = dc->ctx;
  1935		int i, master = -1, embedded = -1;
  1936		struct dc_crtc_timing hw_crtc_timing[MAX_PIPES] = {0};
  1937		uint64_t phase[MAX_PIPES];
  1938		uint64_t modulo[MAX_PIPES];
  1939		unsigned int pclk;
  1940	
  1941		uint32_t embedded_pix_clk_100hz;
  1942		uint16_t embedded_h_total;
  1943		uint16_t embedded_v_total;
  1944		bool clamshell_closed = false;
  1945		uint32_t dp_ref_clk_100hz =
  1946			dc->res_pool->dp_clock_source->ctx->dc->clk_mgr->dprefclk_khz*10;
  1947	
  1948		if (dc->config.vblank_alignment_dto_params &&
  1949			dc->res_pool->dp_clock_source->funcs->override_dp_pix_clk) {
  1950			clamshell_closed =
  1951				(dc->config.vblank_alignment_dto_params >> 63);
  1952			embedded_h_total =
  1953				(dc->config.vblank_alignment_dto_params >> 32) & 0x7FFF;
  1954			embedded_v_total =
  1955				(dc->config.vblank_alignment_dto_params >> 48) & 0x7FFF;
  1956			embedded_pix_clk_100hz =
  1957				dc->config.vblank_alignment_dto_params & 0xFFFFFFFF;
  1958	
  1959			for (i = 0; i < group_size; i++) {
  1960				grouped_pipes[i]->stream_res.tg->funcs->get_hw_timing(
  1961						grouped_pipes[i]->stream_res.tg,
  1962						&hw_crtc_timing[i]);
  1963				dc->res_pool->dp_clock_source->funcs->get_pixel_clk_frequency_100hz(
  1964					dc->res_pool->dp_clock_source,
  1965					grouped_pipes[i]->stream_res.tg->inst,
  1966					&pclk);
  1967				hw_crtc_timing[i].pix_clk_100hz = pclk;
  1968				if (dc_is_embedded_signal(
  1969						grouped_pipes[i]->stream->signal)) {
  1970					embedded = i;
  1971					master = i;
  1972					phase[i] = embedded_pix_clk_100hz*100;
  1973					modulo[i] = dp_ref_clk_100hz*100;
  1974				} else {
  1975	
  1976					phase[i] = (uint64_t)embedded_pix_clk_100hz*
  1977						hw_crtc_timing[i].h_total*
  1978						hw_crtc_timing[i].v_total/
  1979						get_clock_divider(grouped_pipes[i], true);
  1980					modulo[i] = (uint64_t)dp_ref_clk_100hz*
  1981						embedded_h_total*
  1982						embedded_v_total;
  1983	
  1984					if (reduceSizeAndFraction(&phase[i],
  1985							&modulo[i], true) == false) {
  1986						/*
  1987						 * this will help to stop reporting
  1988						 * this timing synchronizable
  1989						 */
  1990						DC_SYNC_INFO("Failed to reduce DTO parameters\n");
  1991						grouped_pipes[i]->stream->has_non_synchronizable_pclk = true;
  1992					}
  1993				}
  1994			}
  1995	
  1996			for (i = 0; i < group_size; i++) {
  1997				if (i != embedded && !grouped_pipes[i]->stream->has_non_synchronizable_pclk) {
  1998					dc->res_pool->dp_clock_source->funcs->override_dp_pix_clk(
  1999						dc->res_pool->dp_clock_source,
  2000						grouped_pipes[i]->stream_res.tg->inst,
  2001						phase[i], modulo[i]);
  2002					dc->res_pool->dp_clock_source->funcs->get_pixel_clk_frequency_100hz(
  2003						dc->res_pool->dp_clock_source,
  2004						grouped_pipes[i]->stream_res.tg->inst, &pclk);
> 2005						grouped_pipes[i]->stream->timing.pix_clk_100hz =
  2006							pclk*get_clock_divider(grouped_pipes[i], false);
  2007					if (master == -1)
  2008						master = i;
  2009				}
  2010			}
  2011	
  2012		}
  2013		return master;
  2014	}
  2015	
  2016	void dcn10_enable_vblanks_synchronization(
  2017		struct dc *dc,
  2018		int group_index,
  2019		int group_size,
  2020		struct pipe_ctx *grouped_pipes[])
  2021	{
  2022		struct dc_context *dc_ctx = dc->ctx;
  2023		struct output_pixel_processor *opp;
  2024		struct timing_generator *tg;
  2025		int i, width, height, master;
  2026	
  2027		for (i = 1; i < group_size; i++) {
  2028			opp = grouped_pipes[i]->stream_res.opp;
  2029			tg = grouped_pipes[i]->stream_res.tg;
  2030			tg->funcs->get_otg_active_size(tg, &width, &height);
  2031			if (opp->funcs->opp_program_dpg_dimensions)
  2032				opp->funcs->opp_program_dpg_dimensions(opp, width, 2*(height) + 1);
  2033		}
  2034	
  2035		for (i = 0; i < group_size; i++) {
  2036			if (grouped_pipes[i]->stream == NULL)
  2037				continue;
  2038			grouped_pipes[i]->stream->vblank_synchronized = false;
  2039			grouped_pipes[i]->stream->has_non_synchronizable_pclk = false;
  2040		}
  2041	
  2042		DC_SYNC_INFO("Aligning DP DTOs\n");
  2043	
  2044		master = dcn10_align_pixel_clocks(dc, group_size, grouped_pipes);
  2045	
  2046		DC_SYNC_INFO("Synchronizing VBlanks\n");
  2047	
  2048		if (master >= 0) {
  2049			for (i = 0; i < group_size; i++) {
> 2050				if (i != master && !grouped_pipes[i]->stream->has_non_synchronizable_pclk)
  2051				grouped_pipes[i]->stream_res.tg->funcs->align_vblanks(
  2052					grouped_pipes[master]->stream_res.tg,
  2053					grouped_pipes[i]->stream_res.tg,
  2054					grouped_pipes[master]->stream->timing.pix_clk_100hz,
  2055					grouped_pipes[i]->stream->timing.pix_clk_100hz,
  2056					get_clock_divider(grouped_pipes[master], false),
  2057					get_clock_divider(grouped_pipes[i], false));
> 2058					grouped_pipes[i]->stream->vblank_synchronized = true;
  2059			}
  2060			grouped_pipes[master]->stream->vblank_synchronized = true;
  2061			DC_SYNC_INFO("Sync complete\n");
  2062		}
  2063	
  2064		for (i = 1; i < group_size; i++) {
  2065			opp = grouped_pipes[i]->stream_res.opp;
  2066			tg = grouped_pipes[i]->stream_res.tg;
  2067			tg->funcs->get_otg_active_size(tg, &width, &height);
  2068			if (opp->funcs->opp_program_dpg_dimensions)
  2069				opp->funcs->opp_program_dpg_dimensions(opp, width, height);
  2070		}
  2071	}
  2072	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
