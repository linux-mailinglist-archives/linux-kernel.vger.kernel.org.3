Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1127E53B1BB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 04:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbiFBCsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 22:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbiFBCsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 22:48:14 -0400
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29261B4361
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 19:48:13 -0700 (PDT)
Received: by mail-pf1-f195.google.com with SMTP id 187so3576689pfu.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 19:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Qfj25vgUy2vlco/zeYZvtjrkAOyeuWII5kfYsnOot4=;
        b=4ywCLiSA69lecCzyVMUj2zP0hzTejmApx7HYd2lH2LOAqOL7nYxitPQsExCK2G5+HC
         D/8Ck+BneTvgf3D/S6cGvsz+VKLLn9yrdMjAsVCEuqJmWjlP41wD4phTW7191ZwISucg
         Nu1IXmCT5/tn2IIdhPd6UISZtV/jRxgPtnofvcxheKS5ZuaXEeynY/OKwShdnbiXXPOE
         xD6cdaYE0cTVkwnYZh80YVKQQnBvh558MzMnEB3oXfY7ZUl/trJv4MLXevypn3Tu2/kq
         y6W1hQvWQXQnTPcKb5lt/Sbo6yTp2sUq6JU2V94+yWaeunGf+IRciNmM45cKZscPF/Y0
         ofYw==
X-Gm-Message-State: AOAM533MFcCTIWo74Twq4kDhbOaTG/xcYbLioZ6gxuCqHoklJqP/8Thq
        eQuPcZZRJRjSHExoV4MUOg==
X-Google-Smtp-Source: ABdhPJwj97f92+oKYJX3/nM4SU6Juy4SkU5cImZOTxgJnaFU3BKykF87LgnQ1Evw/0j5RBZ2qtDh1A==
X-Received: by 2002:a63:6a84:0:b0:3fa:e914:79b5 with SMTP id f126-20020a636a84000000b003fae91479b5mr2234833pgc.365.1654138093288;
        Wed, 01 Jun 2022 19:48:13 -0700 (PDT)
Received: from localhost.localdomain (ns1003916.ip-51-81-154.us. [51.81.154.37])
        by smtp.gmail.com with ESMTPSA id i3-20020a170902eb4300b00161ccdc172dsm2159645pli.300.2022.06.01.19.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 19:48:12 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     maz@kernel.org, julien.grall@arm.com, james.morse@arm.com,
        will@kernel.org, catalin.marinas@arm.com, suzuki.poulose@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, sunliming@kylinos.cn,
        kelulanainsley@gmail.com, kernel test robot <lkp@intel.com>
Subject: [PATCH] KVM: arm64: fix the inconsistent indenting
Date:   Thu,  2 Jun 2022 10:48:05 +0800
Message-Id: <20220602024805.511457-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the inconsistent indenting in function flush_context.

Fix the following smatch warnings:

arch/arm64/kvm/vmid.c:62 flush_context() warn: inconsistent indenting

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 arch/arm64/kvm/vmid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/vmid.c b/arch/arm64/kvm/vmid.c
index 8d5f0506fd87..d78ae63d7c15 100644
--- a/arch/arm64/kvm/vmid.c
+++ b/arch/arm64/kvm/vmid.c
@@ -66,7 +66,7 @@ static void flush_context(void)
 	 * the next context-switch, we broadcast TLB flush + I-cache
 	 * invalidation over the inner shareable domain on rollover.
 	 */
-	 kvm_call_hyp(__kvm_flush_vm_context);
+	kvm_call_hyp(__kvm_flush_vm_context);
 }
 
 static bool check_update_reserved_vmid(u64 vmid, u64 newvmid)
-- 
2.25.1

