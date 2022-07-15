Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4FE575C12
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 09:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiGOHFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 03:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiGOHEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:04:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4141C357D9;
        Fri, 15 Jul 2022 00:04:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1D28B82AB2;
        Fri, 15 Jul 2022 07:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B460C34115;
        Fri, 15 Jul 2022 07:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657868689;
        bh=+Y5Z2mVF4rEiTII2zUYwwADJz3f7ylC2w0+rKJDXuu0=;
        h=From:To:Cc:Subject:Date:From;
        b=dFStlN/qt38Ixcn3Basfe/L4rfzXPWikVRBG7aCRvp3zoBFwl95Pac2tbC2bo5//q
         8KJNQKUF2cSHImEKnY4zQOCtj/hNJtImcwNHP9nDfqHhvRdxffw6mBnQpUVWvh2raJ
         2IGX81I8fCOfitkbmjPtX3jcfsjTM1a/R6SVyxIwHaQAVUZLm577yK32YudeHHm2Kw
         YV5RFG0M255YCjPrF5vT3PY4hR4ACoFJq+zsouJFYd8CLdhogQDqU5VvPZ5tCTEIHB
         si5kzd9XKxpzWlALRFxdl6/xlqfCbSexs2ySPRKJsJeFk0yAU9yi+0AHtuiYuFAfxO
         ectUPQwBoWy3A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oCFNe-0004yr-6j; Fri, 15 Jul 2022 09:04:54 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 0/4] arm64: dts: qcom: USB clock and interrupt fixes
Date:   Fri, 15 Jul 2022 09:02:44 +0200
Message-Id: <20220715070248.19078-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second half of the series which adds the missing binding for
SC8280XP and cleans up the current bindings somewhat:

	https://lore.kernel.org/all/20220713131340.29401-1-johan+linaro@kernel.org/

The binding updates have now been merged by Greg so that the qcom dts
fixes that depend on them can also be applied.

Johan


Changes in v2:
 - fix the pwr_event interrupt number for usb_1 (Andrew)
 - amend commit summary of first patch to mention also clock "naming"
   (Krzysztof)
 - add ack and review tags from Andrew and Krzysztof


Johan Hovold (4):
  arm64: dts: qcom: sc8280xp: fix USB clock order and naming
  arm64: dts: qcom: sc8280xp: fix USB interrupts
  arm64: dts: qcom: sc7280: reorder USB interrupts
  arm64: dts: qcom: reorder USB interrupts

 arch/arm/boot/dts/qcom-sdx65.dtsi      | 10 +++++----
 arch/arm64/boot/dts/qcom/sc7280.dtsi   | 15 +++++++------
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 30 +++++++++++++++-----------
 arch/arm64/boot/dts/qcom/sm8250.dtsi   | 20 ++++++++++-------
 arch/arm64/boot/dts/qcom/sm8350.dtsi   | 20 ++++++++++-------
 5 files changed, 55 insertions(+), 40 deletions(-)

-- 
2.35.1

