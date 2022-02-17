Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B684BA032
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 13:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240442AbiBQMdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 07:33:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239347AbiBQMdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:33:02 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD07E2604DA
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 04:32:46 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2d62593ad9bso29731687b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 04:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ywnpXw+FYV24U6JkELut8aLwZlHVlN4ozgsA3QnjwlU=;
        b=zfEBuYqlqXgQVCPU+O37vu6MDj90eOlxT+j7Y4sSkc5xB9GWNAJOUVAS0Y/6l2Rn4S
         PV3/tYKph8agacASAxrW92I9pPp4bZTo5MKsKX+Q6sA/WU910AIwSPoF4CvXOSa9M7ur
         nc10TpPHBBA0e9cgPxai0fMMPOXP6B61uLUvNGlW/BjtH3sRpRMPuYRR7fNz6/hnG0Gu
         rTgdhkYcG/kDJnv4eLPK8xLrL6HiNsMgR4OUGfjwWNYTVbvOI93HWR+yqdlWyvBPPKUv
         oKmfvcT8SUMXrCeRTFJHFs42uS2ldpMzjgiq8mgEaNkOgU+4ZUMGop1lm5tPOwpr+TPL
         v0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ywnpXw+FYV24U6JkELut8aLwZlHVlN4ozgsA3QnjwlU=;
        b=imo+2bNhkbNFK27Hi9hwGWU44kfP4k6virTxStmPboKTntfVKc+E7pCzAr1lKrSQK0
         6UCnqBin5SAM3knnVRORjFJV2wjVOOKOLHqVvNmCb6qt7r1gLbEQF1ITP58GKfFdvhqs
         ZMHk/VWk/EJESbTeSbauTOVAfmDuqAJuBBuree7JWb7PIeYSDbkFgD5hVGDz7aDs/iFM
         DNI6tj0XB7kXa3i/VwiAwc8VvbRk2e7RBfoQhgqfSFufpTkwemlTu83j5UzBlwPwIIs1
         off/Hst+detn2n8MhywxpY7xvA4v+M4LXFeySauj5fsDEOMmKHVJa3XnZSaZl3D8p5Wx
         oEiA==
X-Gm-Message-State: AOAM532lbJmJPA5dvgo/zoa/p8Srfwa2Bos2bS+FqaMmwq9jsTx4RVUT
        mXLzTtcyWuHvv+5/+l3x9QagVVdxO9gcGOJGsHSHfA==
X-Google-Smtp-Source: ABdhPJxMPcjIoro8tE2e0XS/Kkhx0mMiNFnkSbLs+j1dHHrzmhC/rOSLQaFamMtzFi/RV7tfMa0AaYO2sfvS1G0iXnk=
X-Received: by 2002:a81:a148:0:b0:2d0:7177:5f2b with SMTP id
 y69-20020a81a148000000b002d071775f2bmr2308558ywg.182.1645101165834; Thu, 17
 Feb 2022 04:32:45 -0800 (PST)
MIME-Version: 1.0
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 17 Feb 2022 13:32:35 +0100
Message-ID: <CADYN=9L0g4yizcEM_4oXqhPphhRX6ZVD-JEm=E+=KMh-XOL8mw@mail.gmail.com>
Subject: Re: drm/msm/gpu: Cancel idle/boost work on suspend
To:     robdclark@chromium.org, robdclark@gmail.com
Cc:     sean@poorly.run, quic_abhinavk@quicinc.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

While booting Linux mainline on arm64 qcom db410c device the following
kernel NULL pointer dereference noticed due to this commit [1]
6aa89ae1fb04 ("drm/msm/gpu: Cancel idle/boost work on suspend")

 [   17.207382] Unable to handle kernel NULL pointer dereference at
 virtual address 0000000000000010
 [   17.207755] Mem abort info:
 [   17.215915]   ESR = 0x96000004
 [   17.217903]   EC = 0x25: DABT (current EL), IL = 32 bits
 [   17.225033]   SET = 0, FnV = 0
 [   17.226501]   EA = 0, S1PTW = 0
 [   17.233147]   FSC = 0x04: level 0 translation fault
 [   17.233332] Data abort info:
 [   17.238135]   ISV = 0, ISS = 0x00000004
 [   17.240720]   CM = 0, WnR = 0
 [   17.244061] user pgtable: 4k pages, 48-bit VAs, pgdp=000000008e7b9000
 [   17.247323] [0000000000000010] pgd=080000008e790003,
 p4d=080000008e790003, pud=080000008c2aa003, pmd=0000000000000000
 [   17.254369] Internal error: Oops: 96000004 [#1] PREEMPT SMP
 [   17.264042] Modules linked in: crct10dif_ce qcom_wcnss_pil
 adv7511(+) cec qcom_pon rtc_pm8xxx qcom_spmi_temp_alarm qcom_spmi_vadc
 qcom_vadc_common snd_soc_msm8916_digital snd_soc_msm8916_analog
 qcom_camss snd_soc_apq8016_sbc snd_soc_lpass_apq8016 snd_soc_lpass_cpu
 qcom_q6v5_mss qcom_pil_info snd_soc_lpass_platform qcom_q6v5
 snd_soc_qcom_common msm videobuf2_dma_sg qcom_sysmon venus_core
 qcom_common v4l2_fwnode qcom_rng qcom_glink_smem v4l2_async
 v4l2_mem2mem qmi_helpers qnoc_msm8916 gpu_sched mdt_loader
 videobuf2_memops qcom_stats videobuf2_v4l2 videobuf2_common
 i2c_qcom_cci display_connector icc_smd_rpm drm_kms_helper rpmsg_char
 socinfo rfkill rmtfs_mem drm qrtr fuse
 [   17.306825] CPU: 2 PID: 67 Comm: kworker/2:2 Not tainted 5.17.0-rc1 #1
 [   17.328796] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
 [   17.335137] Workqueue: pm pm_runtime_work
 [   17.341979] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 [   17.345896] pc : hrtimer_active+0x14/0x80
 [   17.352652] lr : hrtimer_cancel+0x28/0x70

 Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
 Reported-by: Anders Roxell <anders.roxell@linaro.org>

 kernel crash log links [2][3].

Cheers,
Anders
[1] https://lore.kernel.org/all/20220108180913.814448-3-robdclark@gmail.com/
[2] https://lkft.validation.linaro.org/scheduler/job/4422191#L2360
[3] https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v5.17-rc1-230-g145d9b498fc8/testrun/7713584/suite/linux-log-parser/test/check-kernel-oops-4422047/log
