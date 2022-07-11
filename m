Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D19256FF7A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 12:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiGKKv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 06:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiGKKvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 06:51:15 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289AAF78B4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 02:57:36 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id s27so4279308pga.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 02:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ucIABpm0tHgZbugMVpXR/cvUpPRiZNPssbWbAhXi7gg=;
        b=rNmK0O6/+Lj6vxcMBnC3KBcmhOIh5Ic2wZj2otu6RA+O59tfRCYmBngCYG+901kZxL
         bcLdoGG7dH6wcQ1OIeQwd8U65ldL1NjQbcAPJELi97B+TPum+uX23qFHoBDa0FnRlCKj
         3c/SGPLHeAv0SJOFum0MZM83m7KXs5k2Yi6F0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ucIABpm0tHgZbugMVpXR/cvUpPRiZNPssbWbAhXi7gg=;
        b=CqtK+3w1suoXtCuDuE2S6jXWKYjdMS1NLe0L6eT5YSjU95ohNSKy5FzQuLXzikcTS8
         /PNB1IL4ybxrjMaS9YXZcoMqem2cGAd6glEhcmatGFccXnmKlgNZGFgNmj5kMpbI4hh5
         c5xpET+RHtC+sdeVernBY4hqUGJSrZXGD19rToEYxR0RlbjlbvNODzDC6fxeqvDLhApU
         bmC3byNYOWjCdTDBBEl9qXUkYZ6aEjOsrYUXzRf4vkg8G0RtYJpYSQ9qpE6nyMhhKKa8
         7U+vTlVCmQniVTwW/9i3Gg5ffIuyS8NF1veQIvryh7/bOW7NOh5nasGTcv6dmD1hlHbd
         aACw==
X-Gm-Message-State: AJIora95eCF1ok0MpYkhAK83Qd88mC/AhJdnBIvSgVIMhYKbM2Ptqh93
        ACJBkuMc3QMs5mJuW4yIBeoAiKBLgQN7wE5Qdv8=
X-Google-Smtp-Source: AGRyM1shcbcdZucQQ7F1qcDmpMRqkfAOfjxb3Q05U7MTeRf2MEHZ1fAJoCmUS3y5HaN1ewWsco7fFQ==
X-Received: by 2002:a05:6a00:2292:b0:525:6c57:8dd5 with SMTP id f18-20020a056a00229200b005256c578dd5mr17866670pfe.17.1657533455349;
        Mon, 11 Jul 2022 02:57:35 -0700 (PDT)
Received: from localhost.localdomain ([183.83.136.224])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090a390300b001ef81bac701sm6560814pjb.42.2022.07.11.02.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 02:57:34 -0700 (PDT)
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
Subject: [PATCH v3 0/2] Add R16 Vista E board from RenewWorldOutreach
Date:   Mon, 11 Jul 2022 15:27:19 +0530
Message-Id: <20220711095721.1935377-1-sunil@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
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

v2 patches can be found here:
https://lore.kernel.org/all/20220615093900.344726-1-sunil@amarulasolutions.com/

Suniel Mahesh (2):
  dt-bindings: arm: sunxi: Add binding for RenewWorldOutReach
    R16-Vista-E board
  ARM: dts: sun8i: Add R16 Vista E board from RenewWorldOutreach

 .../devicetree/bindings/arm/sunxi.yaml        |   6 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/sun8i-r16-renew-vista-e.dts | 362 ++++++++++++++++++
 4 files changed, 371 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-r16-renew-vista-e.dts

-- 
2.25.1

