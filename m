Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0BA574985
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238491AbiGNJqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238399AbiGNJpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:45:47 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5911A4B4B4;
        Thu, 14 Jul 2022 02:45:46 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id c3so453230pfb.13;
        Thu, 14 Jul 2022 02:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d5dQ5EQwn8mX60+IF0sZKf5rrEpnkwl9K3LbLZ9fU5E=;
        b=WE4NfXRNJOlUu1nI7eT+yjooUYkwHuL4Zc+a7jJMb4lu9txVWiagY+QSWpsMOrq+gH
         PbpvPaON+EDr4kxaRPLJPplEKL2VGjHUmt62T3pJjHuMlaZtQ8GdOHAJRdMZiJJaqF6x
         p38Xbrt6natRwjkfQZEtR35yknaQFEK6eOUuFGJQA61XlJLoQryAyIMOfbpY2KSsfDGm
         5rsQFXP3pDQ7wBm3srYVqET1kPj++qY/XQ39iG9zmPBepXJK7OCCUQzzXKkHmuCeaPnU
         3uyjQoKWWOkGfru/5uvglL1jymz+NSVwWxg/aL53jU38Q35nRus892c66oIiRve1j+rV
         Pt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d5dQ5EQwn8mX60+IF0sZKf5rrEpnkwl9K3LbLZ9fU5E=;
        b=m0qdB42MEBXdpaUXeXNiTqpbl0z/lhUlIodrNpXVlXuEQ1jBKl5t4/eE3tQZHo+L2z
         IZB1FU6bQ1PKTbqRPaqh4oGaamJsyZC5ZxRPjYnzAyutFBl7r0dMscWwhLnlDYpdflf5
         jeiUS63jMiltx32qbtViVK8yxe1caFhvB8/2Dvrus/BXKb4GjhCe2I1kZJog5HySfP/c
         BMnThSLxLyA8Cp5ZaRisZoGJxwp11nZN1zKg88SgoFgzONxKKj7GLdniP/X61BvMQLHQ
         JyuSnuDp987bAH1JJmDzwZHPY3apDYqUVSMnW3I4RHa2+J0Jr3Lq5DyvZsFePG9nrFOb
         6wtQ==
X-Gm-Message-State: AJIora9RBFmmczqVy7R4wpBrpMhH4pwDjhXkfIGSIqrCJCH/I7cUZqal
        KSzfpQLiNp1qW/OPxg+PI7g=
X-Google-Smtp-Source: AGRyM1t20DkAevcHeaiJX+bQcVXqEihBXsE5IoQKn3N3qunX3d7UgtfRsZtk9UUAN8tXLf9a8S1NEg==
X-Received: by 2002:a63:5c5e:0:b0:412:a2f1:d0dd with SMTP id n30-20020a635c5e000000b00412a2f1d0ddmr7069106pgm.251.1657791945809;
        Thu, 14 Jul 2022 02:45:45 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:488:5f89:217d:a3c8:f1ea:4115])
        by smtp.gmail.com with ESMTPSA id i1-20020a056a00004100b0052acb753b8bsm1169233pfk.158.2022.07.14.02.45.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jul 2022 02:45:45 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, cy_huang@richtek.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v6 3/3] Documentation: ABI: testing: rtq6056: Update ABI docs
Date:   Thu, 14 Jul 2022 17:45:25 +0800
Message-Id: <1657791925-23929-4-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1657791925-23929-1-git-send-email-u0084500@gmail.com>
References: <1657791925-23929-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add documentation for the usage of voltage channel integration time.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d4ccc68..1f7d327 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2030,3 +2030,13 @@ Description:
 		Available range for the forced calibration value, expressed as:
 
 		- a range specified as "[min step max]"
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_integration_time
+KernelVersion:	5.20
+Contact:	linux-iio@vger.kernel.org
+Description:
+		For voltage sensing hardware, there may be different time between
+		channel conversion and sample update. 'Integration time' is used to
+		specify the channel internal conversion time. And sample update
+		interval is equal to average sample count multiple integration time.
+		Unit as microsecond.
-- 
2.7.4

