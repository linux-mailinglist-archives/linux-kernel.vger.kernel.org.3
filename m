Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476A3569EB1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 11:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbiGGJkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 05:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbiGGJkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 05:40:01 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9F313D43;
        Thu,  7 Jul 2022 02:40:00 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n185so10277683wmn.4;
        Thu, 07 Jul 2022 02:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=cfC1eHw7vjyJEGT4bP0Ijue63QAf+zrsCzWAQ0rV+Js=;
        b=eBaCrhvMik2nM7yS82rCJEfeku6KyF5Gd9yVUjzBw9knDNqqQA3UHJLWB7PgMDbT+T
         PDa6S0zhQQ6h4qf5AEA0ayAM7yxjiKcl3IkCCQO71pYoys76DlHv+cjOrQYOGj1bszh6
         vZaHugoCRLiR+X2f9O7nnnQBgtxTGIWQm614m743tWWHXzwY7YTiw/0Y3Tbx5sFphmOz
         9by034TRbwnNZCENdFEUow6A8kCv3srDOfcUUWDC1TiGjqJKrODDOgq8Y8DR13WYOr1/
         iMmG31vrAxgbsLlB+QKtPI4+gphvXPMTzAQtrIBp/lI+kMGH2IC4//b0EfdMFBfH+RKh
         DBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cfC1eHw7vjyJEGT4bP0Ijue63QAf+zrsCzWAQ0rV+Js=;
        b=qJQknZS2UBeTbnxJEDuKuAehr9PrlcwnFrns/nrNjNjWEh5K2oHNUbWY3HLCj4h9Cw
         RXf0mVTZlxOOmsC6ueMvdKbXtk7kR+s6Jzqay3VWOeu/A54etqZHaE/p58jaaZsjUh79
         2T0dK49O8OIdGTVOoNnIDOeH3LLImiWvjoueebWcPk9A9bUsYZhlqgSWBLva+N+ZtY5U
         LEKNPm+X2PE8pttNoeaPm+ITRQ4/W7vEnLvJ4IiDCU+3U3Aa8Z7DshcGQAY9XqosbSXV
         ixKXZ5AfHTI4VipZgATZ3AjtYGqIPE01YZXt93H+LS0pk72nW3szU1P2dfzD0UcAeuBT
         Uryg==
X-Gm-Message-State: AJIora/mB84vIwjCRlDh7yycmCQTStfAbMAFjiXSenRHjkyM9HRZvf9f
        rztbc2XT3np1j2roT23+qfE=
X-Google-Smtp-Source: AGRyM1tV3ux5VMnFhY59IYP2nYIcJ/IVUvUn/b66ZUw7h8bA6IKJ3xV0bIf+akq51E1t5JZKF5xDng==
X-Received: by 2002:a05:600c:214c:b0:3a0:401a:6f4b with SMTP id v12-20020a05600c214c00b003a0401a6f4bmr3209000wml.15.1657186799374;
        Thu, 07 Jul 2022 02:39:59 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id j14-20020a5d564e000000b0021d68d3a27dsm13831314wrw.45.2022.07.07.02.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 02:39:58 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Furkan Kardame <furkan@fkardame.com>
Subject: [PATCH 1/2] dt-bindings: arm: amlogic: add Beelink GT1 Ultimate binding
Date:   Thu,  7 Jul 2022 09:39:53 +0000
Message-Id: <20220707093954.21716-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the board binding for the Shenzen AZW (Beelink) GT1 Ultimate
Android Set-Top Box device.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 61a6cabb375b..3217c069673e 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -120,6 +120,7 @@ properties:
           - enum:
               - amlogic,q200
               - amlogic,q201
+              - azw,gt1-ultimate
               - khadas,vim2
               - kingnovel,r-box-pro
               - libretech,aml-s912-pc
-- 
2.17.1

