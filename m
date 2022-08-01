Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CADDE586284
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 04:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238707AbiHACUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 22:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238637AbiHACUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:20:44 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025FA12ADF
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:20:40 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id v18so9195842plo.8
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=n2C3cWPyEPK62L9QNW3odLHuxPFgMTmW2KM5Bt5TsxQ=;
        b=ST8eQORvYm28bCZgyqei+Qy7PRjx7Mr4o6WGtrfaC1aGclnURMntlThdQtNQAbkkHM
         96Mu3ySe/iwoC3NfI8yEEPggUX9FGrqRCn7X1XoMgthGcodxwgfa/dUE1vmo7sWbt6DU
         5wGhKADuPCIfwYBib1ZglyuKfNN9icDGGzzCXg4JrtI3gsaupeo7EoTLHtXZ0rr+lBtp
         A6UDt24OYSSAKZaf36mXn/DkU2vqbRv0feXiM/1ldfF6G/ZEMYKMRjsL6C8FVqdDp7Ow
         ddqZFOcwx6U/PgTlNjMBfERt1NkwQpbmtW5yr7o+UrTecgJyr+5adVgrY9PqfIYC3SJS
         Q+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=n2C3cWPyEPK62L9QNW3odLHuxPFgMTmW2KM5Bt5TsxQ=;
        b=hcydf/99BtDOyNY5C9ALTruGQ3k/VhtfTl+yg4CfhiuP0KeQt90V0CtGH/vJ+XqqQt
         x4/f1OoW2wRqeKJXQXJmSmFVNjZ/q6eGDClDxCpCzNAtZ03WlnXdtuxYJ6GKRNy8r7LM
         jZpHtpLjtB3Hv9mnJBnFLnbB9Sea6C0c6tvG/uDwemInH1CEqfmmfbWqMy/xdl3HTHwq
         8cLkyVTRkNozpohyyILZwiaHhWwmia6u6RTqUGatL0FhJg3HiXfG6dTnAUsT2C/Qc8ju
         depEnpas8cEKeFLmK1whS14Rb7kQ3sFqGz50eHcLlyA0pbZfEQSwMRxteaTuBPmSY3Fx
         RdnQ==
X-Gm-Message-State: ACgBeo10qtN+bk+kICTj4XDI0xZQ61aJoCE86xd2tv3igdaAxyjl075U
        F7+syxNdDKrYGB5nHgh+t23O+jnh+DE=
X-Google-Smtp-Source: AA6agR4AQb0aEtJpC0HeT9arpqIdbfchcfCcMOjmv4J8FVnMK5JP8zlZ8yhidgLcEeOlopA6wG/ZNQ==
X-Received: by 2002:a17:90b:3901:b0:1f0:2e50:6f3f with SMTP id ob1-20020a17090b390100b001f02e506f3fmr17505355pjb.233.1659320440077;
        Sun, 31 Jul 2022 19:20:40 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w13-20020a170902ca0d00b001677fa34a07sm8076285pld.43.2022.07.31.19.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 19:20:39 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] drm/amd/display: Swap with swap() function Use swap() to instead of : temp = a; a =b; b = temp;
Date:   Mon,  1 Aug 2022 02:20:30 +0000
Message-Id: <20220801022030.1594208-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 09fbb7ad5362..6e36a0f5989d 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -2906,7 +2906,6 @@ static enum bp_result construct_integrated_info(
 	struct atom_common_table_header *header;
 	struct atom_data_revision revision;
 
-	struct clock_voltage_caps temp = {0, 0};
 	uint32_t i;
 	uint32_t j;
 
@@ -2982,10 +2981,8 @@ static enum bp_result construct_integrated_info(
 				info->disp_clk_voltage[j-1].max_supported_clk
 				) {
 				/* swap j and j - 1*/
-				temp = info->disp_clk_voltage[j-1];
-				info->disp_clk_voltage[j-1] =
-					info->disp_clk_voltage[j];
-				info->disp_clk_voltage[j] = temp;
+				swap(info->disp_clk_voltage[j-1],
+					 info->disp_clk_voltage[j]);
 			}
 		}
 	}
-- 
2.25.1
