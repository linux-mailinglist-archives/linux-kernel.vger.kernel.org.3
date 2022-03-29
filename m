Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6716E4EB289
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 19:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240107AbiC2RRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 13:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240095AbiC2RQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 13:16:59 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E258E888E3;
        Tue, 29 Mar 2022 10:15:15 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id m67so32706167ybm.4;
        Tue, 29 Mar 2022 10:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hCIFXZipoBsdOpVRO6RduZXXCWSQTLTSQ0IE1wabs0A=;
        b=WDtbJwVcIQ4LQfna3wNBsAsEG+6MRixKtmwTNCQDWM4skr1PzNPNucBwezIC+x5ceF
         BxyvKSjmvVgFehH2jTbTdzjPgVOvP3+K5T0J54OCkjwcCPilF7T1Nzk79RajeSGc2ecP
         md42fYDV8HwokMJLU1bacXf5Dnxvv3wAhZjFCkEsTNLiriwjKZSFwCnTia7RahW2MAaR
         3tXjGl67xgImXdKeLy5o8aAxAhfyXfUtD7t8PJDariS7eJrv3qKnM6r0VK+LQb+C/Xn6
         QE5s+KIC7bfNtJFvN9CMKwfgVAhhBN9My3N4dq2qgz2xIXBTH4F0ZCrTWCCw0GpijIUo
         hBRg==
X-Gm-Message-State: AOAM532LohMFqizrmpXcVZVsO2QpA8t5TEyuvktNkHuDiJG6hlDU3VXa
        nlSjqhLxcs7P8A1VCqtpz0nyGHwzzbKwZqigEmKKa6D9lj8=
X-Google-Smtp-Source: ABdhPJzY95ifSFitlViYzjHhb1fRJq4JPah4sK+UeRp1CBFDqFSJsU6iAiA3gQmU1Vtui2W396Y/twq6Fia0H4wU+4g=
X-Received: by 2002:a25:bbc1:0:b0:610:b4ce:31db with SMTP id
 c1-20020a25bbc1000000b00610b4ce31dbmr29285037ybk.482.1648574114688; Tue, 29
 Mar 2022 10:15:14 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 29 Mar 2022 19:15:03 +0200
Message-ID: <CAJZ5v0jcQownj7hRpai9XQ+yLW4KJcdEhKz7ANYus-bubQ0wpw@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v5.18-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-5.18-rc1-2

with top-most commit 3b65dd5be3c72b9d2013bfe6e9261e2b06222fa9

 Merge branch 'pm-docs'

on top of commit 02b82b02c34321dde10d003aafcd831a769b2a8a

 Merge tag 'pm-5.18-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more power management updates for 5.18-rc1.

These update ARM cpufreq drivers, the OPP (Operating Performance
Points) library and the power management documentation.

Specifics:

 - Add per core DVFS support for QCom SoC (Bjorn Andersson), convert
   to yaml binding (Manivannan Sadhasivam) and various other fixes
   to the QCom drivers (Luca Weiss).

 - Add OPP table for imx7s SoC (Denys Drozdov) and minor fixes (Stefan
   Agner).

 - Fix CPPC driver's freq/performance conversions (Pierre Gondois).

 - Minor generic cleanups (Yury Norov).

 - Introduce opp-microwatt property to the OPP core, bindings, etc
   (Lukasz Luba).

 - Convert DT bindings to schema format and various related fixes
   (Yassine Oudjana).

 - Expose OPP's OF node in debugfs (Viresh Kumar).

 - Add Intel uncore frequency scaling documentation file to its
   MAINTAINERS entry (Srinivas Pandruvada).

 - Clean up the AMD P-state driver documentation (Jan Engelhardt).

Thanks!


---------------

Bjorn Andersson (2):
      cpufreq: qcom-hw: Add support for per-core-dcvs
      cpufreq: blocklist Qualcomm sc8280xp and sa8540p in cpufreq-dt-platdev

Denys Drozdov (1):
      ARM: dts: imx7s: Define operating points table for cpufreq

Jan Engelhardt (1):
      Documentation: amd-pstate: grammar and sentence structure updates

Luca Weiss (1):
      cpufreq: qcom-cpufreq-nvmem: fix reading of PVS Valid fuse

Lukasz Luba (5):
      dt-bindings: opp: Add "opp-microwatt" entry in the OPP
      OPP: Add "opp-microwatt" supporting code
      PM: EM: add macro to set .active_power() callback conditionally
      OPP: Add support of "opp-microwatt" for EM registration
      Documentation: EM: Describe new registration method using DT

Manivannan Sadhasivam (2):
      dt-bindings: dvfs: Use MediaTek CPUFREQ HW as an example
      dt-bindings: cpufreq: cpufreq-qcom-hw: Convert to YAML bindings

Pierre Gondois (1):
      cpufreq: CPPC: Fix performance/frequency conversion

Srinivas Pandruvada (1):
      MAINTAINERS: Add additional file to uncore frequency control

Stefan Agner (1):
      cpufreq: Add i.MX7S to cpufreq-dt-platdev blocklist

Viresh Kumar (1):
      opp: Expose of-node's name in debugfs

Yassine Oudjana (7):
      dt-bindings: arm: qcom: Add msm8996 and apq8096 compatibles
      arm64: dts: qcom: msm8996-mtp: Add msm8996 compatible
      dt-bindings: opp: qcom-opp: Convert to DT schema
      dt-bindings: opp: Convert qcom-nvmem-cpufreq to DT schema
      arm64: dts: qcom: msm8996: Rename cluster OPP tables
      arm64: dts: qcom: qcs404: Rename CPU and CPR OPP tables
      dt-bindings: power: avs: qcom,cpr: Convert to DT schema

Yury Norov (1):
      cpufreq: replace cpumask_weight with cpumask_empty where appropriate

---------------

 Documentation/admin-guide/pm/amd-pstate.rst        | 135 ++--
 Documentation/devicetree/bindings/arm/qcom.yaml    |  16 +-
 .../bindings/cpufreq/cpufreq-qcom-hw.txt           | 172 -----
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml          | 201 ++++++
 .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml       | 166 +++++
 .../bindings/dvfs/performance-domain.yaml          |  14 +-
 .../devicetree/bindings/opp/opp-v2-base.yaml       |  23 +
 .../devicetree/bindings/opp/opp-v2-kryo-cpu.yaml   | 257 +++++++
 .../devicetree/bindings/opp/opp-v2-qcom-level.yaml |  60 ++
 .../devicetree/bindings/opp/qcom-nvmem-cpufreq.txt | 796 ---------------------
 Documentation/devicetree/bindings/opp/qcom-opp.txt |  19 -
 .../devicetree/bindings/power/avs/qcom,cpr.txt     | 130 ----
 .../devicetree/bindings/power/avs/qcom,cpr.yaml    | 160 +++++
 Documentation/power/energy-model.rst               |  10 +
 MAINTAINERS                                        |   6 +-
 arch/arm/boot/dts/imx7s.dtsi                       |  16 +
 arch/arm64/boot/dts/qcom/msm8996-mtp.dts           |   2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |   4 +-
 arch/arm64/boot/dts/qcom/qcs404.dtsi               |   4 +-
 drivers/cpufreq/cppc_cpufreq.c                     |  43 +-
 drivers/cpufreq/cpufreq-dt-platdev.c               |   3 +
 drivers/cpufreq/qcom-cpufreq-hw.c                  |  20 +-
 drivers/cpufreq/qcom-cpufreq-nvmem.c               |   2 +-
 drivers/cpufreq/scmi-cpufreq.c                     |   2 +-
 drivers/opp/core.c                                 |  25 +
 drivers/opp/debugfs.c                              |   8 +
 drivers/opp/of.c                                   | 108 ++-
 drivers/opp/opp.h                                  |   1 +
 include/linux/energy_model.h                       |   2 +
 include/linux/pm_opp.h                             |  12 +-
 30 files changed, 1191 insertions(+), 1226 deletions(-)
