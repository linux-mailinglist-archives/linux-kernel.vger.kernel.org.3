Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE374EAAB1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 11:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbiC2Jqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 05:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbiC2Jqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 05:46:34 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535651480C8;
        Tue, 29 Mar 2022 02:44:51 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mj15-20020a17090b368f00b001c637aa358eso1615846pjb.0;
        Tue, 29 Mar 2022 02:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZxcUXMRIWi10Bb3Yn0d7DQkBUePE+suYIRN22VgBmlk=;
        b=pIHFTBvFOdroSMYLJmbokuhXRhGu0YiK4mQyUUjxzAD3slLRiBcRxzNTTYTzzT5HHJ
         IH4QD14bcZq2eS8ywDzDOVI8iBBL5n+tr/fLmMBI7n6t0PDvlYS5qdOXTXpIM/5vJ7Wg
         pRkOALLR1omH3ECOCbeEIOXI60mixggl/brGAlyVXz0PRVLfN3fm/4O99bDaYUfacpxb
         6vTESWgCSxxE9nIMDYREt0ud9ARH5gPj6UI8J4T+lhNX/7eH1mrskwilN96BHg6owDGT
         PavMHxAN26XdbyqbnV/MmKpOVkBN8/CcgCg1a3kq9Ks5/oghQyqAX0cy2JopYVhMcSXi
         +Xvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZxcUXMRIWi10Bb3Yn0d7DQkBUePE+suYIRN22VgBmlk=;
        b=f63TjZNFejdSeGJ0RmhwVlCZ/JU2wCWih03+eb9HBFfReLdNTUXonDgyEJJH3zV8c4
         6dmpjxF5C0lEII4Jd2yhnWrXA1ANxA8YQIt6BqpGFhTtKPorbO8eID5f4AUD/2XIZCI4
         4OzrNgve74E9Nh3QZHuSkJI102/XMQHsn2e6ccGPm37rduG7kysgWyrF8oNfkLNEoEGg
         yCtnATLocZlKBszhG0PpLtmw29bqyBL4oLmHMmzfKYkVd9ERUCq/dTuNwhjAjaV5peFW
         xVx2UeSKqeIpdEmX1jVswXGpbOKpq263kkwbeStza26jOdSoJkUOvm4mqsXOaICq0KtT
         zrtw==
X-Gm-Message-State: AOAM531KW4WnlURDSyIcuUn3k815FvFVWkzbvKp9I3NEl+/a/ge6Tt8A
        2uvoKZhaFYmNwj3FOqyhdlw=
X-Google-Smtp-Source: ABdhPJyAYUce+W+zwHS0NxaiOPL8AQq0MSVS4H59L6ZFCt5X2doklICAbvLw2MlkIhCnCoqukc3pjA==
X-Received: by 2002:a17:902:ec8c:b0:154:2e86:dd51 with SMTP id x12-20020a170902ec8c00b001542e86dd51mr29923984plg.99.1648547090825;
        Tue, 29 Mar 2022 02:44:50 -0700 (PDT)
Received: from anyang.. ([106.250.177.234])
        by smtp.googlemail.com with ESMTPSA id m15-20020a638c0f000000b003827bfe1f5csm15090968pgd.7.2022.03.29.02.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 02:44:50 -0700 (PDT)
From:   Dongjin Kim <tobetter@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: rockchip: Add Hardkernel ODROID-M1 board
Date:   Tue, 29 Mar 2022 18:44:45 +0900
Message-Id: <20220329094446.415219-1-tobetter@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding for Hardkernel ODROID-M1 board based on RK3568
SoC.

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index eece92f83a2d..48fd0858a795 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -664,6 +664,11 @@ properties:
           - const: rockchip,rk3568-bpi-r2pro
           - const: rockchip,rk3568
 
+      - description: Rockchip RK3568 Hardkernel ODROID-M1
+        items:
+          - const: rockchip,rk3568-odroid-m1
+          - const: rockchip,rk3568
+
 additionalProperties: true
 
 ...
-- 
2.32.0

