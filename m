Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9415C4BAE60
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiBRAaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:30:14 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiBRAaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:30:13 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E555E17C;
        Thu, 17 Feb 2022 16:29:57 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c192so4176913wma.4;
        Thu, 17 Feb 2022 16:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/OTruRCD+Ij6EmV9ckr8IJ1zAJ1b2hmL42wGrOlCU10=;
        b=pImZn1Zhd2lJxHSPc8u25DL0DScj4aIrBcWC7PAamH33A13iQ1UhnqIKRK0ZhbwzSP
         +rvkMHRFZ0iqZ55M5CRkQ2F+EtrwmKTyVe6f9wLO/DjFccUFgMZdD/hKm4F8Gtf197J7
         tQ2ezG51RkTN10j1TPVo2dUfmIco/G9ln6mnBiOkUkjCBnRbUu35TZmMEv2NoB+pnnOX
         /KgOujMt+vEuRFNLc+7IYr9p7zD1hS6DgxAksy1C5nkDRfaLjXLyRDgNtBKgFQHrhre+
         sSUIHVXGkDZnEIqSunfYV5qnm4DoaAXzkvwa3APCBVeUbbPp7UkSztf7aZPpwNRUDugw
         zsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/OTruRCD+Ij6EmV9ckr8IJ1zAJ1b2hmL42wGrOlCU10=;
        b=728XWdI19rbUo2HyDurNKeMsTD6pU63K6wDwtLyXm3OHbUWyp15HYC7WaYWAp1ToFa
         74TtFdKye4nc6YbTVYXv9o3Osf1ML0fqLyeZTS7zAbgjdHcJNjHFrQwJZV2Q6Y17E9co
         iE/rdYQDz/AXcNKZPa0j6ultzQDBsDmvc5ab3wfBo2rUlDc6ksA/JBbz/kiNM1oqgfI9
         8eH6ddARtwcjlREvFtczj6S4v9RTs5TA2T+2HCT/YE/cpH26Wi1JRqRBWmGlSH7pO5Jc
         EqRqbStHjSbKekH0WRIKxevMLjYDRuo0PLIQXBqWSUfjNfsqDtEBnN0k6q3OJ0/5vJ2J
         wehA==
X-Gm-Message-State: AOAM5321Hj6rWjtdsiash4jV7rObu9f3rDRmHVIjfrSjgmbyv/Gy57MD
        pYm7jPMfeubIuZFZk960kYo=
X-Google-Smtp-Source: ABdhPJx+hrwVMjoiO5aTUi3AaEvAAdkQP879FBW22W4ZFQBb9PeUZwxZM23/oekaDNmvTFfmDHHFEQ==
X-Received: by 2002:a05:600c:364f:b0:37b:ba9e:2805 with SMTP id y15-20020a05600c364f00b0037bba9e2805mr4750108wmq.119.1645144195936;
        Thu, 17 Feb 2022 16:29:55 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id d29sm3640406wra.63.2022.02.17.16.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 16:29:55 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH v2 00/18] Multiple addition to ipq8064 dtsi
Date:   Fri, 18 Feb 2022 01:29:38 +0100
Message-Id: <20220218002956.6590-1-ansuelsmth@gmail.com>
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

