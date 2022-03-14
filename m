Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5217A4D8055
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 12:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238757AbiCNLEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 07:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238758AbiCNLEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 07:04:09 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B28F63BE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 04:02:58 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id y17so4135594ljd.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 04:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w493K1WiqKcZmge3rtv/QGItEltc1mivQITChU2JpVk=;
        b=nTJcrzVroKckZXpun8BCHaJei0s7hUwmOly1CUC9IXxJDXBAU4Uu8Byn4QXDePIZI+
         VBVeH6wo5eqkQf+3SgV5qXcaoBdhqORlipn25XDTCaq1opB1wkhK6eodh/aBSbpGwY/P
         CEfx4rkBQij0xjZgAwlmp5XRwAwwWJmUgxGPscR/mYZmMniq8HuHNYB9tetZSwImD5gj
         +vUVlEzvXPNjqi5ngsdqPH///z0At61QT7UYBc8fkCPQWaPMWjrNiJhbk7ZlKGRySjdm
         p+5dawIHojAjE7bIC9oaQaBsmBMKWKzZ5AV0EtOspYZ5PE8/aw7Fbs/37K868VAMFk6A
         NJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w493K1WiqKcZmge3rtv/QGItEltc1mivQITChU2JpVk=;
        b=tEZAoCNoIDJ/Q4/0Cc+ZAlzjvRM6Ee1qkThAsWQlVCjS0DuMxyZWxCRSz9poXVuyco
         vpXvYeS2cKFensegGV+uvP3M19KbTXLmbXvsYOpuvubmEsdJEP/DsV14VmH0hQJFDjss
         j+EyI6+1La4BJqr1rQDxgUynWKAV30iwW7SDREdBfT9kpMzErIwp403aYqUTgSXwh2vM
         5QGgtGZnNOtmqWb3O3fYTxaIZ/UhzEFSVOSO+iN2MMWsVEiax0CyCG82ZM73zHhVGSyf
         r7tf5JtAN/2HvhPaWj9G7/Co4t6Fu2FFtaCDtLnhMGjBBoYcO5MBGdkJbOkrioG1emZ6
         vhpQ==
X-Gm-Message-State: AOAM531acp+OfSakM1RqgthmNxi2wjOKQ5Z3vZH9Z1w+y/Z6EMtSYV4m
        3lbKtozOVcQOCIfDLJZ+2ccjJhOwhqDMnTwx
X-Google-Smtp-Source: ABdhPJwTeUdm/n3CP0uLMywChE3nB1rcsKA4y1OMjaLOdZ9qXK2UacWWJI9cabwaEQxkWag6Uv0bNQ==
X-Received: by 2002:a2e:864b:0:b0:248:321:f13a with SMTP id i11-20020a2e864b000000b002480321f13amr13858282ljj.210.1647255776808;
        Mon, 14 Mar 2022 04:02:56 -0700 (PDT)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id w30-20020ac2599e000000b0044824f72b1esm3219517lfn.110.2022.03.14.04.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 04:02:56 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
        kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCHv2] net: phy: Kconfig: micrel_phy: fix dependency issue
Date:   Mon, 14 Mar 2022 12:02:54 +0100
Message-Id: <20220314110254.12498-1-anders.roxell@linaro.org>
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

Rework Kconfig for MICREL_PHY to depend on 'PTP_1588_CLOCK_OPTIONAL'.
Arnd describes in a good way why its needed to add this depends in patch
e5f31552674e ("ethernet: fix PTP_1588_CLOCK dependencies").

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

