Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB825908A8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 00:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbiHKWOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 18:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbiHKWOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 18:14:16 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4C0A0335;
        Thu, 11 Aug 2022 15:14:11 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M3h0t6fVpz4wgv;
        Fri, 12 Aug 2022 08:14:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1660256047;
        bh=m6KjgOzbDaQ/Q0LqxhKfLlU33XvnbTQigjVbzGxvAFc=;
        h=Date:From:To:Cc:Subject:From;
        b=GiV4fiXbYNJT7ByiAMgmHAyx+yQ3SjVEl6tnZUWoXTT0qJHi9ZpuiUcJfGeYFuXnM
         iIXBm1lTBeB0uERNx1sjb4F6guFk5+hroZRmsiL14b72bUsPjRkFUCJUczPvx1BOSs
         D6QWRwDkDP8xJX6fdANNWeqgJ9x3b8UM7yMJ0WMKv8Jr5ziswK1BD0frkgahMTuhT7
         CsGKYT04ikgAqb8rJ8458DcmKSFJUrPJ5IG7/AVP5ry6GdEEz4g596XPZoFjlgdPJe
         I3LqRX1lrcv8zfg9L8Oepg6HILYrY/CSOQiqK8sEMOwBZhsOxcAe3/K+fyBDqmME4x
         Wj74QKN64H2bA==
Date:   Fri, 12 Aug 2022 08:13:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the amdgpu tree
Message-ID: <20220812081245.380c375f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/C4H4alhtg7UI0g=K7.saxGF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/C4H4alhtg7UI0g=K7.saxGF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (htmldocs)
produced this warning:

drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'always_scale' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'always_use_regamma' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'aux_wake_wa' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'avoid_vbios_exec_table' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'az_endpoint_mute_only' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'bandwidth_calcs_trace' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'bw_val_profile' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'clock_trace' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'cm_in_bypass' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'crb_alloc_policy' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'crb_alloc_policy_min_disp_count' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'disable_48mhz_pwrdwn' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'disable_clock_gate' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'disable_dcc' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'disable_dfs_bypass' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'disable_dmcu' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'disable_dpp_power_gate' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'disable_dram_clock_change_vactive_support' not described in 'dc_debug_=
options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'disable_dsc' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'disable_dsc_edp' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'disable_dsc_power_gate' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'disable_dtb_ref_clk_switch' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'disable_fams' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'disable_fec' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'disable_fixed_vs_aux_timeout_wa' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'disable_hubp_power_gate' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'disable_idle_power_optimizations' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'disable_mem_low_power' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'disable_min_fclk' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'disable_pplib_clock_request' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'disable_pplib_wm_range' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'disable_psr' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'disable_stereo_support' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'disable_stutter' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'disable_timing_sync' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'disable_uhbr' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'disable_z10' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'disable_z9_mpc' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'dmcub_emulation' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'dml_disallow_alternate_prefetch_modes' not described in 'dc_debug_opti=
ons'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'dml_hostvm_override' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'dmub_command_table' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'dmub_offload_enabled' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'dpia_debug' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'dram_clock_change_latency_ns' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'dsc_bpp_increment_div' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'dsc_min_slice_height_override' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'dwb_fi_phase' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'edid_read_retry_times' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'enable_dmcub_surface_flip' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'enable_dmub_aux_for_legacy_ddc' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'enable_dp_dig_pixel_rate_div_policy' not described in 'dc_debug_option=
s'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'enable_dram_clock_change_one_display_vactive' not described in 'dc_deb=
ug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'enable_driver_sequence_debug' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'enable_mem_low_power' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'enable_single_display_2to1_odm_policy' not described in 'dc_debug_opti=
ons'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'enable_sw_cntl_psr' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'enable_tri_buf' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'enable_z9_disable_interface' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'exit_idle_opt_for_cursor_updates' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'extended_blank_optimization' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'fec_enable_delay_in100us' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'fixed_vs_aux_delay_config_wa' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'force_abm_enable' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'force_clock_mode' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'force_disable_subvp' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'force_dp2_lt_fallback_method' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'force_dsc_edp_policy' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'force_fclk_khz' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'force_min_dcfclk_mhz' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'force_odm_combine' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'force_odm_combine_4to1' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'force_single_disp_pipe_split' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'force_subvp_mclk_switch' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'force_usr_allow' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'force_vblank_alignment' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'hdmi20_disable' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'hpo_optimization' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'ignore_cable_id' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'legacy_dp2_lt' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'mall_additional_timer_percent' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'mall_error_as_fatal' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'mall_size_override' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'max_disp_clk' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'max_downscale_src_width' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'min_disp_clk_khz' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'min_dpp_clk_khz' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'min_dram_clk_khz' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'mst_start_top_delay' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'native422_support' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'optimize_edp_link_rate' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'optimized_watermark' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'percent_of_ideal_drambw' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'performance_trace' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'pplib_wm_report_mode' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'psr_power_use_phy_fsm' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'pstate_enabled' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'recovery_enabled' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'root_clock_optimization' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'sanity_checks' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'scl_reset_length10' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'seamless_boot_odm_combine' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'set_mst_en_for_sst' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'skip_detection_link_training' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'sr_enter_plus_exit_time_dpm0_ns' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'sr_enter_plus_exit_time_ns' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'sr_exit_time_dpm0_ns' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'sr_exit_time_ns' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'surface_trace' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'timing_trace' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'underflow_assert_delay_us' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'urgent_latency_ns' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'usbc_combo_phy_reset_wa' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'use_legacy_soc_bb_mechanism' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'use_max_lb' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'validate_dml_output' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'validation_trace' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'visual_confirm' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'visual_confirm_rect_height' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'voltage_align_fclk' not described in 'dc_debug_options'
drivers/gpu/drm/amd/display/dc/dc.h:847: warning: Function parameter or mem=
ber 'vsr_support' not described in 'dc_debug_options'

Introduced by commit

  a2b3b9d57bdb ("drm/amd/display: Document pipe split policy")

--=20
Cheers,
Stephen Rothwell

--Sig_/C4H4alhtg7UI0g=K7.saxGF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmL1fxsACgkQAVBC80lX
0GwWOggAnP25ZIkMt8PF/zqr367R+5VdFSMJI6YZbMmOpiLMlDVf4GU9OU//lkqy
t+OvoukPjjmNkSAYN5+dmDp1h6o3WTYUZNfpTrBrygaD0ZHS4RA8aaV/4+NDNi8j
LfEurqlfsl3rc9B1RS6tEMocsnVfTyxNS+jRRoDYABL7+pr57tZtYN2Ezmkdhzsy
rpN2B92YaWvSl/HaSo45tpiEA2N0QMXVuGdAmxTTehjNEC6E2DOEUt6S3zvSHLzF
Ik6PFbRPECB2rkF1R3vHz+PcV+eaiKxJpyaQ3rrO5i+lyFjIRmL991S5Usthr4wW
L4xKiPrRJUp+RJhTbMTzSkhtdtFzBg==
=4TVX
-----END PGP SIGNATURE-----

--Sig_/C4H4alhtg7UI0g=K7.saxGF--
