Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91554E62E1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 13:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349893AbiCXMDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 08:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241040AbiCXMDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 08:03:04 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5A5A7764;
        Thu, 24 Mar 2022 05:01:32 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a8so8635749ejc.8;
        Thu, 24 Mar 2022 05:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nuEjM18NFC9m+DMIdfnC8bAfeSbsPDnsYC00cbxSyog=;
        b=oGg85a/oNA32MV99mldPci1AdcqVmedXiLODuJTR+ISCXXfh+bU3SXxkfWg6fTrFix
         FPTmUvlGN9DZMW1tD1v186I8W8gW+aY/xyJ0qdwQrml+ezB0+scHv4FSvmSi+Imcot1+
         r/MKrFbG36Cb5YozzVu+6yxidvCOazpZ8iOqg6965Jh3qTtnVlmhDvd9lfQISGNFUP9A
         wAQSWsLIkiIJQHpP7PihEC7AtKb7B86BvhGIsrrKEfpOcYywxD0a+xKoacGa+PHAWyfU
         2+Fl1Xq6E+1Yvfs6+oU6zz4SiS/JWWWSKtU+xw1e6SWSMc0h/0ixmApkRuil1qWrBzA3
         CMZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nuEjM18NFC9m+DMIdfnC8bAfeSbsPDnsYC00cbxSyog=;
        b=M+3QVwTyH/0pYzqweBUCeWkliShlbANA9BrAa4OuVPQOG7D/W93C+llNjZUl8scEb5
         VAznoa8RV9bRkaThNVy0g+SIyGYEbWUQz/U4+XwWuWMEzZvteeyU4tMP298J1Uv/wUyU
         /kElVcNelSmJn95NZbavGbZbvUCaTYrlNtgAqYGoBk29NhPqs6hbuCPwa4YPdUaZ9edr
         GacHy1BSWkDtcDZGAzti+hvcGaaItvuWcNDUy0TJDf6s8Fu6E38ZvQhQIgbK3+rF4CEq
         qxqeo4fx+OJcaP4iB2CCrWr8TzO/spVT4t5dN7c4A/767LdGuqrR+DlczNeekhrLOWA2
         46Mw==
X-Gm-Message-State: AOAM532vSEbVf8qpyCrhdVZZCl4Ds0asSFjQL8CyNXZ9xgTldPY8GbCD
        aqzLtiAQXLl6Jdy6CtDmShA=
X-Google-Smtp-Source: ABdhPJzrW0qji+QJkSKZDeLk0VV+83wm1d4vZCMJ8ny5BJSXclaIGGWEwJcgWElkC7xZrak+JvNL0A==
X-Received: by 2002:a17:906:9b85:b0:6db:ab80:7924 with SMTP id dd5-20020a1709069b8500b006dbab807924mr5395242ejc.160.1648123291338;
        Thu, 24 Mar 2022 05:01:31 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090657c300b006d01de78926sm1068822ejr.22.2022.03.24.05.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 05:01:28 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, kishon@ti.com,
        vkoul@kernel.org, yifeng.zhao@rock-chips.com,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9] dt-bindings: soc: grf: add naneng combo phy register compatible
Date:   Thu, 24 Mar 2022 13:01:22 +0100
Message-Id: <20220324120122.1339-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
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

Add Naneng combo phy register compatible.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index b2ba7bed8..5079e9d24 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -15,6 +15,8 @@ properties:
       - items:
           - enum:
               - rockchip,rk3288-sgrf
+              - rockchip,rk3568-pipe-grf
+              - rockchip,rk3568-pipe-phy-grf
               - rockchip,rk3568-usb2phy-grf
               - rockchip,rv1108-usbgrf
           - const: syscon
-- 
2.20.1

