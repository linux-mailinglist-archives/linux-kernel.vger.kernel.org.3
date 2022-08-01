Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C20586CA0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbiHAOKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbiHAOKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:10:14 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB612AE;
        Mon,  1 Aug 2022 07:10:11 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id t15so5567370ilm.7;
        Mon, 01 Aug 2022 07:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SKYMNZOozs9ygfjwGcEyMLKhWm5HBP/AFTsEusdw08c=;
        b=n+pfKw4wVib4NhLgdB8D4DQ0RU/OE9wK6w+nDi+XIe1rQAChYJh66H6Tt3BLJwtRgJ
         QI1Du/+wKJ0gJg6f6kaLQt4gKjoutK3cKfcNfNLkH5UrOpYXG5Mx5j1yJkevYdY+2RCg
         KtJvcMa9U/KCEEnKBo1+lkYuAAmcnXHxEc3cChPFrq0GYmY5EM063kT01fJK7JHS9/kA
         9C65uQIulAlORwFPEs/EPYQlo2FcoT4th+OPjTlXgtxPMnJkD47s6ra6kndgoz8D6P5T
         0fYTjIsIPSRLbmpJhqM+isvQoZ+FFu6C3hnwAq66sQncwzOr5DmvTipGRATJnLUgDNK5
         lOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SKYMNZOozs9ygfjwGcEyMLKhWm5HBP/AFTsEusdw08c=;
        b=KY/+lECPJ56AER4LCHv19AivTyLQCGqQ5+9F+FsCpG6/ZqLHesgNKP90/OcjeJvOf/
         rI3dNcX5ZO3nwsMm+kyLUPglnTWPGxqGB1atTo+3qnggCtcqLJ2Lq2Udx28S8doVf9sL
         XwUTrOcWdcYWHk4sb2dZhAbwdN5b+OE3xVoEYc+IgpukK2Xs4QQGerpfLYjdTLLB37HL
         Eih0cNX4Xq1k4Vb2LvtjnriDihQuTMe1Ie1EKrEAA3QhSB7CmuXeOrXdNaQap7I2fjiY
         yYBLll4SGOaXditfsst2aTbx6gwW014FM5iILoy+Jjta9RJJfCPlKf9dYbFSWgJWrUfI
         XrVg==
X-Gm-Message-State: AJIora/yBhzCC4aTXnhO7UIzF0zEzJTdgSA7A7SfaimOops+VWZUkkhi
        3+YZNr/1vbEnSGoU1ti5UpE=
X-Google-Smtp-Source: AGRyM1sfVKGjR4GNxeoOmnvnMg1NBMdB7a/75YmeQutwkz2VY0SmLEhDqWN5itsBhpce1YCN97bbng==
X-Received: by 2002:a05:6e02:180a:b0:2de:20c8:572 with SMTP id a10-20020a056e02180a00b002de20c80572mr5864808ilv.213.1659363010615;
        Mon, 01 Aug 2022 07:10:10 -0700 (PDT)
Received: from localhost.localdomain (wnpgmb0311w-ds01-45-179-115.dynamic.bellmts.net. [206.45.179.115])
        by smtp.gmail.com with ESMTPSA id x16-20020a026f10000000b0033f4bd1342esm5329836jab.104.2022.08.01.07.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 07:10:09 -0700 (PDT)
From:   jassisinghbrar@gmail.com
To:     robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sudeep.holla@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH] arm64: dts: juno: Add missing MHU secure-irq
Date:   Mon,  1 Aug 2022 09:10:05 -0500
Message-Id: <20220801141005.599258-1-jassisinghbrar@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jassi Brar <jaswinder.singh@linaro.org>

The MHU secure interrupt exists physically but is missing in the DT node.

Specify the interrupt in DT node to fix a warning on Arm Juno board:
   mhu@2b1f0000: interrupts: [[0, 36, 4], [0, 35, 4]] is too short

Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index 446c8f476eec0..fa3710c7c26c4 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -26,7 +26,8 @@ mailbox: mhu@2b1f0000 {
 		compatible = "arm,mhu", "arm,primecell";
 		reg = <0x0 0x2b1f0000 0x0 0x1000>;
 		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
+			     <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 		#mbox-cells = <1>;
 		clocks = <&soc_refclk100mhz>;
 		clock-names = "apb_pclk";
-- 
2.25.1

