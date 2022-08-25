Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2545A1049
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241503AbiHYMWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241575AbiHYMWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:22:20 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D24B14EC
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:22:19 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id lx1so2751335ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=trj0YLDpn1TqD1P1ieko3B94hmrka5UjWeHSInEj3Hc=;
        b=k4ET56EkH1q++vfvslW8RqtrAcenWl5SBCjde4uWc0zNe1CI1meraEXb7G2Z/X6Tu6
         UQz1JFbdXOFhPszOt337tAu7h59CSz8fmfK4f8qhowEzBKxGtFIUrbWR7qG0CmYCy/U6
         EWnYCKWVNN+Xg8/xKFNGMvrIl61Pz4i/jSNWkQsRWgvd9MNzNC4cC7TWUU7XoDXSyaKs
         4HQlkIiTJoecq3C/wlNCGo/7kzXKxknOPiGKQ//Dmny1vXSObwsAKl/XYq91kL8VanOc
         51ZRGRRkJc7dAZPjVFW+jYK6hF//56wMRv7XAB6cfmpnZZtQTrQNozqkmMbXIsTBLk7L
         NaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=trj0YLDpn1TqD1P1ieko3B94hmrka5UjWeHSInEj3Hc=;
        b=h0QccCFTdm/Kt1XBLoVYBLrYzo2Y0WYTdylgrfufMahZHlhEIuYSvGBL7pGTSB75q0
         NnnKTnSfwWuMO77hpSuXCWToYtJUrVjuB7yTYLpeyU/Tv8JHTpT6KqH6HhX6uQBuBicg
         hKTt4mur7UFHwYMN9Aq2qL7Hss5cKDcCMLWHej8acNfINupYY+Ef4FGadkbKNi4wB8hO
         hgqkP6wXviiidYgWJx/KImAhTFkHsqSMHnekrr53zBAyblrUiFQecPL0TLhD6QO8dLEF
         9MOd7+CrdnzseKkh7f1PYHdlGXUxB8VeTn1Stc3ghAV9QGDdvJIQWD2O6xh26OVE1X0c
         c7Ng==
X-Gm-Message-State: ACgBeo35xefg56Ohsa2AQPA/GlZxqvgH+m97nMVBpD1lXMNB9CaBhQ+l
        dv3HQ6segx+l/dnGPjIouS/ZyIuBXKiPyYJ7u+6+qQ==
X-Google-Smtp-Source: AA6agR66xx3+2JCCWoAZdLZcDaGlWrZmyWu6rMNDgUs0ZWUDmvZ3sAZIINx2veDxtJY6a6BxE8stUvZVbFisyeyGUrc=
X-Received: by 2002:a17:906:9bd9:b0:73d:da74:120c with SMTP id
 de25-20020a1709069bd900b0073dda74120cmr628764ejc.412.1661430137649; Thu, 25
 Aug 2022 05:22:17 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 25 Aug 2022 17:52:06 +0530
Message-ID: <CA+G9fYu549Bb_TwcOMFJQJOB=23=arHdckCSSzds5eT+FgT-tw@mail.gmail.com>
Subject: WARNING: CPU: 3 PID: 301 at include/media/media-entity.h:465 media_graph_walk_start+0xcc/0xd4
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following kernel crash noticed on db410c while booting mainline 6.0.0-rc2.
This crash is not always reproducible.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

metadata:
  git_ref: master
  git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
  git_sha: c40e8341e3b3bb27e3a65b06b5b454626234c4f0
  git_describe: v6.0-rc2-54-gc40e8341e3b3
  kernel_version: 6.0.0-rc2
  kernel-config: https://builds.tuxbuild.com/2Dmj8axHFHLJ7YdTYjhOEGppduR/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline/-/pipelines/621141375
  artifact-location: https://builds.tuxbuild.com/2Dmj8axHFHLJ7YdTYjhOEGppduR
  toolchain: gcc-11

Crash log:
----------
[    7.203248] qcom-camss 1b0ac00.camss: Adding to iommu group 1
[    7.213651] qcom-camss 1b0ac00.camss: Failed to configure power domains: -17
[    7.213786] qcom-camss: probe of 1b0ac00.camss failed with error -17
[    7.418502] ------------[ cut here ]------------
[    7.418556] WARNING: CPU: 3 PID: 301 at
include/media/media-entity.h:465 media_graph_walk_start+0xcc/0xd4
[    7.422214] Modules linked in: pm8916_wdt(+) msm(+) crct10dif_ce
qcom_camss adv7511 qcom_wcnss_pil(+) qcom_q6v5_mss(+) venus_core(+)
cec snd_soc_lpass_apq8016 qcom_pil_info gpu_sched snd_soc_lpass_cpu
qcom_q6v5 videobuf2_dma_sg drm_dp_aux_bus display_connector
snd_soc_lpass_platform snd_soc_apq8016_sbc qcom_sysmon
snd_soc_qcom_common drm_display_helper v4l2_fwnode
snd_soc_msm8916_digital qcom_common snd_soc_msm8916_analog
qcom_glink_smem v4l2_mem2mem v4l2_async drm_kms_helper qnoc_msm8916
qcom_spmi_temp_alarm videobuf2_memops rtc_pm8xxx qcom_spmi_vadc
videobuf2_v4l2 qmi_helpers qcom_pon qcom_vadc_common videobuf2_common
i2c_qcom_cci icc_smd_rpm mdt_loader qcom_rng qcom_stats drm socinfo
rmtfs_mem fuse
[    7.422761] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000000
[    7.438434] adreno 1c00000.gpu: Adding to iommu group 2
[    7.450496] platform 1a98000.dsi: Fixing up cyclic dependency with 3-0039
[    7.450670] platform 1a98000.dsi: Fixing up cyclic dependency with
1a01000.mdp
[    7.471401] CPU: 3 PID: 301 Comm: v4l_id Not tainted 6.0.0-rc2 #1
[    7.471415] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[    7.471421] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    7.471433] pc : media_graph_walk_start+0xcc/0xd4
[    7.471450] lr : media_graph_walk_start+0x40/0xd4
[    7.471462] sp : ffff80000bceb9d0
[    7.471466] x29: ffff80000bceb9d0
[    7.482012] ------------[ cut here ]------------
[    7.482023] WARNING: CPU: 2 PID: 299 at
include/media/media-entity.h:465 media_graph_walk_start+0xcc/0xd4
[    7.482049] Modules linked in: pm8916_wdt(+) msm crct10dif_ce
qcom_camss adv7511 qcom_wcnss_pil(+) qcom_q6v5_mss(+) venus_core(+)
cec snd_soc_lpass_apq8016 qcom_pil_info gpu_sched snd_soc_lpass_cpu
qcom_q6v5 videobuf2_dma_sg drm_dp_aux_bus display_connector
snd_soc_lpass_platform snd_soc_apq8016_sbc qcom_sysmon
snd_soc_qcom_common drm_display_helper v4l2_fwnode
snd_soc_msm8916_digital qcom_common snd_soc_msm8916_analog
qcom_glink_smem v4l2_mem2mem v4l2_async drm_kms_helper qnoc_msm8916
qcom_spmi_temp_alarm videobuf2_memops rtc_pm8xxx qcom_spmi_vadc
videobuf2_v4l2 qmi_helpers qcom_pon qcom_vadc_common videobuf2_common
i2c_qcom_cci icc_smd_rpm mdt_loader qcom_rng qcom_stats drm socinfo
rmtfs_mem fuse
[    7.482250] CPU: 2 PID: 299 Comm: v4l_id Not tainted 6.0.0-rc2 #1
[    7.482262] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[    7.482268] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    7.482279] pc : media_graph_walk_start+0xcc/0xd4
[    7.482292] lr : media_graph_walk_start+0x40/0xd4
[    7.482303] sp : ffff80000bc1b9d0
[    7.482308] x29: ffff80000bc1b9d0 x28: ffff80000bc1bc70 x27: 0000000000000000
[    7.482325] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
[    7.482342] x23: ffff00000584d368 x22: 0000000000000001 x21: ffff000005303960
[    7.482360] x20: ffff00000584d368 x19: ffff000005303a98 x18: 0000000000000000
[    7.482377] x17: 0000000000000000 x16: ffff800008fc3190 x15: 0000000000000000
[    7.482394] x14: ffffffffffffffff x13: ffff00000456d025 x12: ffff80000bc1bcb4
[    7.482411] x11: 00000006955fc5f6 x10: 0000000000000002 x9 : ffff800008fc302c
[    7.482428] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000001
[    7.482444] x5 : ffff80000aa8f000 x4 : 0000000000000000 x3 : ffff000005303a78
[    7.482460] x2 : 0000000000000000 x1 : 000000000000000a x0 : 0000000000000000
[    7.482477] Call trace:
[    7.482481]  media_graph_walk_start+0xcc/0xd4
[    7.482494]  pipeline_pm_power.part.0+0x38/0xfc
[    7.482505]  v4l2_pipeline_pm_use+0x5c/0xa0
[    7.482514]  v4l2_pipeline_pm_get+0x20/0x30
[    7.482523]  video_open+0x80/0xe4 [qcom_camss]
[    7.482583]  v4l2_open+0xb4/0x130
[    7.482593]  chrdev_open+0xcc/0x23c
[    7.482603]  do_dentry_open+0x134/0x3ec
[    7.482614]  vfs_open+0x38/0x44
[    7.482625]  path_openat+0x8c0/0xe64
[    7.482638]  do_filp_open+0x8c/0x13c
[    7.482651]  do_sys_openat2+0xbc/0x174
[    7.482661]  __arm64_sys_openat+0x6c/0xbc
[    7.482672]  invoke_syscall+0x50/0x120
[    7.482687]  el0_svc_common.constprop.0+0x68/0x124
[    7.482700]  do_el0_svc+0x3c/0xd0
[    7.482712]  el0_svc+0x30/0x94
[    7.482723]  el0t_64_sync_handler+0xc0/0x13c
[    7.482734]  el0t_64_sync+0x18c/0x190
[    7.482744] ---[ end trace 0000000000000000 ]---

ref:
https://lkft.validation.linaro.org/scheduler/job/5434242#L2360

Test details log:
https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.0-rc2-54-gc40e8341e3b3/testrun/11545376/suite/log-parser-test/tests/

--
Linaro LKFT
https://lkft.linaro.org
