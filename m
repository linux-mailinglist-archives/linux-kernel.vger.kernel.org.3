Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A234E54C4D6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 11:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbiFOJj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 05:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346553AbiFOJjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:39:24 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F9D403F8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:39:14 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id k5-20020a17090a404500b001e8875e6242so1499437pjg.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ja3EqjN7N3wjkxeGuFVn5Brj3OCcnua+aSOiaQe4d38=;
        b=Dl6wspIqN1HwQv+xanGbY5aahQSjQUwlXUwZZrlw7ZsOmHfqQ+C82WMcs9hILlP2J7
         A08MpVrb4Xc124CZe2D49toRajJ1auXhphFK1rOZSQmsvxoY2ciSH7k7+Z6fkM7fz7Tv
         53bTfCSTORaNt5pw+0wYQZY8oUsa8h68+R1dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ja3EqjN7N3wjkxeGuFVn5Brj3OCcnua+aSOiaQe4d38=;
        b=GsKgaDA3HvFu1jYFFYD6Uvj8wshuSjdKEWfGzMRHK9jqilLLfVLUu6XBS5wO10no0V
         3xAxsGRNzhgUAAPAwhTJubDOXBTHLOUR942Ib9DKKk92lIqq83UzIuaCpnalYbHwo60Z
         noX4U2J7aeQhuQweRWbYKq3qlM5E+faNfSQH/9xt82/SizTML0sBSnjvzCOGAECmc/zi
         BKZd553JeHWKlKiT0hXc9clICXG1FQv30YRwJkgmVeQFAGOW0JC81nKZcWXINlO9Leuv
         ZvXGO++DAp1TjBDvmTknpf2ux5mguRTikrvIRIH1bOA1rjUki3m4/LMnoJIT9GJQ1cXu
         N4DQ==
X-Gm-Message-State: AJIora+qsRuyG+4AWTN7NnCUfi1pcPTBEuKMSWjnHy6Hmg6Z/nXjxLh8
        1H6RCza8hvphREbCJiPujVOHkg==
X-Google-Smtp-Source: AGRyM1ttjP1JHhgada/B2uAxCQZnmdni3+xYfYipiH7otAjGeZI2YHcaZGJM5J6ZNWQ53JQTvClPJA==
X-Received: by 2002:a17:90b:3b8a:b0:1e2:f1da:bf9b with SMTP id pc10-20020a17090b3b8a00b001e2f1dabf9bmr9184899pjb.77.1655285953507;
        Wed, 15 Jun 2022 02:39:13 -0700 (PDT)
Received: from localhost.localdomain ([183.83.136.224])
        by smtp.gmail.com with ESMTPSA id jf17-20020a170903269100b00163f183ab76sm8662543plb.152.2022.06.15.02.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 02:39:13 -0700 (PDT)
From:   Suniel Mahesh <sunil@amarulasolutions.com>
To:     Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Christopher Vollo <chris@renewoutreach.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     dri-devel@lists.freedesktop.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        linux-amarula@amarulasolutions.com
Subject: [PATCH v2 0/2] Add R16 Vista E board from RenewWorldOutreach
Date:   Wed, 15 Jun 2022 15:08:58 +0530
Message-Id: <20220615093900.344726-1-sunil@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the R16-Vista-E board from RenewWorldOutreach based
on allwinner R16(A33).

Patch 1/2 adds the dt-bindings for the board.

Patch 2/2 adds the board with the following below features:

General features:
- 1GB RAM
- microSD slot
- Realtek Wifi
- 1 x USB 2.0
- HDMI IN
- HDMI OUT
- Audio out
- MIPI DSI
- TI DLPC3433

It has also connectors to connect an external mini keypad.

Suniel Mahesh (2):
  dt-bindings: arm: sunxi: Add binding for RenewWorldOutReach
    R16-Vista-E board
  ARM: dts: sun8i: Add R16 Vista E board from RenewWorldOutreach

 .../devicetree/bindings/arm/sunxi.yaml        |   6 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/sun8i-r16-renew-vista-e.dts | 361 ++++++++++++++++++
 3 files changed, 368 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-r16-renew-vista-e.dts

-- 
2.25.1

