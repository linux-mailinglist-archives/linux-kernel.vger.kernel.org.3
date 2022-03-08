Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C12A4D20F2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346353AbiCHTIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349841AbiCHTI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:08:29 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9900DF5D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 11:07:29 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id g19so176688pfc.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 11:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dlYDY5S/XDx5NW4Fv9JuxYnsAy3lZY4PrUFXc2DC20E=;
        b=fbl/m/GJ9RguZxpwlYSV73iVjMMe4SNgYzjYZ5vr6QXELRkv49Lq/0CjCTiaoKpMrL
         ByovFxAKsvcuYQPlFu1itELof6n05qGzselHpuASh5uqu7+ATfdTNeZH4fSXDxSoxa9E
         nBCwhki8tMKxh0hgxSop2a6K+DEHC7CN4FKgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dlYDY5S/XDx5NW4Fv9JuxYnsAy3lZY4PrUFXc2DC20E=;
        b=YbQgFJTlwFOX6ovBCOwNLqqw65xpZFUjdtpWYo9os/r++NTAfqkyfWdATRcJsLkKiv
         ZlsX6l5AaGGtR732VIcymj9LyRtEVetGjc7HJKgAvE3qeNz0N1eavFQISpURdIF2PRS9
         T3eXJ94L73E8+G5dg9oYWuF3RPOD0tu3ZZaJcYJ0tLPAdAJiP0sGle84+b1aTSgkVWOI
         WkOxgKZ0XO6mqrgELuLzFQ75RnfUMOl7r6tjbhLW3RWpM+nUSPYVZe5T2BYz0XaK/GmJ
         OXYY4gDrgeciClNnsc3uSQfJMUJxbKuuMdDbGWJB4WeJY7xo+zfneaMn7ZlbgJtp/Ua6
         LXXA==
X-Gm-Message-State: AOAM532YwFcOODmJhKboSZrD664LrUsCCmQXyAYtwMQTNc0f6wPiU5M6
        kFZW7ZD9LKevIvrypwNtOtRQMg==
X-Google-Smtp-Source: ABdhPJxmf8ha/2Xk+EbD6Ae2W0oV8AzDmOjRY6EupaurEZd7CYN60GSz9SGpInxlogA+DjR1c7faMw==
X-Received: by 2002:a63:6949:0:b0:380:94ab:9333 with SMTP id e70-20020a636949000000b0038094ab9333mr3176468pgc.199.1646766449359;
        Tue, 08 Mar 2022 11:07:29 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:3cfa:63e6:3098:9d0])
        by smtp.gmail.com with ESMTPSA id r1-20020a63b101000000b00380989bcb1bsm2270762pgf.5.2022.03.08.11.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 11:07:29 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sam Ravnborg <sam@ravnborg.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <robert.foss@linaro.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] drm/bridge: Add myself as a reviewer for the Parade PS8640 bridge chip
Date:   Tue,  8 Mar 2022 11:06:59 -0800
Message-Id: <20220308110615.3.I04f99fbcc14b8c09610b4b18f0696c992a44d2b7@changeid>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
In-Reply-To: <20220308110615.1.I1f1b10daf7361feb6705f789deb680b8d7720de9@changeid>
References: <20220308110615.1.I1f1b10daf7361feb6705f789deb680b8d7720de9@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Though the parade bridge chip is a little bit of a black box, I'm at
least interested in hearing about changes to the driver since this
bridge chip is used on some Chromebooks that I'm involved with.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d25d0b4dccc..db7fe53643c2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6171,6 +6171,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino.yaml
 F:	drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.c
 
+DRM DRIVER FOR PARADE PS8640 BRIDGE CHIP
+R:	Douglas Anderson <dianders@chromium.org>
+F:	Documentation/devicetree/bindings/display/bridge/ps8640.yaml
+F:	drivers/gpu/drm/bridge/parade-ps8640.c
+
 DRM DRIVER FOR PERVASIVE DISPLAYS REPAPER PANELS
 M:	Noralf Trønnes <noralf@tronnes.org>
 S:	Maintained
-- 
2.35.1.616.g0bdcbb4464-goog

