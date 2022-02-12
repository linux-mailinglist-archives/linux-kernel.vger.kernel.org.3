Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5D24B36E0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 18:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiBLRzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 12:55:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiBLRzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 12:55:21 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2579A2FFD0;
        Sat, 12 Feb 2022 09:55:18 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id u12so7192004plf.13;
        Sat, 12 Feb 2022 09:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S36hks2RJ4Re0coMrXWBvTFTqYUMh3MT1Ki6NWqUkFY=;
        b=PvpA1x3ux+lK5IBZl1QL+VxW/zkoOX6xnWr7c4Gli8K3cLpAZZ8g2vXxEbk1J9m47W
         mfMpWE54ocKqEwTe/JCwjxVefs4kIeYN2xl7o627tAwRsVVjFywhACXahWPHGaMp6oTp
         UqYFsYcfhjkt5iYKwwwbcNsBJM0OoH1pj9hOdnXcasg1kzdfRSu7zycLjG+ZOVwR5bWu
         HeFSjm+7vt/Pu3q4HAd+vwkmjONOk6mA2YI+CV7Ae+iOl9c5g5UXTNsXyb6pawrooBVL
         yir78UGoQxxorEVkbmG91W7IHDX3fthrfd2OartZjrL9EbNLRMyT17U/HbB+cZfnLZQq
         6ZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S36hks2RJ4Re0coMrXWBvTFTqYUMh3MT1Ki6NWqUkFY=;
        b=IYfNfvMvcTc8n9XG8oe5KMnRIMzi5Q5jS5LL0tV5hJSxpKHMt9bD/aUU//slwNBBqA
         U/jPaWimBtgQ81YJYVfHjZmzf0NdMzfbwJttM53EtEThAjozc1THJIDhovA6/oOpdJEb
         3mSYqmZ/JTks9NHCPPNeEE2QIBFa/qB301nkJW86wpApUzNL/VzmOmTpb2yfETLzCu3y
         qyN61/xb0A+DcY3QQ0MTsysw92dJl/L7N7EBRhL6vby9Y4VXA06U/ocgFprzloel1Xpd
         yCJ9j4i9in2Qz8IbDM8LBNa/FTizCLtOigOu9X9N/ffE5j4tpXhsb0o5RtuqMsvxoFdw
         nEww==
X-Gm-Message-State: AOAM530bJFjZHbtuJQuL8ZspsT0zZCdO2brsumB04CyEBSGHe/N/2/2d
        RhFFUgbU5pu3RJ+6QiaDujc=
X-Google-Smtp-Source: ABdhPJxuPaLOxXK6GVwQIPfak/PrkZNEm0dxv1wuxY1USOojmqe+cg5X1Eo5R6sHWJSqKsbfHN4H+A==
X-Received: by 2002:a17:902:6903:: with SMTP id j3mr6935252plk.137.1644688517517;
        Sat, 12 Feb 2022 09:55:17 -0800 (PST)
Received: from localhost.localdomain ([2402:4000:2380:2a17:a7f8:71f:713f:850b])
        by smtp.gmail.com with ESMTPSA id o8sm31797155pfu.52.2022.02.12.09.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 09:55:17 -0800 (PST)
From:   Husni Faiz <ahamedhusni73@gmail.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     Husni Faiz <ahamedhusni73@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: serial: Fix Coding Style Errors
Date:   Sat, 12 Feb 2022 23:25:10 +0530
Message-Id: <20220212175510.521072-1-ahamedhusni73@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Added a space before the ternary operator.
Removed the space after the function argument.

Signed-off-by: Husni Faiz <ahamedhusni73@gmail.com>
---
 drivers/usb/serial/cp210x.c      | 2 +-
 drivers/usb/serial/iuu_phoenix.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 8a60c0d56863..1fcdfb7d118c 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -1403,7 +1403,7 @@ static int cp210x_tiocmget(struct tty_struct *tty)
 		|((control & CONTROL_RTS) ? TIOCM_RTS : 0)
 		|((control & CONTROL_CTS) ? TIOCM_CTS : 0)
 		|((control & CONTROL_DSR) ? TIOCM_DSR : 0)
-		|((control & CONTROL_RING)? TIOCM_RI  : 0)
+		|((control & CONTROL_RING) ? TIOCM_RI  : 0)
 		|((control & CONTROL_DCD) ? TIOCM_CD  : 0);
 
 	dev_dbg(&port->dev, "%s - control = 0x%02x\n", __func__, control);
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

