Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904BD4D20F0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbiCHTIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349836AbiCHTI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:08:26 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A99EA6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 11:07:28 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id fs4-20020a17090af28400b001bf5624c0aaso244549pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 11:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o5rO1oO6v5AYtlUIb5c5k5sSAJxVe6/hFwowLpNFVz8=;
        b=a5FYsP3lRV8nsb6SRNtyoS9NpKLoe+GwCurekXFoQoLg+sq/JtVsNwZubbdkHnUDME
         Fmty33ZKNRRMDCAzrMb+Lti8+qMPUwtbcLU5rMAeDEpExmdgLiGJRZzYgr9oSS7Y5YEK
         xUQCi4pJW7nOcpSOfGoucudIXQHscZYR09WH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o5rO1oO6v5AYtlUIb5c5k5sSAJxVe6/hFwowLpNFVz8=;
        b=WEvkGOk2sNvmp3HNnk1JSSvvstelXKRj4ErFRS9HpZaReuxL8yzf5qChZh9Arvm3/b
         H0D3ZrTvxdXEAVpgRe4+KX7jOTYTPiv1vJoaQTrfrfVV+z5aqrnWMO46FwPZL7ATE4cc
         m3i4nNGxEPYEHHUyCtIubwo6zbfg7M8caJLKqs9ucCwc75AsI9IkfohBVDkXy3VK2xv4
         vkWXDObUUA5bmvetERSwLv5elP+nhp83NB6k5LZ9MeLYs90Eo2lLNzHObmokNUgJ4Ca6
         j22z/uqvgptsG6YrKj6OqdUEu4C6kt9sJUrYEKcWZHKIGv7flz97jm096YkxEHai6e/C
         OEVA==
X-Gm-Message-State: AOAM531vzojZlGbZZp1PMAZJx9aS3mpFFWVkkW000p+tBE2zNthsRlts
        GtQ3MJ/Yf28/KnBaUGx3Ran94A==
X-Google-Smtp-Source: ABdhPJzQLapgtK0EmHqlzuH9s6sGWfyMEf6/zWeN6bjRhqQp0pLIeBLU1GnaNTaKVDIckb/AOeqQLw==
X-Received: by 2002:a17:902:9681:b0:150:288:7440 with SMTP id n1-20020a170902968100b0015002887440mr18466980plp.166.1646766448080;
        Tue, 08 Mar 2022 11:07:28 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:3cfa:63e6:3098:9d0])
        by smtp.gmail.com with ESMTPSA id r1-20020a63b101000000b00380989bcb1bsm2270762pgf.5.2022.03.08.11.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 11:07:27 -0800 (PST)
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
Subject: [PATCH 2/3] drm/bridge: Add myself as a reviewer for the TI SN65DSI86 bridge chip
Date:   Tue,  8 Mar 2022 11:06:58 -0800
Message-Id: <20220308110615.2.I4485769d5b25a8096508e839b8fea12ce7b836d3@changeid>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
In-Reply-To: <20220308110615.1.I1f1b10daf7361feb6705f789deb680b8d7720de9@changeid>
References: <20220308110615.1.I1f1b10daf7361feb6705f789deb680b8d7720de9@changeid>
MIME-Version: 1.0
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

I've spent quite a bit of time poking at this driver and it's used on
several Chromebooks I'm involved with. I'd like to get notified about
patches. Add myself as a reviewer. It's expected that changes will
still be landed through drm-misc as they always have been.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a73179d55d00..7d25d0b4dccc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6284,6 +6284,11 @@ DRM DRIVER FOR TDFX VIDEO CARDS
 S:	Orphan / Obsolete
 F:	drivers/gpu/drm/tdfx/
 
+DRM DRIVER FOR TI SN65DSI86 BRIDGE CHIP
+R:	Douglas Anderson <dianders@chromium.org>
+F:	Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
+F:	drivers/gpu/drm/bridge/ti-sn65dsi86.c
+
 DRM DRIVER FOR TPO TPG110 PANELS
 M:	Linus Walleij <linus.walleij@linaro.org>
 S:	Maintained
-- 
2.35.1.616.g0bdcbb4464-goog

