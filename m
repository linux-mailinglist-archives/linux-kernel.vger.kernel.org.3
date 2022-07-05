Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494B45666F1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbiGEJuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiGEJtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:49:07 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B40B12777;
        Tue,  5 Jul 2022 02:49:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0BA3ECE1AF8;
        Tue,  5 Jul 2022 09:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21808C341D0;
        Tue,  5 Jul 2022 09:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657014542;
        bh=hOZdnrgEGFBVc2ds9Xi9MI9BeEk4FYW9RhPpXX4KXlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XqNkofo+AaX1/AKivDAxrHFCS6fce32JK3UTXsYi9SsCjl28VMSfI6sxzEXEunkQV
         FVvw7qViIOT9WAWqwMTEuWust6QJiR0bN3eEKVP/SmcT8sqEsxCOpDEJulI6cVUrFU
         sGgx9ZLIHf8v+GqrNSXqCOK4asnqE6q7c74rk5NNVomVRD8kivj3n+I4AfS0GChRik
         ZgIjXdWEFqNtmjTATN43B6dJgRbu/L2vordtfORhHjS1CLePWGM7IWnoeS1nrl0jk6
         zcASf9H8AZ2v7ZN14tqoHtRNHwDpVkb1L8/qrNeie4SejF6d9YI91/dpNsY3OYtnZo
         PngVpUdQl8wQA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8fB0-0004Wz-S4; Tue, 05 Jul 2022 11:49:02 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 04/43] dt-bindings: phy: qcom,qmp: clean up example
Date:   Tue,  5 Jul 2022 11:42:00 +0200
Message-Id: <20220705094239.17174-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220705094239.17174-1-johan+linaro@kernel.org>
References: <20220705094239.17174-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the example node somewhat by grouping consumer and provider
properties in the child node.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
index 83f777b4636f..e678d7d5f675 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
@@ -486,10 +486,13 @@ examples:
                       <0x400 0x1fc>,
                       <0x800 0x218>,
                       <0x600 0x70>;
-                #clock-cells = <0>;
-                #phy-cells = <0>;
+
                 clocks = <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
                 clock-names = "pipe0";
+
+                #clock-cells = <0>;
                 clock-output-names = "usb3_uni_phy_pipe_clk_src";
+
+                #phy-cells = <0>;
             };
         };
-- 
2.35.1

