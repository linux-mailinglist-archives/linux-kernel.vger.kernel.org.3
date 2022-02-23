Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9720F4C0ECD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 10:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239181AbiBWJDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 04:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239117AbiBWJDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:03:18 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2049A3D488
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 01:02:50 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id w27so12072116lfa.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 01:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=karuga-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UYUz8Ivg2sbFi9UjIBOKZiugtmcYnDRDXJxBmoWlVVg=;
        b=sHXbPaiDyQ3l/e6qLDfuZeJXm2/PKiAgNVSSJYjNmC5GMFt8QDF4Y8dTpVE8OIcpTo
         loJTHj58geHyrTR/YmU5b4+wn/ojLgliBle3iateISLnKnfELvKp808M3oo7z7mNapA7
         bpYaSzBZee14Kw/BceIV2sB74QYFDmFggaoaqazsHY8i+Rr4JvzyZro1qpa1iWa426pL
         NfqEeNFd9cn02kYPz+QMj8GE/Hexn27XZV/QhvZMdMQ6NBwNFQrc4tWNAw4uemQfUAbq
         Qad0ca+nDUEu/hAUwrkkXSGPzVCYtc9uWxjil+F25yGhXuyyKkXJHkIahlw7hAh5YJwp
         fdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UYUz8Ivg2sbFi9UjIBOKZiugtmcYnDRDXJxBmoWlVVg=;
        b=5SOEToFwxNSmhZDFYsVyhsathtA8hN/SIYQ01Oyn7gVvLVdHii3aZBCD53eXsYN924
         gwzP1qlmT49lEauqJzvXgWZb+oqNxVH4mWC9kKeIC3HHqw2bk1LNmPRujeYM4Y+M+9oG
         IwbTFb0X01tLlZLzGPBu/Npb7TuMcCxrR4ENlZf65p+Gcq4lwFAYdTodNW/XvKA82ylj
         HE0NCAykNu+iK3B/uc0CDGRrB3V2Oe1db6/A8NTMvXWkZVbAXC1zvkvqeTcd+aKgnr8Y
         pUa2+OHPYmEJki9aE1J/Yl9Yfu86rlYuVf+DA2xq9IgSoe9iH5YgTjGR404q38W43UCJ
         uBeA==
X-Gm-Message-State: AOAM5300GhjW9U2CZ8Uu/T0yEQkIEEXmfJKvteiJ0O9839H+S1XYt+42
        79WWEeCd8meAErksig1OG3WZmC1Pyt76e0Za6NTXJQ==
X-Google-Smtp-Source: ABdhPJzRxqYdGtINoTjRLuYEfhz/riWHFWKne4XGoI6AKqqyyI0KzUhiRfsSiUXDz3QTbCSq5IdOYQ==
X-Received: by 2002:a19:a404:0:b0:443:2ef6:1ae7 with SMTP id q4-20020a19a404000000b004432ef61ae7mr20699528lfc.554.1645606968882;
        Wed, 23 Feb 2022 01:02:48 -0800 (PST)
Received: from virtualbox.. ([197.211.27.230])
        by smtp.gmail.com with ESMTPSA id k12sm642562lfg.108.2022.02.23.01.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 01:02:48 -0800 (PST)
From:   Wambui Karuga <wambui@karuga.org>
To:     zackr@vmware.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-graphics-maintainer@vmware.com
Subject: [PATCH] drm/vmwgfx: make vmw_pt_sys_placement static
Date:   Wed, 23 Feb 2022 12:02:44 +0300
Message-Id: <20220223090244.576093-1-wambui@karuga.org>
X-Mailer: git-send-email 2.32.0
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

Converts the variable vmw_pt_sys_placement to static to
fix the following Sparse warning:
warning: symbol 'vmw_pt_sys_placement' was not declared. Should it be static?

Signed-off-by: Wambui Karuga <wambui@karuga.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
index b84ecc6d6611..21057ff0d340 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c
@@ -120,7 +120,7 @@ struct ttm_placement vmw_sys_placement = {
 	.busy_placement = &sys_placement_flags
 };
 
-struct ttm_placement vmw_pt_sys_placement = {
+static struct ttm_placement vmw_pt_sys_placement = {
 	.num_placement = 1,
 	.placement = &vmw_sys_placement_flags,
 	.num_busy_placement = 1,
-- 
2.32.0

