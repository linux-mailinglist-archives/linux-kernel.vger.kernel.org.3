Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B73508F84
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 20:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381521AbiDTShI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 14:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346657AbiDTShF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:37:05 -0400
Received: from mail1.bemta31.messagelabs.com (mail1.bemta31.messagelabs.com [67.219.246.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB25129;
        Wed, 20 Apr 2022 11:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com;
        s=Selector; t=1650479657; i=@motorola.com;
        bh=3P37IxzWVK0w9ZSre3qUDtbzzByBCjaQG/eZQCGHfpg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding;
        b=GtDsQ7/GlJ9DgXMA/L3hF2pttO8t4aMrTzlJC7r3+kMRhn147xf6FaMsDwrWSdwCl
         rIVvBe27ccQG4ptpi2J1AhQxD3wK70l3XJlFOZpXGNOYWeD7ySp+h1zJwsh1V5dBGy
         JIJh51smW/P34magU2DuXPEbadjN+4bFj13jExF15YTuZGCy3TTNsk7iG6xLOrzjS9
         s6jhHsNctIwK1FNUd94s8avJx/uZNpa6paXxPEHupdYTJSged5q3LJtw2w0S5l1oRw
         kjAxwiMCjYpVq3nCOXtldLOQdlJM7LJU6FXZIOBPEEubeZmnoNDOrS+ZJj6bl8fbbA
         0yaEfhBe0Rq+Q==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRWlGSWpSXmKPExsWS8eKJqK56UEK
  SQdM2K4tjbU/YLZoXr2ezuLxrDpvFomWtzBarFhxgt1jbNIvNgc3jcl8vk8emVZ1sHvvnrmH3
  2LL/M6PH501yAaxRrJl5SfkVCawZux/+YyzoYK94fnIaewNjN1sXIxeHkMB0Jom2VbuhnCVME
  q8f7WHsYuTkYBNQk1jwehUziC0iICtx+MpvZpAiZoGXjBJtC/awdDFycAgL+EtMeWgOUsMioC
  rxeeM6dhCbV8BS4lLTDLBeCQF5iVPLDjJBxAUlTs58wgJiMwPFm7fOZp7AyD0LSWoWktQCRqZ
  VjBZJRZnpGSW5iZk5uoYGBrqGhia6prpGeolVuol6pcW6qYnFJbqGeonlxXqpxcV6xZW5yTkp
  enmpJZsYgYGYUsTKtINxYc9PvUOMkhxMSqK8i/gSkoT4kvJTKjMSizPii0pzUosPMWpwcAgsO
  Td3OpMUS15+XqqSBO9mP6A6waLU9NSKtMwcYLTAlEpw8CiJ8BZaA6V5iwsSc4sz0yFSpxgVpc
  R5HwYAJQRAEhmleXBtsAi9xCgrJczLyMDAIMRTkFqUm1mCKv+KUZyDUUmYdzXIFJ7MvBK46a+
  AFjMBLa6eEguyuCQRISXVwDTX5oVptOrkkOhnvaYi53W+sLQs9q6RfvCv0nfNG+eJzqeefjih
  6/S/urnqtI+u6zaOpAQX+5k/jMyV+BaeaFof5lXTevdRemVrxLZax4T104/e7s09ftLtkVGsl
  d3+HyG6DFoscndF7p8SUD7w7aySRlv+lKVbZ73JeKymJ9fAfeH7dQb/e74POvk9PlV/0RXw7y
  1Ifzo39U38UqUwiQVPrHR+XDy4W/np2uOXZAX1FktwVW7Z/5rbgk9+f6WMr6IG28WCI1XFNw0
  td/Fz/15mbGtbdOaz4qs/N92VXjFomqwz6uT+KspVKcymsUvXymROzZMfP2Nj50q02TrMTtaz
  KeSvv7CwIoKh1rpBiaU4I9FQi7moOBEAElDTCUsDAAA=
X-Env-Sender: w36195@motorola.com
X-Msg-Ref: server-10.tower-686.messagelabs.com!1650479655!16369!1
X-Originating-IP: [104.232.228.21]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 27052 invoked from network); 20 Apr 2022 18:34:15 -0000
Received: from unknown (HELO va32lpfpp01.lenovo.com) (104.232.228.21)
  by server-10.tower-686.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 20 Apr 2022 18:34:15 -0000
Received: from va32lmmrp01.lenovo.com (va32lmmrp01.mot.com [10.62.177.113])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by va32lpfpp01.lenovo.com (Postfix) with ESMTPS id 4Kk8TM4sCQzgNVW;
        Wed, 20 Apr 2022 18:34:15 +0000 (UTC)
Received: from p1g3.. (unknown [10.45.5.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: w36195)
        by va32lmmrp01.lenovo.com (Postfix) with ESMTPSA id 4Kk8TM2n3Mzf6f9;
        Wed, 20 Apr 2022 18:34:15 +0000 (UTC)
From:   Dan Vacura <w36195@motorola.com>
To:     linux-usb@vger.kernel.org
Cc:     Wesley Cheng <wcheng@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Dan Vacura <w36195@motorola.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: gadget: increase tx fifo size for ss isoc endpoints
Date:   Wed, 20 Apr 2022 13:33:38 -0500
Message-Id: <20220420183338.445622-1-w36195@motorola.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve performance of isoc transfers in superspeed by increasing the
number of possible endpoints available, matching that of what was
configured for bulk transfers.

Signed-off-by: Dan Vacura <w36195@motorola.com>
---
 drivers/usb/dwc3/gadget.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index ab725d2262d6..faffa4f4050c 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -783,7 +783,8 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
 		num_fifos = 3;
 
 	if (dep->endpoint.maxburst > 6 &&
-	    usb_endpoint_xfer_bulk(dep->endpoint.desc) && DWC3_IP_IS(DWC31))
+	    (usb_endpoint_xfer_bulk(dep->endpoint.desc) ||
+	     usb_endpoint_xfer_isoc(dep->endpoint.desc)) && DWC3_IP_IS(DWC31))
 		num_fifos = dwc->tx_fifo_resize_max_num;
 
 	/* FIFO size for a single buffer */
-- 
2.32.0

