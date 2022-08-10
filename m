Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 367AC58EDCD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 16:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbiHJOCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 10:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbiHJOB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 10:01:59 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377FA6CD3B;
        Wed, 10 Aug 2022 07:01:57 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id dc19so27822921ejb.12;
        Wed, 10 Aug 2022 07:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=bP8LP7Iq6Ef009AhSK4u5faUfPJtfq7x6vlBRz0vKas=;
        b=TijWU1YImPghIYNgR8/CWyY/PZWAzeKl22HkIoJ4ne6EKKppFPm9MvHm56JvjZCBRN
         1az2JaXpNqj3Vl2eodZwwVO0u9zbgandZSudKc9Ldgpy+y1ZpYYZNiYWLkNadL2lvH/v
         MXR4Jgit8tdtFv12d62/MAXe7jYUhg6RJSaPtonzzVqcGG+HgvpND7H+qEb9gN2HG2vU
         7Z8hOYLAiWGJebd3qcf7hME752+46DshpXmQ+hL9SiwRJGdC7OFmZEX8CBX98pPpGxSc
         zI1DIhxIgRUXJKvOHl37SkGFx+94HMM6D13SU+xuji/rEH94Zigb+fIjDI3MkeiXMy7I
         bdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=bP8LP7Iq6Ef009AhSK4u5faUfPJtfq7x6vlBRz0vKas=;
        b=YH/DbZVh9SsshUVeMct9EqcchZtNddoL+nJWS6ANt3ttZeMerDGrjs9oZU3r/qkoOk
         cpUVaJlEOBsQ/qOA3AOwGarb+Zq+7b35qkL3OweJzT34GgPjzsuEohnFOvjmpXhS5M9e
         6qDE3UmLgDA28lfOJsfxygLfSzawwrsSL22GQ33kUTZhDimCAG7JV1j0U2Jzqr9bGBqQ
         Qfj+JRMl7VMaw6j4mHKJAHVu6Ha7/Y2H2OTZXEEWeABA2WE5mG4l/bfpeiI4se4Pq7Bw
         lOaOQQO6a8IV1/jG7X9bACwT+zMqTRQDw8vZPxpyXhWgSng8fRoo8ghzhIX+1WnhyOMp
         SunQ==
X-Gm-Message-State: ACgBeo3DFsAOre8PgBO7h5YhY5Lmd37a6U69I5yRYrHl8ww6+ouiA/jQ
        8FxrV+k9/qw00ohFK5XhVfA=
X-Google-Smtp-Source: AA6agR461AETEjbmlAgbthQrphmCvR+8xaY7mBCUtzkT615M5qJ16zQCwVz6+7I9POz9RPFNPcpPWg==
X-Received: by 2002:a17:907:28d6:b0:731:100c:8999 with SMTP id en22-20020a17090728d600b00731100c8999mr15647407ejc.210.1660140115247;
        Wed, 10 Aug 2022 07:01:55 -0700 (PDT)
Received: from xws.localdomain ([37.120.217.162])
        by smtp.gmail.com with ESMTPSA id kz22-20020a17090777d600b0072b2ffc662esm2344013ejc.156.2022.08.10.07.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 07:01:54 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH] platform/surface: aggregator_registry: Add support for Surface Laptop Go 2
Date:   Wed, 10 Aug 2022 16:01:33 +0200
Message-Id: <20220810140133.99087-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Surface Laptop Go 2 seems to have the same SAM client devices as the
Surface Laptop Go 1, so re-use its node group.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/surface_aggregator_registry.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index ce2bd88feeaa..08019c6ccc9c 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -556,6 +556,9 @@ static const struct acpi_device_id ssam_platform_hub_match[] = {
 	/* Surface Laptop Go 1 */
 	{ "MSHW0118", (unsigned long)ssam_node_group_slg1 },
 
+	/* Surface Laptop Go 2 */
+	{ "MSHW0290", (unsigned long)ssam_node_group_slg1 },
+
 	/* Surface Laptop Studio */
 	{ "MSHW0123", (unsigned long)ssam_node_group_sls },
 
-- 
2.37.1

