Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD16E5993DF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 06:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345791AbiHSEGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 00:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345384AbiHSEGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 00:06:00 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A73D3EEB
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 21:05:58 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bs25so3802366wrb.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 21:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc;
        bh=+rnds3IPRhTHcbrUjwkCnqyLL2hBHfBhXb8wBLduchc=;
        b=g71mOxuMbvYULPrJhXLHi6wOEJgLWhaFuIy+/AcG0AXyeXLHQJtysYq4Un4LsLxWgq
         vdYZZ/wLuSzhHbgRNS4LI3B3yNSemWzO6ycbu7CI7xm67CJDq/d2mbIKoIr01DZbXih4
         qbpKa3E3NgTnjjFd753CcoFxUgvTklSnN/8JZOHqaTj/19fvc9AYZthVTNFgAAaMhfJn
         7mwL6XNjxXguNppGaoKba2vD+NmTp5qv3mgCUrlzHOA/ky4TIAfRnPDzkjz5w59Oy0u2
         boK2smsQaXGLT3vj2gxROwbr+dv5WEmv7iu2fvNU0f71IBCuqzl5rnvIy0jpOjMI/AFb
         zpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+rnds3IPRhTHcbrUjwkCnqyLL2hBHfBhXb8wBLduchc=;
        b=FK3ybTj/xDni+KFO2HMKICvcRn7AA65lNhKHDJYzQa2dR5DnP7jiGSndIrRBsEu1PR
         Ow+OTz7ReTbWhKXgUlMc0DDEOAVdD6njLn28aO7cjyEQvG8Wc8JN8Jh60xKGAQZQAVDd
         PHB3dlrSbC4QVYZD80FrNr6TaODI5A4TJf4jun8q5jAV3oa1q/a8Q9E6nZWvjr0GlSkk
         J34DQH89Zzf19+iDWRlZB/3NgoPgEURRxbQf7FdOfbyIX4WW9xe//ym8h8XOXqxrx+Qr
         0kvZqru6VxP875pEK703bKavDehBABcoidOhdRNWhP6z26mslypzyaz0ZJgBDoaAqh0i
         Lv0w==
X-Gm-Message-State: ACgBeo2/4Za/HNsmta0bgNcjoy1m1nb8rlzJrV1c0GXHUsTUm7SToZoJ
        f9pDmF3ub6wGLoD8LNONyXBsNvGhRzU98T8LlFm1SMa1qtA=
X-Google-Smtp-Source: AA6agR6AjUGbKsbd4RycAQ1SXgOwYSRg8M6zVucKUKwfKLDaqem6NQkGf61csEzMFRIUkm5IOXmM1m5Qkhh8YcGIWtI=
X-Received: by 2002:adf:e5c1:0:b0:225:24f8:16ee with SMTP id
 a1-20020adfe5c1000000b0022524f816eemr2990233wrn.568.1660881957102; Thu, 18
 Aug 2022 21:05:57 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 19 Aug 2022 14:05:45 +1000
Message-ID: <CAPM=9tx=MmC2wezaYG7m0A71jdL=niFrFhcXxaS8Z5=6Rf88Qg@mail.gmail.com>
Subject: [git pull] drm fixes for 6.0-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Regular weekly fixes. The nouveau patch just enables modesetting on
GA103 hw which is like other ampere cards that are already supported.
amdgpu has 2 weeks of fixes, as Alex was away, so a bit larger than
usual, otherwise some i915 and misc other fixes.

Dave.

drm-fixes-2022-08-19:
drm fixes for 6.0-rc2

ttm:
- NULL ptr dereference

i915:
- disable pci resize on 32-bit systems
- don't leak the ccs state
- TLB invalidation fixes

nouveau:
- GA103 enablement
- off-by-one fix

amdgpu:
- Revert some DML stack changes
- Rounding fixes in KFD allocations
- atombios vram info table parsing fix
- DCN 3.1.4 fixes
- Clockgating fixes for various new IPs
- SMU 13.0.4 fixes
- DCN 3.1.4 FP fixes
- TMDS fixes for YCbCr420 4k modes
- DCN 3.2.x fixes
- USB 4 fixes
- SMU 13.0 fixes
- SMU driver unload memory leak fixes
- Display orientation fix
- Regression fix for generic fbdev conversion
- SDMA 6.x fixes
- SR-IOV fixes
- IH 6.x fixes
- Use after free fix in bo list handling
- Revert pipe1 support
- XGMI hive reset fix

amdkfd:
- Fix potential crach in kfd_create_indirect_link_prop()

imx:
- warning fix

meson:
- refcounting fix

lvds-codec:
- error check fix

sun4i:
- underflow fix
- dt-binding fix
The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868=
:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-08-19

for you to fetch changes up to b1fb6b87ed55ced458b322ea10cf0d0ab151e01b:

  Merge tag 'amd-drm-fixes-6.0-2022-08-17' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2022-08-19
09:45:22 +1000)

----------------------------------------------------------------
drm fixes for 6.0-rc2

ttm:
- NULL ptr dereference

i915:
- disable pci resize on 32-bit systems
- don't leak the ccs state
- TLB invalidation fixes

nouveau:
- GA103 enablement
- off-by-one fix

amdgpu:
- Revert some DML stack changes
- Rounding fixes in KFD allocations
- atombios vram info table parsing fix
- DCN 3.1.4 fixes
- Clockgating fixes for various new IPs
- SMU 13.0.4 fixes
- DCN 3.1.4 FP fixes
- TMDS fixes for YCbCr420 4k modes
- DCN 3.2.x fixes
- USB 4 fixes
- SMU 13.0 fixes
- SMU driver unload memory leak fixes
- Display orientation fix
- Regression fix for generic fbdev conversion
- SDMA 6.x fixes
- SR-IOV fixes
- IH 6.x fixes
- Use after free fix in bo list handling
- Revert pipe1 support
- XGMI hive reset fix

amdkfd:
- Fix potential crach in kfd_create_indirect_link_prop()

imx:
- warning fix

meson:
- refcounting fix

lvds-codec:
- error check fix

sun4i:
- underflow fix
- dt-binding fix

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu: Only disable prefer_shadow on hawaii

Alvin Lee (8):
      drm/amd/display: Add a variable to update FCLK latency
      drm/amd/display: Revert "attempt to fix the logic in
commit_planes_for_stream()"
      drm/amd/display: For stereo keep "FLIP_ANY_FRAME"
      drm/amd/display: Don't try to enter MALL SS if stereo3d
      drm/amd/display: Add 16 lines margin for SubVP
      drm/amd/display: Don't set DSC for phantom pipes
      drm/amd/display: Use pitch when calculating size to cache in MALL
      drm/amd/display: Include scaling factor for SubVP command

Andrey Strachuk (1):
      drm/amdgpu: remove useless condition in
amdgpu_job_stop_all_jobs_on_sched()

Aric Cyr (2):
      drm/amd/display: 3.2.197
      drm/amd/display: 3.2.198

Arunpravin Paneer Selvam (1):
      drm/ttm: Fix dummy res NULL ptr deref bug

Aurabindo Pillai (4):
      drm/amd/display: Add a missing register field for HPO DP stream encod=
er
      drm/amd/display: fix CAB allocation for multiple displays
      drm/amd/display: Check correct bounds for stream encoder
instances for DCN303
      drm/amd/display: Enable SubVP by default on DCN32 & DCN321

Chaitanya Dhere (1):
      drm/amd/display: Modify header inclusion pattern

Charlene Liu (1):
      drm/amd/display: avoid doing vm_init multiple time

Chiawen Huang (1):
      drm/amd/display: Device flash garbage before get in OS

Chris Wilson (5):
      drm/i915/gt: Ignore TLB invalidations on idle engines
      drm/i915/gt: Invalidate TLB of the OA unit at TLB invalidations
      drm/i915/gt: Skip TLB invalidations once wedged
      drm/i915/gt: Batch TLB invalidations
      drm/i915/gem: Remove shared locking on freeing objects

Dan Carpenter (1):
      drm/amdkfd: potential crash in kfd_create_indirect_link_prop()

Daniel Miess (3):
      drm/amd/display: Use pixels per container logic for DCN314 DCCG divid=
ers
      drm/amd/display: Fix TMDS 4K@60Hz YCbCr420 corruption issue
      drm/amd/display: Add debug parameter to retain default clock table

Daniel Phillips (2):
      drm/amdgpu: Remove rounding from vram allocation path
      drm/amdgpu: Pessimistic availability based on rounded up allocations

Dave Airlie (3):
      Merge tag 'drm-intel-next-fixes-2022-08-11' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-misc-fixes-2022-08-16' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'amd-drm-fixes-6.0-2022-08-17' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

David Galiffi (2):
      drm/amd/display: Allow alternate prefetch modes in DML for DCN32
      drm/amd/display: Fix Compile-time Warning

Duncan Ma (2):
      drm/amd/display: Fix VPG instancing for dcn314 HPO
      drm/amd/display: Correct DTBCLK for dcn314

Dusica Milinkovic (1):
      drm/amdgpu: Increase tlb flush timeout for sriov

Ethan Wellenreiter (1):
      drm/amd/display: reverted limiting vscsdp_for_colorimetry and
ARGB16161616 pixel format addition

Evan Quan (4):
      drm/amd/pm: add 3715 softpptable support for SMU13.0.0
      drm/amdgpu: disable 3DCGCG/CGLS temporarily due to stability issue
      drm/amd/pm: add missing ->fini_microcode interface for Sienna Cichlid
      drm/amd/pm: add missing ->fini_xxxx interfaces for some SMU13 asics

Felix Kuehling (2):
      drm/amdkfd: Handle restart of kfd_ioctl_wait_events
      drm/amdkfd: Fix mm reference in SVM eviction worker

Fudong Wang (1):
      drm/amd/display: clear optc underflow before turn off odm clock

Harish Kasiviswanathan (1):
      drm/amdgpu: Add decode_iv_ts helper for ih_v6 block

Ian Chen (1):
      drm/amd/display: Add reserved dc_log_type.

Ilya Bakoulin (1):
      drm/amd/display: Fix pixel clock programming

Joseph Greathouse (1):
      drm/amdgpu: Enable translate_further to extend UTCL2 reach

Josip Pavic (2):
      drm/amd/display: Avoid MPC infinite loop
      drm/amd/display: do not compare integers of different widths

Karol Herbst (1):
      drm/nouveau: recognise GA103

Kenneth Feng (3):
      drm/amd/pm: skip pptable override for smu_v13_0_7
      drm/amd/amdgpu: add ih cg and hdp sd on smu_v13_0_7
      drm/amd/pm: add mode1 support on smu_v13_0_7

Khalid Masum (1):
      drm/amdgpu/vcn: Return void from the stop_dbg_mode

Laurentiu Palcu (1):
      drm/imx/dcss: get rid of HPD warning message

Leo Ma (1):
      drm/amd/display: Fix HDMI VSIF V3 incorrect issue

Liang He (1):
      drm/meson: Fix refcount bugs in meson_vpu_has_available_connectors()

Lijo Lazar (1):
      drm/amdgpu: Avoid another list of reset devices

Likun Gao (1):
      drm/amdgpu: change vram width algorithm for vram_info v3_0

Ma Jun (1):
      drm/amdgpu: Remove redundant reference of header file

Magali Lemes (4):
      drm/amd/display: remove DML Makefile duplicate lines
      drm/amd/display: make variables static
      drm/amd/display: remove header from source file
      drm/amd/display: include missing headers

Marek Vasut (1):
      drm/bridge: lvds-codec: Fix error checking of
drm_of_lvds_get_data_mapping()

Matthew Auld (1):
      drm/i915/ttm: don't leak the ccs state

Mauro Carvalho Chehab (1):
      drm/i915: pass a pointer for tlb seqno at vma_invalidate_tlb()

Ma=C3=ADra Canal (1):
      drm/amdgpu: Fix use-after-free on amdgpu_bo_list mutex

Meenakshikumar Somasundaram (1):
      drm/amd/display: Fix TDR eDP and USB4 display light up issue

Melissa Wen (1):
      drm/amd/display: set panel orientation before drm_dev_register

Michel D=C3=A4nzer (1):
      Revert "drm/amd/amdgpu: add pipe1 hardware support"

Mukul Joshi (1):
      drm/amdgpu: Fix interrupt handling on ih_soft ring

Nicholas Kazlauskas (1):
      drm/amd/display: Update clock table policy for DCN314

Nirmoy Das (1):
      drm/i915: disable pci resize on 32-bit machine

Rajneesh Bhardwaj (1):
      drm/amdgpu: Avoid direct cast to amdgpu_ttm_tt

Rodrigo Siqueira (7):
      Revert "drm/amd/display: reduce stack for dml32_CalculatePrefetchSche=
dule"
      Revert "drm/amd/display: reduce stack for
dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport"
      Revert "drm/amd/display: reduce stack for dml32_CalculateVMRowAndSwat=
h"
      Revert "drm/amd/display: reduce stack for
dml32_CalculateSwathAndDETConfiguration"
      drm/amd/display: Create FPU files for DCN314
      drm/amd/display: Move populate dml pipes from DCN314 to dml
      drm/amd/display: Drop FPU flags from Makefile

Samson Tam (1):
      drm/amd/display: add chip revision to DCN32

Samuel Holland (2):
      dt-bindings: display: sun4i: Add D1 TCONs to conditionals
      drm/sun4i: dsi: Prevent underflow when computing packet sizes

Sebin Sebastian (1):
      drm/amdgpu: double free error and freeing uninitialized null pointer

Shane Xiao (1):
      drm/amdgpu: Add secure display TA load for Renoir

Tim Huang (15):
      drm/amdgpu: add GFX Clock Gating support for GC IP v11.0.1
      drm/amdgpu: enable GFX Clock Gating control for GC IP v11.0.1
      drm/amdgpu/pm: update smu driver interface header for SMU IP v13.0.4
      drm/amdgpu/pm: remove EnableGfxOff message for SMU IP v13.0.4
      drm/amdgpu: enable GFX Power Gating for GC IP v11.0.1
      drm/amdgpu: add GFX Power Gating support for GC IP v11.0.1
      drm/amd/pm: update the smu driver interface version for SMU IP v13.0.=
4
      drm/amdgpu: add MMHUB IP v3.0.1 Clock Gating support
      drm/amdgpu: add HDP IP v5.2.1 Clock Gating support
      drm/amdgpu: add ATHUB IP v3.0.1 Clock Gating support
      drm/amdgpu: enable MMHUB IP v3.0.1 Clock Gating
      drm/amdgpu: enable HDP IP v5.2.1 Clock Gating
      drm/amdgpu: enable ATHUB IP v3.0.1 Clock Gating
      drm/amdgpu: enable IH Clock Gating for OSS IP v6.0.1
      drm/amd/pm: Enable GFXOFF feature for SMU IP v13.0.4

Timur Tabi (1):
      drm/nouveau: fix another off-by-one in nvbios_addr

Tom Chung (1):
      drm/amd/display: Fix plug/unplug external monitor will hang
while playback MPO video

Yifan Zhang (2):
      drm/amd/display: change family id name for DCN314
      drm/amdkfd: reserve 2 queues for sdma 6.0.1 in bitmap

Zhen Ni (2):
      drm/amd/pm: Fix a potential gpu_metrics_table memory leak
      drm/amd/pm: Fix a potential gpu_metrics_table memory leak

 .../bindings/display/allwinner,sun4i-a10-tcon.yaml |   4 +
 drivers/gpu/drm/amd/amdgpu/aldebaran.c             |  45 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |  21 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c            |   4 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h          |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |  34 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c           |   3 +-
 drivers/gpu/drm/amd/amdgpu/athub_v3_0.c            |  42 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             |   3 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c             |   3 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |   3 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              |   7 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |  39 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |   3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |   6 +-
 drivers/gpu/drm/amd/amdgpu/hdp_v5_2.c              | 150 ++++
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c               |   1 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c          |  42 +-
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c             |   7 +-
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c             |  10 +
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c             |   1 -
 drivers/gpu/drm/amd/amdgpu/soc21.c                 |  25 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c              |   5 +-
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c             |   7 +-
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c             |   7 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |   7 +-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c            |  24 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |  17 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h               |   1 -
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |  11 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  15 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |   4 +-
 drivers/gpu/drm/amd/display/dc/basics/conversion.c |  21 +
 drivers/gpu/drm/amd/display/dc/basics/conversion.h |   3 +
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c   |   4 +-
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  |   3 +-
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.h  |   1 +
 .../amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c | 200 +++--
 .../amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.h |   2 +-
 .../drm/amd/display/dc/clk_mgr/dcn314/dcn314_smu.h |  33 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  41 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |   6 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       |  15 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h           |   1 +
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |   2 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp.c   |   2 -
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c  |   3 -
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |   1 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c   |   6 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c  |   5 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c   |   2 -
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c  |   3 -
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c   |   6 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c    |   8 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c   |   2 -
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c  |   2 +-
 .../drm/amd/display/dc/dcn303/dcn303_resource.c    |   2 +-
 .../display/dc/dcn31/dcn31_hpo_dp_stream_encoder.h |   3 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_resource.c  |   2 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_resource.h  |   1 -
 drivers/gpu/drm/amd/display/dc/dcn314/Makefile     |  25 -
 .../gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c   |  42 +-
 .../gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.h   |   4 +
 .../gpu/drm/amd/display/dc/dcn314/dcn314_init.c    |   2 +
 .../drm/amd/display/dc/dcn314/dcn314_resource.c    | 341 +--------
 .../drm/amd/display/dc/dcn314/dcn314_resource.h    |   3 +
 .../drm/amd/display/dc/dcn315/dcn315_resource.h    |   1 -
 .../drm/amd/display/dc/dcn316/dcn316_resource.h    |   1 -
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c |  40 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_optc.c  |   2 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_resource.c  |   3 +-
 .../amd/display/dc/dcn32/dcn32_resource_helpers.c  |   2 +-
 .../drm/amd/display/dc/dcn321/dcn321_resource.c    |   5 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile        |   4 +-
 .../gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c   |   1 +
 .../gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c |   1 +
 .../gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c   |   9 +-
 .../amd/display/dc/dml/dcn31/display_mode_vba_31.c |   2 +-
 .../display/dc/dml/dcn31/display_rq_dlg_calc_31.c  |   2 +-
 .../gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c | 376 ++++++++++
 .../gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.h |  40 +
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c   |  47 +-
 .../amd/display/dc/dml/dcn32/display_mode_vba_32.c |  12 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c        | 812 +++++++++++------=
----
 .../dc/dml/dcn32/display_mode_vba_util_32.h        |   5 -
 .../gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c |   7 +
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.h  | 106 ---
 drivers/gpu/drm/amd/display/include/dal_asic_id.h  |   6 +-
 drivers/gpu/drm/amd/display/include/logger_types.h |   4 +-
 .../drm/amd/display/modules/freesync/freesync.c    |  15 +-
 .../pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_4.h |   4 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h       |   2 +-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |   1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     |  21 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |   2 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c   |  17 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c   |   3 +
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |  14 +
 drivers/gpu/drm/bridge/lvds-codec.c                |   2 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.c         |  16 +-
 drivers/gpu/drm/i915/gem/i915_gem_object_types.h   |   3 +-
 drivers/gpu/drm/i915/gem/i915_gem_pages.c          |  25 +-
 drivers/gpu/drm/i915/gt/intel_gt.c                 |  77 +-
 drivers/gpu/drm/i915/gt/intel_gt.h                 |  12 +-
 drivers/gpu/drm/i915/gt/intel_gt_pm.h              |   3 +
 drivers/gpu/drm/i915/gt/intel_gt_types.h           |  18 +-
 drivers/gpu/drm/i915/gt/intel_migrate.c            |  23 +-
 drivers/gpu/drm/i915/gt/intel_ppgtt.c              |   8 +-
 drivers/gpu/drm/i915/gt/intel_region_lmem.c        |   4 +
 drivers/gpu/drm/i915/i915_drv.h                    |   4 +-
 drivers/gpu/drm/i915/i915_vma.c                    |  33 +-
 drivers/gpu/drm/i915/i915_vma.h                    |   1 +
 drivers/gpu/drm/i915/i915_vma_resource.c           |   5 +-
 drivers/gpu/drm/i915/i915_vma_resource.h           |   6 +-
 drivers/gpu/drm/imx/dcss/dcss-kms.c                |   2 -
 drivers/gpu/drm/meson/meson_drv.c                  |   5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  |  22 +
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c             |  10 +-
 drivers/gpu/drm/ttm/ttm_bo.c                       |   2 +-
 130 files changed, 1978 insertions(+), 1249 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.h
