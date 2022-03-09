Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258AD4D39CB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237376AbiCITQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237353AbiCITQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:16:16 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93F010EC77;
        Wed,  9 Mar 2022 11:15:15 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 7-20020a05600c228700b00385fd860f49so2112920wmf.0;
        Wed, 09 Mar 2022 11:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+9maJ1V25mJdFx9ur9GjoHx/zoOZrNdScGBRyVYH6oI=;
        b=a6I549TNzCCZZ6BzjvdBSuem6v0dkxjN0jV1r8qXeKoqN5yHrAbYTbL+g4ZleXy/NA
         32aW0r27YbuX3DIS4IT+TBJS+TKilynvZitW5c9yLKs9Ie5qlNNU2ISzgAZ8988tytXB
         hfL1JpBGc/xVc+fKtLqTwVl1ohM4q+EOhCW2uM8tCS7HqWlPfWGu+uy3u/B1M97l7JK1
         8CNyXQu3eUOh/PDLDnHu/65/CbEgo/7osPCTGp0WnC4sokaiqMh2dKoGAXzViY2DXu8J
         Ig0GT/VnAcnbVnKB6ZnPuwegLfo5iC2aCW3rtY69SLchj7HeCmsCCfrRgt59l+4bWdfa
         oraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+9maJ1V25mJdFx9ur9GjoHx/zoOZrNdScGBRyVYH6oI=;
        b=IogfvLdBqiW+S8X0Mk3K3gUmhJDO9q5ePOz9iAEpnUQ0GhrfjaZ3BDVduQNjbq96ix
         8ormWare5NiuQ8oEEc4jBONw5ZpcWiJLwOcdphgvgguxGOtlpXyICmiE5xOIEhX5Ju3b
         aG9ENWNkyiyVwO5x60SQdOEFXbrP7SFci0axBvtfGWOQs0UA4gukH7gnLhc7qx7zBR1c
         /Rinz3x0Bfq3ObrQSvCk4I18CL1ItTcvFHDglpcuXIPjLMLSwxn+A+s5LYIOHwDy9QuR
         kmeCukS0HCuiBs71Gv2leDUm+0MlHmuWlzRxOjX5rvsPwn+yU5IbubidsuJ3tOfOkW2H
         QGig==
X-Gm-Message-State: AOAM530AwIMdPFMo7lavAxR4+d3nXFXC8WqvxXwKT1w9N4LCFBG2jlug
        5NW62/tO3/e6NO4Uau3mzU4=
X-Google-Smtp-Source: ABdhPJzBoVmlKArcBkUNkclq8mlbvc8PlvuUCAhujMehIveAomIBFKvYT60Bdz2eJptQU1hRx/CEwg==
X-Received: by 2002:a1c:7212:0:b0:389:9f29:4e28 with SMTP id n18-20020a1c7212000000b003899f294e28mr8690638wmc.165.1646853314110;
        Wed, 09 Mar 2022 11:15:14 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-79-47-249-147.retail.telecomitalia.it. [79.47.249.147])
        by smtp.googlemail.com with ESMTPSA id w6-20020a5d6806000000b002036515dda7sm2396699wru.33.2022.03.09.11.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 11:15:12 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH v3 00/18] Multiple addition to ipq8064 dtsi
Date:   Wed,  9 Mar 2022 20:01:34 +0100
Message-Id: <20220309190152.7998-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This try to complete the ipq8064 dtsi and introduce 2 new dtsi
ipq8064-v2 and ipq8065. While some node are still missing (cpufreq node,
l2 scale node, fab scale node) this would add most of the missing node
to make ipq8064 actually usable.

Some of the changes are the fix for the pci IO that cause any secondary
wifi card with ath10k to fail init.
Adds regulators definition for RPM.
Adds many missing gsbi nodes used by all the devices.
Enable the usb phy by default as they are actually enabled internally by
xlate only if the dwc3 driver is used.
Add opp table and declare idle state for ipq8064.
Fix some dtc warning.

This also add the ipq8064-v2.0 dtsi and the ipq8065 dtsi used by more
recent devices based on this SoC.

v3:
- Fix error in rb3011 dts
- Add tested-by tag on the entire series
v2:
- Added missing patch
- Added additional gsbi6 spi
- Added extra description for L2 cache opp
- Fxied smb208 enabled by default that is problematic for rb3011 devices

Ansuel Smith (18):
  ARM: dts: qcom: add multiple missing pin definition for ipq8064
  ARM: dts: qcom: add gsbi6 missing definition for ipq8064
  ARM: dts: qcom: add missing rpm regulators and cells for ipq8064
  ARM: dts: qcom: disable smb208 regulators for ipq8064-rb3011
  ARM: dts: qcom: add missing snps,dwmac compatible for gmac ipq8064
  ARM: dts: qcom: enable usb phy by default for ipq8064
  ARM: dts: qcom: reduce pci IO size to 64K for ipq8064
  ARM: dts: qcom: fix dtc warning for missing #address-cells for ipq8064
  ARM: dts: qcom: add smem node for ipq8064
  ARM: dts: qcom: add saw for l2 cache and kraitcc for ipq8064
  ARM: dts: qcom: add sic non secure node for ipq8064
  ARM: dts: qcom: fix and add some missing gsbi node for ipq8064
  ARM: dts: qcom: add opp table for cpu and l2 for ipq8064
  ARM: dts: qcom: add speedbin efuse nvmem binding
  ARM: dts: qcom: add multiple missing binding for cpu and l2 for
    ipq8064
  ARM: dts: qcom: remove redundant binding from ipq8064 rb3011 dts
  ARM: dts: qcom: add ipq8064-v2.0 dtsi
  ARM: dts: qcom: add ipq8065 dtsi

 arch/arm/boot/dts/qcom-ipq8064-rb3011.dts |  21 +-
 arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi  |  70 ++++
 arch/arm/boot/dts/qcom-ipq8064.dtsi       | 375 +++++++++++++++++++++-
 arch/arm/boot/dts/qcom-ipq8065.dtsi       | 168 ++++++++++
 4 files changed, 603 insertions(+), 31 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi
 create mode 100644 arch/arm/boot/dts/qcom-ipq8065.dtsi

-- 
2.34.1

