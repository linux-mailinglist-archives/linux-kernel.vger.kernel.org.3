Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A31559D1CA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240872AbiHWHKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240867AbiHWHKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:10:07 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA2B61B0D
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:10:06 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso13627564pjh.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Qm98Qsqpzi3gp9jivym+i6z48ahQ8BsAtz2LbL2QzGM=;
        b=qw8pSqwQ5MRQZRk/hBPyjXrHSVI6QjQKPKiTPo+6elrntvT+Rt9oyyfllIHPPztn6E
         AMgAd+cti0q2PIpZCmqa+53M6FMGgqopWY7vAOHGSxCNkrf/foktjhBwJH+a5YELsuw9
         XF1mVEDIFyi8X67CobT6bUg+97RvJ1erfqMntjBnD1aAc96+1wEzWu1H5mM5CO1zqpWo
         a0dmuVL1oI7pV1b1wX00ehvW4H2UYgovyMV9hN+RqMJgkknn2xWH9xyx7KapmIft9fqO
         eiGFijdxgjibQj5qyMoUGZYcBqGZ6xA1loK/uik3kr0mKTERo4zxdV4Vh8fZONN6NcUl
         MJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Qm98Qsqpzi3gp9jivym+i6z48ahQ8BsAtz2LbL2QzGM=;
        b=eONquCt8fH2jp/9S4h/X/m7mq/lziPVhvz9RJddQiIeNJxcQwJ0KFsTmlTF2kXGQeD
         37PFOcRkRMPGy2o22+wdmvHZyQ1gayhJHx9FXq8rYwi2Ka/NF5nQBTjwoDrCoiuE0C4O
         m4D8JkS+0h+tlQB9Z2KAnxjT7/v1QsCE5S1IWFNzcCnWPd2aXka5es/y6jHHpuYxc64c
         cr1jhjRq4nyP1zamJrLkyLgRK7Ciz4OFQV4V451WsaK6WJ2hyrgB9jBwbl9KskfmTk2X
         QgcJwc9pEfCDi/VYmKPyyaybTxDeG1Ku7XaU02PeKLdX6MKtTW8VHPNfLIs5YSf9NI/x
         6MSw==
X-Gm-Message-State: ACgBeo2jmi0lWcengeXX1UqGREnxQUAmQFyScuwwG1mpdSha0fheJfra
        rraXOhu4RkH4lF5fogzLsGuU5SLzbZc=
X-Google-Smtp-Source: AA6agR4ZCIV/zQ5QgCXqZL1tSRstVPAWNJ0xJI+TRfEYE9JMCrRk3UoUC3fqyJFKNwqKFVcnOK64XQ==
X-Received: by 2002:a17:902:a5c7:b0:172:dd10:f638 with SMTP id t7-20020a170902a5c700b00172dd10f638mr11390815plq.127.1661238606312;
        Tue, 23 Aug 2022 00:10:06 -0700 (PDT)
Received: from localhost.localdomain (121-200-9-125.79c809.mel.nbn.aussiebb.net. [121.200.9.125])
        by smtp.gmail.com with ESMTPSA id 22-20020a630d56000000b0041c66a66d41sm8506773pgn.45.2022.08.23.00.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 00:10:06 -0700 (PDT)
From:   Daniel Tobias <dan.g.tob@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Tobias <dan.g.tob@gmail.com>, nirmoy.das@amd.com,
        alexander.deucher@amd.com, trivial@kernel.org
Subject: [PATCH 1/3] amdgpu: fix typo debugsfs -> debugfs
Date:   Tue, 23 Aug 2022 17:08:37 +1000
Message-Id: <20220823070839.533562-2-dan.g.tob@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823070839.533562-1-dan.g.tob@gmail.com>
References: <20220823070839.533562-1-dan.g.tob@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Daniel Tobias <dan.g.tob@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index cb00c7d6f50b..5303a332e51c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1775,14 +1775,14 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
 				  &fops_ib_preempt);
 	if (IS_ERR(ent)) {
-		DRM_ERROR("unable to create amdgpu_preempt_ib debugsfs file\n");
+		DRM_ERROR("unable to create amdgpu_preempt_ib debugfs file\n");
 		return PTR_ERR(ent);
 	}
 
 	ent = debugfs_create_file("amdgpu_force_sclk", 0200, root, adev,
 				  &fops_sclk_set);
 	if (IS_ERR(ent)) {
-		DRM_ERROR("unable to create amdgpu_set_sclk debugsfs file\n");
+		DRM_ERROR("unable to create amdgpu_set_sclk debugfs file\n");
 		return PTR_ERR(ent);
 	}
 
-- 
2.37.2

