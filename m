Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D428551639
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239886AbiFTKse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240834AbiFTKs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:48:26 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5493C5FFA;
        Mon, 20 Jun 2022 03:48:21 -0700 (PDT)
X-QQ-mid: bizesmtp75t1655722026tpfowczi
Received: from localhost.localdomain ( [106.117.82.33])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 20 Jun 2022 18:46:56 +0800 (CST)
X-QQ-SSF: 01000000004000D0I000B00A0000000
X-QQ-FEAT: AsJu5+SoYW4r99ODow98FzXA05NwqwMOP0PDB6J+D6MRSmW7JE7EPnWFeeFyr
        WBMGF/XR9kGz/QAfFWvSnljZE0ukbHUzd3DQYAfbDif8AJ8meakRTgmfH1Xc2jyXua8A7sP
        Wad3n3PSwrIvp87ycqBsdInNghQv/HBooxfOvzXvS0VFj8crsEFnZMX6KOEnZYGJ6Slz8S+
        u3iInKuO1HH9MCeu4RL/iH76Caj3jU6MFYUg4paqInSyEEcaB3nNVzurKnDttF6aVCU074I
        pIaXvzyGsMtNBvK0M7lsn/paPyPgrMgKeHvOKQN2ThqiyC6+UPJ2RcmAjv/UfaPzRNeXTXw
        90zLVVQ37CKXuEugCU=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     jason.wessel@windriver.com
Cc:     daniel.thompson@linaro.org, dianders@chromium.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] serial: kgdboc: Fix typo in comment
Date:   Mon, 20 Jun 2022 18:46:53 +0800
Message-Id: <20220620104653.5451-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'the'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/tty/serial/kgdboc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
index 79b7db8580e0..7aa37be3216a 100644
--- a/drivers/tty/serial/kgdboc.c
+++ b/drivers/tty/serial/kgdboc.c
@@ -342,7 +342,7 @@ static int param_set_kgdboc_var(const char *kmessage,
 	/*
 	 * Configure with the new params as long as init already ran.
 	 * Note that we can get called before init if someone loads us
-	 * with "modprobe kgdboc kgdboc=..." or if they happen to use the
+	 * with "modprobe kgdboc kgdboc=..." or if they happen to use
 	 * the odd syntax of "kgdboc.kgdboc=..." on the kernel command.
 	 */
 	if (configured >= 0)
-- 
2.36.1

