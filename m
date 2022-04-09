Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397C04FA576
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 08:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238636AbiDIGpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 02:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237637AbiDIGpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 02:45:11 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED59DB647B;
        Fri,  8 Apr 2022 23:43:02 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id h126-20020a1c2184000000b0038eb17fb7d6so336811wmh.2;
        Fri, 08 Apr 2022 23:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Hew5fcLWaJy7bwAuvYjA3lNei48lfLSyllJNDnqQkVc=;
        b=jILQ4LHxO5+CInWgmA9XopC7fi7sLeqXXx9pBVE3OL7uY/CCkh9vQt8hlKNx8vQQv6
         lCLmAnhndgoqf1I+4UIz9HdwcUb8XBn8cGk0o58ymElyZOOt+rqSa5ZJo5ze9rkezna0
         oxsSslQgdJGQv/f3Q41ckLEsfGQeoZ4MvdjDcFOBfA1DHSpsR6gm+N02GSgGY7tIs9Lw
         KwZTlemStbsCE7Rf9k23+HFArdXbk867jm3jn0D5OHMX7LrPEE7eQXcEVxGoE6eTLZmU
         qyB1RPeLQgzslAiW9Guq3hP8d4Gsg8b7s52l+/1pS23Q4hd6M15L6u4QX9aRtfEy+ezN
         x5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Hew5fcLWaJy7bwAuvYjA3lNei48lfLSyllJNDnqQkVc=;
        b=UxZeWnMDL19WGNyKYUM0HdQn2oYIoccdgE+zrzk9qRdtUo67KQeeK0tWxxmAvnTQ++
         F4rh9x/GT56H3KibfSKlOgxUY1egb7Rybp5V1TI21u2Oud1ln1d8ngIT79aHMWA/6vc+
         A2/H7OhIIQP50FjA5bomJbAeTaUGxgP7E7NBY+84zNjIuFHb/nCMZhuA2V7LVtGnlsLk
         Eowhk+mdho6MiHK6AVZUQ88sUys0WrFVK9YOYwiFRfjxQQKyvz+yxF9n07pYR7p9OEfc
         +PAdVVGCm63Cmw9CPOj/iAOKZpUF46xETQ+wEvM+3lklxcpg+pxoOZnzIF6AeFrlFDxc
         mwEQ==
X-Gm-Message-State: AOAM531g0cJVhlSOjk5WLl64zYCP0C/xQximZ+U/olZQE1LC8H+RbeUV
        0NSgHDMPhrk0neskn8drMUM=
X-Google-Smtp-Source: ABdhPJxdQ1FvRmMXuNN14cFg6MkFQt5NUoRYqlA8V6b4WyYE1xKS45Ugoygq92XUmHHpnELWWhi/eA==
X-Received: by 2002:a7b:c188:0:b0:38e:74f1:7cbf with SMTP id y8-20020a7bc188000000b0038e74f17cbfmr19905948wmi.104.1649486581395;
        Fri, 08 Apr 2022 23:43:01 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id n7-20020a5d5987000000b00207891050d4sm5375643wri.46.2022.04.08.23.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 23:43:01 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] arm64: dts: meson: alpa sort the board Makefile
Date:   Sat,  9 Apr 2022 06:42:57 +0000
Message-Id: <20220409064257.24453-1-christianshewitt@gmail.com>
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

Let's alpha-sort the board Makefile to keep things organised.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/Makefile | 38 ++++++++++++++--------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 0eec18678311..8773211df50e 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -1,17 +1,18 @@
 # SPDX-License-Identifier: GPL-2.0
-dtb-$(CONFIG_ARCH_MESON) += meson-axg-s400.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-a1-ad401.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-axg-jethome-jethub-j100.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-axg-s400.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-radxa-zero.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-sei510.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-u200.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12a-x96-max.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-g12b-a311d-khadas-vim3.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gsking-x.dtb
-dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking-pro.dtb
-dtb-$(CONFIG_ARCH_MESON) += meson-g12b-a311d-khadas-vim3.dtb
-dtb-$(CONFIG_ARCH_MESON) += meson-g12b-s922x-khadas-vim3.dtb
-dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2-plus.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-g12b-s922x-khadas-vim3.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-ugoos-am6.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-kii-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nanopi-k2.dtb
@@ -19,29 +20,29 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nexbox-a95x.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-odroidc2.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-p200.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-p201.dtb
-dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-vega-s95-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-vega-s95-meta.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-vega-s95-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-vega-s95-telos.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-wetek-hub.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-wetek-play2.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s805x-libretech-ac.dtb
-dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-hwacom-amazetv.dtb
-dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-khadas-vim.dtb
-dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-libretech-cc.dtb
-dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-libretech-cc-v2.dtb
-dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-nexbox-a95x.dtb
-dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-p212.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s805x-p241.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-libretech-pc.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-mecool-kii-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p230.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p231.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-phicomm-n1.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-sml5442tw.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-vero4k-plus.dtb
-dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s805x-p241.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-jethome-jethub-j80.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-p281.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-tx3-mini.dtb
-dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-libretech-pc.dtb
-dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905w-jethome-jethub-j80.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-hwacom-amazetv.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-khadas-vim.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-libretech-cc-v2.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-libretech-cc.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-nexbox-a95x.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-p212.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-khadas-vim2.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-mecool-kiii-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-minix-neo-u9h.dtb
@@ -52,15 +53,14 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxm-rbox-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-s912-libretech-pc.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-vega-s96.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxm-wetek-core2.dtb
-dtb-$(CONFIG_ARCH_MESON) += meson-sm1-a95xf3-air.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-s4-s805x2-aq222.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-a95xf3-air-gbit.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-sm1-a95xf3-air.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-bananapi-m5.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-h96-max.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-khadas-vim3l.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-c4.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-odroid-hc4.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-sei610.dtb
-dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air-gbit.dtb
-dtb-$(CONFIG_ARCH_MESON) += meson-a1-ad401.dtb
-dtb-$(CONFIG_ARCH_MESON) += meson-s4-s805x2-aq222.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-sm1-x96-air.dtb
-- 
2.17.1

