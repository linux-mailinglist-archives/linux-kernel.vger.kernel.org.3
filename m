Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A3B4D1133
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 08:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242681AbiCHHnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 02:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344726AbiCHHnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 02:43:01 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239763E0C1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 23:42:06 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E7CCF3F7FA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646725324;
        bh=Un+PBm7TVpil6wZFl7iMD+ssa0pQW3YglAFfrUmMR/0=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=W69ZLe3tSwrcrThJ6oa5hI6KQyeCf/yge1ZpKEf9YCJ0zHcZoZA4HgXgBKLDV9nCE
         azZcqyZlBFvuK6Ap8qMZJxPRHhJngOtkQtkXsY3+ElZ3lp1p564alZeK8wJOYsaF92
         isx7fjupCBVxN20Lt2Bb/V81mi2a/s9P3zzHV67KWLYlvf5qCVTqdC5NII7xxyjehp
         IQKkuu/lQ6G4v7qBCBHrB1SFT22zcanXnMqkobjrIZ/oJiKty+ZWh5/ofxycS+Pywh
         l5EMOFxJxPmhkbbqW6HhyaBFWngmfO9yHXjNi0wNQeYgpwDPx9CglMBnlVoe2pLGkk
         eL3frctLIxIiA==
Received: by mail-ej1-f70.google.com with SMTP id qf24-20020a1709077f1800b006ce8c140d3dso8227136ejc.18
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 23:42:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Un+PBm7TVpil6wZFl7iMD+ssa0pQW3YglAFfrUmMR/0=;
        b=INoAcPvJpQHIVejSd+ya/jYokSoCF3VCkv0hUS6JZvCnvgw3/ruZ0jbl3AGlAYdfBV
         Q8v6sp599L+gPSev6TMSshx6QsD5LW7rpj44YoW9WrnG+u9cw6vjSjpmmIVMv6GO4Irx
         eTmqe6mHr9hguYiRG8PCACReKHukYBL9xFNG+BpWDUXrvlx4LmN7+S2BBAseP9TecfFj
         /WQ0QDQQt26oIo5++uBgh70YEeMGQV1NdWd6ajF8voAL0INSm9Otf6H/c4IGx9WmSBdL
         5PlX302GsehVm7V84+6ZM9iRv6VkwR7Qzk0+mR8xn8ckz252SrvOk/6aVB1a9f4o9eaz
         NraQ==
X-Gm-Message-State: AOAM531VtDdT5Kk8uKkOjBFPqBSeJIBQT/R8ZrH9wrJBzkg5ZARz+6IH
        z+KKwAEW8r374EwbIx9TiO4KZTNC1g6sIO6rfjllNMPPQdx1stxhIfRME1YPgPKRSsx/AAJNu4H
        ZIb3vPHP7K8USJZzDc/42ZPJs7L4j+kggMySO72X7rQ==
X-Received: by 2002:a50:d498:0:b0:416:2b00:532 with SMTP id s24-20020a50d498000000b004162b000532mr13081361edi.396.1646725320735;
        Mon, 07 Mar 2022 23:42:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzjhCqo9HH0cK+RI8/E89ekTwyLjLyg0tpT17qz7uVBuNxty/NMegrabspJHC1kBpHoMxQrTQ==
X-Received: by 2002:a50:d498:0:b0:416:2b00:532 with SMTP id s24-20020a50d498000000b004162b000532mr13081352edi.396.1646725320534;
        Mon, 07 Mar 2022 23:42:00 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id d4-20020a1709067a0400b006d6e3ca9f71sm5565533ejo.198.2022.03.07.23.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 23:41:59 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] serial: 8250_tegra: mark acpi_device_id as unused with !ACPI
Date:   Tue,  8 Mar 2022 08:41:57 +0100
Message-Id: <20220308074157.113568-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver's acpi_device_id table is referenced via ACPI_PTR() so it
will be unused for !CONFIG_ACPI builds:

  drivers/tty/serial/8250/8250_tegra.c:178:36:
    warning: ‘tegra_uart_acpi_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/tty/serial/8250/8250_tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_tegra.c b/drivers/tty/serial/8250/8250_tegra.c
index e13ae18b0713..e7cddeec9d8e 100644
--- a/drivers/tty/serial/8250/8250_tegra.c
+++ b/drivers/tty/serial/8250/8250_tegra.c
@@ -175,7 +175,7 @@ static const struct of_device_id tegra_uart_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, tegra_uart_of_match);
 
-static const struct acpi_device_id tegra_uart_acpi_match[] = {
+static const struct acpi_device_id tegra_uart_acpi_match[] __maybe_unused = {
 	{ "NVDA0100", 0 },
 	{ },
 };
-- 
2.32.0

