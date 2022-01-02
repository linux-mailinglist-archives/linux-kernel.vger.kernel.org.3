Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF6C4828EA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 03:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiABCI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 21:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiABCI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 21:08:57 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D044C061574;
        Sat,  1 Jan 2022 18:08:57 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id mj19so26271244pjb.3;
        Sat, 01 Jan 2022 18:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ccSIOZd64GvaHS3TUywTQrdgyuVHIwhkxdkNz92oDQ=;
        b=hW+pdDtlj7TRxyd8E5Ro1HRBHuwMhGS0hWnZpPwDbKoggAJPcqhM7AAcxTYD/UEJid
         h1roG0BPbWe3uijIECDBieYzKvlEyBzfCwDO4jMACAALW7fgYSWSX1BCEKRm7/muycjb
         5vRVs7disfc17qzl41djjpiA9WIY/4xkFDB7uaopNYcHWL+s9gEUTuUsWIiC/AgWQnkR
         Zp7f9Mf6b6v2sYLm+nqamueJIuovrFOKHt+8K+afLa2LO4j58WDtwK5vvlrOVja5BCEg
         8UO4EvTAzHPgPNt0DddkEaBvWNrDcvEEp9ZU2EpHjrzYl4H4bvZRm3jDJOAvBnMxvFs/
         +SGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ccSIOZd64GvaHS3TUywTQrdgyuVHIwhkxdkNz92oDQ=;
        b=Hz7y+xNXyYhfhbFhFAvDuiwSLLspQ3ZPsTGSDftt5jum/8VYeR24/l0lwCy/1XPmPB
         XvDORPw18kjCN4U436OMMebfWanwztOv0AoYCxaDM7n3+7V8BXLq+8UoGly8lsZe2eky
         QifuKt/di5UDHG/C9CWDKqnWugCxlWb+ospRVrgmOm9v1GEE78SEeraMLRg2/WDBLYmz
         k+ESVyp2bHDF4kACCC14bzfeKZSb/fEGi+iJn9Wviyo/5Kp2uMP9j/nNuGxK9CVmGbWU
         oaYncPFWzdLve2TevvQ7gb+P4Y5cgLHRqcDbrosNvMOarwjpHN4YN8fWUUbrKik8cJHk
         T9ww==
X-Gm-Message-State: AOAM533hu+8Mo+Na5kMNJD9jvMC2PALe59HbLx+CLneMODND28oTk29v
        /N4OAPJMNHBkv1tJMXjIaRTAwHskFHA=
X-Google-Smtp-Source: ABdhPJwShUb3IEbhIGIe65Jy1F70ufw1rq3eiD+1/U9sRg2NFzne24n9t4onIkk1A8q/ruWw3sasoA==
X-Received: by 2002:a17:902:8b8b:b0:149:6d32:4b4c with SMTP id ay11-20020a1709028b8b00b001496d324b4cmr33870972plb.8.1641089336649;
        Sat, 01 Jan 2022 18:08:56 -0800 (PST)
Received: from kessel.lan ([47.147.80.75])
        by smtp.gmail.com with ESMTPSA id h1sm13283318pfi.109.2022.01.01.18.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jan 2022 18:08:56 -0800 (PST)
From:   Gregory Fong <gregory.0xf0@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Doug Berger <opendmb@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: update gpio-brcmstb maintainers
Date:   Sat,  1 Jan 2022 18:08:11 -0800
Message-Id: <20220102020811.8013-1-gregory.0xf0@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Doug and Florian as maintainers for gpio-brcmstb, and remove myself.

Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5ea5655a29c3..674cfd8b43d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3804,7 +3804,8 @@ S:	Supported
 F:	drivers/net/wireless/broadcom/brcm80211/
 
 BROADCOM BRCMSTB GPIO DRIVER
-M:	Gregory Fong <gregory.0xf0@gmail.com>
+M:	Doug Berger <opendmb@gmail.com>
+M:	Florian Fainelli <f.fainelli@gmail.com>
 L:	bcm-kernel-feedback-list@broadcom.com
 S:	Supported
 F:	Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
-- 
2.25.1

