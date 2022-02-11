Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2FB4B23C4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349230AbiBKKxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:53:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245284AbiBKKxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:53:19 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32459D94;
        Fri, 11 Feb 2022 02:53:18 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d27so10737350wrb.5;
        Fri, 11 Feb 2022 02:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=of3le3k/KcLzclFf7nJv6f4XfC/usK0Ju0claWmnEME=;
        b=GZ7csHpJQWS+7GE0vCWAKb1M6ZTyGqs+BBFyESHjeloc00rNm75VLj2Vr5sLW4zOgJ
         IPca/d27X0xAYVzJYIZ1kiOP6u45c9SNks4KwWBNwGE45FA8gymJBkSOJwh5fM1hgC0i
         jFhWzRi9MjrVlkx5v0RWTbsKybcfuO1HynN7kWFDJ/Lff5pgcO+FrKIl1tmY8LeCyIYl
         tNUOLa5SBzTAc2LJKz1420XCJ+c60X8lFhRSPllfsuAqBlEDkbKTclNCgmnFcnGPTtS2
         1iY63pArgoOHRG/TqjMIUgdbn3+Woclo1hwmfLY6kL8CZMkJj7UJ6wxGhp07DVb9Q5sm
         hnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=of3le3k/KcLzclFf7nJv6f4XfC/usK0Ju0claWmnEME=;
        b=0JVtSNy8SGkBia5wNB4hHT7g+Hz/lTPOun0Nmzf6ltZLoKn1+Jt0pq6P9pT5UVA5DY
         pxglBDZcr81tyrfUGhe+vTWo4ODoEPViboftcZvqSVhOUrpu+XJF6o8IKv/JpeRXowzI
         +xFgGbZQikTUeqwghvgqqA2DzH9c7alqfv8lkuxCcAQ0nuEwLC+MEdRUEbZKGBQvyG+R
         jMKrEGbjzhvNAMueLarVMjtGKnesD3d2OeJMIQi3v+iL8OpkEkUarNTMPX004KxLGtrs
         8ueJsXQT0BI6Ut3YvscHlT1jTgltCVSWxBvvgB71PWDeZ9UAWJcKQ/iTG7CsNy1ONrp1
         CDJg==
X-Gm-Message-State: AOAM530qXWedzLX47K9FC23yLNPBp7mPc7eYPE/Gc6qj3ML7EwkBtjyE
        stuhUDc61QUEpU0vruy4nzY=
X-Google-Smtp-Source: ABdhPJwBV4hMhVs8zqK+aOVwlnMeYFKAdAUfTzKutsCN8IPhNiw/tqsDIIIgxzG4C7agGJo/SxrmzA==
X-Received: by 2002:adf:dd8a:: with SMTP id x10mr925672wrl.422.1644576796556;
        Fri, 11 Feb 2022 02:53:16 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id b4sm13382374wrw.100.2022.02.11.02.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 02:53:15 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Sam Nazarko <email@samnazarko.co.uk>,
        Chad Wagner <wagnerch42@gmail.com>
Subject: [PATCH v2 0/3] arm64: dts: meson: add support for OSMC Vero 4K+
Date:   Fri, 11 Feb 2022 10:53:08 +0000
Message-Id: <20220211105311.30320-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the OSMC Vero 4K+ Set-Top Box device
based on the Amlogic GXL (S905D) chipset. The Vero 4k+ is notable
for being an original Linux (not Android) STB device, running its
own Debian-derived 'OSMC' distro. Big thanks to Chad Wagner for his
help with testing and device-tree fettling.

Changes since v1:
- Address device-tree comments from Neil
- Add Neil's reviewed-by to patch 3

Christian Hewitt (3):
  dt-bindings: vendor-prefixes: add osmc prefix
  dt-bindings: arm: amlogic: add Vero 4K+ bindings
  arm64: dts: meson: add support for OSMC Vero 4K+

 .../devicetree/bindings/arm/amlogic.yaml      |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../amlogic/meson-gxl-s905d-vero4k-plus.dts   | 117 ++++++++++++++++++
 4 files changed, 121 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-vero4k-plus.dts

-- 
2.17.1

