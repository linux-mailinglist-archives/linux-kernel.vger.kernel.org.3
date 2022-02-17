Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C774BA5C1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243148AbiBQQ1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:27:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243107AbiBQQ1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:27:38 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A619A9A3;
        Thu, 17 Feb 2022 08:27:24 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id f17so10666183edd.2;
        Thu, 17 Feb 2022 08:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YEIQSgJVSRiyLY5DqxsBH1nNB/kYSQxeQBbJ8QX8vA0=;
        b=bvOJLcYKGITSELAcwDgWspmn0xZgmxZI7Nv/X66sLBdVghQz6iPNRclyg2ebH5zXcy
         npWVakKWsKQVr51V2j8czIaPaWOoWjHA2y03HDVRDC1IhcfsQC2O5z8qpHgQUOPVPmuA
         PA+CP9zNcWiIGDHKoOOmrs0JtqqJ4HMfATRLHtCnqeyStjnr+nIRNqCXb4hD/JIOtfhl
         w6aqt7di7XD3ZEYKeWA5E9annkgOsZBzmiCbtyp03aO80L936nn9q+HCj7MhoDmrC3cj
         cp5VeA6k63TrgbceXIdGlfd+WQ4ujEGd3d0lQM63oXmz/LFiayjiKqtGbcC+A+l1/eiq
         x7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YEIQSgJVSRiyLY5DqxsBH1nNB/kYSQxeQBbJ8QX8vA0=;
        b=Aj3MicKaRy0p1og3uKciHudf9EXVvzfKT2qLgqUsSbFNHbvSo8vi8kMabR1uHi9XZp
         xKHvaWF0l6qSbt/bHIX7HhRMNFwitJkZzCopiBL4TOQZRRQHVoMemu5S722DOQtHuNUN
         G6Ny96Pe6OJ3vGsuUs/0mUT6B51LHzyP64I1uJ80taHj1C7u2lerAQs8sEOs1ChbWKG3
         rr/UApYIwPDC3K1QNABHwrAViNIknmxoPhQgOS5DrhTSugzHnF0U8pSKPQ5ZQKLYh6j0
         OEcI9MlxEl3n8bEzDAFDcZOQzSo6EHWR57Y4KZsRSejAMq8uGDOMpwjr5x5G4x/eRscU
         KT0A==
X-Gm-Message-State: AOAM533Cmh+o6Mky/zCtow5FD9YUmAEW8x2/8C5Pvfz8FaouHk8zeYpl
        zeV3j3ScfopAEv+beP1zzC4=
X-Google-Smtp-Source: ABdhPJxVjoZHB48h1w82ew1WNRxVUjZMMmkdyAg6jnc0RRRtIP3WvKGONRJD+LoRrD6bmxkCOpz3lw==
X-Received: by 2002:a05:6402:17d9:b0:410:aaaf:6467 with SMTP id s25-20020a05640217d900b00410aaaf6467mr3590082edy.38.1645115242996;
        Thu, 17 Feb 2022 08:27:22 -0800 (PST)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id j13sm3653742edw.24.2022.02.17.08.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 08:27:22 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [v3 02/13] iio: document linear acceleration modifiers
Date:   Thu, 17 Feb 2022 17:26:59 +0100
Message-Id: <20220217162710.33615-3-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217162710.33615-1-andrea.merello@gmail.com>
References: <20220217162710.33615-1-andrea.merello@gmail.com>
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

This patch introduces ABI documentation for new iio modifiers used for
reporting "linear acceleration" measures.

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 Documentation/ABI/testing/sysfs-bus-iio | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index c551301b33f1..b2fb4d9abcd1 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -233,6 +233,15 @@ Description:
 		Has all of the equivalent parameters as per voltageY. Units
 		after application of scale and offset are m/s^2.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_linear_x_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_linear_y_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_linear_z_raw
+KernelVersion:	5.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		As per in_accel_X_raw attributes, but minus the gravity
+		acceleration.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_gravity_x_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_gravity_y_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_gravity_z_raw
-- 
2.17.1

