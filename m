Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47C451695A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 04:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352807AbiEBCSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 22:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245618AbiEBCSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 22:18:06 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19217393E2
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 19:14:39 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l11-20020a17090a49cb00b001d923a9ca99so11693331pjm.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 19:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/6Cb5quQcvr6w4aquM9DgaTqeLRCFAMGcR2tJUmbtLU=;
        b=d9+xyl3TTsYoDqDmHTrZccfj71lKamLTsmONamCeF6V38dumBz36dHdLyevokgi5Ut
         Xn0bZcRB2loUzeJiPafcSO5/WrcL/9owgY2b6lb2pvIwVRjYvsCQPOiO/V6JowmYbJIF
         kLamJ+A+MOeIOImPoMdX9YJaYN+hC3armcLPlTltur/PIjBpzWKrN0jYeq+cO1sp/teh
         /tiidD0tqeTXXyMQVeEIz8lJnQlGGFsTLGS672UMl4U38HvneirztPm1/54Q+t4pTWOU
         TeJunDxqmSgcm5RAgGjdcp4TSwr/1F5W2twWEGrmaKnBDuuPiiHtwXgk0rp+baZyt52z
         TzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/6Cb5quQcvr6w4aquM9DgaTqeLRCFAMGcR2tJUmbtLU=;
        b=GMI19ShGO9u5Q8OQdM48Ii9n80NbVL6JAFuGMXMuuPyK3M9ZpFT6d0zS2ZXJVOwmYY
         jdAf+8ocWXf8iuVokDO1zVy0OBOge53xHKIb903TI0sEoJ9GAEpcGqS8bMaL4dLPweG4
         ZKZ1kNYSk8mCVzPabjRa+fOWiHejK7ZY5iV1h0m/OxcfZLIcN+96fm/0W2QvKvx8Iwsl
         hg4qXwQt+WLv9/NBsmB6yIycKtRdJheVSp/UlUYIJYKpm0LzI+2XoWKb0g0uOUWE61PC
         ND0qPD/CGRCjoAQyKowXQkI1hPHDtCP4qNx1m5atAUh/BOQdQrE0bSUMBJYQtis2avOJ
         QXkw==
X-Gm-Message-State: AOAM532ZePWPXGKaxxM1kd04HP6LFS+QbgCVzB80p4lyVyEJqY+TicNY
        DNhN3wwHQT7hXcqb4CNWXT3q8w==
X-Google-Smtp-Source: ABdhPJyHVrPMj/QysGF4PO8NxMM2ZKszBnTj3OJ73k+dsYSsXrk01OtyxHNfdl7JSsW2ChKd9dHEag==
X-Received: by 2002:a17:903:11d1:b0:151:9fb2:9858 with SMTP id q17-20020a17090311d100b001519fb29858mr9642183plh.136.1651457677684;
        Sun, 01 May 2022 19:14:37 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1001:7090:c18e:6070:88f2:a04d])
        by smtp.gmail.com with ESMTPSA id j2-20020a17090a734200b001cd4989febcsm18714475pjs.8.2022.05.01.19.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 19:14:37 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH 0/3] ARM: dts: enable am33xx and am43xx wkup_m3_ipc features
Date:   Sun,  1 May 2022 19:15:06 -0700
Message-Id: <20220502021508.1342869-1-dfustini@baylibre.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable new wkup_m3_ipc features which includes IO isolation on the
am437x-gp-evm and i2c voltage scaling firmware for both am33xx and
am43xx based boards.

This dts series depends on the bindings and driver changes in:
- [PATCH v3 0/2] soc: ti: wkup_m3_ipc: support i2c voltage scaling [1]
- [PATCH v3 0/2] soc: ti: wkup_m3_ipc: Add support for IO Isolation [2]

Dave Gerlach (3):
  ARM: dts: am437x-gp-evm: Enable wkup_m3 control of IO isolation
  ARM: dts: am33xx: Add i2c voltage scaling firmware to wkup_m3_ipc
  ARM: dts: am43xx: Add i2c voltage scaling firmware to wkup_m3_ipc

 arch/arm/boot/dts/am335x-bone-common.dtsi | 4 ++++
 arch/arm/boot/dts/am335x-evm.dts          | 4 ++++
 arch/arm/boot/dts/am335x-evmsk.dts        | 4 ++++
 arch/arm/boot/dts/am437x-gp-evm.dts       | 5 +++++
 arch/arm/boot/dts/am437x-sk-evm.dts       | 4 ++++
 arch/arm/boot/dts/am43x-epos-evm.dts      | 4 ++++
 6 files changed, 25 insertions(+)

[1] https://lore.kernel.org/linux-devicetree/20220426200741.712842-1-dfustini@baylibre.com/
[2] https://lore.kernel.org/linux-devicetree/20220414192722.2978837-1-dfustini@baylibre.com/
-- 
2.32.0

