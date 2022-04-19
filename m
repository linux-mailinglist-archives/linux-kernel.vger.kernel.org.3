Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD675064C7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 08:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348963AbiDSGqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 02:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348997AbiDSGqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 02:46:02 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB12131343;
        Mon, 18 Apr 2022 23:43:20 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id s4so12844773qkh.0;
        Mon, 18 Apr 2022 23:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lCEwVctplujUVn3aWOAAg060aVQwyGc3JDb5YqPzLpg=;
        b=Rzglu8dkVnAtjM3wsCn4uI2jtekslQMjTbEJx6z7NujF2SDSfpEQ3ciQusg6iNqU59
         8zoSmSPXvCWtQJltyu6jFPICGvVHe9dAOQZQ81REw1ngzRrpLog+mysa/uQvNgztaZdb
         aaNZwpRefsRzWzDV6afIn6EyiEhTl61d4iaJWVr17o3W/CRdTUUtFxkcAtiwJBvAjIn4
         3ZRe5nFNhRmKXg3MEIfjHwj+ty0BcTf7mo81kH/xuO1hixP2RuCwGQgVihc+6utd/iOv
         /smycl11fjB9zATTnVkEGUmduXr3pgBxuOgM52aSL6M8H8RcoTCn7i3OaVCkUE3dLAER
         WM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lCEwVctplujUVn3aWOAAg060aVQwyGc3JDb5YqPzLpg=;
        b=YrQ0rL5jWSN6gBn1/rvKL1G8d+39vl8z0u+7ZDTUa8hNmk4WyzHiX6VHSPBiwz9f7s
         E7fiLJovZOI7KpyxSUdRLvDRLL5PW/As98HLKeIxPgLBfGYVPAs2kIcaMY6jbkMexecC
         Rh7kf9eTPZ3qaxRT+xzqoRnec36EUuoYoxkgS1r1nWSnVF7swnhj7sh5OXQ1A8jqk7EV
         ODz044pQcWb+NqfQl9pQwmrfrSXwBubp5X8fmRicksH02i3WfS3GoGzhY8Eta5khlY0k
         aywVcVQvH66j8uW/8TAsGl3orRYuJqrqPYSrPp3j0zUwN+f8RAuEtxHrsgmqNyA8/B5D
         5U3Q==
X-Gm-Message-State: AOAM532dBcXhj/x274AAUaFYSDe2ZDPd3AGDnbCgpnpq/e5Ieq//ctof
        vVo+/SNwDol+76eLhVWaxo/Qavzwb0U=
X-Google-Smtp-Source: ABdhPJyIqAjVWapfZuf+9IuFP0bQM4o+OeOppDY7/+9kKdQpTnNAiKVXqMjz6QBSKvLb9KBH0M5t3Q==
X-Received: by 2002:a05:620a:2456:b0:69e:9fa0:6479 with SMTP id h22-20020a05620a245600b0069e9fa06479mr4744407qkn.414.1650350599703;
        Mon, 18 Apr 2022 23:43:19 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 2-20020ac84e82000000b002f1f95ce5fbsm4559081qtp.3.2022.04.18.23.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 23:43:19 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] Input: Remove unneeded variable
Date:   Tue, 19 Apr 2022 06:42:55 +0000
Message-Id: <20220419064255.2563333-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Remove unneeded variable used to store return value.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/input/input.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index e5a668ce884d..1365c9dfb5f2 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -1793,8 +1793,6 @@ EXPORT_SYMBOL(input_reset_device);
 
 static int input_inhibit_device(struct input_dev *dev)
 {
-	int ret = 0;
-
 	mutex_lock(&dev->mutex);
 
 	if (dev->inhibited)
@@ -1816,7 +1814,7 @@ static int input_inhibit_device(struct input_dev *dev)
 
 out:
 	mutex_unlock(&dev->mutex);
-	return ret;
+	return 0;
 }
 
 static int input_uninhibit_device(struct input_dev *dev)
-- 
2.25.1

