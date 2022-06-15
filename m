Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01E254C2B4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245552AbiFOHfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245205AbiFOHfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:35:22 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2433F4756E;
        Wed, 15 Jun 2022 00:35:21 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id j5-20020a05600c1c0500b0039c5dbbfa48so611343wms.5;
        Wed, 15 Jun 2022 00:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6231YElwpY0EMQw/jVrtaouMPdsWUXcvBmdiLPb1PQ4=;
        b=YQiPihd7vfYxTOea4eaxk6vyRopNf5N4OX8VEVZW9Fw7eCPaaCqHGtFLvvCJBB9xiW
         +EPPQbDSQ/wjQjzo3tpHCC88vX0TwD7lYgbIL4PHfR3Lq+wl6lR7mx/HwhXhJ0jOkI+G
         ancgT5HSvQ3NXGBNOS/EmXaOafJWmxgaruoOmCXsGeXJNrNuPdSI5UfSwXKiDvEmf41b
         qqRBRXynxr9t3F2RCvq1z5QBX8AiTtbacCj/H4f/NRIfZ4jHabwBbmyHvE108rmMM2wz
         XmE+PSUZo+8oOXmM+veBs66DFSyrtenU5aWWCNKbkYzcB6wB0HiNJXYcs6/VWZN4cI8q
         vfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6231YElwpY0EMQw/jVrtaouMPdsWUXcvBmdiLPb1PQ4=;
        b=1Z48Api1k7kb+FV482jj0d46sqcfV8OtAfjcrZCBhgKJuytMEpKC1p2F9kB8uamgC4
         x6dkMSMMO3bcoNsmR0QcRaIWbMfXr2tIvtr0d1X9npUrFODhkXvEjq25UMU/tv4DrTl0
         vxdk97s6fauoU7CdiIuwSrSZIsERRbPdPQfFgqsxy6ZfNJQmdJnvxmvcto5TR40/c2hi
         pMuenYJ9MtYL9OdIxuSs6dqaeyYJk0xIdCdpsDBmPC8iv/zO0cMDXkkHY/vkfLUiHmIj
         cKaefpnnAzJfi5T9XsnnILHEnvRyX2uir4ls1aViIHm0SBLvzyzoargLIMrnVRJ2dsWO
         U+kg==
X-Gm-Message-State: AOAM531uAfT2roFh7DttIcWAStukLCRZJrZWhBQYaF8EodSKg37b7xIJ
        mh9unOZWn95PSGpXV0RYjOCesmUBNGIQCfPG
X-Google-Smtp-Source: ABdhPJxh39A5lnBvRYI/2TeMwxhzEyOmO3E10gV5vCOnbG6aQ091rRCB9B4vaiuLlJlnkIUtCS6w+w==
X-Received: by 2002:a05:600c:1d1f:b0:39c:5350:c5a3 with SMTP id l31-20020a05600c1d1f00b0039c5350c5a3mr8084676wms.136.1655278519588;
        Wed, 15 Jun 2022 00:35:19 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id m17-20020adfc591000000b0020fff0ea0a3sm14224612wrg.116.2022.06.15.00.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 00:35:18 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Neal Liu <neal_liu@aspeedtech.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] usb: gadget: ast2600: Fix a couple of spelling mistakes
Date:   Wed, 15 Jun 2022 08:35:18 +0100
Message-Id: <20220615073518.192827-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
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

There are a couple of spelling mistakes, one in a dev_warn message
and another in a SETUP_DBG message. Fix these and remove an extraneous
white space too.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/usb/gadget/udc/aspeed_udc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index 1fc15228ff15..05cfcc4812b8 100644
--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -904,7 +904,7 @@ static void ast_udc_epn_handle_desc(struct ast_udc_dev *udc, u16 ep_num)
 	int i;
 
 	if (list_empty(&ep->queue)) {
-		dev_warn(dev, "%s reqest queue empty !\n", ep->ep.name);
+		dev_warn(dev, "%s request queue empty!\n", ep->ep.name);
 		return;
 	}
 
@@ -1036,7 +1036,7 @@ static void ast_udc_ep0_handle_setup(struct ast_udc_dev *udc)
 
 	memcpy_fromio(&crq, udc->creq, sizeof(crq));
 
-	SETUP_DBG(udc, "SETEUP packet: %02x/%02x/%04x/%04x/%04x\n",
+	SETUP_DBG(udc, "SETUP packet: %02x/%02x/%04x/%04x/%04x\n",
 		  crq.bRequestType, crq.bRequest, le16_to_cpu(crq.wValue),
 		  le16_to_cpu(crq.wIndex), le16_to_cpu(crq.wLength));
 
-- 
2.35.3

