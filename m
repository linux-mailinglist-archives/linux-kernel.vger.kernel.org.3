Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4F255E3A8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345845AbiF1Mpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345367AbiF1Mp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:45:26 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EEA193ED;
        Tue, 28 Jun 2022 05:45:23 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z7so17351981edm.13;
        Tue, 28 Jun 2022 05:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QkD5ZdlMfFp9BqXoXwOYIRoxn3i+2Ef4KXobvEMyiVo=;
        b=RARWGWYAnD1Tn9kDygIdnwtnUPjcHumdDo4lilQszfGD18lQdgNgi/Ryn1jc+D1oug
         D96C3smjnVPUr1RCcaPTZBUpoNhJsICKCnWV07vAJ+dil1HAN8mhg+3mc8S2vm0PAlDP
         tx6BBB8nKfouvX5z+OZPqAKaSu5FlF1sIgUgb7ml2HV5BKV16WYJx2jhYQYRirHYFpcH
         ongbZI5osfzqM9O1WAGweu+dmoyVyh7X66dqEPYg56HWLqVhBRX0Jjail790UpANcCmU
         3L34pCNmjrfoVERLs7tKWqbCa0iwLMJcHEwa+k0+sjm3gYzkTxIsGzv8NTUgsz9vCGhI
         wx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QkD5ZdlMfFp9BqXoXwOYIRoxn3i+2Ef4KXobvEMyiVo=;
        b=ddRE9AADGEdEnPkvqY2ZK9w39v37F9otLM1AEWtAKyxkslrE5nwjKsaBBujAda4Oyt
         86rCWBl1tsO4/lxtk2BQaf1HOsxEkZCwZkhRU4hDGWnsIDxpKhbuwGgHDJ+dDT7EpDdg
         mUG8L4pxZe9SA22vxMQ+kJkVAi8log+yl7QwfgkQH1kMHqf3K5lwTAHxX8Xkljsko1ps
         nh3oVcHr9lidhey2gnv8uZbQRICOEMACArzNXycn76PYSgZCRqM49zQkZPm3jkl6j6V5
         JPjKRHhAa2JzA3YR03gHLrkzRR+C9PCRwSs+vB8EXSXCpQ6uV9nFJBZ5p+2XfbV3xfRu
         bZCw==
X-Gm-Message-State: AJIora+1oLIlYhN0tLDYKzS7Y7U10vgQWvqICZVaCI1Vcx/CG4qPCBSh
        TAKJwM11xs7n9KkVEK3yU5o=
X-Google-Smtp-Source: AGRyM1ssn0vDK56CFH/r87RlWCyxx7oYUzSFnXO1WBdJwdhLCtV04NDaUAeCU7F3U3g+HfhhvVTPDg==
X-Received: by 2002:a05:6402:51c7:b0:437:a22c:60f5 with SMTP id r7-20020a05640251c700b00437a22c60f5mr8917530edd.281.1656420322252;
        Tue, 28 Jun 2022 05:45:22 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-114-061-215.95.114.pool.telefonica.de. [95.114.61.215])
        by smtp.googlemail.com with ESMTPSA id f13-20020a170906824d00b00726e108b566sm622871ejx.173.2022.06.28.05.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 05:45:21 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        vkoul@kernel.org, kishon@ti.com, rtanwar@maxlinear.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 6/9] reset: intel: Add and update compatible strings Lantiq SoCs
Date:   Tue, 28 Jun 2022 14:44:38 +0200
Message-Id: <20220628124441.2385023-7-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220628124441.2385023-1-martin.blumenstingl@googlemail.com>
References: <20220628124441.2385023-1-martin.blumenstingl@googlemail.com>
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

Amazon-SE, Danube and xRX100 only have one reset request and one status
register whereas xRX200 has two of each. Add compatible strings for the
former three and update the compatible string for xRX200 to the same as
in Documentation/devicetree/bindings/mips/lantiq/rcu.txt (old RCU
binding documentation).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/reset/reset-intel-gw.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/reset-intel-gw.c b/drivers/reset/reset-intel-gw.c
index effc177db80a..46ed7a693666 100644
--- a/drivers/reset/reset-intel-gw.c
+++ b/drivers/reset/reset-intel-gw.c
@@ -223,7 +223,7 @@ static int intel_reset_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct intel_reset_soc xrx200_data = {
+static const struct intel_reset_soc xway_data = {
 	.legacy =		true,
 	.reset_cell_count =	3,
 };
@@ -235,7 +235,10 @@ static const struct intel_reset_soc lgm_data = {
 
 static const struct of_device_id intel_reset_match[] = {
 	{ .compatible = "intel,rcu-lgm", .data = &lgm_data },
-	{ .compatible = "intel,rcu-xrx200", .data = &xrx200_data },
+	{ .compatible = "lantiq,ase-rcu", .data = &xway_data },
+	{ .compatible = "lantiq,danube-rcu", .data = &xway_data },
+	{ .compatible = "lantiq,xrx100-rcu", .data = &xway_data },
+	{ .compatible = "lantiq,xrx200-rcu", .data = &xway_data },
 	{}
 };
 
-- 
2.36.1

