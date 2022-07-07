Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF28B56972C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 03:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiGGBKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 21:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiGGBKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:10:06 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318BE2D1DA;
        Wed,  6 Jul 2022 18:10:05 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id o25so29861901ejm.3;
        Wed, 06 Jul 2022 18:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KKNNnLP6BXv9weNP7IrNJFXjpWPkNIIO0KIHrji3Gzg=;
        b=INIh4Vdzmf6A/7ZYXbviiMTjCDSI0atyLc6D8rmQ7LfaZx/oKLBy1rIywsSIBghieK
         jHugcAncjqdEXCK1FtXFXztRJttcQjySL6kyyu3eew32nfoIZuZTxAD7Sk1vNjbbKLua
         tXxjmWn2M/7HQt/gF/wpbejpgWKNQQd0qIgMYmVtEiWw/IddHYOLfCQCuTVRYT60tOVH
         sazeVrA+U1hxDI+651KlF3inw15/+517xKtxYU0mTSSd0cU1q9xah5kChv6cQiMZXfNg
         cQ9OMIjuH9Zr5uwLiDvquJ/eZhjNmhoY/8ePWUETQ0UVOTdimoDM44Q5tpNrpBf/W6pK
         WMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KKNNnLP6BXv9weNP7IrNJFXjpWPkNIIO0KIHrji3Gzg=;
        b=3iuIhitVM+CE4pVWHmr6HPoBp6ZYth9KswTKQfrtgXvFKV+W6Zww+9k/9FLO3JNopM
         hLHdBAcqshCY9ilRFrcr0FOabDixHutZya4YBGgIsh8YeXUXG1+xzI7FWTHUJfpukGA6
         XDmjUDBOY/skXWi5yEwgdA2ru2Zm4tOwm47lfIvjXbfJ+GeLDZxrDlbZvrY40CBL65Vz
         k4VmwkNBPi6NthRDnjKD4cz0nVPuqn786Nygm4O/OdRit5NTDuxzJ3qlrqFyXlZRSQMn
         yxFXBliLl1LgETP/3fNku2iccMcVMUzyvsRPQ+CubQMiSQzDqyzulAC7rF7tQUmTeRhI
         incg==
X-Gm-Message-State: AJIora9ONPKudD4jekPJWBCxCvmDmCyrZpuxWbxbJpLtlMlAl3avi5WC
        ucpWPrHEKro2FrLjD2JYZ0s=
X-Google-Smtp-Source: AGRyM1uV/3jNW3DhZDU9/Q9ygmIQrlpWie+2DSwdJ7QEWuoxhbTKY4IV5LA6qQXjl38VNkGDb5PHrQ==
X-Received: by 2002:a17:906:149b:b0:726:2968:e32a with SMTP id x27-20020a170906149b00b007262968e32amr42903304ejc.71.1657156203599;
        Wed, 06 Jul 2022 18:10:03 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id u17-20020a056402111100b0043a6e807febsm6915464edv.46.2022.07.06.18.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 18:10:03 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH v2 0/8] Add ipq806x missing bindings
Date:   Thu,  7 Jul 2022 03:09:34 +0200
Message-Id: <20220707010943.20857-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
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

This is a respin of "Multiple addition to ipq8064 dtsi" series
with major changes and some commit removed.

This series try to add some of the missing bindings for ipq806x.

This still lacks of the cpu bindings and all the bindings required
to scale cpu clk or L2. These will come later as the driver and
documentation require some changes.

So for now we try to add bindings that can directly applied without
making changes to any drivers.

Changes:
v2:
- Dropped "add sic non secure node for ipq8064" (no user found)
- Dropped "add smem node for ipq8064" (require changes to the driver
  to remove syscon node and use regs directly, will be added in a
  different series)
- Dropped "fix dtc warning for missing #address-cells for ipq8064" (
  doesn't actually fix any warning)
- Changed "enable usb phy by default for ipq8064" to disable usb phy
  by default
- Reworked rpm smb208 declaration to a saparate dtsi
- Fixed order with compatible-reg-status
- Squashed "remove redundant binding from ipq8064 rb3011 dts" with
  "add multiple missing pin definition for ipq8064" to prevent dtc
  error.
- Add review tag for snps patch

Changes from "Multiple addition to ipq8064 dtsi":
v3:
- Fix error in rb3011 dts
- Add tested-by tag on the entire series
v2:
- Added missing patch
- Added additional gsbi6 spi
- Added extra description for L2 cache opp
- Fxied smb208 enabled by default that is problematic for rb3011 devices

Christian Marangi (8):
  ARM: dts: qcom: add multiple missing pin definition for ipq8064
  ARM: dts: qcom: add gsbi6 missing definition for ipq8064
  ARM: dts: qcom: add specific ipq8064 dtsi with smb208 rpm regulators
  ARM: dts: qcom: add missing snps,dwmac compatible for gmac ipq8064
  ARM: dts: qcom: disable usb phy by default for ipq8064
  ARM: dts: qcom: reduce pci IO size to 64K for ipq8064
  ARM: dts: qcom: fix and add some missing gsbi node for ipq8064
  ARM: dts: qcom: add speedbin efuse nvmem node

 arch/arm/boot/dts/qcom-ipq8064-ap148.dts   |   6 -
 arch/arm/boot/dts/qcom-ipq8064-rb3011.dts  |   9 --
 arch/arm/boot/dts/qcom-ipq8064-smb208.dtsi |  37 +++++
 arch/arm/boot/dts/qcom-ipq8064.dtsi        | 150 +++++++++++++++++++--
 4 files changed, 179 insertions(+), 23 deletions(-)
 create mode 100644 arch/arm/boot/dts/qcom-ipq8064-smb208.dtsi

-- 
2.36.1

