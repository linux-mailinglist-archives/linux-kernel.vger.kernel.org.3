Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A5950B891
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448038AbiDVNga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448034AbiDVNgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:36:21 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D528258E4C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:33:26 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id t15so9062885oie.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=de5cYv9udGhvYDO7mNwHuK98M+en+qgo8AFwYs9167Y=;
        b=RcwvHmsLpebm7Ci3Xt0BAlj7oa76AW3bGWew8HCMNJxyK1SuDq2YGUAvG97nOq3Eo3
         KsAn8/JRYLPyhgAEfU98ydLP9sr7+kVoFWqn567X8F77dqtAG7xTwe0fG43/CgCcvSuP
         ehqXus3Ts+GejURjxBs5Rm6L9OZ9bIHh/rBLTGuif4ruJVxASyoKso1y87nxpfZkpIn2
         LAZSVjygJ88KEQjUXkUJvF87yuqNLlVvmUojOVtqkzG4IC/X4ag3AvJLwn3n0CgzHZCR
         qOT5f80Qii8tstUWxSnbyfRZFRdndFKnPHKpdJwn67x49JXv+qhogJjE1UhtR5aEXTSr
         NyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=de5cYv9udGhvYDO7mNwHuK98M+en+qgo8AFwYs9167Y=;
        b=FF2FUCPKIuZ2+8nSn5QYYoEg8SMfP3vwYPo8UKie6F4AWPYIwlb9M/5Rj7vxe1ZJEJ
         F22nrHjD+J852Jj07yaQm57OBPsoV3Hp7zQGN7HZws0mBPsC4NDGnu78QIOtrgRHd/5h
         1Z0EAjXZB2sO98kmA2kK0//v9pqlQrY05Ke2CKlvypFGfEgaFrTtzpgcqQ047wmlxiSt
         +oCivX4Vy97mvEVKFulBevW0I8nWiCwC9fSJ18n9qk3p8n+ums/5s9qazioiyLgLGq65
         YnUdpYyzp0NfGjPiu//j4fD2NWGKpg+ZWyzUWaGSdTOgd5G/9/oyAkhWK7vlg+qrQn+8
         RvDw==
X-Gm-Message-State: AOAM532SuGD10jG6pv/a0NZGJu1el6g+OcU6bQK297uKxgnOFou1PWap
        yX0iBZEukU83EYBPCtFj7d4=
X-Google-Smtp-Source: ABdhPJzfVz3jSr2UPzaynpM2Jy1ECjorM1FHE4t1xa2lixCvgu3KZmnZ3G6+f6bpdTXu7Kccq4ASEw==
X-Received: by 2002:a05:6808:e8d:b0:322:bac0:2943 with SMTP id k13-20020a0568080e8d00b00322bac02943mr2234162oil.126.1650634406199;
        Fri, 22 Apr 2022 06:33:26 -0700 (PDT)
Received: from bertie (072-190-140-117.res.spectrum.com. [72.190.140.117])
        by smtp.gmail.com with ESMTPSA id o2-20020a05687072c200b000d9ae3e1fabsm641007oak.12.2022.04.22.06.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 06:33:25 -0700 (PDT)
From:   Rebecca Mckeever <remckee0@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Rebecca Mckeever <remckee0@gmail.com>
Subject: [PATCH v3 5/5] memblock tests: remove completed TODO item
Date:   Fri, 22 Apr 2022 08:33:02 -0500
Message-Id: <201729cfd08cfe5a8681f815b4a423455263d03d.1650633253.git.remckee0@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1650633253.git.remckee0@gmail.com>
References: <cover.1650633253.git.remckee0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove completed item from TODO list.

Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
---
 tools/testing/memblock/TODO | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/memblock/TODO b/tools/testing/memblock/TODO
index c25b2fdec45e..cd1a30d5acc9 100644
--- a/tools/testing/memblock/TODO
+++ b/tools/testing/memblock/TODO
@@ -23,6 +23,3 @@ TODO
 
 5. Add tests for memblock_alloc_node() to check if the correct NUMA node is set
    for the new region
-
-6. Update comments in tests/basic_api.c to match the style used in
-   tests/alloc_*.c
-- 
2.32.0

