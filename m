Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBFB4BB0B6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 05:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiBREVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 23:21:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiBREVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 23:21:16 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7971B0A30;
        Thu, 17 Feb 2022 20:21:00 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id w1so6222687plb.6;
        Thu, 17 Feb 2022 20:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bcgt5PK1Q0mp9E0RmLUvcE/cB/2glUg86KZveaMOtXU=;
        b=C9ypeM/CKWvbodCJOdNi/gxpPmZTeHpNPvHZTvvXQlhYMQlBTKZ6H/e+Sz+SCS4GLG
         1INrS0EPhh5AjszltH74Sr9hRbrQp3fEOniA1Z6LLhWVnkROoqemCcQozMfBUEHufPHq
         cYoaSAgUNHCv1eXUnMdD42izE5hLtntqBokAcrjLoaIdE1BaDfshqTDSzt5KRYJQbgxk
         Ody9DRkovZUieGicW1T84rIyotfWCXa73Aqu21LEKzSxjlgQi43VAt8j9rqXVYUDC0c8
         OE0Tdh8NiFmt4H5ll1cADUQOVAhEfzgTZqFaowGl+Y8MHShOe9XcrH7TwN9zgQ+waoT8
         n0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bcgt5PK1Q0mp9E0RmLUvcE/cB/2glUg86KZveaMOtXU=;
        b=ITdtsj+IIvpnkIBBo3aOqTuAL6cbyZl/LYeiZV9rQMSqV2sVGiHnI2SKTSXf6cuzXh
         wOf59Dzop8HXhZ1hMD93w3xyaulE3URC4sQOMK7HnGGu1yFoYx5EMbNlIJbb4sUj2ZJ0
         BJc/4sZGY/LQYINiUCHS0h774oXDSxbnuvtGft7ME3UOJmSfjgvFzyrYmAipoephQ/tq
         XVt3ZAyrt9qlgDLSz6pS0yQGOQk9qs0HgpckUr7U/Pc1OopcnuTUoD5LqWtFvM1lzW/X
         +oeWIMIgznNl3IIl6IrCk1/ytUrltrudpDe8wYqQPlQFPmYJ166L+iBwxh9yBTgcgT+3
         y83g==
X-Gm-Message-State: AOAM533deJNDnOPQxrW9RNWPTmHfuDVm6J9nhW/yeLesaXr7s51y0CZK
        D97sT+YJmD6Rtnd+OsFr39A=
X-Google-Smtp-Source: ABdhPJzw/42FdPwT9VUX3kY0fyQEO9XvZa5n8i/BQZLqS/3ia96z/DkJX/UytGuvgZmlKwFBFJbbfQ==
X-Received: by 2002:a17:902:ce91:b0:14e:dad4:5ce2 with SMTP id f17-20020a170902ce9100b0014edad45ce2mr4552109plg.120.1645158059871;
        Thu, 17 Feb 2022 20:20:59 -0800 (PST)
Received: from localhost.localdomain ([60.243.248.66])
        by smtp.gmail.com with ESMTPSA id h26sm9530300pgm.72.2022.02.17.20.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 20:20:59 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        sst@poczta.fm, robh+dt@kernel.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/6] dt-bindings: iio: potentiometer: Add Maxim DS3502 in trivial-devices
Date:   Fri, 18 Feb 2022 09:50:38 +0530
Message-Id: <20220218042038.15176-7-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220218042038.15176-1-jagathjog1996@gmail.com>
References: <20220218042038.15176-1-jagathjog1996@gmail.com>
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

