Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D18577A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 07:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbiGRFqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 01:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbiGRFqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 01:46:23 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA2D140B6;
        Sun, 17 Jul 2022 22:46:21 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id v21so8096664plo.0;
        Sun, 17 Jul 2022 22:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d5dQ5EQwn8mX60+IF0sZKf5rrEpnkwl9K3LbLZ9fU5E=;
        b=FCMtTf6stUMQqFdLzH2VOuXfzscbDA7yuh0eFv9bRVrel3kf4AAZJs0u33h4HyW4XJ
         h2w05maGwI3KgSXWtlP7ky0dcK6myt9f/DvkF4ZIrtMdqYLyaxaWW2W3p0bY0VhJ13e+
         /m9yEycuLLyyPnL72zXPAIlLnFpcCDyxv2E8hdV8MUEfDKiQQFLWgRRo7SoBOB47T0q+
         ywP/RNaBgkWFhneBm0Gy4PJq2N1Lr/Z8DKFXSeALeQ5KtcwPXZkFdmtwxEPefOIvQo3/
         9+UlER67UM3YZkoCwHvgtGF3Yj5OZZnUYw4EnEByjKXo1AUpqnk+99PrBrjX5Jlhe/N7
         GIVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d5dQ5EQwn8mX60+IF0sZKf5rrEpnkwl9K3LbLZ9fU5E=;
        b=Bkq5OFl2Wmulat9+3BkryhGKzuvJgdvoyZBbWKw9kLxEv3Wl3URxtDgxuVf7KZOEJW
         ztL03aYVH622UtVSVIqGW3Nx3HDuQzmItUylHFMHEo0X6JJVrZnOejjHEnA3ZZaSQcRM
         cDn6/o98SpD+EeIxQqTu9keYMLv6MthdbTDjE1KbroyP9ATSwPFujJtw5sW31fmBpO2C
         EakcfnMMtPuR+nRKpkv34RJlgiTpuDRPqjFABGo+fwW/jAIYIbbDh4RBLi5gAp39Bxsc
         qiNhqOrrbHlC1XzccRAw91wsBLrDrmYsDuqa486+lZbVx/yp5zGpHK+FvKIptdfShNme
         c9SA==
X-Gm-Message-State: AJIora83MgBSSkn4Yz/NZptNtmfZP5twpqF1XeLvuHgEk06D2ikrf14z
        KMSj6act9wZkC31lsOAu9EI=
X-Google-Smtp-Source: AGRyM1tI2rrHJ3NKf2jgtoN8216r/XWM1F1HbsxO7HxyIJs/ANqJw8mzaKCw2+sfSQfmTDqN85PT3w==
X-Received: by 2002:a17:902:c945:b0:16c:49c9:7932 with SMTP id i5-20020a170902c94500b0016c49c97932mr26844396pla.80.1658123180599;
        Sun, 17 Jul 2022 22:46:20 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:587:e7ad:4982:5f13:5219:614d])
        by smtp.gmail.com with ESMTPSA id c66-20020a621c45000000b00528ce53a4a6sm8147951pfc.196.2022.07.17.22.46.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jul 2022 22:46:20 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, cy_huang@richtek.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v7 3/3] Documentation: ABI: testing: rtq6056: Update ABI docs
Date:   Mon, 18 Jul 2022 13:46:03 +0800
Message-Id: <1658123163-10039-4-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1658123163-10039-1-git-send-email-u0084500@gmail.com>
References: <1658123163-10039-1-git-send-email-u0084500@gmail.com>
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

