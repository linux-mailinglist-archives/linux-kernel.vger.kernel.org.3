Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23FE4CE608
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 17:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbiCEQxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 11:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiCEQxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 11:53:08 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6B13BA58;
        Sat,  5 Mar 2022 08:52:13 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 25so1282630ljv.10;
        Sat, 05 Mar 2022 08:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KyIZoma6nL6BsyhKxEeJM+MfxC8hS7UdkR4yW2TLSfw=;
        b=T1VjD4+QycZwunsFP2qTyxIOJ7gA4y/jJUm1IIwbtMsMkoQOTnjLTDyat4dE+1wIsu
         T2RG7Wd/M45aScOSibO8B2zjz4QQeTUerM7oI+xPTSJLfDmmou8KWiX3YhFdmtx+mqdn
         hv4h7fAzMka8UzGsTJOjYUIiO0VmvLCJ8u4XXRaUwIA1+y74KesMRBbmQllSfX42w4fx
         bPN2Pnytgo3bkva1I6wfi51Nx94o9OyrK1f/EmqbdZT9yqZbHjFtUyYU0+ErH34WIasi
         BSA9/YaW1nphMbn5GFlIr9/fnACoTfpqVu3HHHB2xAdW0JUhDjRLvIUExr9h+hDa1n/t
         hn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KyIZoma6nL6BsyhKxEeJM+MfxC8hS7UdkR4yW2TLSfw=;
        b=fjdMhYy5anpO26td+jk5DBPZEScYNM/Mge6yyNIy8v9ETIFLfYJNk9hlGUi/O0zUqm
         zJmMZNPs7lxCIDl74QoOsxrKblcjR3705rA07lPIG9QXy5E2BMJqpqAtn6c8ajdA9TxQ
         t6PB+kMRfFKrrO6Mtl0r//tuKJZ7N/yrw9MeVP/zf+NtuCYzHSPr/aBLg62a42f2x01W
         A6aCUiTnD0MiGfoJFVWGd2DmHFfMkRPJY0VQfbihQ2lkHA+58Pr+G8xu9hOdVUosgzrK
         SFZDIxnNK8WYPCPyvMniDi+SDRTp62ap/BznDQReufr+1pc6/O8RKgHITPbpw0SgL9QO
         qnxw==
X-Gm-Message-State: AOAM533ASPLOlZdSfpoiy53Wz0l3D8gFJNYxBS7yP2JZhaHoygHXUDMn
        E9rgEcxlTMNg1reNxjzSqm6rjXaCU8DoDccl
X-Google-Smtp-Source: ABdhPJzJXkXG/bwrZWdLIEoEJEJNecoVBdGZPfKnzIo2q+ClV+8OcVg9gNYTLJpgCPMt1p5ZozPTSw==
X-Received: by 2002:a2e:aa18:0:b0:244:bb00:db39 with SMTP id bf24-20020a2eaa18000000b00244bb00db39mr2413268ljb.341.1646499129796;
        Sat, 05 Mar 2022 08:52:09 -0800 (PST)
Received: from localhost.localdomain (adsa4.neoplus.adsl.tpnet.pl. [79.185.186.4])
        by smtp.gmail.com with ESMTPSA id n16-20020a0565120ad000b00443c3f383c5sm1751287lfu.231.2022.03.05.08.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 08:52:09 -0800 (PST)
From:   Adam Skladowski <a39.skl@gmail.com>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] firmware: qcom_scm: Add compatible for MSM8976 SoC
Date:   Sat,  5 Mar 2022 17:49:05 +0100
Message-Id: <20220305164906.16853-5-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220305164906.16853-1-a39.skl@gmail.com>
References: <20220305164906.16853-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add compatible for SCM on MSM8976.
Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 drivers/firmware/qcom_scm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 491bbf70c94a2..3163660fa8e29 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -1379,6 +1379,10 @@ static const struct of_device_id qcom_scm_dt_match[] = {
 							     SCM_HAS_IFACE_CLK |
 							     SCM_HAS_BUS_CLK)
 	},
+	{ .compatible = "qcom,scm-msm8976", .data = (void *)(SCM_HAS_CORE_CLK |
+							     SCM_HAS_IFACE_CLK |
+							     SCM_HAS_BUS_CLK)
+	},
 	{ .compatible = "qcom,scm-msm8994" },
 	{ .compatible = "qcom,scm-msm8996" },
 	{ .compatible = "qcom,scm" },
-- 
2.25.1

