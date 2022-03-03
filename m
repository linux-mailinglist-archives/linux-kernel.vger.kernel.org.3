Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151DD4CB9EF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 10:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiCCJQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 04:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiCCJQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:16:09 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17568119852;
        Thu,  3 Mar 2022 01:15:24 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so2805435wmb.3;
        Thu, 03 Mar 2022 01:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tOD3C8xPHi26AvWtZ3j95f7BpqGMvl1acGZhVPnpW/Q=;
        b=La7Rj/5s2w5fQs8YKLblq0ik4nHVSzMfqmvcYqJbNiv/ss46EHYUZ1h0ZXF812ko/H
         Qj86S1IvRcuYuCf1uqCH+gt4ssUwdzIfwmpeCFrzwvJxyMoP02MnWNs8ZJTypjUM7BjL
         Wnqx0rkPUL5Zm7c0R0zrIUqAi9endXLbNI38LDbguY69nfVHc+dKROe+CczPEYcK/sTp
         Mecf0DCZyVWBElQ1U39YEBzCD9QCgRgPcgOGsejsorPrUU1ernU9C5ljMhWl2t1n4eeg
         jvb3JkE1bzawcuAc/xgd/ogCGxDM4TXa5RK/jJgapHsK1rtCcCt2nXiN4t5/r7k+1HtT
         AhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tOD3C8xPHi26AvWtZ3j95f7BpqGMvl1acGZhVPnpW/Q=;
        b=qfXGmVuJPoe6ooA1HQas1vgvxFqhSw2FX8+4MeOer0pRRMl6NZbzR4EaQxJLvqANJv
         YZFcno/oObLXi/EkDXifFLbTCpVIHy2HtmL1HqJry2UtP7vX7sxCcSJpatlEHDVc0KmV
         rE72oF4YaYFHttavhj1d7cc0Yt+HeC1mvvvDwy/QiiN42cbFbFUvnAHS+x44agyA6Px7
         pki6nravgF2Pe6frIEyiaFGRn8fDRmokkKt+97X5BmWp0wCM6BojdVXtzi4asxON6l/M
         31W4P8Nq6AS4rsM9cSTWXWKo1sgjNEu+eyuauEnEwGattOL6iWQTxGFlrrhP495VyCaU
         SOPA==
X-Gm-Message-State: AOAM530EWIA8MDemag0JlcVXdFu9X4YXFQlTALZF7QTGxyVClAnecje4
        2PbOYzRB/HnVZt/FD3PIPQU=
X-Google-Smtp-Source: ABdhPJwWB2LCuprSAfbuxvHg5K+zwwrZvsjM29AmBxc/03tvN08WM9x2uv6KJazvCeoPH1L6UspUnw==
X-Received: by 2002:a05:600c:3c8b:b0:37f:1546:40c9 with SMTP id bg11-20020a05600c3c8b00b0037f154640c9mr2996657wmb.161.1646298922503;
        Thu, 03 Mar 2022 01:15:22 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id i15-20020a5d522f000000b001e85b14dadcsm1479923wra.5.2022.03.03.01.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 01:15:22 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-mips@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: tee_bnxt: remove redundant assignment to variable nbytes
Date:   Thu,  3 Mar 2022 09:15:21 +0000
Message-Id: <20220303091521.1125841-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The variable nbytes is assigned a value that is never read, it is
being re-assigned a new value on the following statement. The
assignmen is redundant and can be removed.

Cleans up cppcheck warning:
drivers/firmware/broadcom/tee_bnxt_fw.c:148:10: style: Variable 'nbytes'
is reassigned a value before the old one has been used.
[redundantAssignment]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/firmware/broadcom/tee_bnxt_fw.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/broadcom/tee_bnxt_fw.c
index a5bf4c3f6dc7..6d92ec02f2c7 100644
--- a/drivers/firmware/broadcom/tee_bnxt_fw.c
+++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
@@ -143,8 +143,6 @@ int tee_bnxt_copy_coredump(void *buf, u32 offset, u32 size)
 	prepare_args(TA_CMD_BNXT_COPY_COREDUMP, &arg, param);
 
 	while (rbytes)  {
-		nbytes = rbytes;
-
 		nbytes = min_t(u32, rbytes, param[0].u.memref.size);
 
 		/* Fill additional invoke cmd params */
-- 
2.34.1

