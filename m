Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063D456023D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 16:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbiF2OMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 10:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbiF2OMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 10:12:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02622ED5B;
        Wed, 29 Jun 2022 07:12:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C1D7B823E1;
        Wed, 29 Jun 2022 14:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2429C341C8;
        Wed, 29 Jun 2022 14:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656511949;
        bh=bIvjUkXa9IPjW38Ewt2LnVD5DIrb2+7etgxeumjBb1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qU5UD+2yFDJZqXVgaE9pVzAGSytEsODwKyTwXT+E2iUvFtr7lYU6Ml137CgjAF6ow
         AUYyy+tqqm0fCQ6ZurEKO7Hwvay9h24K1RHxnMPNMJRL16LPxCtPW4ECu1obeGWMoF
         PIkSYNRjgY4E7K3eDrz17vw9Qlj+TcWz+278a1wTeDD4o7x5Wj+daHzj4XXZdaW3g9
         90QUhZnI3CTH8FwYZBA/BpFGGQwYbtauUodcvJfKJdMUAmPm//Vef3Ka+ADAv0ZE9l
         zH4V1OFKMhsbdMi7n0rVhqfjfvG58cKRU2iYXq3Yj3cJmCX0/580CElIIposgLxz+O
         WGB46YsTN6xSw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o6YQe-0004lG-N8; Wed, 29 Jun 2022 16:12:28 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 05/10] dt-bindings: PCI: qcom: Add SA8540P to binding
Date:   Wed, 29 Jun 2022 16:09:55 +0200
Message-Id: <20220629141000.18111-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220629141000.18111-1-johan+linaro@kernel.org>
References: <20220629141000.18111-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SA8540P is a new platform related to SC8280XP but which uses a single
host interrupt for MSI routing.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index a039f6110322..e9a7c8c783e7 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -25,6 +25,7 @@ properties:
       - qcom,pcie-ipq4019
       - qcom,pcie-ipq8074
       - qcom,pcie-qcs404
+      - qcom,pcie-sa8540p
       - qcom,pcie-sc7280
       - qcom,pcie-sc8180x
       - qcom,pcie-sc8280xp
@@ -603,6 +604,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,pcie-sa8540p
               - qcom,pcie-sc8280xp
     then:
       properties:
@@ -720,6 +722,7 @@ allOf:
               - qcom,pcie-ipq8064
               - qcom,pcie-ipq8064-v2
               - qcom,pcie-ipq8074
+              - qcom,pcie-sa8540p
               - qcom,pcie-qcs404
     then:
       properties:
-- 
2.35.1

