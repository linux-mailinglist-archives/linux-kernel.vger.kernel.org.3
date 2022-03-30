Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052294EC5CD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346211AbiC3Nly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343632AbiC3Nlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:41:45 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6CD1EC5C;
        Wed, 30 Mar 2022 06:40:00 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id yy13so41617888ejb.2;
        Wed, 30 Mar 2022 06:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NsJbyypLE3sW1sduwkhRapWQvWc+cGtXMQ61CIAQ1+g=;
        b=M+pDkAbJFxQ+RxHYE8gK0a5U98UWp4mGQ2YUHCu6oL1CMqPGSL+aevqSzpI7IFg73W
         vrFxaVyBdq3XdYL95j0oDyZdSMhXhAKwqurLQLejYOHD1YFUfu8UEmxswg6p8T32UseT
         XNoLCUmS1bVgDliofo0EmG9Ids+/K93BN1UBnWEjJbThF+JFhqsDIv/lYlY5ZM4CLoGm
         G5GZcB+9AiCJHf9OGJ2ufF0wnTf6XSm50FfqzDLRwchVzpu0rkbfh64tgPP+icJ6pazo
         h15TEO/QMbqK2h8bNMnmahO13kNR1TSdlQuEIF/nGwI72vqrpQPHhLXJG63OmJWGpfnJ
         webQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NsJbyypLE3sW1sduwkhRapWQvWc+cGtXMQ61CIAQ1+g=;
        b=lnIjX6+7V8e1DaTAGAlfkPbaWU0yyA81Pkm7OKZrwJRpUt2iC6PU6sldiOHw4vH+ZY
         ehc7fiefHvs2m9q0LK+eFqfJhO/9b4U8zYzhDitCvfXabBgP1x90c56p3AlKlLS/2YIj
         NRjKlK7wGmAtkDs3T5JW0xGWR8TH7fgeOiipAFWQ56DBAs3D5ZvCH+ZI3KSvCVPgvNQ2
         4way0K6Y/5zndTBwC21LFl4H3s9atc96xEXTp1TxNQZF8+rWg7/6JJbOKEH/zjJ9EbwS
         9rPiCOwFie+On13NlKZ4Xsf/Hif1tTVdM3gro64+gU8ggr+EbE7ArICCA7WtGYHVVCWm
         vRSQ==
X-Gm-Message-State: AOAM533PPE267VtAV9r7yEeaGpBah+Anb4nGJnyI8L+xCLa9xCYnen8s
        gWXi/l+aDE2IeKccAeE5TkM=
X-Google-Smtp-Source: ABdhPJyJB4XsIr3erusAgEepKJEAMljGWVw3235YbaVzv6NM8hmgJScAskVbUKQBlCMfhR5Tv1ml3A==
X-Received: by 2002:a17:906:6a11:b0:6d7:76cc:12f6 with SMTP id qw17-20020a1709066a1100b006d776cc12f6mr39897365ejc.456.1648647598788;
        Wed, 30 Mar 2022 06:39:58 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id do8-20020a170906c10800b006dfe680dbfcsm8375448ejc.43.2022.03.30.06.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 06:39:58 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: pinctrl: add rockchip,rk3036-pinctrl compatible string
Date:   Wed, 30 Mar 2022 15:39:51 +0200
Message-Id: <20220330133952.1949-1-jbx6244@gmail.com>
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

Add the compatible string "rockchip,rk3036-pinctrl" in already
in use in rk3036.dtsi to rockchip,pinctrl.yaml.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
index b0eae3a67..9e90faf9b 100644
--- a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
@@ -33,6 +33,7 @@ properties:
     enum:
       - rockchip,px30-pinctrl
       - rockchip,rk2928-pinctrl
+      - rockchip,rk3036-pinctrl
       - rockchip,rk3066a-pinctrl
       - rockchip,rk3066b-pinctrl
       - rockchip,rk3128-pinctrl
-- 
2.20.1

