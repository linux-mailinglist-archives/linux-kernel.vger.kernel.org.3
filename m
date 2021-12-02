Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 575A7466099
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 10:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353866AbhLBJqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 04:46:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbhLBJq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 04:46:28 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79351C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 01:43:06 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so3103162wmd.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 01:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=f7qmmLTWAwXpHW+Kafc3zE9V8+RCHtiqILk1ED4oeZw=;
        b=QvZdFJWbNDn+unwRTEc6BvBAUd7pX19/yxeZZ5+uRDIKuZgkOMVROgyGIdeHFJzWtr
         0HIwR5x1CMGcvgH+SbIOSPH4A+tnRD/O6+cJ+Ga4FSM6NtzXNz5+PHol6MKMptTT0YFM
         dLPPaUdp8LdymL3USGaxHlPhcEHZ399jwtsZAY5kZ0UonKDr3IzVdLX3qebAafj83/p/
         pNfbRVCzgp5Ad8qQxW3u8B72HL3GvQ2iJUsPzXEqP+XJidzMVzzUBlTp/PW8tfaW21FA
         KvV6DgSSHvjcO5unPs4G4T26hXLkMioJLOCtSaGgR8fqhATMsredmKOJfNPYd2+z3j6q
         dB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=f7qmmLTWAwXpHW+Kafc3zE9V8+RCHtiqILk1ED4oeZw=;
        b=7Hrjl07rwF6bEart1r8q5IKIPmS5VzkPuXoitawWTyg2MzTTyeBq4CyF0uq6ksDaPo
         v6OdgAcXs66FhyEeOk0UkVUe9ImneH/pRpGo+aTSnpbXfjn0YnpwbbMxo2Ef459vz5kB
         h1xYKzgtcqfu/bX/q8wM4n1xQuJv7sUviTSBvu+tGZnT5M7MAwX1Uiho0rSsDjivaDO2
         NQBoAE/eLcjmWm+WuXlCEy8xXbWjrQL2/lM330DYqm5AAU+bFpoee0/9UhOn0rMfQFCY
         vjDe/oJiO5Wg0wACNdH+D/VWRaapQvyTUf7h960grT8wRF0/xV12cP9IVNZJMgTBdmAJ
         e1ww==
X-Gm-Message-State: AOAM53220C2XvxqNpmdLRpKFBuq64IXtAO15mwo8Cx6klge8CEMO0qff
        Gwe49SelZmaLH1bbUMAv/Ps=
X-Google-Smtp-Source: ABdhPJxOoRO1aefGBNjv5CjjzZloukOyBrqQyLL4M/ThC/MFEGnCJZ9XYRPg/h69gC9OabwGWkmsnQ==
X-Received: by 2002:a1c:7f43:: with SMTP id a64mr5190549wmd.4.1638438185049;
        Thu, 02 Dec 2021 01:43:05 -0800 (PST)
Received: from ?IPV6:2003:ea:8f1a:f00:6195:7c7f:1f45:58f4? (p200300ea8f1a0f0061957c7f1f4558f4.dip0.t-ipconnect.de. [2003:ea:8f1a:f00:6195:7c7f:1f45:58f4])
        by smtp.googlemail.com with ESMTPSA id a22sm1623782wme.19.2021.12.02.01.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 01:43:04 -0800 (PST)
Message-ID: <223bc330-5be1-136b-7b42-e4bc1331d28f@gmail.com>
Date:   Thu, 2 Dec 2021 10:42:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     Peter Tyser <ptyser@xes-inc.com>, Lee Jones <lee.jones@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] mfd: lpc_ich: convert name to const char*
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change reduces the memory footprint of the structs (admittedly
not much), and it allows the compiler to store names only once.
E.g. i2c-i801 uses name "Intel PCH" twice. All users assign static
strings to name, and only usage of name is in iTCO_wdt_probe() for
printing a syslog info message. So we don't really have to worry
about potential issues like use after free.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mfd/lpc_ich.c                  | 2 +-
 include/linux/mfd/lpc_ich.h            | 2 +-
 include/linux/platform_data/itco_wdt.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/lpc_ich.c b/drivers/mfd/lpc_ich.c
index f10e53187..acb33a180 100644
--- a/drivers/mfd/lpc_ich.c
+++ b/drivers/mfd/lpc_ich.c
@@ -889,7 +889,7 @@ static int lpc_ich_finalize_wdt_cell(struct pci_dev *dev)
 	info = &lpc_chipset_info[priv->chipset];
 
 	pdata->version = info->iTCO_version;
-	strlcpy(pdata->name, info->name, sizeof(pdata->name));
+	pdata->name = info->name;
 
 	cell->platform_data = pdata;
 	cell->pdata_size = sizeof(*pdata);
diff --git a/include/linux/mfd/lpc_ich.h b/include/linux/mfd/lpc_ich.h
index 39967a5ec..6dec7d992 100644
--- a/include/linux/mfd/lpc_ich.h
+++ b/include/linux/mfd/lpc_ich.h
@@ -27,7 +27,7 @@ enum {
 };
 
 struct lpc_ich_info {
-	char name[32];
+	const char *name;
 	unsigned int iTCO_version;
 	unsigned int gpio_version;
 	enum intel_spi_type spi_type;
diff --git a/include/linux/platform_data/itco_wdt.h b/include/linux/platform_data/itco_wdt.h
index 45d860cac..c6941c089 100644
--- a/include/linux/platform_data/itco_wdt.h
+++ b/include/linux/platform_data/itco_wdt.h
@@ -19,7 +19,7 @@
  * @no_reboot_use_pmc: Use PMC BXT API to set and clear NO_REBOOT bit
  */
 struct itco_wdt_platform_data {
-	char name[32];
+	const char *name;
 	unsigned int version;
 	bool no_reboot_use_pmc;
 };
-- 
2.34.1

