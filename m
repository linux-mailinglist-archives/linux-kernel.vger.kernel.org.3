Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86862560BBB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiF2Vcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiF2Vcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:32:35 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861E51F611;
        Wed, 29 Jun 2022 14:32:34 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id w24so16831293pjg.5;
        Wed, 29 Jun 2022 14:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=nOHcuOTPkIbDYUQB65Vui/csKMWP3wQ61WdHbTE9lEA=;
        b=UmolaNiQGpeof4+6nYALIrm+Q3Kr3tBR+btasq7YV109OVWnCSdhPRtVqV0RfnLJTL
         hfpmNkkjGDx5c8BhPzPnr5JIj0CdBp5TEWaR0bbQtblnxEvvFv6g1ryWrBZ1zhNyXq8R
         SbsRJlJTFjz+4ASIg+iyDk1dg1/eqFpzXP1+xqKHa4sl4Qtb6PxunZcZwUqmF/g0VKr7
         TCmYrmQwIla5qXSA68ymDMLOj4IlZnrk71ytVDvDReKaiAFBUwG4eKj5gxlrv8T7OjU7
         R0yhZUUFjQXsilBrrvHWcxlHVd1LicgOP8ooCdwca3R4MrjTE/dpDaDG+K3Mm9dEp0oV
         op0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=nOHcuOTPkIbDYUQB65Vui/csKMWP3wQ61WdHbTE9lEA=;
        b=JIOHcCchVb4Pw2VEmBDdAxIn7F4lJjD+MKaix4ILRu3GVto8ysin6AmtZ947sJZ0bQ
         1maoFnKCiVrvG0oB6OW6CtFVWm/dI/r/kMVxcAhbLvljhHJ8AZq3yZqcgDrNKrX4irWn
         7E0FLcS0GfObJkiw4o0w9C1z7Zips9E0v1F4Ogaq+htZ7qHNqOOi7CFHe9DxyALkNeZh
         GD/Jj5ehrA6Ct6eD3JehxSWKhon0poPZNDGnGk8kZYSAkRrPY8UxIK4M/ZoX1tgYlinn
         D4KjMYxhSr9VlY2H3mmqHECb/MxAzbMfjHVFKovKaJptkX0k2XOiBoQflU+3xHgEEh1u
         rXDQ==
X-Gm-Message-State: AJIora8VHFxQDH+nKvAOH56mVcvVyyAzuInyQuDcHWLJ1FhXopjs+DTx
        hnkGXsfleroQHZU54p/NR03E373D5DA=
X-Google-Smtp-Source: AGRyM1tC7PHcefWeGYNUJSbgYXjvi1JGGYjT3X3z6pjy9fvUG4xjBZ+H4/pezO0C03zi6d6SfBGXvA==
X-Received: by 2002:a17:902:f608:b0:168:e92b:47e8 with SMTP id n8-20020a170902f60800b00168e92b47e8mr12396422plg.115.1656538353934;
        Wed, 29 Jun 2022 14:32:33 -0700 (PDT)
Received: from [172.30.1.37] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id z4-20020a1709027e8400b00163f3e91ea0sm6852948pla.238.2022.06.29.14.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 14:32:33 -0700 (PDT)
Message-ID: <03056170-6501-3f4d-0331-37866d12330e@gmail.com>
Date:   Thu, 30 Jun 2022 06:32:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanwoo Choi <chanwoo@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Subject: [GIT PULL] devfreq fixes for 5.19-rc5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Rafael,

This is devfreq-fixes pull request for v5.19-rc5. I add detailed description of
this pull request on the following tag. Please pull devfreq with
following updates.

Best Regards,
Chanwoo Choi


The following changes since commit 03c765b0e3b4cb5063276b086c76f7a612856a9a:

  Linux 5.19-rc4 (2022-06-26 14:22:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-fixes-for-5.19-rc5

for you to fetch changes up to f08fe6fcbe13f83558ecccc4acaf5af3dce71a1f:

  PM / devfreq: passive: revert an editing accident in SPDX-License line (2022-06-30 05:11:17 +0900)

----------------------------------------------------------------

Update devfreq for 5.19-rc5

Detailed description for this pull request:
1. Fix devfreq passive governor issue when cpufreq policy are not ready
during kernel booting because some cpus turn on after kernel booting or others.

  - Re-initialize the vairables of struct devfreq_passive_data when PROBE_DEFER
  happen when cpufreq_get_returns NULL

  - Use dev_err_probe to mute warning when PROBE_DEFER

  - Fix cpufreq passive unregister erroring on PROBE_DEFER
  by using the allocated parent_cpu_data list to free resouce
  instead of for_each_possible_cpu.

  - Remove duplicate cpufreq passive unregister and warning when PROBE_DEFER

  - Use HZ_PER_KZH macro in units.h

  - Fix wrong indentation in SPDX-License line

2. Fix reference count leak of exynos-ppmu.c by using of_node_put()

3. Rework freq_table to be local to devfreq struct
  - struct devfreq_dev_profile includes freq_table array to store
  the supported frequencies. If devfreq driver doesn't initialize
  the freq_table, devfreq core allocate the memory and initialize
  the freq_table.

  On a devfreq PROBE_DEFER, the freq_table in the driver profile struct,
  is never reset and may be leaved in an undefined state. To fix this
  and correctly handle PROBE_DEFER, use a local freq_table and
  max_state in the devfreq struct.

----------------------------------------------------------------
Christian Marangi (5):
      PM / devfreq: Fix kernel panic with cpu based scaling to passive gov
      PM / devfreq: Mute warning on governor PROBE_DEFER
      PM / devfreq: Fix cpufreq passive unregister erroring on PROBE_DEFER
      PM / devfreq: Rework freq_table to be local to devfreq struct
      PM / devfreq: Fix kernel warning with cpufreq passive register fail

Lukas Bulwahn (1):
      PM / devfreq: passive: revert an editing accident in SPDX-License line

Miaoqian Lin (1):
      PM / devfreq: exynos-ppmu: Fix refcount leak in of_get_devfreq_events

Yicong Yang (1):
      PM / devfreq: passive: Use HZ_PER_KHZ macro in units.h

 drivers/devfreq/devfreq.c           | 76 ++++++++++++++++++-------------------
 drivers/devfreq/event/exynos-ppmu.c |  8 +++-
 drivers/devfreq/governor_passive.c  | 62 +++++++++++++-----------------
 include/linux/devfreq.h             |  5 +++
 4 files changed, 75 insertions(+), 76 deletions(-)
