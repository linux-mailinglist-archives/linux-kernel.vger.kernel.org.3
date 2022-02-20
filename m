Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020344BCE92
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 14:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243811AbiBTNOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 08:14:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiBTNOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 08:14:09 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1A53BA55;
        Sun, 20 Feb 2022 05:13:48 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 12so8418250pgd.0;
        Sun, 20 Feb 2022 05:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v3lcWy39/feSBR2awpXTCsURsclOCUkZfJp12n1k3gw=;
        b=Kzc1kuFvgvQ0dEq1XdjLtihLfBmtL17gacl5yN4yZAHsJqQMoutC+Dl6yLcqlyfcY+
         c+vwOJFlyoGF9+3y5A6M5LpwpjDlzQaU32+/x0n7UQqzOCJFeWYIlJzUobQexR4C7T8I
         xAhyIQM8BF7xsxr1uKOrtK2/qOWjTlcAAECoVeVOZ4jDLbCuVavnnmVUwS1gh+zyl80f
         65i5msB9/Rp6wPtXBrsDb5HB2427hb/jHKYfRNC9Vo94CKjYnO5n0yzbrszFxQ44IvLM
         XWqY93owYh/uB6f/sAWtVKHTGusZA37CagU8GemJm07HljbCWJGdnAP+v799LeVHtexe
         mOdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v3lcWy39/feSBR2awpXTCsURsclOCUkZfJp12n1k3gw=;
        b=FKt+QAiHznyYZaL//YxnbHP2R0gIITzFJGriUPLvgrPGG9up4ZFV0VfOXl8cXE0UVc
         MFYjLsxhDkDta1bgwML7X71Jwyg9j0Rib3jLnGYQp548HLx5rwDx54lK01T15cwpaaVQ
         c+vkhOCNxXt6cxRUho9+mLG6RLbREWfS1SdIYA0GJ0iA1vX7n1GdmIBbb1923uGfWBgv
         aFh9TuKDIUGdULHe3rz4W2PmMxohOte4dvHIb8jaUPY1gGDIZ4X1c8m7p91V83gizHj0
         sYJFhwYpj8sZ7Uu3VPpwO0ruKTYdPd44yRuQktf+BYASVlGefr+kOxFakoo3Urln19vF
         jQ2g==
X-Gm-Message-State: AOAM533IDGhIBmg5lKtgiww4YsHeQlVeugFIRNimyuv9eY/ibbuDgSa0
        Al9q8SIrr9GdKHaMIeHPwMwjffuGD9b+Bw==
X-Google-Smtp-Source: ABdhPJyRrh/7e91UMMmzE/lH0U70jf28jxjhWEXCvaFRNAabc6rRwMfLWxX+edDGzGrjyeqsNz+Fbw==
X-Received: by 2002:a63:1844:0:b0:36c:6a88:ad72 with SMTP id 4-20020a631844000000b0036c6a88ad72mr12416622pgy.329.1645362828150;
        Sun, 20 Feb 2022 05:13:48 -0800 (PST)
Received: from localhost.localdomain ([116.206.246.215])
        by smtp.gmail.com with ESMTPSA id s3-20020a17090a5d0300b001bc2b469051sm1419246pji.29.2022.02.20.05.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 05:13:47 -0800 (PST)
From:   Husni Faiz <ahamedhusni73@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     Husni Faiz <ahamedhusni73@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] usb: serial: Fix Space Prohibited Coding Style Errors
Date:   Sun, 20 Feb 2022 18:43:39 +0530
Message-Id: <20220220131339.179648-1-ahamedhusni73@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220212175510.521072-1-ahamedhusni73@gmail.com>
References: <20220212175510.521072-1-ahamedhusni73@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes "space prohibited before that ','"  checkpatch error.
Removed the space after the function argument value "8".

Signed-off-by: Husni Faiz <ahamedhusni73@gmail.com>
---
V1->V2 : Separated the style changes into multiple patches.

 drivers/usb/serial/iuu_phoenix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/serial/iuu_phoenix.c b/drivers/usb/serial/iuu_phoenix.c
index 0be3b5e1eaf3..2f7784572c4d 100644
--- a/drivers/usb/serial/iuu_phoenix.c
+++ b/drivers/usb/serial/iuu_phoenix.c
@@ -360,7 +360,7 @@ static void iuu_led_activity_on(struct urb *urb)
 	usb_fill_bulk_urb(port->write_urb, port->serial->dev,
 			  usb_sndbulkpipe(port->serial->dev,
 					  port->bulk_out_endpointAddress),
-			  port->write_urb->transfer_buffer, 8 ,
+			  port->write_urb->transfer_buffer, 8,
 			  iuu_rxcmd, port);
 	usb_submit_urb(port->write_urb, GFP_ATOMIC);
 }
@@ -380,7 +380,7 @@ static void iuu_led_activity_off(struct urb *urb)
 	usb_fill_bulk_urb(port->write_urb, port->serial->dev,
 			  usb_sndbulkpipe(port->serial->dev,
 					  port->bulk_out_endpointAddress),
-			  port->write_urb->transfer_buffer, 8 ,
+			  port->write_urb->transfer_buffer, 8,
 			  iuu_rxcmd, port);
 	usb_submit_urb(port->write_urb, GFP_ATOMIC);
 }
-- 
2.25.1

