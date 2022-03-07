Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505894D064B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244727AbiCGSWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiCGSWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:22:03 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2026D811AC;
        Mon,  7 Mar 2022 10:21:09 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 132so14308514pga.5;
        Mon, 07 Mar 2022 10:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DS2qv/sbCHqoLMCgOnfUdla2dw7bnIePwmkfx7decsw=;
        b=W9Gg5GyxMVII/LvqUsfW3gjfBZEdfgm8xv8ik/Z9siuo7Pqo4MulN5oQQB8so6ryAN
         mYtizLZIPZ71DYS2mXy7Dh5KJnIAXBypw/RIUQESQRb/31LCLjwtTPJyGbHKBh6YXmZA
         mORLiFaCUuG+7VS1Z8/itd8HbhJmQR4xyP+0G878i3pwc2TCVyy+GCMVYZc0rPNwl3EP
         2Dwzd6322CLGiJSqLjRbqGaWW3mMheT4+HXRfF4HqP+jg14uyoe7OvHUW3K0tdV9kgNw
         hHxRqlD2FOEl6jAdC2drnovLuGbpB6vGEJcA9K1aCPW6bUng7/La+LKeUPJIDSKM1QjM
         cs5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DS2qv/sbCHqoLMCgOnfUdla2dw7bnIePwmkfx7decsw=;
        b=f+q0chNf/rRVN/3uM52MKL4ept0XPTTl8jDi4j/1Enm9ejP3xFUnkdhnY38eunQxav
         wx99+fLZ49ptCeALtDxpmtcIj2Dzfalu6tvkMdPV9rs873MjFw3HApoZ7O/m39PaAgoZ
         A5GsrSsVKHGBjK10Cz4QsePZrlvF0VbDVYAi7gFM135s5kmad5hKVqLbzuHsFI5k82cD
         GvtIpsIUOo61V0m9cqNjwFF4A252QraPUqLIPfSM9FNeXkaobsgoMC2veH+Kq0IQ5tJD
         cJ1BqYyDcHMuJYPiC0jaz7GgWHs1x+N+UzJsIY2LUAHznszWYuCqzJquTrKMgmsZHJyb
         H8Rw==
X-Gm-Message-State: AOAM531ihYsgl2Jw/MD9MnradQOBqS7YlxFiDK7sCPhWGW3xlHLwxQVX
        8/zY55C519Hk6BEASf6h+rk=
X-Google-Smtp-Source: ABdhPJwuISSrdr2UftD1PKRqdTuR1a5SMMrV6QtwGPZRsPdtrDfRcGN6R2dbmjM4JwA8i/KgK85S6w==
X-Received: by 2002:a63:445c:0:b0:375:9c0c:c360 with SMTP id t28-20020a63445c000000b003759c0cc360mr10744430pgk.588.1646677268440;
        Mon, 07 Mar 2022 10:21:08 -0800 (PST)
Received: from localhost.localdomain ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id t190-20020a632dc7000000b003759f87f38csm12245809pgt.17.2022.03.07.10.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 10:21:08 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>
Subject: [PATCH 1/3] MAINTAINERS: Update git tree for broadcom IPROC boards
Date:   Mon,  7 Mar 2022 23:50:59 +0530
Message-Id: <20220307182101.84730-1-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Current git tree for broadcom boards is pretty outdated as it's not
updated for a long time. Fix the reference.

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c914384..5d627156efd9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3900,7 +3900,7 @@ M:	Scott Branden <sbranden@broadcom.com>
 M:	bcm-kernel-feedback-list@broadcom.com
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-T:	git git://github.com/broadcom/cygnus-linux.git
+T:	git git://github.com/broadcom/stblinux.git
 F:	arch/arm64/boot/dts/broadcom/northstar2/*
 F:	arch/arm64/boot/dts/broadcom/stingray/*
 F:	drivers/clk/bcm/clk-ns*
-- 
2.25.1

