Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1944CC00D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 15:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbiCCOfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 09:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiCCOf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 09:35:29 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DEA15C9D1;
        Thu,  3 Mar 2022 06:34:43 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id p9so8130160wra.12;
        Thu, 03 Mar 2022 06:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GxN8h7L2LXnHB8VpVtq2yQnoP4VfiQvLPMhymszGuv4=;
        b=Lel/0NQb4buqvKc+9T/sn4AIpQy82QTeubDPa/IAXmzmeMn6SZBELOCSaycLRNXTHD
         9EmNscSIAej+JsMIpuFm8q0McIYxSxIxq1dWfHZFhHMBXXHXoGA0ApciSWdVR//P+587
         QJEuJsFwTYSjN2ZedMJepqp/KFz5PnAo827XBdTWJi+QTPBQz2ttPXkNzG3hiB6o0rns
         nLnkK/8DdMNQVjT91fcEK3RHdiAH18eNc/GqH8sGl348Zs6lqBV2mH8d+lLOAc4khhL8
         Xt942lE3fo4yEq1lah7IKQAiSxhKTleaE/Wt7UtuLxIF1NZY15ay5Drddl3rQ7WtR9cw
         sZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GxN8h7L2LXnHB8VpVtq2yQnoP4VfiQvLPMhymszGuv4=;
        b=NJ3/Clmf9VFZ+YjJKExX+ur59sTM1EfpOWPI5PLZBBn1E6TvkMqazbKVKjTrdfCzPo
         0SEc0Sox4kDgpjzNucSC5RXkAlRDo+Q7AqpOJoHLNbu0I9q/WUSmxyBq+EVj62/bQ1kD
         Z5Hdvn17sPFztCm0qtE/+APpbAKrtZtdbJgLIkbSwOIF3UILNGkTbsmUvcC9W8+Um4v8
         pl/22jGkmKWTVDcCNO4AINcNl8EFZbEWQf4yyq3ZRODd61tfxE5iV6ZO2q8Gj58w6BjN
         3gN4VsIclmyaX1pFs8gHwSOTatHzHgBqvtN3Z+5cc1udSn/wBJhD5+kEDlLw3lC7J7Wy
         lcBQ==
X-Gm-Message-State: AOAM531Q/it50wU+JFLJzr44v2yVvIeiDaUnvg+s+m90qs4mZgA4ZPNb
        DzNZ4Rn8hINShd5EAqzHva1Zpj/SnI0sVA==
X-Google-Smtp-Source: ABdhPJwycauQBU16hXmq8/RdYtzLbTamgVEta0wBzuUfMQAZDc/8XT6dWw5g2Xq6AzEupFOT02hmjg==
X-Received: by 2002:adf:f94a:0:b0:1ef:9485:e43d with SMTP id q10-20020adff94a000000b001ef9485e43dmr17061994wrr.552.1646318081857;
        Thu, 03 Mar 2022 06:34:41 -0800 (PST)
Received: from localhost.localdomain ([105.66.7.237])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c4e8800b00380ee4a78fdsm3018255wmq.4.2022.03.03.06.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 06:34:41 -0800 (PST)
From:   Nour-eddine Taleb <kernel.noureddine@gmail.com>
To:     christophe.leroy@csgroup.eu, paulus@ozlabs.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org,
        Nour-eddine Taleb <kernel.noureddine@gmail.com>
Subject: [PATCH] arch:powerpc:kvm: remove unnecessary type castings
Date:   Thu,  3 Mar 2022 15:34:16 +0100
Message-Id: <20220303143416.201851-1-kernel.noureddine@gmail.com>
X-Mailer: git-send-email 2.33.1
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

remove unnecessary castings, from "void *" to "struct kvmppc_xics *"

Signed-off-by: Nour-eddine Taleb <kernel.noureddine@gmail.com>
---
 arch/powerpc/kvm/book3s_xics.c        | 2 +-
 arch/powerpc/kvm/book3s_xive.c        | 2 +-
 arch/powerpc/kvm/book3s_xive_native.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
index ebd5d920de8c..ec208d0c8d13 100644
--- a/arch/powerpc/kvm/book3s_xics.c
+++ b/arch/powerpc/kvm/book3s_xics.c
@@ -1440,7 +1440,7 @@ static int kvmppc_xics_create(struct kvm_device *dev, u32 type)
 
 static void kvmppc_xics_init(struct kvm_device *dev)
 {
-	struct kvmppc_xics *xics = (struct kvmppc_xics *)dev->private;
+	struct kvmppc_xics *xics = dev->private;
 
 	xics_debugfs_init(xics);
 }
diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index 225008882958..0c1f4819884c 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -2368,7 +2368,7 @@ static void xive_debugfs_init(struct kvmppc_xive *xive)
 
 static void kvmppc_xive_init(struct kvm_device *dev)
 {
-	struct kvmppc_xive *xive = (struct kvmppc_xive *)dev->private;
+	struct kvmppc_xive *xive = dev->private;
 
 	/* Register some debug interfaces */
 	xive_debugfs_init(xive);
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index 99db9ac49901..1405b3f4e94e 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -1276,7 +1276,7 @@ static void xive_native_debugfs_init(struct kvmppc_xive *xive)
 
 static void kvmppc_xive_native_init(struct kvm_device *dev)
 {
-	struct kvmppc_xive *xive = (struct kvmppc_xive *)dev->private;
+	struct kvmppc_xive *xive = dev->private;
 
 	/* Register some debug interfaces */
 	xive_native_debugfs_init(xive);
-- 
2.33.1

