Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF6C5930B0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 16:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243037AbiHOO0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 10:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbiHOO0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 10:26:36 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62451165B8;
        Mon, 15 Aug 2022 07:26:34 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id s23so3911300wmj.4;
        Mon, 15 Aug 2022 07:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=LMVpZMCDSX69KQGDvljJL1Ywd9Ygz92B8rIgyIaAokc=;
        b=WLhpdsBgXT4H1XMe4WJFNDUmPcbT+8pCsoDhwmhXrp47s6gQNfcl6NbaTsYNJGeOlx
         sRp/mYQbDo0NlsrcVSOFACuqwyPhNys73M3Je9dRPbmDwI1EAhM+YSz1VoDQ7lJ00Syw
         p8aSjRPVQ+9raHyQI4gianCQ+l7Tn2pqr20Khv7tGdg10T0ZsDLNAURaNhYNelWeqnJy
         zNjOY8T+OU4RjjKjtzJluQixLnS2CM/ky9nxoj7KRG7XVwbNSBuIz2Psi1KvldR2Fkfl
         IZ2nPhFy1Viu5r2crusFA5nC/oCr7HdeqTXqHUYWYlHk6VoOYlsKQIf9Ci+eUJcm+iJv
         /Plw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=LMVpZMCDSX69KQGDvljJL1Ywd9Ygz92B8rIgyIaAokc=;
        b=kO4zgMHYrn2ql36Ou7ch3sxUA2HgM43KpMUGOhxfI+TGRyv4lmWqtn68TIibwX1vhL
         T8D/QDFsDMya4MfyedAsIvSkkNDQtzhNAT5UiZ4Kyu8rWtul6qE7OaM6SrYNt6im6yT8
         e0yMf4WkRAx2jy/3LQLBItZOFkx6dxnQIQ5Qv/PCXfXPLjGu06nK1qerRcGSfONjadY3
         qsV5gjI37K3/re2H62T1fhK4DN+Jv9nnmmMVqruoD1ARnG+MdbLp0fnIrW72AiiO8lo/
         cYsWiGsj05+3E6hM9d5f7NgxMijVDtRVgGIcUN/iRUcW0IpU8FklKMS8YKYvVoj6CXi6
         oJ1w==
X-Gm-Message-State: ACgBeo2vb/gWG7DvsI2lAHn4syFS8jKimhpGaO+n3obYyDRFuisX8NmO
        kxvz0d+J5rtauPSoI7q5LHY=
X-Google-Smtp-Source: AA6agR53DoF3E2T0Syyg9+I9CJv8wb6IQMk0ZOiPhqjZJYQalztzNCz0yBmXZp+90X72kjFZ4kiiIw==
X-Received: by 2002:a1c:ed05:0:b0:3a5:3af:f5c3 with SMTP id l5-20020a1ced05000000b003a503aff5c3mr10539979wmh.52.1660573592990;
        Mon, 15 Aug 2022 07:26:32 -0700 (PDT)
Received: from localhost.localdomain ([94.73.32.249])
        by smtp.gmail.com with ESMTPSA id u8-20020a05600c19c800b003a5f3de6fddsm4761159wmq.25.2022.08.15.07.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 07:26:31 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH RESEND] HID: uclogic: Add missing suffix for digitalizers
Date:   Mon, 15 Aug 2022 16:26:15 +0200
Message-Id: <20220815142615.17965-1-jose.exposito89@gmail.com>
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
commit f7d8e387d9ae ("HID: uclogic: Switch to Digitizer usage for
styluses"). However, a suffix was not selected for the new usage.

Handle the digitalizer application usage in uclogic_input_configured()
and add the required suffix.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>

---

Kindly resending this patch so it doesn't get lost after the merge
window.
---
 drivers/hid/hid-uclogic-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index 47a17375c7fc..ff46604ef1d8 100644
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

