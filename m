Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BA352A4F4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349021AbiEQOeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245165AbiEQOeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:34:07 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07DE4248D
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:34:06 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id v11so17052615pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GKG9qxJvJLAopP/NwMsxDvVc37jrWfz1QwXOphMi9Y8=;
        b=JyAKK1rb3nhhl2JjdhenF9b0O10x5C7tuNv0qKiYrhvbA5xE8sUS+n9njtNo/yEBZ7
         JraV3gJU6BShw4Vg49/tyeK5FPQNdkYzyBp+BZwqv19MVeuYGstHX4mrEhdnQR8gHkkH
         cY9b4hq4p3h/8FXoRWG+LtG+5FISfqd13nVdUVkYxGPj8TXFlouZL5e2pjOh17uJQZ6+
         CRoW8upGF0VzYXozNIXhzo7SWIZmDkMUXDx2VlT3e/AWEE6S5M3QL6vjwC98n8Q3OZfZ
         yWMDfgIUFHC6azNevfCmNxcQTuJq7T3sLOv7dKBhVbHZTibQWfX7QBzXi1Ac6zF6KIVE
         n/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GKG9qxJvJLAopP/NwMsxDvVc37jrWfz1QwXOphMi9Y8=;
        b=zFZhOUs9iScvy1Wj7cocRMYg8QGw2vgjaeMQX6l8dtK0+NYIARjhxrySWdHtqiR4pv
         Koz8e0xpZI782aiCHrShJgA4oss31Ej/zB6Cs5ekQI60AnrJblwbv9K9AjwTs5krYw1k
         9E3kLo/8zm8S5szCIjKAlHAeFAsmW9XfudZUO8/Fs23dMByksCTMkLJg7eMwFxSjwRCA
         Z9Yv0n5S1gZOxOAjGUHl7Bu8dpmLW3eaC31Fh3quRqw9mvgM4OiQE+2yvsabeoMx9S0K
         emNXQRvBcV99Qbkm9ooo38fxHT9Z8NtRQCYPf0pbNaawLnqOLTttu721xuEd32tozmNE
         Wj8Q==
X-Gm-Message-State: AOAM530+2gLXNsfvlWajZZNrE1gGgHj2NfraAoO6BPO8qMclv1XRw29q
        1FNkWzuTHReO3HxkcpgW8IBoRXGmQJJFnQ==
X-Google-Smtp-Source: ABdhPJzdN10p6+jbRjBFVRujrjZAADIa/P2a60o0SCXs9HIaozOdkvhMLB8ygpgDW/Jp8iZgEa0YxA==
X-Received: by 2002:a05:6a00:801:b0:50d:ec66:fac0 with SMTP id m1-20020a056a00080100b0050dec66fac0mr22894471pfk.23.1652798046431;
        Tue, 17 May 2022 07:34:06 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id iz19-20020a17090ae79300b001cd4989ff53sm1733855pjb.26.2022.05.17.07.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 07:34:06 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] MAINTAINERS: add myself as a memcg reviewer
Date:   Tue, 17 May 2022 22:33:20 +0800
Message-Id: <20220517143320.99649-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have been focusing on mm for the past two years. e.g. developing,
fixing bugs, reviewing.  I have fixed lots of races (including memcg).
I would like to help people working on memcg or related by reviewing
their work.  Let me be Cc'd on patches related to memcg.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ce78f2275dc..0d5de0c553aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5057,6 +5057,7 @@ M:	Johannes Weiner <hannes@cmpxchg.org>
 M:	Michal Hocko <mhocko@kernel.org>
 M:	Roman Gushchin <roman.gushchin@linux.dev>
 M:	Shakeel Butt <shakeelb@google.com>
+R:	Muchun Song <songmuchun@bytedance.com>
 L:	cgroups@vger.kernel.org
 L:	linux-mm@kvack.org
 S:	Maintained
-- 
2.11.0

