Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624BF4D0693
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244820AbiCGScA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244815AbiCGSb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:31:58 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C17E811A9;
        Mon,  7 Mar 2022 10:31:02 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id i8so24724665wrr.8;
        Mon, 07 Mar 2022 10:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m72AqO39IssFZDp6OQ50uBNhRiFL6qd5FMbmNqInMYY=;
        b=HG61rhPPl9ijRh/DZjgsmR3XRCPX1iN+yDTPO4PeEJ0JpRqVmDcfGpwFqmwcSp6+6d
         cgebmSecr2IZzjfmNSNVux931ao5vRa6VgGAO/I6H8rv5tfNjHw04WBUabXBhdbpB8RN
         blalDdsFWmw5RVfjNfZMRrh4ebsmXAnZL9kUCrraKLoBHvZZ1X3Npz4kxI5QeXHgfFq5
         wRf0Q1kt+cti0BPtl1h8Y8KkYtAfKEZPWqusx+0ADysc50rydtVt97Buo4HWBwDWTCx9
         w+FaTbI3/fmy3/AlmN8mQEEulymHvFKwFes2F76kBnOKoCm/YqB2c3ddSQSweQt9u+ev
         VF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m72AqO39IssFZDp6OQ50uBNhRiFL6qd5FMbmNqInMYY=;
        b=1n4WQUscXjMSZCQ1aO8yD8vYxKUVv1bqhi1s7OdWDG0EHLvq9eTgW+gBsp4HQTtzfq
         RmvRUyIoTV5jzE2m+djYzZITSUk5l7adHXUVEHeEQ4RAgVnL6aDtyW0/uaCGzl244YIq
         ldN6xBq1otUHNnkhUTZEVUjtq+gBJK/VZ/gDKzO3TU+/A1ISYJ47vaijOjwE6YzCinrB
         zwASIb5KAE/rIzs8cNxGFvHIUeC9kBnMBXAkxOmrfvS8uiPWEnEI98E3S2pfH9RpMcBT
         DpXlwvNTbEZwtrANPctljcsAg5WMvqaZFxCWBmAtYRMauvr2QPzIMB9T8vVdoORs0Yqp
         EYvg==
X-Gm-Message-State: AOAM530LnlVqQdx1bwuLfYMAqueVW2lfZtZsA1DcY7gUyVZK7WLtkZgk
        3hd02gd1EDa11wO3/9doK7A=
X-Google-Smtp-Source: ABdhPJxY7q8nq1BsndaRkG27EN2+/8HLVeSIn5ggzQYJgfOt/hH8PMDTLAG/+sdpy1hRcaUn75eAtQ==
X-Received: by 2002:a5d:6852:0:b0:1f0:98e7:a963 with SMTP id o18-20020a5d6852000000b001f098e7a963mr9303209wrw.646.1646677861176;
        Mon, 07 Mar 2022 10:31:01 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id h13-20020adff18d000000b001f1de9f930esm13371560wro.81.2022.03.07.10.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 10:31:00 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] USB: serial: usb_wwan: remove redundant assignment to variable i
Date:   Mon,  7 Mar 2022 18:31:00 +0000
Message-Id: <20220307183100.150082-1-colin.i.king@gmail.com>
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

Variable i is being assigned a value that is never read, it is being
re-assigned two statements later in a for-loop. The assignment is
redundant and can be removed.

Cleans up clang scan build warning:
drivers/usb/serial/usb_wwan.c:151:2: warning: Value stored to 'i'
is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/usb/serial/usb_wwan.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_wwan.c
index cb01283d4d15..dab38b63eaf7 100644
--- a/drivers/usb/serial/usb_wwan.c
+++ b/drivers/usb/serial/usb_wwan.c
@@ -148,7 +148,6 @@ int usb_wwan_write(struct tty_struct *tty, struct usb_serial_port *port,
 
 	dev_dbg(&port->dev, "%s: write (%d chars)\n", __func__, count);
 
-	i = 0;
 	left = count;
 	for (i = 0; left > 0 && i < N_OUT_URB; i++) {
 		todo = left;
-- 
2.35.1

