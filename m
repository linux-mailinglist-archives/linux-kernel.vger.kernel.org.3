Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E45E5669F5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiGELlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiGELk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:40:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFCF13F57;
        Tue,  5 Jul 2022 04:40:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B6C86142F;
        Tue,  5 Jul 2022 11:40:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA16C341EA;
        Tue,  5 Jul 2022 11:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657021256;
        bh=ujskMW1N8gcjwTsYNFmpSl6x9W5Ja7UgKQRuwMPhtG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WzoSx+3GzTJezLKq/zvfWNpo8Sd/zazPD9lSjrkGmg/icg3FrEBDzyGg4l3Iu7efL
         R3P35F3hoYqGoWL/t3CuqUFwU3GcOR0LoW6AtBHR/A/4JG8ycoNssiI2XsStmX7sDJ
         z/Zoarpc/6p3LJYBbPB2PG3HbfJysME9wpdVJP/mtUJhw/xmW12Dgasl1YlzEUpjDx
         KhYOgwSDLV87g7PAPG2tmZnuJN3S3KHJ6Hy4New+7/7zcxktVMzNOItD7/gQcKVvb9
         FwRVy8NeED1aO2qEeKKY3aYthLz43E9zDHgZcOUH7ZsV8RlRhyXI84gI7n7mlLjxkG
         TEQW9kE1Lf4qw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8gvJ-0005xs-U7; Tue, 05 Jul 2022 13:40:57 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 10/14] arm64: dts: qcom: sm8250: drop UFS PHY clock-cells
Date:   Tue,  5 Jul 2022 13:40:28 +0200
Message-Id: <20220705114032.22787-11-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220705114032.22787-1-johan+linaro@kernel.org>
References: <20220705114032.22787-1-johan+linaro@kernel.org>
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

The QMP UFS PHY provides more than one symbol clock and would need an
index to differentiate the clocks, but none of this is described by the
binding currently.

Drop the incorrect '#clock-cells' property for now.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 7e399d739cd9..57f5ece8b741 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2148,7 +2148,6 @@ ufs_mem_phy_lanes: phy@1d87400 {
 				      <0 0x01d87800 0 0x108>,
 				      <0 0x01d87a00 0 0x1e0>;
 				#phy-cells = <0>;
-				#clock-cells = <0>;
 			};
 		};
 
-- 
2.35.1

