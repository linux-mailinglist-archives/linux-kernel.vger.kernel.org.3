Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE2448D19B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 05:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiAMES0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 23:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiAMER4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 23:17:56 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015B3C061756;
        Wed, 12 Jan 2022 20:17:56 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id u21so18268300edd.5;
        Wed, 12 Jan 2022 20:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HzmvZxRpnsxgqGIy8YYN4OsfjU68b3aJ8+UIStoBfA0=;
        b=Q4bJawOd+ZZkXv8DYD1cyGYc//O4+8Xv3qrX0kFxaS3KqdjqvRko4txY9AxFKmhTi9
         bQCGzdLhejzpi7defB3twuJjK5WsZhWFD3soyz2BBdx/9bnZpbzb6YdFdmkCCC9IkUAm
         ILL0FSwuIdsdNTt5qFWxuWJM7/1Cb4Jl0ooWHAHP1CW39KB8goeDhZ4FSP8rKz6ZwAsY
         J+Obew/8rmtQbBAXvxkMbx/l7V+7L2rAoe2lZKBqCcODi/QYKtfTYFR8WtdikZ5whLqU
         vja9VoRFM5NRp/FStTVJukn0GFcrSAPjr+H5RqIOfYuSQ9Kkfmb/TuHgYT1QqwCjp5ME
         SjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HzmvZxRpnsxgqGIy8YYN4OsfjU68b3aJ8+UIStoBfA0=;
        b=1zfVpEiKLgn4AnitR1jsa3vJCniynYqofDKAE3q9aN3EoHqRPuv2CKTjVaVlhKOK/E
         Hb91WvmIeH53vb74kT3uP8CdcXhNIFnEhN6NIQIdWt3AqEW8Ku92o66Da4UofvyNz3qH
         Tn/UoVjI84AdhyFKKRHR+AdDvmpzsI5Fim9S0OD+EDGGjfGo3SphxiSvbdQDOV706S9M
         Z5Fxd/sKGlz5r2Fz0fsTA6ktCAOHlrwEg9RR6QKRskdMNh6dLe5eV2+TW8nu0sVnqtJQ
         H8hJFJoSNSZDqyZGB2dW4Q9rVIVK6vkIJHkuWdI4bkSnIqVm99ss4Tgms9wJiwr2loK6
         EJXQ==
X-Gm-Message-State: AOAM532EsQiOjfFKXsKtgZxrXTNLWDYvnc5nsqodXW7B9nQ1/zFt4mgu
        X3iHufE9Lyg2h8gWgEvHsdqUH3oPan0v7Yp6
X-Google-Smtp-Source: ABdhPJxo4ki9X78vZDozmtI4hYQi3ocBBT2r1MmiDeO62vyGXqHwpXjySadKKu6tkkT+yyagVAxixw==
X-Received: by 2002:aa7:d507:: with SMTP id y7mr229177edq.298.1642047474644;
        Wed, 12 Jan 2022 20:17:54 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id eb14sm651822edb.16.2022.01.12.20.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 20:17:54 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 2/3] arm64: dts: meson: move pwm_ef node in P212 dtsi
Date:   Thu, 13 Jan 2022 04:17:45 +0000
Message-Id: <20220113041746.16040-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220113041746.16040-1-christianshewitt@gmail.com>
References: <20220113041746.16040-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cosmetic-only change to move/alpha-sort the node.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dtsi   | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
index c635e5858929..b3d7b8613d6d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
@@ -97,6 +97,14 @@
 	pinctrl-names = "default";
 };
 
+&pwm_ef {
+	status = "okay";
+	pinctrl-0 = <&pwm_e_pins>;
+	pinctrl-names = "default";
+	clocks = <&clkc CLKID_FCLK_DIV4>;
+	clock-names = "clkin0";
+};
+
 &saradc {
 	status = "okay";
 	vref-supply = <&vddio_ao18>;
@@ -170,14 +178,6 @@
 	vqmmc-supply = <&vddio_boot>;
 };
 
-&pwm_ef {
-	status = "okay";
-	pinctrl-0 = <&pwm_e_pins>;
-	pinctrl-names = "default";
-	clocks = <&clkc CLKID_FCLK_DIV4>;
-	clock-names = "clkin0";
-};
-
 /* This is connected to the Bluetooth module: */
 &uart_A {
 	status = "okay";
-- 
2.17.1

