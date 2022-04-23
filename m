Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF2150CDD7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 23:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237287AbiDWVuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 17:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235940AbiDWVuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 17:50:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5D249C97
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 14:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650750454; x=1682286454;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WqmeweBvpZl3zsfylxNwYeR5VyRpiEOJ4Vvt7yjXuhA=;
  b=YHyrD38BbzfnhEL5Ad/8a+HlA9B4oHf5q4P5GAcmK7WoWHPprvTRapNA
   2uQTEFpdGlcYQCSzKs4V+LSfMpmvsDMPiUuFue5X7gzoyPAp3u44JBk5D
   AR7bFBKSmSk7qW1PtfGNjP7ivyJxEZGe7v9UfjwON5vOZvaxM40lR754j
   kVZ8dE3GqbIHK7MkRV+I4+uXo6hRHXnTXSmF8X52MO+AEsMv/8c1MWeHj
   DZmy9ZiSzEhH3+Ibq0xgT1lkxkVT/b0/uaJzuW0m6J8OSpWPLjAq4Q9Du
   dfh3Hum84csvN6z5jp8kNsCljiL7W7Q6pfG9b2W83yqaLfa7B69wJfoQK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="246867006"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="246867006"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 14:47:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="674316817"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 23 Apr 2022 14:47:31 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1niNbH-0000Vp-8g;
        Sat, 23 Apr 2022 21:47:31 +0000
Date:   Sun, 24 Apr 2022 05:46:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Lyude Paul <lyude@redhat.com>,
        "Lin, Wayne" <Wayne.Lin@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:3602:32:
 warning: variable 'ret' set but not used
Message-ID: <202204240503.RZCZdjrQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   13bc32bad7059d6c5671e9d037e6e3ed001cc0f4
commit: d740e0bf8ed4c14ac6a616e2b31626bdcf417135 drm/amd/display: Add DP 2.0 MST DC Support
date:   6 months ago
config: powerpc64-randconfig-r033-20220420 (https://download.01.org/0day-ci/archive/20220424/202204240503.RZCZdjrQ-lkp@intel.com/config)
compiler: powerpc64le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d740e0bf8ed4c14ac6a616e2b31626bdcf417135
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d740e0bf8ed4c14ac6a616e2b31626bdcf417135
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/gpu/drm/amd/amdgpu/../display/dmub/dmub_srv.h:67,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:49:
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h: In function 'dmub_rb_flush_pending':
   drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2819:26: warning: variable 'temp' set but not used [-Wunused-but-set-variable]
    2819 |                 uint64_t temp;
         |                          ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c: In function 'dc_link_reduce_mst_payload':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:3602:32: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
    3602 |         enum act_return_status ret;
         |                                ^~~


vim +/ret +3602 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c

  3589	
  3590	#if defined(CONFIG_DRM_AMD_DC_DCN)
  3591	enum dc_status dc_link_reduce_mst_payload(struct pipe_ctx *pipe_ctx, uint32_t bw_in_kbps)
  3592	{
  3593		struct dc_stream_state *stream = pipe_ctx->stream;
  3594		struct dc_link *link = stream->link;
  3595		struct fixed31_32 avg_time_slots_per_mtp;
  3596		struct fixed31_32 pbn;
  3597		struct fixed31_32 pbn_per_slot;
  3598		struct link_encoder *link_encoder = link->link_enc;
  3599		struct stream_encoder *stream_encoder = pipe_ctx->stream_res.stream_enc;
  3600		struct dp_mst_stream_allocation_table proposed_table = {0};
  3601		uint8_t i;
> 3602		enum act_return_status ret;
  3603		DC_LOGGER_INIT(link->ctx->logger);
  3604	
  3605		/* decrease throttled vcp size */
  3606		pbn_per_slot = get_pbn_per_slot(stream);
  3607		pbn = get_pbn_from_bw_in_kbps(bw_in_kbps);
  3608		avg_time_slots_per_mtp = dc_fixpt_div(pbn, pbn_per_slot);
  3609	
  3610		stream_encoder->funcs->set_throttled_vcp_size(
  3611					stream_encoder,
  3612					avg_time_slots_per_mtp);
  3613	
  3614		/* send ALLOCATE_PAYLOAD sideband message with updated pbn */
  3615		dm_helpers_dp_mst_send_payload_allocation(
  3616				stream->ctx,
  3617				stream,
  3618				true);
  3619	
  3620		/* notify immediate branch device table update */
  3621		if (dm_helpers_dp_mst_write_payload_allocation_table(
  3622				stream->ctx,
  3623				stream,
  3624				&proposed_table,
  3625				true)) {
  3626			/* update mst stream allocation table software state */
  3627			update_mst_stream_alloc_table(
  3628					link,
  3629					pipe_ctx->stream_res.stream_enc,
  3630					pipe_ctx->stream_res.hpo_dp_stream_enc,
  3631					&proposed_table);
  3632		} else {
  3633			DC_LOG_WARNING("Failed to update"
  3634					"MST allocation table for"
  3635					"pipe idx:%d\n",
  3636					pipe_ctx->pipe_idx);
  3637		}
  3638	
  3639		DC_LOG_MST("%s  "
  3640				"stream_count: %d: \n ",
  3641				__func__,
  3642				link->mst_stream_alloc_table.stream_count);
  3643	
  3644		for (i = 0; i < MAX_CONTROLLER_NUM; i++) {
  3645			DC_LOG_MST("stream_enc[%d]: %p      "
  3646					"stream[%d].vcp_id: %d      "
  3647					"stream[%d].slot_count: %d\n",
  3648					i,
  3649					(void *) link->mst_stream_alloc_table.stream_allocations[i].stream_enc,
  3650					i,
  3651					link->mst_stream_alloc_table.stream_allocations[i].vcp_id,
  3652					i,
  3653					link->mst_stream_alloc_table.stream_allocations[i].slot_count);
  3654		}
  3655	
  3656		ASSERT(proposed_table.stream_count > 0);
  3657	
  3658		/* update mst stream allocation table hardware state */
  3659		link_encoder->funcs->update_mst_stream_allocation_table(
  3660				link_encoder,
  3661				&link->mst_stream_alloc_table);
  3662	
  3663		/* poll for immediate branch device ACT handled */
  3664		ret = dm_helpers_dp_mst_poll_for_allocation_change_trigger(
  3665				stream->ctx,
  3666				stream);
  3667	
  3668		return DC_OK;
  3669	}
  3670	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
