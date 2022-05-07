Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D254D51E7EC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 17:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385502AbiEGPFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 11:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241703AbiEGPFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 11:05:39 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8816B13F31;
        Sat,  7 May 2022 08:01:52 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso13328821pjb.1;
        Sat, 07 May 2022 08:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8NKAyyQ3FnM44x6XP0i+mCi4s4b8wIYmk1Eo3/lHAUw=;
        b=pkO8aQEX32pGRB6cUQTzlskx96fDI3Zch6J0tmix+6b5lGYO/1jGYuLlYBUGGX8y+b
         RzPMgK4Yds5nTwHp6DI6eiKA26MkIT3wOdSeLRfQN1jwLaEbXddgn4DaOHodEJ1On1qV
         7w6/Nk8TCg/aOIRCKKq8CA7mRalGPGVC3cAClDiPTQunafRK7Y6hVb6R1WoIWb+JWjGU
         PpqwoEFFFbs3EOneBSVzVDNi0c8Jhd7wU/lWLsXuNs0K1VkAKD5m1bQTKAuFY0K/yCql
         ATg3cDO2ERtFPpsLJw1lMkKPesDTO3euoIijW80hnYohJPDvKh/wUAw814ADYB9w88W4
         jszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8NKAyyQ3FnM44x6XP0i+mCi4s4b8wIYmk1Eo3/lHAUw=;
        b=3TtWEqwl+VTzLVQDd9RrSUbUEAXqFV8GSE1isDMVVJOcY+IeOBrRrX4xyNJA6GtUu/
         yiB9yQ9u0wr+Q8sHIkTle+023BqFzkX7AjFrlU+NAqHsfT8W9ZLftMSbyMa+dIG/Lnnh
         RDepvrnX33UG5d8qAR97t9dljiyVnUwR+LLfCrIpJCHpSbVg3bfafzs31WX+gTAe3k2w
         mBm6SgWArvusZVFoyuR0G076IyO3fos5SgN0EA6Og0LC0slM9Bo13wHsA7Aw1Bvkq8Up
         t+h4dqt/9TeHah/1N09XpEFhuapGHTFXl6TEDs6gj0WU+LXGO6kfAS78draRvQIpo5G8
         dZrg==
X-Gm-Message-State: AOAM532C+4/DwuEH4qE40y2B8z5RC9Sfh7X52MWCCuLxHcPB37eu9OGl
        Ins4KjVrmMBoogoVra2E8EAhluhnFmNdMg==
X-Google-Smtp-Source: ABdhPJwF+kqnOBYFDATtEOscG1AeFgyq/qCkBo/nZj4J9PSn/y2gnNaILWlEqsOT9x3GvyGK3lT5kQ==
X-Received: by 2002:a17:902:9a4c:b0:156:6735:b438 with SMTP id x12-20020a1709029a4c00b001566735b438mr8561903plv.46.1651935711878;
        Sat, 07 May 2022 08:01:51 -0700 (PDT)
Received: from localhost.localdomain ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id v21-20020a170902ca9500b0015e8d4eb2a8sm3711007pld.242.2022.05.07.08.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 08:01:51 -0700 (PDT)
From:   Chanwoo Choi <cwchoi00@gmail.com>
X-Google-Original-From: Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, johnson.wang@mediatek.com,
        mka@chromium.org, jia-wei.chang@mediatek.com,
        andrew-sh.cheng@mediatek.com, hsinyi@chromium.org,
        sibis@codeaurora.org, saravanak@google.com
Subject: [PATCH v2 0/5] PM / devfreq: Add cpu based scaling support to passive governor
Date:   Sun,  8 May 2022 00:01:40 +0900
Message-Id: <20220507150145.531864-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devfreq passive governor has already supported the devfreq parent device
for coupling the frequency change if some hardware have the constraints
such as power sharing and so on.

Add cpu based scaling support to passive governor with required-opp property.
It uses the cpufreq notifier to catch the frequency change timing of cpufreq
and get the next frequency according to new cpu frequency by using required-opp
property. It is based on patch[1] and then just code clean-up by myself.

Make the common code for both passive_devfreq and passive_cpufreq
parent type to remove the duplicate code.

[1] [RFC,v2] PM / devfreq: Add cpu based scaling support to passive_governor
- https://lore.kernel.org/patchwork/patch/1101049/

Changes from v1:
: https://patchwork.kernel.org/project/linux-pm/cover/20210617060546.26933-1-cw00.choi@samsung.com/
- Rename cpu_data variable to parent_cpu_data to avoid build fail
- Use for_each_possible_cpu macro when register cpufreq transition notifier
- Add missing exception handling when cpufreq_passive_register_notifier is failed
- Keep cpufreq_policy for posible cpus instead of NR_CPU in order to avoid
  the memory waste when NR_CPU is too high.
- Add reviewed-by tag of Matthias Kaehlcke for patch1

Chanwoo Choi (4):
  PM / devfreq: Export devfreq_get_freq_range symbol within devfreq
  PM / devfreq: passive: Reduce duplicate code when passive_devfreq case
  PM / devfreq: passive: Keep cpufreq_policy for possible cpus
  PM / devfreq: passive: Update frequency when start governor

Saravana Kannan (1):
  PM / devfreq: Add cpu based scaling support to passive governor

 drivers/devfreq/devfreq.c          |  20 +-
 drivers/devfreq/governor.h         |  27 ++
 drivers/devfreq/governor_passive.c | 412 ++++++++++++++++++++++++-----
 include/linux/devfreq.h            |  17 +-
 4 files changed, 402 insertions(+), 74 deletions(-)

-- 
2.25.1

