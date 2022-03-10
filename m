Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C484D4460
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 11:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241139AbiCJKS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 05:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbiCJKSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 05:18:53 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C94A554B0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 02:17:50 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id w27so8566546lfa.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 02:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ok2yIWNdYw6UT5efIAaPeOu7HZzSRGXMlO55ACJQkJA=;
        b=iFB1j+Q2fbiLFyCEX66U0kNp3R9Qdjv5othk0HJtDc2koSj6UaHKn2IGAqWRW1srde
         83/F+janZ5NyYA/TbT8hP3qMpuxwDcs+Hsmm5M7olP4d98+JP0b0cjAXIi5je2Pkk3vy
         CwQRiqmsLBbLHQTdFz1H6D3p9Yq+eQH6L0ozOBmN0tLogA0aNw+uevLz3ol6JQgP8Di+
         uqkd0BRWhgDZdMpWrnilq2tFFuwxUkdzz3pBJ++1f3oR55zUi20lDRqI0qZWQfUMs1rD
         QHePrR5mY8w/q7oY6LnLziLRnEnookfGFge72iCcTKzqTvZLiTLBiYzk1/YZ715UeuYk
         aj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ok2yIWNdYw6UT5efIAaPeOu7HZzSRGXMlO55ACJQkJA=;
        b=VYxvEGlRMBavm6khvi7LFEHAWsLa1oXZvw4vorvZAs7fDUiKRN4LVHqZ9LiEyEHK4F
         PhW1l90xztTJGj754YHeS2SkvxqGUx1z2bfFh5i4irbrrvN4pJD+rkJqROsx1B/SXQH+
         wcEzFUzq9FCYT9i4ZI7Imf+JjtwziqwdlyyF359No31k73kbh2weDlwzzjWSsGaIM8l9
         MCGw7+RUGRMQIhRZAKEsyMN1ciLgUCZs0hMzVYxjDMrwaByqKmMsEBz+kHMvPx50KWjl
         ZjoiwZScgA9fQqohuanfm640rNS7+ifPm/siwnje76v/zsfshhGxYMGWBwWx+Ug6KwI7
         wsZw==
X-Gm-Message-State: AOAM5339DLgzMvlELVGN8STV16i80xNnh7yqZdSnHFWeh/ui9Z3Cf5f4
        t16v3e977w9XYBMxw7l4OBJT7A==
X-Google-Smtp-Source: ABdhPJwBLpPZruapkiuD/6bfRKohLHFYZXOqojAnrZrEwuSgOh2iA/UtAX49f1b2E4n4vKWILkebQg==
X-Received: by 2002:ac2:420e:0:b0:448:1c25:f22d with SMTP id y14-20020ac2420e000000b004481c25f22dmr2563248lfh.476.1646907468987;
        Thu, 10 Mar 2022 02:17:48 -0800 (PST)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id n19-20020a2eb793000000b00247ec95fddfsm984566ljo.33.2022.03.10.02.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 02:17:48 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
        kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] net: phy: Kconfig: micrel_phy: fix dependency issue
Date:   Thu, 10 Mar 2022 11:17:44 +0100
Message-Id: <20220310101744.1053425-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building driver CONFIG_MICREL_PHY the follow error shows up:

aarch64-linux-gnu-ld: drivers/net/phy/micrel.o: in function `lan8814_ts_info':
micrel.c:(.text+0x1764): undefined reference to `ptp_clock_index'
micrel.c:(.text+0x1764): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `ptp_clock_index'
aarch64-linux-gnu-ld: drivers/net/phy/micrel.o: in function `lan8814_probe':
micrel.c:(.text+0x4720): undefined reference to `ptp_clock_register'
micrel.c:(.text+0x4720): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `ptp_clock_register'

Rework Kconfig for MICREL_PHY to depend on 'PTP_1588_CLOCK_OPTIONAL ||
!NETWORK_PHY_TIMESTAMPING'. Arnd describes in a good way why its needed
to add this depends in patch e5f31552674e ("ethernet: fix PTP_1588_CLOCK
dependencies").

Reported-by: kernel test robot <lkp@intel.com>
Fixes: ece19502834d ("net: phy: micrel: 1588 support for LAN8814 phy")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/net/phy/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 902495afcb38..ea7571a2b39b 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -220,6 +220,7 @@ config MEDIATEK_GE_PHY
 
 config MICREL_PHY
 	tristate "Micrel PHYs"
+	depends on PTP_1588_CLOCK_OPTIONAL
 	help
 	  Supports the KSZ9021, VSC8201, KS8001 PHYs.
 
-- 
2.35.1

