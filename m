Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E466E5A2553
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343817AbiHZKDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343889AbiHZKBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:01:33 -0400
Received: from smtpout140.security-mail.net (smtpout140.security-mail.net [85.31.212.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFFE9C1EB
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:01:31 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx409.security-mail.net (Postfix) with ESMTP id 0C81E3238BC
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:01:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1661508090;
        bh=4bC1M/PS4HWRMG+9tQOUbpWEXqqJeGvjy13WJUKSUJA=;
        h=From:To:Cc:Subject:Date;
        b=tkzgjD6MgeX792FB9Vv9hw3nYqJl6CeXEACrJkoHZtfWBnHeFSVrMkUtL0ervwb2i
         +H3TfPWCqG+PZUndeEGob1B2eMi71IslQGKt4dy4ZM5bV37lHYwUt/FxagZ4ZIIi4v
         BZQF0+nFYJerAhwuUPrLZOosCTHBzNV3tHA8f/DQ=
Received: from fx409 (localhost [127.0.0.1])
        by fx409.security-mail.net (Postfix) with ESMTP id A351D3238BF;
        Fri, 26 Aug 2022 12:01:29 +0200 (CEST)
X-Virus-Scanned: E-securemail
Secumail-id: <5f96.630899f7.96ab6.0>
Received: from zimbra2.kalray.eu (unknown [217.181.231.53])
        by fx409.security-mail.net (Postfix) with ESMTPS id 98D5C3238DC;
        Fri, 26 Aug 2022 12:01:27 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTPS id 64A9227E0396;
        Fri, 26 Aug 2022 12:01:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 4E6D627E0392;
        Fri, 26 Aug 2022 12:01:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 4E6D627E0392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1661508087;
        bh=dJ9IP1YX/f4PTjh2ZawYjIO6VFebYMNL6zIzAO/NNFo=;
        h=From:To:Date:Message-Id;
        b=MNDZdVBw7jB2yXvolhpZqeY82IuEuWy4FcQsjF3KSo+qdsN9ncfHLQtKgPlFusfkp
         xWEIWaNDsW24g5Gh/PSXI1G2pwnlrJaQ/H19ZMBcJxRZhjVAuefPdMMO6ZL+KBL2y5
         t1+wv7sdKVs15LqucDot9Y/hq3f2cKcyENi8BjuQ=
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RqJShZBeD5xR; Fri, 26 Aug 2022 12:01:27 +0200 (CEST)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id 3EC4B27E02FA;
        Fri, 26 Aug 2022 12:01:27 +0200 (CEST)
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Jules Maselbas <jmaselbas@kalray.eu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: v4l2: Fix repeated word in comments
Date:   Fri, 26 Aug 2022 12:00:51 +0200
Message-Id: <20220826100052.22945-23-jmaselbas@kalray.eu>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: by Secumail
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant word `the`.

CC: Mauro Carvalho Chehab <mchehab@kernel.org>
CC: linux-media@vger.kernel.org
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index c314025d977e..96793dacb08f 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1045,7 +1045,7 @@ static void v4l_sanitize_format(struct v4l2_format *fmt)
 	/*
 	 * The v4l2_pix_format structure has been extended with fields that were
 	 * not previously required to be set to zero by applications. The priv
-	 * field, when set to a magic value, indicates the the extended fields
+	 * field, when set to a magic value, indicates the extended fields
 	 * are valid. Otherwise they will contain undefined values. To simplify
 	 * the API towards drivers zero the extended fields and set the priv
 	 * field to the magic value when the extended pixel format structure
-- 
2.17.1

