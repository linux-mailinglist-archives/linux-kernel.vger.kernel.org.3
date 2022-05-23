Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E50E531680
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbiEWTjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbiEWTjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:39:35 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD55106A4C
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:32:08 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id ev18so14911535pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1wnCjP5k4eX2zs3WnXnoMhMGUr28/cypjl3o/2Z6tes=;
        b=f96L1AT0mMjn1RyAtdZVgkH33HDZ3/VSA/ng8TU23JHBipyGveEAF7DkL2d00oCE6H
         zIMx6xWWYXMx89FXNceFqwrVXxVGbmsTeNwpkhojYLOXsICJ9JOQ1LKjsOgCtbFgOoK2
         kZqvPnK/6aGbuIab5p6ELE0mTUnLLj4sS8rFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1wnCjP5k4eX2zs3WnXnoMhMGUr28/cypjl3o/2Z6tes=;
        b=QPU89eK0Py/rmKq4mo6qR8UgrMG5wYOLzCDhq6EGGX4T6wgvRdG7VReBQFhKdMD6c3
         fRmRjfrf+sXwWU8SIlIUB5M2ksjoXhZWNiazoiRaWnIBHo5XzLlDkd6/F6Wjtf/2eKKs
         7iqrmcmcJm+ya5YTHScDeXjgn7aC713E2+pWz1XlwVKs2bAm1PrzRC+P3axJYA45F+r+
         in2r/72OzwFWe5o9HXjdVT1IurDwFknzxQNGvqa/wh4ceS4iODJlA1djshvEL+ImYcqj
         ae5cJ0Xqi6N6wakIq1w2TDkz6+drvazxbXKrr/aVJTxwkZ5wyDcunuwUwcA+lpPv3DAl
         MaXw==
X-Gm-Message-State: AOAM532GhM09q9dPvFYbItQ6sPoA6sdc+dQbIH9AFrEL6VHT6g3lK5yV
        JYcp1Kj4nBd+aamOZ9mJgsSE3Q==
X-Google-Smtp-Source: ABdhPJxX6NxzBbaQ+Q2IdSpZVtxZcdeQA8n0q/eIC47fkQbMLtVd2ZTJsqFGaSkDZy+dM6YShA+Ltw==
X-Received: by 2002:a17:903:1104:b0:15f:bce:1a0c with SMTP id n4-20020a170903110400b0015f0bce1a0cmr23570068plh.149.1653334327861;
        Mon, 23 May 2022 12:32:07 -0700 (PDT)
Received: from localhost ([2620:15c:11a:202:46dd:d5d8:48f6:713e])
        by smtp.gmail.com with UTF8SMTPSA id p8-20020a637f48000000b003c14af50631sm5138505pgn.73.2022.05.23.12.32.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 12:32:07 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 1/2] arm64: dts: qcom: sc7280: herobrine: Don't disable the keyboard backlight node
Date:   Mon, 23 May 2022 12:32:03 -0700
Message-Id: <20220523123157.v2.1.I47ec78581907f7ef024f10bc085f970abf01ec11@changeid>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On herobrine boards the keyboard backlight is controlled through the
PWM LED driver. Currently both the PWM LED node and the node for the
keyboard backlight are disabled in sc7280-herobrine.dtsi, which
requires boards with a backlit keyboard to enable both nodes. There
are no other PWM LEDs on herobrine boards besides the keyboard
backlight, delete the 'disabled' status from the keyboard backlight
node, with that boards only have to enable the 'pwmleds' node for
keyboard backlight support.

Also add a label to the 'pwmleds' node to allow board files to refer to
it with a phandle.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index 9cb1bc8ed6b5..55b513912e79 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -295,11 +295,10 @@ pp1200_wf_cam: pp1200-wf-cam-regulator {
 
 	/* BOARD-SPECIFIC TOP LEVEL NODES */
 
-	pwmleds {
+	pwmleds: pwmleds {
 		compatible = "pwm-leds";
 		status = "disabled";
 		keyboard_backlight: keyboard-backlight {
-			status = "disabled";
 			label = "cros_ec::kbd_backlight";
 			pwms = <&cros_ec_pwm 0>;
 			max-brightness = <1023>;
-- 
2.36.1.124.g0e6072fb45-goog

