Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826C54F9920
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237430AbiDHPOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237418AbiDHPOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:14:47 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74481100A7C;
        Fri,  8 Apr 2022 08:12:43 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id o18so3710757qtk.7;
        Fri, 08 Apr 2022 08:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OhT3uuxxEHcPBuHXHb1jb3YfeT1PnX/kEpDmvODTxcw=;
        b=NsMM4YWVyUraCz/kt+F2EMVswAI3CaTU0YpNV/knTwNsdFgF08dAxMTCTEMQoYGxGX
         /atW6laRZ1rN3aittfIb6/7h+Hd0khonSfmlyPSPe9fLOej9LMJu94Mj68YwkOvNMMTL
         rtobblPenS1M3tLoC9l6b9JPo6TT12ypmDKX/kFC2kLyfaH0z+8MJl0pe1NHB6RlOel/
         j9OptSo03QbptL+cX3POeHQ20X9hrPfHEOsamD0HD13Ms1ZYZDlQGtYIY2r6IjNc9ZAU
         k0jPcUAx8G+aprnpSuF1E93o9lNl2iVt6VeSWJUTaWMdKPvSgPDFEJyV2XZGXD1b7RoL
         iqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OhT3uuxxEHcPBuHXHb1jb3YfeT1PnX/kEpDmvODTxcw=;
        b=oFcIcOhH6aXk0smH5rjoMP6Ql88uEeGWrFgLRqcxZV4Qo/RHXD4K+llPj3NageMqlf
         OXSNQL4u30xLjNhtx33lDw450gB3AsIQ4HYGUXxu2ZMuM3RxBHEdx/QKMEnInzvYWx0L
         Pyzg86/ZLAKMDdg1KuS6VGKOUvqJ0hevgGbviOTWQjgivSepAlQgrD7L5BT1kr/AWiOY
         +RFDQZUMP6WcNTZoUQHqHLJxrMZ5HFE4ij3bZ1gXR9UKbUC8QZuoEw5Mcwh1rxlBaeYt
         G37Yci3X+zRdY+4/jgdcLPG/60vSPoNASo1Jm10u1wfcwJB2tJFnPGP8v3+a4KKwrgyQ
         z/hA==
X-Gm-Message-State: AOAM530f/onqiBvY2lnt4FEQvYFzYddWkltzoUBc0+oeLVJ+LovIuKve
        58X07YcTfeqLMoypYv6ASchTl227aKfM5Ic/
X-Google-Smtp-Source: ABdhPJwl9PVVqdJdJKKdKDVS5ybYWrvIT/uqQnD+9OFv41VaukkHsOq0SWSPXzkAwkoNjLXPBPcz7Q==
X-Received: by 2002:ac8:43d1:0:b0:2ed:8a1:e13d with SMTP id w17-20020ac843d1000000b002ed08a1e13dmr2470593qtn.432.1649430762560;
        Fri, 08 Apr 2022 08:12:42 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id 191-20020a3707c8000000b0069a13545fcfsm2266052qkh.123.2022.04.08.08.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 08:12:42 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/5] dt-bindings: soc: grf: add rk3566-pipe-grf compatible
Date:   Fri,  8 Apr 2022 11:12:33 -0400
Message-Id: <20220408151237.3165046-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220408151237.3165046-1-pgwipeout@gmail.com>
References: <20220408151237.3165046-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rk3566 requires special handling for the dwc3-otg clock in order for
the port to function correctly.
Add a binding for the rk3566-pipe-grf so we can handle setup with the
grf driver.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index b2ba7bed89b2..3be3cfd52f7b 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -15,6 +15,7 @@ properties:
       - items:
           - enum:
               - rockchip,rk3288-sgrf
+              - rockchip,rk3566-pipe-grf
               - rockchip,rk3568-usb2phy-grf
               - rockchip,rv1108-usbgrf
           - const: syscon
-- 
2.25.1

