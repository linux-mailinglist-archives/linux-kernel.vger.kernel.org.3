Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7527C502AA9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 15:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353918AbiDONDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 09:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353850AbiDONCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 09:02:55 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB3B366AD;
        Fri, 15 Apr 2022 06:00:26 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id p15so15259665ejc.7;
        Fri, 15 Apr 2022 06:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S84E1eWBaSIUeZ9W/llIuiSE3Qi4QPmakDDip3XJfY0=;
        b=bLxQFC4MPjco0F5aOdPMC8kPpOKIpj0np2d6OckasxJwCZK82InNqzB2qnX0r06VcG
         wEp3CJuJYvsCIhigQeDjy9vmwC4Ji5sJraWFcHckF9uEBf+ra5S4yUa5u4mrBfEIXlKQ
         80GhnQPLHZoL+hxXl715YlCynPWaE7jCUmFefYDTlFR+LSVW3hmQpeT5oLyWXBnHFDLJ
         UEP3xRQ+AU6IQnPqSThj/43PXQxM2ybR0oSRLqPTzBkeGqR4uRGal/0lLw8r9X037nLE
         e7frdGO9+3PIn1Q7u0mr47sEzweMFT6Us68+DwRsU/J2mfUemO9Txajs6LKxvKo0ZUNE
         3FgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S84E1eWBaSIUeZ9W/llIuiSE3Qi4QPmakDDip3XJfY0=;
        b=RMiMZMUJ+ZDxceK8bYQGK9e+5GIsA0HmCT57PWmkPKvauJOte5MrYCGPt8Ymk8B434
         jR2JevFSkVgEXikus5+GO78KWXjO3oMlXQwPlZHtGgPV1EU4irP0uH5izGLcMA8rT/Io
         DVaopFBBSDwgKzmj3nTQ9PN7z2UslYQDuqoP4Kwa+dV7f3s7UdehkU0Iisi9ALiBwI1m
         1gieqC8GWaBKw2mG2b7+fUcHXm/R1ApCClIqZUuVRoWtM+a7zYML/t04k2Q/SBi0/nCM
         BxiuTbNknOmfSFtFC4LklFlk9dCyJC/TMZKtAMbppQueqY8vXbVoS/bj5fT40Wugnj3J
         21zA==
X-Gm-Message-State: AOAM532BTruFLu5GJlX03evIVO52YXEvrpkX1NavvqczEKULJAmPebbx
        4HB3ls+YlYxoCV2e5ZdicmJs24uZ6fagDQ==
X-Google-Smtp-Source: ABdhPJzp9MtPBP/Gvf6pz67J3Xrpth5cKzu/bzZiNlPJWyTgf0IVKetxtVqK+kl/uBwk5PZHWOomug==
X-Received: by 2002:a17:907:da7:b0:6df:9ff4:10c7 with SMTP id go39-20020a1709070da700b006df9ff410c7mr6022534ejc.106.1650027625345;
        Fri, 15 Apr 2022 06:00:25 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id i26-20020a50d75a000000b0041e84bb406fsm2704715edj.0.2022.04.15.06.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 06:00:25 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: [v4 02/14] iio: document linear acceleration modifiers
Date:   Fri, 15 Apr 2022 14:59:53 +0200
Message-Id: <20220415130005.85879-3-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415130005.85879-1-andrea.merello@gmail.com>
References: <20220415130005.85879-1-andrea.merello@gmail.com>
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

From: Andrea Merello <andrea.merello@iit.it>

This patch introduces ABI documentation for new iio modifiers used for
reporting "linear acceleration" measures.

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 Documentation/ABI/testing/sysfs-bus-iio | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d4ccc68fdcf0..aadddd43bf22 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -233,6 +233,15 @@ Description:
 		Has all of the equivalent parameters as per voltageY. Units
 		after application of scale and offset are m/s^2.
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_linear_x_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_linear_y_raw
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_linear_z_raw
+KernelVersion:	5.19
+Contact:	linux-iio@vger.kernel.org
+Description:
+		As per in_accel_X_raw attributes, but minus the
+		acceleration due to gravity.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_gravity_x_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_gravity_y_raw
 What:		/sys/bus/iio/devices/iio:deviceX/in_gravity_z_raw
-- 
2.17.1

