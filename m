Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD792472689
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238086AbhLMJwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 04:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbhLMJpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:45:51 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125C7C0698C9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 01:41:01 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id r130so14471318pfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 01:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SyI4CrxhxjGs4U1AItbH04mOIfBjvOwSAkZHtBeA6Zg=;
        b=MX0I7o11RVxfLQX6hcbyPebvWZP/qh+9KfyXgxOQsIcWqztDfvoyEDJc8rKXoXoAc5
         V2oXQlEnOKkOSK19/PwMBHVwgaevaut0Thnx3XoMCm4OMr2xGIyg4F9qk5+sANxs5pYF
         s641u8j196wmdy8T+4gn7S2ycrB7NQIF6KwU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SyI4CrxhxjGs4U1AItbH04mOIfBjvOwSAkZHtBeA6Zg=;
        b=hUF+v2ycxqrNA9+BOaflYds6+q2AhCN35rIef7D/HumPglI92DuiwUFUwSVBbKQIhX
         sBg+arP17DY+qpdtMyU/JGNVD+8szLqP4NlljTThtVRqhZPiNcAWiwkLyO+/AswA5DCG
         NP/qpX1Lc0UdJFHcEYiIx4TpVkqDHTKa8/Tv4cWmLLH2NtwySNMxLW7V9rQesZvMwtVy
         yyisXrrbGNjFncmCqFZPKG+7/gPGjmYBWt4X2w2zHujBLC5SwhvCkCfrsALJtkI2wtrn
         IDjIpyvEuEWMtTYr7qZre1n+BR3TC0g263h0UXNmt1QxrlGE/216Wn//83J8GluTwHTj
         4wFQ==
X-Gm-Message-State: AOAM533wLAIHhN5yxLfkuoUC+xmP9bg5ePnV+NCLZJ+doc4a8phLOGaI
        YYBhwdresfvAU7+Li5nuueGu9Q==
X-Google-Smtp-Source: ABdhPJwi4MogYiq2WtTnKfk5V1Z8klqo9x/WnYX4zftDB46L0eAqZXBBuZS9aouvemOMLPDEY/iBiQ==
X-Received: by 2002:a05:6a00:9a3:b0:49f:bf9b:3192 with SMTP id u35-20020a056a0009a300b0049fbf9b3192mr32444060pfg.44.1639388460570;
        Mon, 13 Dec 2021 01:41:00 -0800 (PST)
Received: from shiro.work (p864106-ipngn200510sizuokaden.shizuoka.ocn.ne.jp. [180.9.58.106])
        by smtp.googlemail.com with ESMTPSA id d195sm10237609pga.41.2021.12.13.01.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 01:41:00 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH v3 5/5] ARM: dts: mstar: Set gpio compatible for ssd20xd
Date:   Mon, 13 Dec 2021 18:40:36 +0900
Message-Id: <20211213094036.1787950-6-daniel@0x0f.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211213094036.1787950-1-daniel@0x0f.com>
References: <20211213094036.1787950-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now there is gpio support for ssd20xd set the right compatible in the gpio node.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Reviewed-by: Romain Perier <romain.perier@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/mstar-infinity2m-ssd20xd.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd20xd.dtsi b/arch/arm/boot/dts/mstar-infinity2m-ssd20xd.dtsi
index 7a5e28b33f96..6f067da61ba3 100644
--- a/arch/arm/boot/dts/mstar-infinity2m-ssd20xd.dtsi
+++ b/arch/arm/boot/dts/mstar-infinity2m-ssd20xd.dtsi
@@ -6,6 +6,11 @@
 
 #include "mstar-infinity2m.dtsi"
 
+&gpio {
+	compatible = "sstar,ssd20xd-gpio";
+	status = "okay";
+};
+
 &smpctrl {
 	compatible = "sstar,ssd201-smpctrl", "mstar,smpctrl";
 	status = "okay";
-- 
2.34.1

