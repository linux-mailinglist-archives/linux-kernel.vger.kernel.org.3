Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F1D519888
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 09:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345692AbiEDHuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 03:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241137AbiEDHuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 03:50:22 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457D213F03;
        Wed,  4 May 2022 00:46:47 -0700 (PDT)
Date:   Wed, 04 May 2022 07:46:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1651650403;
        bh=wG5xTqvpw4JV4k/SUtdwKNTQQEVmavrVULpNR9uaiBk=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:Feedback-ID:From:To:
         Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID;
        b=WISP9Hg+gh3KnWymTIYwnIVfApL9KiosYQXwCfVYgftiQzm95iwU9N1rgLMwCPGA1
         2Zop5Z3xSn8kX0hPj8Na/v0lTCiTb3ZmOJb2Ic2s2E0ZTGAr7DJaqySjgJv+ncChRu
         gSZZeDvzNdfyRAZ00jfwt5fi38DC32Xc1s26p2V5Cq+1xNP6HJrfAwYp4MidsbHUSf
         +XyIELe5hYm7bgfYtB1p1JWmNStBxNFG9DZk8Eu5lmVs9PGspxGQcE/QUsqZS1+J5E
         jOIV8Rj3v6FH/TApJZVuqUXHICHt9usC/71dCnF18t9aWSMoDrSyWffWId+ZKu2S2w
         0icX2SkOH1xGw==
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
From:   Juerg Haefliger <juergh@protonmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@protonmail.com>
Reply-To: Juerg Haefliger <juergh@protonmail.com>
Subject: [PATCH RESEND] Bluetooth: ath3k: Add MODULE_FIRMWARE for patch and config files
Message-ID: <20220504074606.15505-1-juergh@protonmail.com>
Feedback-ID: 10260306:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ath3k driver loads patch and configuration files so add MODULE_FIRMWARE
macros to povide that information via modinfo.

Signed-off-by: Juerg Haefliger <juergh@protonmail.com>
---
RESEND:
  Resend from protonmail email account to please the test bot.
---
 drivers/bluetooth/ath3k.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 88262d3a9392..56e9a64177ae 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -538,3 +538,5 @@ MODULE_DESCRIPTION("Atheros AR30xx firmware driver");
 MODULE_VERSION(VERSION);
 MODULE_LICENSE("GPL");
 MODULE_FIRMWARE(ATH3K_FIRMWARE);
+MODULE_FIRMWARE("ar3k/AthrBT_0x*.dfu");
+MODULE_FIRMWARE("ar3k/ramps_0x*_*.dfu");
--
2.32.0


