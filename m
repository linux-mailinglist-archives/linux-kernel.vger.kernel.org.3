Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C0C4D20F3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 20:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349849AbiCHTId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 14:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349472AbiCHTI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:08:26 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1376BE90
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 11:07:27 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id e3so60114pjm.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 11:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RxqL9uKmwzsq/dutI/kTwhTRbcQ6LXFSO3B46a+2dh8=;
        b=KDz7sqB/GOy3Rek5x0OSzxb1oJOCtV2TqHyquKOV6tpzO8h03nrC1PoXf0KT6tUcyH
         Z+cjtXV9PZDwwsxVDR3KVKYwtkLCI7vGwl/EwNmG83I+oBuDxEIlZ5mjbrEUMxrUHNJv
         p7g3/JzdIlEcmi16YbX0tUkKP1jX2ExZdmzG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RxqL9uKmwzsq/dutI/kTwhTRbcQ6LXFSO3B46a+2dh8=;
        b=kPWvwMk05AL4TMo9euVc3RjcfKqrpIkjQ2FsaqQ+w7uQKnbUt9rO3YQrS0/YTfT8Iu
         /wYL60OMljU+Ed2shODyDJfTVXSyNwg7r2/iTBSP3PEl+qqdDKa4ji+ftDmDwW8ig5lz
         Az+Td1JB4ZVTopPwlyXZ/8SqUFk8VxVCMEy6P1nGsxaob4LViCLqkZJjMtfmqugtuy8s
         IN1/QNGmF2xFZmvK49KTD4hK+4r2jBT0r6iocSwq4Iialqd4xZryu5gfvQlNbIL4BB4G
         sMfA7ofvPQ9F3JqhDjuOUNt89/CvBK3c/qRiqKZVeh+7o+2655IYQOwezhEgEitZI/gF
         HC9Q==
X-Gm-Message-State: AOAM53241/LCjUI6t0mhJ2S+1/bI7e7AR9hdLJ4ugkoulbUxpbL++v6x
        hhbZhgOs5wpI9DJ+W4CZOKj5hA==
X-Google-Smtp-Source: ABdhPJxA+5oPyDld/G3OlX7XBq5wkvOiVZlmJJeMLXsbKMgRocJxqbOlw2Tt9xYtPdnzlagw18TATw==
X-Received: by 2002:a17:90a:4612:b0:1bc:d7c2:b2e7 with SMTP id w18-20020a17090a461200b001bcd7c2b2e7mr6220103pjg.154.1646766446578;
        Tue, 08 Mar 2022 11:07:26 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:3cfa:63e6:3098:9d0])
        by smtp.gmail.com with ESMTPSA id r1-20020a63b101000000b00380989bcb1bsm2270762pgf.5.2022.03.08.11.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 11:07:26 -0800 (PST)
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
Subject: [PATCH 1/3] drm/bridge: Add MAINTAINERS entry for DRM drivers for bridge chip bindings
Date:   Tue,  8 Mar 2022 11:06:57 -0800
Message-Id: <20220308110615.1.I1f1b10daf7361feb6705f789deb680b8d7720de9@changeid>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
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

The bindings for bridge chips should also get the same maintainers
entry so the right people get notified about bindings changes.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0216d2ffe728..a73179d55d00 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6403,6 +6403,7 @@ R:	Jonas Karlman <jonas@kwiboo.se>
 R:	Jernej Skrabec <jernej.skrabec@gmail.com>
 S:	Maintained
 T:	git git://anongit.freedesktop.org/drm/drm-misc
+F:	Documentation/devicetree/bindings/display/bridge/
 F:	drivers/gpu/drm/bridge/
 
 DRM DRIVERS FOR EXYNOS
-- 
2.35.1.616.g0bdcbb4464-goog

