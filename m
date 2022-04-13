Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56535000FB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239132AbiDMVQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 17:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239079AbiDMVN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:13:28 -0400
Received: from mail1.bemta33.messagelabs.com (mail1.bemta33.messagelabs.com [67.219.247.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEF4517DB;
        Wed, 13 Apr 2022 14:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com;
        s=Selector; t=1649884264; i=@motorola.com;
        bh=ogcplI9Tnxc1mgIdMwyPuytn09r79YioJeB19NGtmqs=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
         Content-Transfer-Encoding;
        b=r/iTO2WaIYJBrq5ghm3qE4L2saSImIaR8HA9jZ1CGB7t3IPvkbyATHwHdHy6frlgV
         BJRJTmNHA00YB3ztLWHJmbP3cuSMijvt3Yt3fMV+j9li4feel4ugI/M8CR08dgzrNL
         ou7d8RL1Pok3wrB+S65PXWeNc1m3eLfiQ+3r8oW9bzter3EZU9t2hgiQHwhtbvEcGL
         HgUc445MpspoJ91gRJK9FNpAxSCzg/JeifLKsKZICf5cEfxA/Dx9vQoV0ypkQBA21K
         eWiAQSZbZ+luhmS7MnW3IG2r70TgLMa7YYfmiYr7TcB3kV24Sj7pK9YG8Q+b71SgYP
         XQcpWfnbB7bqQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRWlGSWpSXmKPExsWS8eKJmG6GTXi
  SQV8nt8WxtifsFs2L17NZXN41h81i0bJWZovGLS/ZHVg9Lvf1MnlsWtXJ5rF/7hp2j8+b5AJY
  olgz85LyKxJYM7bs/cFUsJez4vAj2wbG1RxdjFwcQgLTmCR+9/UyQzhLmCQW/5zG2sXIycEmo
  Cax4PUqZhBbREBW4vCV32BFzAKnGCWev29iAUkIC8RJzO1oZQexWQRUJU40fmEEsXkFLCR+vj
  4BNkhCQF7i1LKDTBBxQYmTM5+A9TIDxZu3zmaewMg9C0lqFpLUAkamVYzWSUWZ6RkluYmZObq
  GBga6hoYmumYmuoZGxnqJVbqJeqXFuqmJxSW6RnqJ5cV6qcXFesWVuck5KXp5qSWbGIGhl1Lk
  UL2DcdWqn3qHGCU5mJREebMMw5OE+JLyUyozEosz4otKc1KLDzHKcHAoSfCGWgHlBItS01Mr0
  jJzgHEAk5bg4FES4XW3BkrzFhck5hZnpkOkTjHqchzctX8vsxBLXn5eqpQ4ryVIkQBIUUZpHt
  wIWExeYpSVEuZlZGBgEOIpSC3KzSxBlX/FKM7BqCTMexNkCk9mXgncpldARzABHfFtVSjIESW
  JCCmpBiat5LsHtDLjdFgrkrb92CPhPNuSX3DCx3NPdtcYxkVWCf1Ztsd/oa7V5pfvre+ZXM4/
  scxX3mVi4x6O9FCVAzfeXRJrbc+a5fjIZfHUDc+EOG1+SjoHPI75vqTUSM0rbE+CqdGROJlN3
  E5b+n0Or1G0+3zZ7OfEdP+tVh9fh/S8OGzRZcI9p85yReXyeQvLbx96MCXyv9uem738f1ryNL
  85TzCWD390hasw+nL4bMGPLZPP9s3Z8KHHTyfVUeUF0/SSZ8d9JqjmbIvSN9spnznhTFEh96e
  Ez1sUXSvYjhgwcbDbyTo0v0z4V8C43enEStMak/uR7c5Ln4kxr/+18KKw5vH0jacOVnUbrohm
  vKHEUpyRaKjFXFScCAArj64wRAMAAA==
X-Env-Sender: w36195@motorola.com
X-Msg-Ref: server-26.tower-635.messagelabs.com!1649884263!3107!1
X-Originating-IP: [104.232.228.22]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17649 invoked from network); 13 Apr 2022 21:11:04 -0000
Received: from unknown (HELO va32lpfpp02.lenovo.com) (104.232.228.22)
  by server-26.tower-635.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 13 Apr 2022 21:11:04 -0000
Received: from ilclmmrp01.lenovo.com (ilclmmrp01.mot.com [100.65.83.165])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by va32lpfpp02.lenovo.com (Postfix) with ESMTPS id 4KdwHW5wSpz50GGs;
        Wed, 13 Apr 2022 21:11:03 +0000 (UTC)
Received: from p1g3.. (unknown [10.45.4.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: w36195)
        by ilclmmrp01.lenovo.com (Postfix) with ESMTPSA id 4KdwHW3wGBzbq6Q;
        Wed, 13 Apr 2022 21:11:03 +0000 (UTC)
From:   Dan Vacura <w36195@motorola.com>
To:     linux-usb@vger.kernel.org
Cc:     Vijayavardhan Vennapusa <vvreddy@codeaurora.org>,
        Dan Vacura <w36195@motorola.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: configfs: clear deactivation flag in configfs_composite_unbind()
Date:   Wed, 13 Apr 2022 16:10:38 -0500
Message-Id: <20220413211038.72797-1-w36195@motorola.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijayavardhan Vennapusa <vvreddy@codeaurora.org>

If any function like UVC is deactivating gadget as part of composition
switch which results in not calling pullup enablement, it is not getting
enabled after switch to new composition due to this deactivation flag
not cleared. This results in USB enumeration not happening after switch
to new USB composition. Hence clear deactivation flag inside gadget
structure in configfs_composite_unbind() before switch to new USB
composition.

Signed-off-by: Vijayavardhan Vennapusa <vvreddy@codeaurora.org>
Signed-off-by: Dan Vacura <w36195@motorola.com>
---
 drivers/usb/gadget/configfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 1fb837d9271e..84b73cb03f87 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -1438,6 +1438,8 @@ static void configfs_composite_unbind(struct usb_gadget *gadget)
 	usb_ep_autoconfig_reset(cdev->gadget);
 	spin_lock_irqsave(&gi->spinlock, flags);
 	cdev->gadget = NULL;
+	cdev->deactivations = 0;
+	gadget->deactivated = false;
 	set_gadget_data(gadget, NULL);
 	spin_unlock_irqrestore(&gi->spinlock, flags);
 }
-- 
2.32.0

