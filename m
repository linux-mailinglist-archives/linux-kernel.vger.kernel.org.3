Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0704757A276
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 16:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238326AbiGSOxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 10:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237962AbiGSOxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 10:53:03 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C845F48;
        Tue, 19 Jul 2022 07:53:02 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y9so13747986pff.12;
        Tue, 19 Jul 2022 07:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OZiBpFyW9MnDMSabeWCxAJ/auRfTTJrBnZ7dKBX77Q8=;
        b=aUUu+v7RPc8KpnCUPG+ReeGtPU9ePs/btyw3lVMyZSKsfVv/eDKICi7mJv3h7KRwsA
         XohNzdTLKPsvegeWmf1i2RN92JtVunk+d7EPRZRxzOD0eZI51kgQt6DaKanX7bfiuI1n
         oPpZfDZVefTyAx8rOLp39r3v1Y3354VYb1jnHWFzYXTtL3fbG3WKLPMcoyB/HbtJvYKr
         Pcuyq5UGU1/F1wezzomiH3V9oAQSo2exD/iXtJjB3Aa2BeSoLB1qcic9HiDbW+flMESz
         ao/rP3+Iv9EcWKgcBTOtTDaxc1xyUzQMBWApWdVHuuffoUtRnYdAUuZFHK1PyTX4k1+g
         mIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OZiBpFyW9MnDMSabeWCxAJ/auRfTTJrBnZ7dKBX77Q8=;
        b=5hgRVmh741Hum2YRGc9bJYTvgt7ExbpYbQl/NgQjjtTA+BL5RO3bqoOAv1KOVqr5k2
         ZlGJC3YBBAtmXZpAdIlKtsAzVnoeSCcCgPwQciVtM5q4CYOElQTNiqjqpcNVnOUWYDp3
         pXcaZi676ztCSzocjC+D94WL4ayzk1SJd60mCMwTlRcHCzYUR5loAK1/QqYFKjvkyEs7
         HaaCWF6KrEsOUjiDzYE7fMTffgHQZ7iKlZnetRye+27NDJf3iBuT5gAQTXpU9LYOv+e0
         xwrog5kMhsJOCIlvnDDNqb6DENZQbAB9N6Oug53Bk4+6lKuTDAZ+PDe5W/h/+zkgEcac
         sS9g==
X-Gm-Message-State: AJIora9WDyAYnxrUjxxbJmySPc/OGzk5L4frNzCnxL6Km7kNt1z/Td0d
        hOPfrJYKImzE6z/vS6zwyg4=
X-Google-Smtp-Source: AGRyM1tt+Zcswq/JMIXpdHwqIDW/OQuVzWBUpDxwLrjc4pXrEWEVJ6/v2L0OdMEgZVU3ip9PHxFHXQ==
X-Received: by 2002:a63:86c8:0:b0:415:366c:f287 with SMTP id x191-20020a6386c8000000b00415366cf287mr29184219pgd.309.1658242382406;
        Tue, 19 Jul 2022 07:53:02 -0700 (PDT)
Received: from localhost.localdomain (1-171-6-142.dynamic-ip.hinet.net. [1.171.6.142])
        by smtp.gmail.com with ESMTPSA id o18-20020a170903211200b001615f64aaabsm11630842ple.244.2022.07.19.07.52.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jul 2022 07:53:01 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, cy_huang@richtek.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v8 3/3] Documentation: ABI: testing: rtq6056: Update ABI docs
Date:   Tue, 19 Jul 2022 22:52:45 +0800
Message-Id: <1658242365-27797-4-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1658242365-27797-1-git-send-email-u0084500@gmail.com>
References: <1658242365-27797-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add documentation for the usage of voltage channel integration time.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Since v8
- Update IIO ABI about sampling frequency for power/current/voltage channel.

---
 Documentation/ABI/testing/sysfs-bus-iio | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d4ccc68..17855f7 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2030,3 +2030,14 @@ Description:
 		Available range for the forced calibration value, expressed as:
 
 		- a range specified as "[min step max]"
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageX_sampling_frequency
+What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_sampling_frequency
+What:		/sys/bus/iio/devices/iio:deviceX/in_currentZ_sampling_frequency
+KernelVersion:	5.20
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Some devices have separate controls of sampling frequency for
+		individual channels. If multiple channels are enabled in a scan,
+		then the sampling_frequency of the scan may be computed from the
+		per channel sampling frequencies.
-- 
2.7.4

