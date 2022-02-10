Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994914B049A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 05:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbiBJEqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 23:46:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiBJEqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 23:46:52 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E614D13E;
        Wed,  9 Feb 2022 20:46:53 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id d14-20020a05600c34ce00b0037bf4d14dc7so2444117wmq.3;
        Wed, 09 Feb 2022 20:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=vRozfgv8c4CSVg47eYADPpU+vSvhsWF/kMmMfWcmYYE=;
        b=nLYaz8y/oYtDmbRGVqujXFIxW76NS6aKCy3G5lxsRPiBFGjwbj379Zk2feZ75DC+N5
         iQAP6VL0m+GxPufKrEU0IT3U0M/kHFirStAtjTGTQX4hKXYunqwVxqKI717dU0bL9AQg
         05zCz0fafn/g1fSDGWfw247fiR3h2bl1nFgn8cVI86dFJSuNeLBHdJGDsWMt4iNQQlDO
         oWznqUkMk4utglAMob5GXrRnkjkhE+G3H6uxEt2zRHAiLWwIilcNGYHhIimj7+8SZ7oi
         BzPXUVz1odlwIO00mFOokMN4Jq3baEDtkTt/aavV2OlunblOH292AgJQ2H8n+4SXsl+A
         VxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vRozfgv8c4CSVg47eYADPpU+vSvhsWF/kMmMfWcmYYE=;
        b=qu/1rGiOgaw/pxETUem4jYRszy5flDiTVc+QQCJBjC8kU9J+mu08k1YHJxyEnk/4O/
         9qpeV4LGwE+HENZlHSYRR8IdchEjMRP1hMlGOQN4dbnFx+Mnn/2IGjFUq5m6Ndou97uA
         UsbxJRYL7nwGnqJB7fJ0gfIg3wqJcam0sOCapohGBww5OLc8Q13PugPWVMym0j9cyKud
         xZNlyTthcYaOu4YKzSwYEfD7foXmBkDXD6/OnLfYX0iI8sNLNN8s9FVeWYvfb+LlxDmx
         cexH2ddtOZapGvU1EWNmNFJe8yIby2of6JorJz9X8W/zNmWOjIEqhRSeeujidsaPuvRd
         hR8w==
X-Gm-Message-State: AOAM530k2+GcHEr63qNqLakpr8wn7iKO+GlKzHNtLNcE7NxjogxdxhWp
        koYMHMJotC1fbrmUmn4jjt4=
X-Google-Smtp-Source: ABdhPJweKEsPlbgk+HcEoXMNC4J0RLS0HDhL0yuHl2kaYSZgeB5vQc0hi4wUyqwPLuunLDtg6Jj+BA==
X-Received: by 2002:a1c:a791:: with SMTP id q139mr560008wme.176.1644468412353;
        Wed, 09 Feb 2022 20:46:52 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id h17sm323089wmm.15.2022.02.09.20.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 20:46:51 -0800 (PST)
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
Subject: [PATCH 0/3] arm64: dts: meson: add support for OSMC Vero 4K+
Date:   Thu, 10 Feb 2022 04:46:44 +0000
Message-Id: <20220210044647.14443-1-christianshewitt@gmail.com>
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

Christian Hewitt (3):
  dt-bindings: vendor-prefixes: add osmc prefix
  dt-bindings: arm: amlogic: add Vero 4K+ bindings
  arm64: dts: meson: add support for OSMC Vero 4K+

 .../devicetree/bindings/arm/amlogic.yaml      |   1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../amlogic/meson-gxl-s905d-vero4k-plus.dts   | 125 ++++++++++++++++++
 4 files changed, 129 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-vero4k-plus.dts

-- 
2.17.1

