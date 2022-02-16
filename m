Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84164B86A3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiBPL3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:29:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiBPL3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:29:51 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D381168EF;
        Wed, 16 Feb 2022 03:29:39 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id o9so2814346ljq.4;
        Wed, 16 Feb 2022 03:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YbTDa5I13Ncw8KhJDSpmxu2P37n56Qwaa9F4OpFETGE=;
        b=gKx7XgpTL3+b/cpnZXxZQMYaZreD93Pl33R+iIY0V9Ac+FMU76BkG+iLkgRj8vY3DC
         D0lyIAcoUMrUFvB7O6hGiX6TfFieG4eQfW70SChsDnXxIcxMparwoFitNVR0BxLwHgxF
         GaFNho49XVyBylWnt1mQH/fWmLAem8CnJBi12LPWMuB3E+snDC1XqRosxabhDW2zmW1c
         AwlO/N2QfeBEDzeam70MPix/zA+gHEe/ityYDmgm1s33FfDY7p7hJzz+AezH7gMlGwEH
         j2Jdz3grMjuJ+p+T5xLANBfbrcrxj04MNhNRNihmAGxQS7Usw6Nl1s4sM153NMAPFS1J
         WhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YbTDa5I13Ncw8KhJDSpmxu2P37n56Qwaa9F4OpFETGE=;
        b=WumVkQfPvykdX36Iksbok+YX/X9kbH/vGcA2WQp3pz0mAY+tfW/Z8DkfHSC48qYfAz
         2rtlPitM4xly5b/zjcORERfoBh5AQDgKSaol8TMXgrVm+zaQ86Tsigy5SuUy5L998Ivw
         ll1mZSUwFBlcw6HLMuS4mtZ0IkCOFYUkwlhTSyidHcBn/bGxpjE85YXOmMcb6e+H8Weq
         vQfETpDGUF5tk+aklhgkbiMs18sG5zAa40aGuMRCIgs9Loci/bNFDqhK4ScfSL7Un+0U
         0DYzgaVDz4nJNHC++xvQk68OkUzQpT4J6c6feSBIV0zQzyxVVm1U8LcCSJ8dNdcfsGM2
         TNEw==
X-Gm-Message-State: AOAM532dXYZ83777yy/x+VmCAFH2wRUqOdujnFPCK8t0kc2rDcTBJWfu
        rYV+5SrEt4rRLpEitbJeYyU=
X-Google-Smtp-Source: ABdhPJwLnwiFO+Ouvb/1/TuiZTBvpRUtpGayQzym76zPnCf0OB46MSeqzZqY09HT2TRqelHPqI/i1Q==
X-Received: by 2002:a05:651c:12cb:b0:23b:2bfc:8dae with SMTP id 11-20020a05651c12cb00b0023b2bfc8daemr1694502lje.364.1645010977853;
        Wed, 16 Feb 2022 03:29:37 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id y11sm4690500ljj.122.2022.02.16.03.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 03:29:37 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] dt-bindings: mfd: brcm,cru: rename pinctrl node
Date:   Wed, 16 Feb 2022 12:29:28 +0100
Message-Id: <20220216112928.5330-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This matches pinctrl.yaml requirement and fixes:

Documentation/devicetree/bindings/mfd/brcm,cru.example.dt.yaml: pin-controller@1c0: $nodename:0: 'pin-controller@1c0' does not match '^(pinctrl|pinmux)(@[0-9a-f]+)?$'
        From schema: Documentation/devicetree/bindings/pinctrl/brcm,ns-pinmux.yaml

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 Documentation/devicetree/bindings/mfd/brcm,cru.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/brcm,cru.yaml b/Documentation/devicetree/bindings/mfd/brcm,cru.yaml
index be4a2df71c25..b85819fbb07c 100644
--- a/Documentation/devicetree/bindings/mfd/brcm,cru.yaml
+++ b/Documentation/devicetree/bindings/mfd/brcm,cru.yaml
@@ -39,7 +39,7 @@ patternProperties:
   '^phy@[a-f0-9]+$':
     $ref: ../phy/bcm-ns-usb2-phy.yaml
 
-  '^pin-controller@[a-f0-9]+$':
+  '^pinctrl@[a-f0-9]+$':
     $ref: ../pinctrl/brcm,ns-pinmux.yaml
 
   '^syscon@[a-f0-9]+$':
@@ -94,7 +94,7 @@ examples:
             reg = <0x180 0x4>;
         };
 
-        pin-controller@1c0 {
+        pinctrl@1c0 {
             compatible = "brcm,bcm4708-pinmux";
             reg = <0x1c0 0x24>;
             reg-names = "cru_gpio_control";
-- 
2.34.1

