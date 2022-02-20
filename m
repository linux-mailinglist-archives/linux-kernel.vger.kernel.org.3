Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A8B4BCBCD
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 03:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243425AbiBTCr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 21:47:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243383AbiBTCrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 21:47:15 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABD31C90F;
        Sat, 19 Feb 2022 18:46:55 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id i6so5623515pfc.9;
        Sat, 19 Feb 2022 18:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bcgt5PK1Q0mp9E0RmLUvcE/cB/2glUg86KZveaMOtXU=;
        b=BmAjtEQEM9r/wz6eZy1u2L5LtdFTRms4kStp5rAyOZKT+oN4W1jMEai/f7FrOkLN1+
         BwY1KHsZbVD9JHxrqTxwfmDVxg89lavZEi+MChzupH3SNaZkVth8x1wyTCXA1aowcXLK
         k0O7PcWVqGLAdMTHF7No+c7oFsyMofq/L+8NUNBcElJ3MxvXg8z+huwrmcvrDs7Xshyu
         AYBMmfWN+5VCObIBmUxoSd4esT/gVwzrBJ2G3zCUNvKuM4IhBJwTA9LJP9pIrpGtEnrD
         TPsOpbZ1ZE0NjYRydJ3UrtGy8MwO1B1H2NEiQ/FhoWNyYc1FI5T4HCOHtec4sZHQME4Q
         Y8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bcgt5PK1Q0mp9E0RmLUvcE/cB/2glUg86KZveaMOtXU=;
        b=ig3W5n9mBhEn/MHQTkiA3pDrdSwqHmMzscpMrzcgDo1oa9y2XW2qHkurDTHkeLB6gH
         tNGsIWl0e12jRDU/8qQdnI6T5i6wOzZwpNnJMBCA6l8gU1l0YcdqCEWPuybmATHW/QBY
         XrXfRCxq2ydsNAquEXoSlExv6QR2nkLpWY+tckNHtSIOejB9VMKmnj4yXOxoJGV+1vkx
         5g1quPhhCrH0fBTyHi+D5YshIkNF7MiUpGI948KOAV6vL018/4dHRSGvcwqK2Ocfd4+g
         pLByPhZbQHKqDHiEWEB1cULqZdiup2uaOrHl1BnszAUNqikJ5+K1DoDlluZzSQWIUD2D
         OCvA==
X-Gm-Message-State: AOAM5330clXiAg0EzQ7VWFTv7NH1rt7PP5lz8G8o3BnAVPS58EEpANJ7
        YJA84skRTFvU+wqhfMlwXRM=
X-Google-Smtp-Source: ABdhPJwhy59ao+hpCRKA/0ilPaaqLNwB0oUCU9MeUz+s5LBO/LHDvOLyfFYxnJEu+nAUWRV4kVecAA==
X-Received: by 2002:a05:6a00:278d:b0:4e1:4534:8801 with SMTP id bd13-20020a056a00278d00b004e145348801mr14197924pfb.78.1645325215383;
        Sat, 19 Feb 2022 18:46:55 -0800 (PST)
Received: from localhost.localdomain ([116.73.72.178])
        by smtp.gmail.com with ESMTPSA id lw16sm3488761pjb.51.2022.02.19.18.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 18:46:55 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        sst@poczta.fm, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/7] dt-bindings: iio: potentiometer: Add Maxim DS3502 in trivial-devices
Date:   Sun, 20 Feb 2022 08:16:32 +0530
Message-Id: <20220220024632.4183-8-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220220024632.4183-1-jagathjog1996@gmail.com>
References: <20220220024632.4183-1-jagathjog1996@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxim DS3502 is a 7 bit nonvolatile digital potentiometer.
Add DS3502 binding into trivial-devices.yaml.

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 091792ba993e..b6187603317a 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -157,6 +157,8 @@ properties:
           - maxim,ds1803-050
             # 100 kOhm digital potentiometer with I2C interface
           - maxim,ds1803-100
+            # 10 kOhm digital potentiometer with I2C interface
+          - maxim,ds3502
             # Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
           - maxim,max1237
             # Temperature Sensor, I2C interface
-- 
2.17.1

