Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C3E4DA3FE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 21:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351711AbiCOU3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 16:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241868AbiCOU3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 16:29:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BA713D79;
        Tue, 15 Mar 2022 13:27:59 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x15so155076wru.13;
        Tue, 15 Mar 2022 13:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h0qv9mDXmv5p2CFMjUqbXa1C/c2t8JyqpwfD6/zqQ/M=;
        b=fjiVnzPc4UZCBBrTPKOfYYmoXaUOtGyPRHh4ux1ZLiyfmsCcqUiOe1IB/LzQ1CyQt3
         IXGfKSN9eJrFDlOp3zY9DqxR38Qe1EK0Vvd62scS6r3EB2J6yW8x2+PINXyXpBQ9aGDV
         Xxlj5UAK2kc9OwuNWBiSKufcxt25YGZWTq5SXvG8QdQcl1D9CfThWz0+GP9CF/HYRv9e
         XveWpnYyXuESbrnUb6OZBQkG9nrFPE3N0ILVguJ4qPAB6+MSqTVaOHwj3OSyfXdFv5L0
         Dnv+QVQkEQRXBtWeRjAqnZgvrWOepS+AeZ8P7dah3xMRuOUff8pWEcxnCHmsl552b+AH
         A+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h0qv9mDXmv5p2CFMjUqbXa1C/c2t8JyqpwfD6/zqQ/M=;
        b=Gyt70LKYAHC6gVxQb3WGnP8ZUZULa23i8AG2Bi8olrd3DaUZzH5fcd3EUpGM9yk314
         b+y8RE5XVOvxA39ycR5+3iSbrEZtu5Sr5gXk2gWXC/kqrNl8BVRaolDYNKp69tEuXzD2
         zeD7mNmGihECqW7QjPFA3zz+ROphio1mYO1pWNVSpQPJVejpGKGXcFGdeN3lfmJvgv48
         /MntK9obr7zDVA6BcNky1218Dng8he5/H+VvIOivuHQ5kA+9eGDELaEqJFYkYdrSgvSE
         Alu8qs3K3ViWQKr6LqF7s8ioAyZc6fahdlFVo+n4zYZGPNsFIS5kTS0TfF0ErEjKzVnq
         YGMw==
X-Gm-Message-State: AOAM530Izjw9etZ27J/tFqVJeHBd+G38kulzaJKItAVQow+crzpr+TaL
        6jCFyftOO6JJObigp6LnU2+Tjmuod7QOlQ==
X-Google-Smtp-Source: ABdhPJxWml19jK5phIRP74Sz6aAEW6VQiwapgaPeuLaXEULiFk2g8DMD+bAHm+XedIs+G/5tQnMSOQ==
X-Received: by 2002:adf:b64c:0:b0:1e3:16d0:3504 with SMTP id i12-20020adfb64c000000b001e316d03504mr21433640wre.333.1647376077808;
        Tue, 15 Mar 2022 13:27:57 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bg42-20020a05600c3caa00b00380deeaae72sm2300849wmb.1.2022.03.15.13.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 13:27:57 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-acpi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] mailbox: pcc: Fix spelling mistake "Plaform" -> "Platform"
Date:   Tue, 15 Mar 2022 20:27:56 +0000
Message-Id: <20220315202756.2953329-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
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

There is a spelling mistake in a pr_err error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/mailbox/pcc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index ed18936b8ce6..2b209acdbab2 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -676,7 +676,7 @@ static int pcc_mbox_probe(struct platform_device *pdev)
 
 		if (pcct_entry->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE &&
 		    !pcc_mbox_ctrl->txdone_irq) {
-			pr_err("Plaform Interrupt flag must be set to 1");
+			pr_err("Platform Interrupt flag must be set to 1");
 			rc = -EINVAL;
 			goto err;
 		}
-- 
2.35.1

