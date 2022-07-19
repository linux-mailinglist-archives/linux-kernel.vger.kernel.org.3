Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8C1579121
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 05:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbiGSDHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 23:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiGSDHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 23:07:32 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8153925587;
        Mon, 18 Jul 2022 20:07:31 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id q13-20020a17090a304d00b001f1af9a18a2so5931714pjl.5;
        Mon, 18 Jul 2022 20:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BpsIYGCJRtvbx2TcIK1tJ0iVgorLSfDv+9DFPy2DSN4=;
        b=DpCSYVK482KEJwYyLtyS4b1uh6RM9EObs1tmhkHPrDPWN47UsQFBicetHG/hWMjU/j
         Vqm8QLr5s4Z1ffsShixACwkoMGWcHMMGY1KJcRZtCD9WLDCESSGjGmQLyuL6OnXct7pU
         qWMdN8+cGedeOBgwjCQjuJnPHhR6CY0kprKSBjIzfHHOuRV1lw/n3gSPOlv+YYxdFP5d
         OKb9mWjeibKzKd3/+7qvV2Ib2kDsmrhcQsg1WjYV2kWTGEaIBroB0iTA8dAOjH4cjAh6
         s9RqRtcbk3a2n2Wb7DdZ1QzMa9b5SilisJAbcHBO0kpS87LSAAFRA+NRiQGSe1KMNpzf
         PBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BpsIYGCJRtvbx2TcIK1tJ0iVgorLSfDv+9DFPy2DSN4=;
        b=pqNShbdwAntZp06VCYEEOjB5RwG5N3uvao0H5fN0Tq2BrR066s1LFICIelv87PVzwY
         okxXxHORW/6Q47I6agIyZNzgX9LDsZ0GzdoxAcYi1k7exPyHIzPSdcn+2AhlaKdE65BM
         sKLWtXsJC2CFtCRs7RAuLgdFWbnoxl2sh2RXV7+P107gAU5LmFFDaWMKyE6s6dDuy2Wn
         DtAuAnDO3fDOS6Ex2TPHl+zsZtQk9663rEBY28ZB4cZpkKMnK0qUwMSRbdWZYle7MsrJ
         6AGuaEabeDfOTaXc3yjBQvRfP1m2HnNfna4JWiubaUPQtFzdoe8XPLD6yf51jy2VCqbs
         Qr+w==
X-Gm-Message-State: AJIora+0YY7mqsyDqyin2Qa59XHhwP/KKuvinHyPdfFLfpNx1CDh2oNj
        yauUyhiIfqLwAh3XnHWRC4M=
X-Google-Smtp-Source: AGRyM1tQzZAiyZf1SK2+bmxzGqHUtXuR/IFD4oodzTgNL8yVoDtRiJHrLtpli7/2d4Kmuh+RSMayHA==
X-Received: by 2002:a17:902:ab53:b0:16b:ecde:3dfc with SMTP id ij19-20020a170902ab5300b0016becde3dfcmr30761503plb.131.1658200051014;
        Mon, 18 Jul 2022 20:07:31 -0700 (PDT)
Received: from debian.moxa.com ([123.51.145.104])
        by smtp.gmail.com with ESMTPSA id i6-20020a62c106000000b0052594a3ba89sm10096857pfg.65.2022.07.18.20.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 20:07:30 -0700 (PDT)
From:   Jimmy Chen <u7702045@gmail.com>
X-Google-Original-From: Jimmy Chen <jimmy.chen@moxa.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Cc:     Jimmy Chen <jimmy.chen@moxa.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] dt-bindings: arm: fsl: Add Moxa UC8210/8220 series
Date:   Tue, 19 Jul 2022 11:07:16 +0800
Message-Id: <20220719030718.28826-2-jimmy.chen@moxa.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220719030718.28826-1-jimmy.chen@moxa.com>
References: <20220719030718.28826-1-jimmy.chen@moxa.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT compatible string for Moxa UC8210/8220 i.MX7D board.

Signed-off-by: Jimmy Chen <jimmy.chen@moxa.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index ef524378d449..fd26b93b4388 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -756,6 +756,8 @@ properties:
               - fsl,imx7d-sdb-reva        # i.MX7 SabreSD Rev-A Board
               - kam,imx7d-flex-concentrator       # Kamstrup OMNIA Flex Concentrator
               - kam,imx7d-flex-concentrator-mfg   # Kamstrup OMNIA Flex Concentrator in manufacturing mode
+              - moxa,uc-8210              # MOXA UC-8210 board
+              - moxa,uc-8220              # MOXA UC-8220 board
               - novtech,imx7d-meerkat96   # i.MX7 Meerkat96 Board
               - remarkable,imx7d-remarkable2  # i.MX7D ReMarkable 2 E-Ink Tablet
               - storopack,imx7d-smegw01       # Storopack i.MX7D SMEGW01
-- 
2.20.1

