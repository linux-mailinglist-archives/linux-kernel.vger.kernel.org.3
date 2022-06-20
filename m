Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AF9550EF2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 05:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbiFTDbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 23:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbiFTDbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 23:31:45 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C3E6264
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 20:31:44 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id s37so9057166pfg.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 20:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=J5hsVa7sKWySaqWB9vABMNQ1qHx6W6r1URjIt5Q2cJA=;
        b=EpVZdVaPP/2/hfyxOlCmUcUO5i31my7rXtSrH/YRuZ8UnQWpCCcJCB6HjVM9UMINnq
         Y11CrGR/LdHtayHyRS7kqm5eBZT8dolgH5Vdl94HVvOLXSIYw9ij5VKIqlmF9KsnnmLA
         IZKkZApj9D81hSoOj8UAmAkC28lFyKplTApJEgQMV3QJUaQx+xhV/2Qm/mRsCHZTj2Ti
         0+A1M0jAUVF9hzduuwB7ZxijwH0YQm9/vgqXdpUtueDeWse3vO0rQ5V6q1q5uPW2zZzL
         FP0EtZxDLUD/zb/9o//+q8avo27guCq9stpJm+0LBRiiq4s9Z1RPMmnd9sai6814Sj68
         8NVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=J5hsVa7sKWySaqWB9vABMNQ1qHx6W6r1URjIt5Q2cJA=;
        b=m+m7N6UM1lp9LMx7f94ZmNYdtG+4C/jfCMjOJHO/ZeyBuxA+JSg2rc06ROs3gfsQJv
         ORzeLyC0vclFv0WUdodM5HcTad7MNcVpROy3COdOiihicJwJ18FP65YXp7pwT4qIuwNd
         axpbToTEVaY5LE+keMbsXyOBdfN3RM1geYQJ9CePQ51XG92kum20uCmmk4iHi7f0rPGz
         1kctyUQ/UfSv2Xanq2wxvVCuQ8GBm7bpXqt2Kb/Z0SEw6w4qJhZAWDn5m+ses2eiq5Mo
         uhMUMuDg54vozFONoJC7nZksIHEHRNKffT36onMV6S+TUDRHVS/friFi03Er7ZoTu4sG
         gJ6g==
X-Gm-Message-State: AJIora/gTz7UHvTCX4qY6UT6wm02TyaKIKhXAOvHfjjXB0sc0SvVlfsk
        EB9qASbe7oWcV52s7t/iAOqXXodPzhnnng==
X-Google-Smtp-Source: AGRyM1v0jI+swv2AvbUHLapd2TYU1gff/sjYtMyF7Z+P0ayi706N92H1FrJ7ei/qWMrBaYkcJT2/2Q==
X-Received: by 2002:a05:6a00:179b:b0:51b:f51f:992e with SMTP id s27-20020a056a00179b00b0051bf51f992emr22423913pfg.60.1655695903918;
        Sun, 19 Jun 2022 20:31:43 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id j16-20020a17090a7e9000b001e2afd35791sm7066180pjl.18.2022.06.19.20.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 20:31:43 -0700 (PDT)
Date:   Sun, 19 Jun 2022 20:31:39 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] sched: Fix __cond_resched annotation typo
Message-ID: <20220620033139.GA674930@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think I found a minor typo.

It seems natural to end with "." rather than ",".

Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 include/linux/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index c46f3a63b758..5cbced81133c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2030,7 +2030,7 @@ static inline int test_tsk_need_resched(struct task_struct *tsk)
  * cond_resched() and cond_resched_lock(): latency reduction via
  * explicit rescheduling in places that are safe. The return
  * value indicates whether a reschedule was done in fact.
- * cond_resched_lock() will drop the spinlock before scheduling,
+ * cond_resched_lock() will drop the spinlock before scheduling.
  */
 #if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
 extern int __cond_resched(void);
-- 
2.25.1

Regards,
Hyunwoo Kim
