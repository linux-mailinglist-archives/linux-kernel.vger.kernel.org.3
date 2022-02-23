Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CA34C18CA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241835AbiBWQgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242893AbiBWQgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:36:33 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF71358381;
        Wed, 23 Feb 2022 08:35:55 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id x11so19191595pll.10;
        Wed, 23 Feb 2022 08:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bcgt5PK1Q0mp9E0RmLUvcE/cB/2glUg86KZveaMOtXU=;
        b=M0j9xNzFyktfVR9Ex34gv6jh+eREkHS60NNePIupNQ0EqJzf/F4qEHp+2mU4FxJ1Nx
         C+ma8SOt4a8EeysSi4gCM1Ks7tEg7+zTNNy1PbBtakQrB6txiHZmXLfPcEkP6UoKyOPt
         ysEFdldsQOs/MARlmqmIMtGSWp+tahTj8v8GNyiyVLz/HxPT+CiEQcSlbv/Qn15X/XqW
         qN6Y18iqfbJaiKAW7xwMcUW24MoCqtcQz/wFf/VfimgCazZr16v77MwqhlzV1+fjg7LP
         oV+2tX8dtDYzsA1tEXodTjHvBSWzMUDF5Zx9JGxqvPot0fUhAWmWDPd8kc2xZdOLUKxp
         V7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bcgt5PK1Q0mp9E0RmLUvcE/cB/2glUg86KZveaMOtXU=;
        b=A74oSey4X4fvY4Dxg2J7RQRWdcnSXnkrOsZm/XvTJnMr2UFQiwzUmOANCEqAhwnNwZ
         jvchkwOJnO42Pl3tZkOHn7BYfOVGkPtTFkjG0ZVYNYhUtR+GHZ/616ERu0h54/7NNWqV
         EGgJNIAfWTKka4J5OywisEjG1dPLp3G+9XXrRLBVnYn7usdaawsMQEDwmoJBxjMjnudQ
         PsM9D+bNfvitNyhCKp9LqC2CX4jQOJ+ufCsrOtWIMl95AuS5s5u2WdCkg4qovLcRA1q5
         6lqLnHjiHCO9z/lRNzz9bE+uStZXgV+IBLOk/Og4P9FUKRiJrfJTZI0gEtmyEnh2Imgl
         ByfQ==
X-Gm-Message-State: AOAM5310v4I5tXRPPocRkKCTbg+h+H7GfWGuvkgEbI+lr5ZBMLmXbO0P
        uM1BJXK1sWI+u5SO3lFlnPk=
X-Google-Smtp-Source: ABdhPJwmXDDTB84pFYHj8MR6ShOZkroY72Sayv4BLY/e8ELIy4W8q12tITwgKVl7vcnxZz9+dfaXrA==
X-Received: by 2002:a17:90a:1548:b0:1b9:d1b7:bb1a with SMTP id y8-20020a17090a154800b001b9d1b7bb1amr141903pja.125.1645634155159;
        Wed, 23 Feb 2022 08:35:55 -0800 (PST)
Received: from localhost.localdomain ([27.7.190.133])
        by smtp.gmail.com with ESMTPSA id q93-20020a17090a4fe600b001b9ba2a1dc3sm3455106pjh.25.2022.02.23.08.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 08:35:54 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        sst@poczta.fm, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 7/7] dt-bindings: iio: potentiometer: Add Maxim DS3502 in trivial-devices
Date:   Wed, 23 Feb 2022 22:05:25 +0530
Message-Id: <20220223163525.13399-8-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220223163525.13399-1-jagathjog1996@gmail.com>
References: <20220223163525.13399-1-jagathjog1996@gmail.com>
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

