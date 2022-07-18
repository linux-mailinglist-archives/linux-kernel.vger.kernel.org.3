Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2C95789E5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 20:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbiGRS4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 14:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiGRS4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 14:56:16 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A1C2F038
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:56:16 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id s18-20020a17090aa11200b001f1e9e2438cso700737pjp.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ImWpl/KKv4UFu4MEO4wU0UdHvw3c0qhUubcZMjHwl1c=;
        b=ZoiVOL41A6vCsGH0b1L/NLRLJ58R67hAbMBl6a3ujrVpjQ4uRQDZ+b6sOUeVZChAv1
         Db+5EalLfTpv9YtPjcUskcoveKHKgPRjT7MSTzmSENZn0PUr4iiWciunSBvNuGMSCB8i
         mS/7dQdFnfsxyyVcx128s5nawZVpZOpiVwKlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ImWpl/KKv4UFu4MEO4wU0UdHvw3c0qhUubcZMjHwl1c=;
        b=bRCf7ig7Jr1OqweQpcsfvLel4Xg0Ls2LmOYsddUCwFHsuzhmguPYZyunEWohN8OhDF
         IbezTyFIK375IupFDTbvSI9kK/bH9naXURrsHLPvZkWhIX/+lZHh3yZrlN2DEYo+8WHs
         Kb2tA+VbmfyzGFCvIceE9meJf8QdqJ7eH1PRURdrACgp5kiRMQj1jrtoVOwDv72ZV+Ni
         odcNCOehX9VMJ84xZsuZ1/NReOxGJe4MMx212RwfByPnrojuSMDBU5EBdE/ozDXQ01FB
         11HafiYVm4PM2qSzZUIak7gUONg2gJ/6LIj/ArhbEELnA7ybSZbZyNXj7VfaDBPn4vXh
         DuUA==
X-Gm-Message-State: AJIora/2VQLXgHMujx+zqFYwqF1kwJQdhWnpBdomggKCGzYmU2hEYff2
        7kdtVfx7D7XSY+kP7G89rHQ5RdwLXOSXOA==
X-Google-Smtp-Source: AGRyM1t8c/cRBGwxbDh8wtrP3JCV2aD79MUsWaVgg+FuCPJnIe4Rl3qht860tDVjt0ZtJy8teE9r9g==
X-Received: by 2002:a17:902:f092:b0:16c:abb9:f984 with SMTP id p18-20020a170902f09200b0016cabb9f984mr25023585pla.41.1658170575345;
        Mon, 18 Jul 2022 11:56:15 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id d66-20020a621d45000000b00528669a770esm9791323pfd.90.2022.07.18.11.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 11:56:14 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        chrome-platform@lists.linux.dev
Cc:     bleung@chromium.org, gregkh@linuxfoundation.org,
        Prashant Malani <pmalani@chromium.org>,
        "Reported-by : kernel test robot" <lkp@intel.com>
Subject: [PATCH] platform/chrome: cros_typec_switch: Add ACPI Kconfig dep
Date:   Mon, 18 Jul 2022 18:55:51 +0000
Message-Id: <20220718185551.1025288-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ACPI Kconfig dependency that was missed during the initial
driver submission. Fixes the following compiler errors:

drivers/platform/chrome/cros_typec_switch.c:93:9: error: call to
undeclared function 'acpi_evaluate_integer'; ISO C99 and later do not
support implicit function declarations
 [-Wimplicit-function-declaration]
   ret = acpi_evaluate_integer(adev->handle, "_ADR", NULL, &index);

drivers/platform/chrome/cros_typec_switch.c:93:35: error: incomplete
definition of type 'struct acpi_device'
   ret = acpi_evaluate_integer(adev->handle, "_ADR", NULL, &index);

Fixes: e54369058f3d ("platform/chrome: cros_typec_switch: Add switch driver")
Reported-by: Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index c62a514a087f..9d4fc505fa25 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -267,7 +267,7 @@ config CHROMEOS_PRIVACY_SCREEN
 
 config CROS_TYPEC_SWITCH
 	tristate "ChromeOS EC Type-C Switch Control"
-	depends on MFD_CROS_EC_DEV && TYPEC
+	depends on MFD_CROS_EC_DEV && TYPEC && ACPI
 	default MFD_CROS_EC_DEV
 	help
 	  If you say Y here, you get support for configuring the Chrome OS EC Type C
-- 
2.37.0.170.g444d1eabd0-goog

