Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2C84682E8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 07:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384258AbhLDGPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 01:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384208AbhLDGO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 01:14:27 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6C8C061359;
        Fri,  3 Dec 2021 22:11:01 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id q64so5841143qkd.5;
        Fri, 03 Dec 2021 22:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NBahFhBm5LsBgIuxKHo9TSxzk1RWdMM4sXQUjJWhdQY=;
        b=lS1x+TbFHPqfVR5fTPKMIrA0xnvBoSS5Axu6fsY58xjLWNUByEqxswtDr1vCmjj2bR
         AAVR3TeRE69as8YfoMhmUh+Z6+57YRIJt+l1NJE0+ICOrjpNoespyUUUVLU+Znon0Gyx
         9Cxz72RWSqQOmT68uv0lADGuJ2b653UX6MC1lNwIw4PCbGVuv15RNT/y5yE/TNlv2B7s
         A0vvtBAZx3bialTSaXGdBDGEh0m4q5GTSEp7I14TGz1HxWvqjHyN169HsKUfghoagiWw
         9arDdfLzzAYBbrDFGV9KIrf75ttuKIKnsqNxEuRZpgIPwVplMI5v5S3KSvna3A0Xn6Hy
         Hp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NBahFhBm5LsBgIuxKHo9TSxzk1RWdMM4sXQUjJWhdQY=;
        b=5TECiiR8T28NfME5jbGLjkE8Z59xdINH6aZlpTSeHcQiSp6Sa1u/XMxXjWHUPTAlS+
         5UUoqQExUexWSWc0xaPT9m9uMhb1KUx8QdHRiAJeyoRqhvX/iRYfFFn2pPrlAb8Mnzam
         gSUt0EA65hozhHPCWUu0JCeh8lYqi88PSio7S98eQ0QfCl8/CLchk2htTVlsrefk1D97
         Y6M8Ql4TRgpnxIBhD8noQ114BejJDJu3jAYrubJy7mh2WPPfogQT687BjWJVe2mvT8s2
         zkYWXeucoK9FbuXCylpVrOFsoxkFrdghxGZj/CxyPktjoiswD6oEHAHK4ihYSZDmLoMr
         lJmw==
X-Gm-Message-State: AOAM530ztUIJgJ1+BcXfvCPufKwqc0O9fMWcJjjFMqjCqM1xbfE+gsd8
        5md4tyfpKSEIFXC4elgBcH8=
X-Google-Smtp-Source: ABdhPJwoQ6RlQrgedA3GGnU1amHGW3NPIWiJNeYr+UuEx5dqtJ9NbYQpWY+Y2UQqJtdqmCrs2ZVJLg==
X-Received: by 2002:a37:4015:: with SMTP id n21mr21207390qka.524.1638598261170;
        Fri, 03 Dec 2021 22:11:01 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id l1sm3500913qkp.125.2021.12.03.22.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 22:11:00 -0800 (PST)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, ulf.hansson@linaro.org, aisheng.dong@nxp.com,
        stefan@agner.ch, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, linux@armlinux.org.uk, abel.vesa@nxp.com,
        adrian.hunter@intel.com, jirislaby@kernel.org,
        giulio.benetti@benettiengineering.com,
        nobuhiro1.iwamatsu@toshiba.co.jp, Mr.Bossman075@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, Jesse Taube <mr.bossman075@gmail.com>
Subject: [PATCH v4 11/13] mmc: sdhci-esdhc-imx: Add sdhc support for i.MXRT series
Date:   Sat,  4 Dec 2021 01:10:40 -0500
Message-Id: <20211204061042.1248028-12-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211204061042.1248028-1-Mr.Bossman075@gmail.com>
References: <20211204061042.1248028-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Taube <mr.bossman075@gmail.com>

Add support for i.MXRT1050's sdhc.

Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
V1->V2:
* Nothing done
V2->V3:
* Rename imxrt to imxrt1050
* Remove BROKEN_AUTO_CMD23 and MAN_TUNING flags
V3->V4:
* Nothing done
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 764ee1b761d9..55981b0f0b10 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -305,6 +305,9 @@ static struct esdhc_soc_data usdhc_imx7ulp_data = {
 			| ESDHC_FLAG_PMQOS | ESDHC_FLAG_HS400
 			| ESDHC_FLAG_STATE_LOST_IN_LPMODE,
 };
+static struct esdhc_soc_data usdhc_imxrt1050_data = {
+	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_HS200 | ESDHC_FLAG_ERR004536,
+};
 
 static struct esdhc_soc_data usdhc_imx8qxp_data = {
 	.flags = ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
@@ -355,6 +358,7 @@ static const struct of_device_id imx_esdhc_dt_ids[] = {
 	{ .compatible = "fsl,imx7ulp-usdhc", .data = &usdhc_imx7ulp_data, },
 	{ .compatible = "fsl,imx8qxp-usdhc", .data = &usdhc_imx8qxp_data, },
 	{ .compatible = "fsl,imx8mm-usdhc", .data = &usdhc_imx8mm_data, },
+	{ .compatible = "fsl,imxrt1050-usdhc", .data = &usdhc_imxrt1050_data, },
 	{ .compatible = "nxp,s32g2-usdhc", .data = &usdhc_s32g2_data, },
 	{ /* sentinel */ }
 };
-- 
2.34.0

