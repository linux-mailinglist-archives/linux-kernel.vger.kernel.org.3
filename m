Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B28056D511
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiGKHAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiGKHAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:00:40 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A915D167C4;
        Mon, 11 Jul 2022 00:00:39 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id v10-20020a05600c15ca00b003a2db8aa2c4so2460781wmf.2;
        Mon, 11 Jul 2022 00:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eZitZxeb+tFy7bckf8dOgFNmWer8aqUshovdBHHfdIU=;
        b=KpaifXBHHWFfwHLHNxAkbRBiOfnHMoLAcyBD7kpOBqblUik8u+9ziUMnWxAWBoOxmD
         yhefiOReWitSzELlcSxTVLnfQfftUoVNswofXINSZxZ++LMfecPsVb5yQYBd70q1L2jh
         Ltiz1JeIPSvbRs42cSq8OGNzMgHDuT+tdxRpGSAEPG2WHh95GlsCZwPPmaeL+aZb/GqO
         pC/g0lRB+JDRi7XBoHwSEzYroESCBQLkjjjgnD/3V6PsqmYVpEqCoQBPqX3V6Jl5ZRRr
         iyQYc8wvCr3aUlPAA3awIcuwiZLttbFW7WJDuxlcDt3AsW0ROKhcWFqpIA3IpxIUevA0
         xJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eZitZxeb+tFy7bckf8dOgFNmWer8aqUshovdBHHfdIU=;
        b=wuXlwtaNGMgZ1UFKZFTFfAxx3+PohKdKRQhUOLGKA6h1q4sLVL2WZ2mRm492K1ppr+
         TvBxy4Xk39j1yPyNc5+3tiKrdmUW5HK6XZHvbLqiMDeGI53btdMRQtaJzexesWD5qZxj
         m7NT9Nji/xVa4V1uyu4hljlMmtHUuqKEpDavAggjql5kV5FoymZeeV/KUTUGfcYyO9EJ
         cplSUSCB3yNy1hVCH3fNH+X2M26mOSAFEEXLItD0ECxP2Yc8XBdh3XKrdHy80b8BrHiO
         Mfpo4PTVO0ducbbpKaYZGuRL0fmjDzJTgnOKSKB1aGmV7zNiuPvitg4fYZcTP8kV2EZd
         T52A==
X-Gm-Message-State: AJIora9EFBFi+r2fmFUWNEY8TU1n6xvHiSD7k/xRuZ1CSZbxelwgNGI3
        9e45cwgjScfwTmlSYn1cB6E=
X-Google-Smtp-Source: AGRyM1sQbzsr1qEHwBUhuJqm0nnpYT6EBStXujczeh14dLIEx/7aGgepj/cKMynAFl8uq+S+XPYrBQ==
X-Received: by 2002:a7b:c003:0:b0:39c:5642:e415 with SMTP id c3-20020a7bc003000000b0039c5642e415mr14077555wmb.111.1657522838108;
        Mon, 11 Jul 2022 00:00:38 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.185])
        by smtp.gmail.com with ESMTPSA id d8-20020adffbc8000000b0021d6a520ce9sm5082614wrs.47.2022.07.11.00.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 00:00:37 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] HID: uclogic: Add missing suffix for digitalizers
Date:   Mon, 11 Jul 2022 09:00:26 +0200
Message-Id: <20220711070026.167428-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The Pen (0x02) application usage was changed to Digitalizer (0x01) in
f7d8e387d9ae ("HID: uclogic: Switch to Digitizer usage for styluses").
However, a suffix was not selected for the new usage.

Handle the digitalizer application usage in uclogic_input_configured()
and add the required suffix.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index c0fe66e50c58..cf3315a408c8 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -153,6 +153,7 @@ static int uclogic_input_configured(struct hid_device *hdev,
 			suffix = "Pad";
 			break;
 		case HID_DG_PEN:
+		case HID_DG_DIGITIZER:
 			suffix = "Pen";
 			break;
 		case HID_CP_CONSUMER_CONTROL:
-- 
2.25.1

