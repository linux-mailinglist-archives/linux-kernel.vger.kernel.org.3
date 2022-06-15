Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC9B54C872
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347944AbiFOMZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238446AbiFOMZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:25:57 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2D73E0DB;
        Wed, 15 Jun 2022 05:25:56 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id c130-20020a1c3588000000b0039c6fd897b4so1035707wma.4;
        Wed, 15 Jun 2022 05:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=smvQt7PY9yq5rEGHSy6OokNYxpvxD37Zb/ZGxe4Zl44=;
        b=p81sq2syYQOfuAlA4rRSnmBOAytXrM/hdYfg9zbL4agok0Qt1imI7fkiejhn5GNPoQ
         1EJh3ZEEZ1Yg5f0l82uME/+cKNlTccOdr7McmrvmGKDbHzFKAgVtSmMQfQa+UCqXPEyJ
         wxoINM2y+JNqq//fH1dTE4KHM3qhomof8mXZ/qc3D+dAVXoe/0r2sdK/HrhhkbH6nZLh
         aCyUxO9r/N58y1EDRHX1oehfRXdc3LCaySh5Z40XtCJfvLiRn/OAzmAV5ZgD8HkkR/7s
         gFrYYT1j9go+naZVE0NcDV3Bvsd9wAKU9pYr17bt2fNbgSNsm73PgEYig7kkxOwaj3Rj
         kBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=smvQt7PY9yq5rEGHSy6OokNYxpvxD37Zb/ZGxe4Zl44=;
        b=tMPclQeCYRyUvK4lGJKGFyb8q6Tx5jHK7jeEaxyUd2jta242gUozXf5MB8FHSjDx2q
         Dwm+TnC8M+A+zuXa7G3DR+CkZZuqnUi4Ra9LJSF6tRHS+M7AXCF1i+f9ztb5q70Q8oA6
         S7/C9LD60Ychxrl5NLGLl2v5T/hkQz0dVz9WeFHLEsbGEb67GsDNjUUex1AiIzMaCtWe
         kn3BWkOMZbIe31UEM6wa7OJGDxtpG4R3ML+TxlNZUgIjk4RzK6q2exC1E5LpnYvJkcPM
         ez84Q+rUV2Pfa656OXASumgmpPQNEIp2jldThfH4DTG5ag5yrfBKk445mhWq8iuxQzfi
         mFzQ==
X-Gm-Message-State: AOAM532B9ScnTHD/skeSPyJ3iAx162kN6/l6fWG6FjudShgpF6qlv/q5
        OQExUngZT6Yk1BRYwyTf8LgZylhSmAbmww==
X-Google-Smtp-Source: ABdhPJxA+WKRE3Ayaxo2n6q/t3kjbcC0p6dj2WCbqZTdysZ6o6cZwTDlhY/xXfWPhjpmMOH6ozc4fw==
X-Received: by 2002:a7b:cd1a:0:b0:39c:4133:ade7 with SMTP id f26-20020a7bcd1a000000b0039c4133ade7mr9719696wmj.111.1655295954928;
        Wed, 15 Jun 2022 05:25:54 -0700 (PDT)
Received: from caracal.museclub.art (p200300cf9f1a9e008d6dafec091202b8.dip0.t-ipconnect.de. [2003:cf:9f1a:9e00:8d6d:afec:912:2b8])
        by smtp.googlemail.com with ESMTPSA id f13-20020adff58d000000b0021a23e06bb0sm3725880wro.92.2022.06.15.05.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 05:25:54 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     Michael Carns <mike@carns.com>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] hwmon: (asus-ec-sensors) add missing comma in board name list.
Date:   Wed, 15 Jun 2022 14:25:44 +0200
Message-Id: <20220615122544.140340-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.35.1
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

From: Michael Carns <mike@carns.com>

This fixes a regression where coma lead to concatenating board names
and broke module loading for C8H.

Fixes: 5b4285c57b6f ("hwmon: (asus-ec-sensors) fix Formula VIII definition")

Signed-off-by: Michael Carns <mike@carns.com>
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 drivers/hwmon/asus-ec-sensors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 886a71b4c64e..19d3ca71b360 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -268,7 +268,7 @@ static const struct ec_board_info board_info[] = {
 	},
 	{
 		.board_names = {
-			"ROG CROSSHAIR VIII FORMULA"
+			"ROG CROSSHAIR VIII FORMULA",
 			"ROG CROSSHAIR VIII HERO",
 			"ROG CROSSHAIR VIII HERO (WI-FI)",
 		},
-- 
2.35.1

