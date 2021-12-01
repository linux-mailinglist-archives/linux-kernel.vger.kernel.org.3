Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5524654C2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352096AbhLASKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352010AbhLASKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:10:24 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B07C061748
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 10:07:03 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id iq11so18606362pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 10:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4ecpP48RccuXNO4SgNuVitHpjcRwWPUYXr+xSlajqRg=;
        b=KU5yCnxiU1nWbi6+szU2izK7gPazQlzOTLJZfeRrUbLx/t6GdEM/p0cShqUstWoflE
         HubVD35uMRXAyWuEne6X8+1Qu71VGWiUNXz2KdEAFHk/lkXL5dayubqrtZh6pTsEiKNj
         6Xsb/syAvakOfZi5BO9X6bAkxlkRQn2UJQg9m55nVmi0K0BZCChNVJfAhDF9biuXUWcr
         24hMuKAcX3hE7x5w8h7NfCSub2olqEaXIz7ug3UrHKF+ljIxBzLlvhNadX+ehlScxZ1u
         yuz/3iqOgTIUjh6ZoNaWXDbuXhN4qubFw1bkPF13GEbK7e7gi6Bzbb/ozVNxh0Hw7eZs
         Blfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4ecpP48RccuXNO4SgNuVitHpjcRwWPUYXr+xSlajqRg=;
        b=DaXuh4dWNJyvj87VUclvHoc2CQUlQbG2HDGZrOp0omJGcaBIXLON045QthjNmACotu
         Td9Pth8Jnlgob95OxnalPeWuf2R9ujGwRc9DhgKr23zIjYDHOwcRGeXECkNIkGeQPtnl
         QGg8dBI4L+6dX+rVw6JSdm5rIMkkGALCN+LjvZ3Ni8H4z3N6sIAnNdd0PhqtMH21KCZN
         sffogJHY/6m7w0Kdp1agHRxKNpQN3Ic1vko0kJXG4UcpA2GHEmCPy1KVTQXpUgsESHbE
         +W6+/Gzf4bOpjA6Lu59OejJuSBzWscWnKFf6ODdlUKYoJuzc7nAPSHQf797v24sSLVwS
         Ya/w==
X-Gm-Message-State: AOAM5334Oe+KEUhtFavrCg0Gelwi2TjXteaoJX/g9dVU0JZ4CVoGwg4q
        UeglLCGkYv5SZViCGjPVB3+PYrJ4/Vor7Q==
X-Google-Smtp-Source: ABdhPJwyDmOP1QSi3uTWWoqoJq/dBKqbQPrqJ/3IsE2TGb7ni/InMrGQk1dZe5M2qCWuklbL+I0ZiA==
X-Received: by 2002:a17:90b:4c0d:: with SMTP id na13mr9608617pjb.177.1638382022739;
        Wed, 01 Dec 2021 10:07:02 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id w142sm462582pfc.115.2021.12.01.10.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:07:02 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 3/3] phy: broadcom: Kconfig: Fix PHY_BRCM_USB config option
Date:   Wed,  1 Dec 2021 13:06:53 -0500
Message-Id: <20211201180653.35097-4-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211201180653.35097-1-alcooperx@gmail.com>
References: <20211201180653.35097-1-alcooperx@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous commit 4b402fa8e0b7 ("phy: phy-brcm-usb: support PHY on
the BCM4908") added a second "default" line for ARCH_BCM_4908 above
the original "default" line for ARCH_BRCMSTB. When two "default"
lines are used, only the first is used and this change stopped
the PHY_BRCM_USB option for being enabled for ARCH_BRCMSTB.
The fix is to use one "default line with "||".

Fixes: 4b402fa8e0b7 ("phy: phy-brcm-usb: support PHY on the BCM4908")
Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/phy/broadcom/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/phy/broadcom/Kconfig b/drivers/phy/broadcom/Kconfig
index f81e23742079..849c4204f550 100644
--- a/drivers/phy/broadcom/Kconfig
+++ b/drivers/phy/broadcom/Kconfig
@@ -97,8 +97,7 @@ config PHY_BRCM_USB
 	depends on OF
 	select GENERIC_PHY
 	select SOC_BRCMSTB if ARCH_BRCMSTB
-	default ARCH_BCM4908
-	default ARCH_BRCMSTB
+	default ARCH_BCM4908 || ARCH_BRCMSTB
 	help
 	  Enable this to support the Broadcom STB USB PHY.
 	  This driver is required by the USB XHCI, EHCI and OHCI
-- 
2.17.1

