Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF0353FB65
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241151AbiFGKee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241087AbiFGKeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:34:03 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FE3692B0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:34:00 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v19so22376532edd.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 03:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u0O6Mf/UrJOEwrZeCEjj2knBSzB2PFx6iqji2ENZg2g=;
        b=IwaL9rxfFfdPgnr716/ClY4yXQUUDH+uGY2IGB7VYY4T6TmoZ9e3dj41Pf3yv+UH30
         6GxlHtJohRz8MIjhHcA96j8p6DHYgRQamw2QqKo9R3otjgIF+F4TbIyQUWtobrbhk82I
         TWFHf8z20fnuPgDEyb7UnQU8J3horlfb8lt/l4ajrLq/6Ra42wfSNfrDqe1bE4BAKKNQ
         emqvW4/GRdXQQZDW9hCKQEGifgsONTnUxg2rE1jQQWYOgj+mZtsabKoYJPdYlxLDNC+7
         OqiOjNsCQX7ioLA89ptRvowvloU3F1siqN+wQdOlIMvucfQddlmx7CHKhmJLbFdB2VU5
         MyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u0O6Mf/UrJOEwrZeCEjj2knBSzB2PFx6iqji2ENZg2g=;
        b=JpH3LbH+IbpTGjR6z17MGUpEw6M/u14ktp5HOuFEABOB46eO4VKLfaMs/WCSBctY06
         LPNdU9zXy/w9zXggiU74XQvZmQNqrdkXvwJHzoC48PUeIoFrFv0rx2ChrkaDAs4/jm6b
         8uvDKLBqh3zRwsBWUFSS8Dcg7qhyDdwx+aDbAg8pdOwXmYkhyl74I0NpHjBzAUULE285
         MhrycgVPaHDMHWDbnAmN4UHqHjASfGYFySrdC5uJz8qvlGcFjq9JYGiC1CSKB5PJSNLr
         JcJKF+WMAEncVj+a5z54YB/9zgA+TmBLisQjNT9b5J3dg9fqJAlbI2Hy5y5fEg40ArS/
         b8Eg==
X-Gm-Message-State: AOAM53193v2XH7BhbmCbLa5euyeD2dL7VEYvEzI8S0p3IdM5bR/L4g9k
        SLq90/RvPv4D1lrq8HdD7CclGw==
X-Google-Smtp-Source: ABdhPJwKvkIDwyyhRdK6kIRYwjZd0OU/0w4Gl5DsX+c1Rallj5Buyt2b3KcIY8pvxUpT9+V6ZnSKKw==
X-Received: by 2002:a05:6402:34d6:b0:42e:2a6a:5dc4 with SMTP id w22-20020a05640234d600b0042e2a6a5dc4mr25257043edc.361.1654598038899;
        Tue, 07 Jun 2022 03:33:58 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id x4-20020a1709065ac400b00704fa2748ffsm7505359ejs.99.2022.06.07.03.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 03:33:58 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 09/10] arm64: dts: qcom: sc7280-herobrine: add function to LED node
Date:   Tue,  7 Jun 2022 12:29:30 +0200
Message-Id: <20220607102931.102805-9-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220607102931.102805-1-krzysztof.kozlowski@linaro.org>
References: <20220607102931.102805-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add common LED property - the function - to LED node.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index 9cb1bc8ed6b5..b5e31d908938 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -15,6 +15,7 @@
 
 #include <dt-bindings/input/gpio-keys.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 
 #include "sc7280-qcard.dtsi"
 #include "sc7280-chrome-common.dtsi"
@@ -301,6 +302,7 @@ pwmleds {
 		keyboard_backlight: keyboard-backlight {
 			status = "disabled";
 			label = "cros_ec::kbd_backlight";
+			function = LED_FUNCTION_KBD_BACKLIGHT;
 			pwms = <&cros_ec_pwm 0>;
 			max-brightness = <1023>;
 		};
-- 
2.34.1

