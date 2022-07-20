Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29E657AFA9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 05:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238872AbiGTDxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 23:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238757AbiGTDxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 23:53:17 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2EC6D568
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 20:53:16 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t3-20020a17090a3b4300b001f21eb7e8b0so252550pjf.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 20:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u6f/TW2lK+Z6PHiB8sDnRQTHwsczaRjv5MXneVlIaMQ=;
        b=juPVXMrbS2z9kh47D+ilwcQvWmxqKyFy59QnQEXlFPHErQANIDdmkJ94pEKszs7LVH
         11McA5QwlW5m2hXr13BzNjONzrdE6PdeJoZHz08lYGEFnuPta0iNv4spyN1rUKMhtAAY
         jZqJLx2jvAnjyUN6gl+G3WS+7B6zdt5+gyU5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u6f/TW2lK+Z6PHiB8sDnRQTHwsczaRjv5MXneVlIaMQ=;
        b=j1WwCaidqL+RKeVcz8Gv7e9bpcbR2KbDBKZ31PrLk9SPU7x81Xhduc8T7p5iIpqtCs
         XkifZmUsexHO0rGkjU7S7BtXLf04eosqG7TympBLrgsv8FDqwz79qunGKSRDiwIFEM8Q
         jfAxtn8rcMgdAREOI6dm8cQ9URd94TARnVL9Xg/q451pArUmtJ2Dg7JKLUJXdi9J84PS
         rkE4WNNxj+YVz49wNEvWdbcRSC/VlBtBeqGSRGayVapIsotIeOx/1YWuW7elTSSvt0rM
         dTKtzQQQg9iU2KI+N5f1NeFhK1gHSl6OwJcOC/wrgE+I324Ij1jac6yOGbCjZ8GJvThV
         2ELw==
X-Gm-Message-State: AJIora/WPCY/y2B42Kca6hwY7GrcETgrif5roIGJEdthoFgUFGSTUIzC
        9wyiOSTbzzAkHj+zdB2GkNTAvw==
X-Google-Smtp-Source: AGRyM1vgdgXehQ06PxCM+weN+8/HaGoYpCkfAjzpKaTH6W4CMVSaGfq/8M0BZ3ghFgv3Wzj1zbzX/Q==
X-Received: by 2002:a17:902:b08a:b0:16c:68b6:311 with SMTP id p10-20020a170902b08a00b0016c68b60311mr34874711plr.166.1658289196255;
        Tue, 19 Jul 2022 20:53:16 -0700 (PDT)
Received: from judyhsiao0523.c.googlers.com.com (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id t11-20020a170902d14b00b0016648412514sm12378346plt.188.2022.07.19.20.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 20:53:15 -0700 (PDT)
From:   Judy Hsiao <judyhsiao@chromium.org>
To:     Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        dianders@chromium.org, mka@chromium.org, cychiang@google.com,
        judyhsiao@google.com, swboyd@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Judy Hsiao <judyhsiao@chromium.org>
Subject: [PATCH v3 3/3] arm64: dts: qcom: sc7280: include sc7280-herobrine-audio-rt5682.dtsi in herobrine-r1
Date:   Wed, 20 Jul 2022 03:52:54 +0000
Message-Id: <20220720035254.1411959-4-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220720035254.1411959-1-judyhsiao@chromium.org>
References: <20220720035254.1411959-1-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include sc7280-herobrine-audio-rt5682.dtsi in herobrine-r1
as it uses rt5682 codec.

Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Change-Id: I53e237add854fadd51a748a7ca13e4cc88440306
---
 arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
index c1647a85a371..98280436813d 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "sc7280-herobrine.dtsi"
+#include "sc7280-herobrine-audio-rt5682.dtsi"
 
 / {
 	model = "Google Herobrine (rev1+)";
-- 
2.37.0.170.g444d1eabd0-goog

