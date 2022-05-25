Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F59E534577
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 23:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbiEYVAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 17:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344387AbiEYVAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 17:00:38 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45A2BA560;
        Wed, 25 May 2022 14:00:37 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id t14-20020a9d66ce000000b0060af9ed4b87so9845836otm.9;
        Wed, 25 May 2022 14:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y7E4PnNWAdqM3wRc2kq28/BErN5cx9srK3ecxf9iFrE=;
        b=sDXsJmpcerVBTTncItqmS9QQsrlegFUU4WXhWFIDDUrTzFEDimTIbIN1/9Q/KN/pSk
         GyMuRERIyfSwr8lvA7aTt3tPCcPnVmpgOR+6LC87XWFDi+qtQpqR9RWw3Iu2N4lCXClK
         +7QNUJ42fgdK+IsTUcGTX5u1QVQccvNf+L4VQc21wRLJtD1VAwPrsZRpSsIHn/+x0Sn5
         GsvLmILJUcNq1yPr1uoZyp1LL+vX3+Dqtm3Xy4Qzjhvk7R5sqtMEZLell/U0lvomplFh
         rmzpFwQ8B8As3I0Oz3B+B8iR6DRAxsG6dYLkzz4hnkwDkf2t1NOVxorxDGaJPOIX6cG1
         stpw==
X-Gm-Message-State: AOAM533wcXNRn+5L6wo7iP23IFZ85lrA2GaEmktHpvmTqBe3RpVklwy7
        2t6K92ebwyITbWZ8zUydjIPDWwCTUg==
X-Google-Smtp-Source: ABdhPJypUgU1tiTdohjUQ19YpnReQFW4zfRPRhZ0KMkfHQ8QCuhoVzAG2dPGJ1gJW36WD0HmKSvQWg==
X-Received: by 2002:a9d:61da:0:b0:60b:220f:950b with SMTP id h26-20020a9d61da000000b0060b220f950bmr4343320otk.316.1653512437079;
        Wed, 25 May 2022 14:00:37 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id h18-20020a056830401200b0060603221278sm6453363ots.72.2022.05.25.14.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 14:00:36 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mtd: mxc-nand: Drop undocumented properties from example
Date:   Wed, 25 May 2022 15:59:46 -0500
Message-Id: <20220525205947.2487165-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With unevaluatedProperties issues fixed, 'nand-bus-width' and
'nand-ecc-mode' are flagged as undocumented. Removing them from the example
is the easiest solution to silence the warnings.

Signed-off-by: Rob Herring <robh@kernel.org>
---
These properties may be deprecated, but they are still widely used in
bindings. They either need to be documented (and marked deprecated) or
removed from current users (i.e. dts files).
---
 Documentation/devicetree/bindings/mtd/mxc-nand.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/mxc-nand.yaml b/Documentation/devicetree/bindings/mtd/mxc-nand.yaml
index 73b86f2226c7..66da1b476ab7 100644
--- a/Documentation/devicetree/bindings/mtd/mxc-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/mxc-nand.yaml
@@ -37,6 +37,4 @@ examples:
         compatible = "fsl,imx27-nand";
         reg = <0xd8000000 0x1000>;
         interrupts = <29>;
-        nand-bus-width = <8>;
-        nand-ecc-mode = "hw";
     };
-- 
2.34.1

